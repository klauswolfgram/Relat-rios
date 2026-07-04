/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR700.CH"
#INCLUDE "REPORT.CH"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR700"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR700   ³ Autor ³ Kleber Dias Gomes     ³ Data ³ 06/09/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Acompanhamento de Projeto.                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³  Data    ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³29/08/2006³ Cleber M.     ³Bops 99278: Desenvolvimento do relatorio    ³±±
±±³          ³               ³personalizavel (Release 4).                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TECR700()
Local oReport				// Objeto para geracao do relatorio
Local aArea := GetArea()	// Salva a area

If !FindFunction("TRepInUse") .OR. !TRepInUse()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa versao anterior do fonte³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	U_TECR700R3()
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                            ³
	//³ mv_par01        //  Projeto De                                  ³
	//³ mv_par02        //  Projeto Ate                                 ³
	//³ mv_par03        //  Cliente De                                  ³
	//³ mv_par04        //  Loja De                                     ³
	//³ mv_par05        //  Cliente Ate                                 ³
	//³ mv_par06        //  Loja Ate                                    ³
	//³ mv_par07        //  Produto De                                  ³
	//³ mv_par08        //  Produto Ate                                 ³
	//³ mv_par09        //  Data De                                     ³
	//³ mv_par10        //  Data Ate                                    ³
	//³ mv_par11        //  Etapa De                                    ³
	//³ mv_par12        //  Etapa Ate                                   ³
	//³ mv_par13        //  Situacao(1=Em Aberto;2=Cancelado;			|
	//|                              3=Concluido;4=Todos)  		        |
	//³ mv_par14        //  Modelo (1=Analitico;2=Sintetico)            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte("ATR700",.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := Tcr700RptDef()
	oReport:PrintDialog()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Restaura a area³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea( aArea )

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr700RptDef ºAutor  ³Cleber Martinez     º Data ³  29/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR700 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr700RptDef()
Local oReport							// Objeto do relatorio
Local oSection1							// Objeto da secao 1
Local oSection2							// Objeto da secao 2
Local oSection3							// Objeto da secao 3
Local cAliasABH		:= "ABH"			// Alias principal do relatorio
Local cAliasABI		:= "ABI"			// Alias das etapas do projeto

#IFDEF TOP
	cAliasABH	:= GetNextAlias()
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR700" TITLE STR0018 PARAMETER "ATR700" ACTION {|oReport| Tcr700PrtRpt(oReport, cAliasABH)} 	DESCRIPTION STR0002 + STR0003
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0019 TABLES "ABH","SA1","SB1","SE4" 
		oSection1:SetLineBreak()
		oSection1:SetHeaderSection(.T.)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		DEFINE CELL NAME "A1_COD" 		OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "A1_LOJA" 		OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "A1_NOME" 		OF oSection1 ALIAS "SA1"
		DEFINE CELL NAME "ABH_PROJET" 	OF oSection1 ALIAS "ABH"
		DEFINE CELL NAME "ABH_DESCRI" 	OF oSection1 ALIAS "ABH"
		DEFINE CELL NAME "ABH_REFER" 	OF oSection1 ALIAS "ABH"
		DEFINE CELL NAME "ABH_ENTREG" 	OF oSection1 ALIAS "ABH"
		DEFINE CELL NAME "B1_COD"	 	OF oSection1 ALIAS "SB1"
		DEFINE CELL NAME "B1_DESC"	 	OF oSection1 ALIAS "SB1"
		DEFINE CELL NAME "E4_DESCRI" 	OF oSection1 ALIAS "SE4" TITLE RetTitle("ABH_CPAGPV")
		DEFINE CELL NAME "ABH_SITUAC" 	OF oSection1 ALIAS "ABH" 
		DEFINE CELL NAME "ABH_CODMEM" 	OF oSection1 ALIAS "ABH" TITLE STR0014 SIZE 120 BLOCK {|| MSMM((cAliasABH)->ABH_CODMEM) }
          
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao2 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
	DEFINE SECTION oSection2 OF oSection1 TITLE STR0020 TABLE "ABI", "ABH", "ABJ","AAG"
		oSection2:SetLineBreak()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao2  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE CELL NAME "ABI_ETAPA" 	OF oSection2 ALIAS "ABI"
		DEFINE CELL NAME "ABI_DESCRI" 	OF oSection2 ALIAS "ABI"
		DEFINE CELL NAME "ABI_VALOR" 	OF oSection2 ALIAS "ABI" PICTURE "@E 999,999,999.99" 
		DEFINE CELL NAME "ABI_CODPRO" 	OF oSection2 ALIAS "ABI"
		DEFINE CELL NAME "AAG_DESCRI" 	OF oSection2 ALIAS "AAG" 
		DEFINE CELL NAME "ABI_INIPRV" 	OF oSection2 ALIAS "ABI"
		DEFINE CELL NAME "ABI_FIMPRV"  	OF oSection2 ALIAS "ABI" 
		DEFINE CELL NAME "ABI_NUMOS" 	OF oSection2 ALIAS "ABI"
		DEFINE CELL NAME "ABI_SITUAC" 	OF oSection2 ALIAS "ABI" 
		DEFINE CELL NAME "cStatus" 		OF oSection2 ALIAS "" 
		DEFINE CELL NAME "dIniReal"		OF oSection2 ALIAS "" 
		DEFINE CELL NAME "dFimReal"		OF oSection2 ALIAS "" 
		DEFINE CELL NAME "nPrevHr"		OF oSection2 ALIAS "" TITLE RetTitle("ABI_TPREVI") PICTURE "@R 999999:99"
		DEFINE CELL NAME "nOrcaHr"		OF oSection2 ALIAS "" TITLE RetTitle("ABI_TORCAD") PICTURE "@R 999999:99"
		DEFINE CELL NAME "nRealHr"		OF oSection2 ALIAS "" TITLE RetTitle("ABI_TREALI") PICTURE "@R 999999:99"
		DEFINE CELL NAME "ABI_NUMPV" 	OF oSection2 ALIAS "ABI" 
		DEFINE CELL NAME "ABI_ITEMPV" 	OF oSection2 ALIAS "ABI"
		DEFINE CELL NAME "ABI_CODMEM" 	OF oSection2 ALIAS "ABI" TITLE STR0014 SIZE 120 BLOCK {|| MSMM((cAliasABI)->ABI_CODMEM) }
                         
		oSection2:Cell("cStatus"):GetFieldInfo("ABI_SITATU")
		oSection2:Cell("dIniReal"):GetFieldInfo("ABI_INIREA")
		oSection2:Cell("dFimReal"):GetFieldInfo("ABI_FIMREA")
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao3 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection3 OF oSection2 TITLE STR0021 TABLE "ABJ","ABI","ABH","AA1"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao3  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		DEFINE CELL NAME "ABJ_TAREFA" 	OF oSection3 ALIAS "ABJ"
		DEFINE CELL NAME "ABJ_DESCRI" 	OF oSection3 ALIAS "ABJ"
		DEFINE CELL NAME "ABJ_TPREVI" 	OF oSection3 ALIAS "ABJ" PICTURE "@R 999999:99"
		DEFINE CELL NAME "ABJ_TORCAD" 	OF oSection3 ALIAS "ABJ" PICTURE "@R 999999:99"
		DEFINE CELL NAME "ABJ_TREALI" 	OF oSection3 ALIAS "ABJ" PICTURE "@R 999999:99"
		DEFINE CELL NAME "ABJ_SITUAC" 	OF oSection3 ALIAS "ABJ" 
		DEFINE CELL NAME "ABJ_SITATU" 	OF oSection3 ALIAS "ABJ" 
		DEFINE CELL NAME "ABJ_CODTEC" 	OF oSection3 ALIAS "ABJ"
		DEFINE CELL NAME "AA1_NOMTEC" 	OF oSection3 ALIAS "AA1"             
		DEFINE CELL NAME "nTotAtend" 	OF oSection3 ALIAS "" PICTURE "@E 99"
		DEFINE CELL NAME "dIniReal" 	OF oSection3 ALIAS "" 
		DEFINE CELL NAME "dFimReal" 	OF oSection3 ALIAS ""  
                         
	  	oSection3:Cell("nTotAtend"):GetFieldInfo("ABJ_NATEND") 
	  	oSection3:Cell("dIniReal"):GetFieldInfo("ABJ_INIREA") 
	  	oSection3:Cell("dFimReal"):GetFieldInfo("ABJ_FIMREA")
	  	
Return oReport 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr700PrtRptºAutor  ³Cleber Martinez     º Data ³  01/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±º          ³cAliasABH: Alias principal do relatorio                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR700 R4                                                   º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³  Data    ³ Programador   ³Manutencao efetuada                         	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³15/09/2006³ Cleber M.     ³Bops 99278: Ajustes na query para evitar erros³±±
±±³          ³               ³no DB2 e outros bancos.                     	³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³20/09/2006³ Tatiana C.    ³Bops 99278: Retirada a expressao  * da query  ³±±
±±³          ³               ³para leitura pelo db2.                     	³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr700PrtRpt( oReport, cAliasABH )
Local oSection1 := oReport:Section(1)							// Define a secao 1 do relatorio
Local oSection2 := oReport:Section(1):Section(1)				// Define a secao 1 do relatorio
Local oSection3 := oReport:Section(1):Section(1):Section(1)	// Define a secao 1 do relatorio
Local cFiltro		:= ""					// Filtro para DBF
Local cProjeto		:= ""					// Nr. Projeto
Local cEtapa		:= ""					// Etapa do projeto
Local cAliasABI		:= ""					// Alias do arq. ABI
Local cAliasABJ		:= ""					// Alias do arq. ABJ
Local cAliasSA1		:= ""					// Alias do arq. SA1
Local cAliasSB1		:= ""					// Alias do arq. SB1
Local cAliasSE4		:= ""					// Alias do arq. SE4
Local cAliasAA1		:= ""					// Alias do arq. AA1
Local cAliasAAG		:= ""					// Alias do arq. AAG
Local cAliasAB9		:= ""					// Alias do arq. AB9
Local lICabABI		:= .F.					// Imprime Cabec. do ABI
Local lICabABJ		:= .F.					// Imprime Cabec. do ABJ
Local aColsABJ		:= {}					// Array com os dados do ABJ
Local aColsABI		:= {}					// Array com os dados do ABI
Local nHorasReal	:= 0					// Nr. horas realizadas
Local nTotAtend		:= 0					// Total de atendimentos
Local dIniReal		:= CToD( "" )			// Data Inicio real
Local dFimReal		:= CToD( "" )			// Data final real
Local nCntFor		:= 0					// Usada em lacos 
Local cStatTaref	:= ""					// Status da tarefa
Local cStatusEtp	:= ""					// Status da etapa
Local dIniCols		:= CToD( "" )			// Data inicial
Local dFimCols		:= CToD( "" )			// Data final
Local nPrevHr		:= 0					// Horas previstas
Local nRealHr		:= 0					// Horas realizadas
Local nOrcaHr		:= 0					// Horas orcadas
Local aSituacABI	:= {STR0009,STR0010}  	//"CONCLUIDA"###"NAO CONCLUIDA"
Local aStatus		:= {STR0011,STR0012}  	//"CONCLUIDA"###"NAO CONCLUIDA"

cAliasABI 	:= "ABI"
cAliasABJ 	:= "ABJ"
cAliasSA1	:= "SA1"
cAliasSB1	:= "SB1"
cAliasSE4	:= "SE4"
cAliasAA1	:= "AA1"
cAliasAAG	:= "AAG"

#IFDEF TOP

	lQuery		:= .F.
	ABH->(dbSetOrder(1))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR700")
	
	If MV_PAR13 == 4 
		cWhere1 := "%%"
	Else
		cWhere1 := "%ABH_SITUAC	='"+AllTrim(Str(MV_PAR13))+"' AND %"
	EndIf
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAliasABH
	
	SELECT 	ABH_FILIAL, ABH_PROJET, ABH_CODCLI, ABH_LOJA, 	ABH_CODPRO, 
			ABH_REFER,	ABH_ENTREG, ABH_DESCRI,	ABH_CODMEM,	ABH_CPAGPV,
			ABH_MOEDA,	ABH_SITUAC
		
	FROM %table:ABH% ABH
		
	WHERE ABH_FILIAL = %xfilial:ABH% 	AND
		ABH_PROJET	>= %exp:MV_PAR01% 	AND
		ABH_PROJET	<= %exp:MV_PAR02%	AND
		ABH_CODCLI	>= %exp:MV_PAR03% 	AND
		ABH_CODCLI	<= %exp:MV_PAR05%	AND
		ABH_LOJA 	>= %exp:MV_PAR04%	AND
		ABH_LOJA 	<= %exp:MV_PAR06% 	AND
		ABH_CODPRO	>= %exp:MV_PAR07%	AND
		ABH_CODPRO	<= %exp:MV_PAR08%	AND
		ABH_REFER 	>= %exp:DtoS(MV_PAR09)%		AND
		ABH_ENTREG	<= %exp:DtoS(MV_PAR10)%		AND
		%exp:cWhere1%
		ABH.%notDel%				 	
	
		ORDER BY %Order:ABH%

	EndSql
	
	END REPORT QUERY oSection1 

#ELSE

    lQuery := .F.
	cAliasABH 	:= "ABH"
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR700")

	ABH->(dbSetOrder(1))
	cKey := ABH->(IndexKey())

	cFiltro	:= "ABH_FILIAL=='"+xFilial("ABH")+"'"
	cFiltro	+= ".AND. ABH_PROJET >='"+MV_PAR01+"'"
	cFiltro	+= ".AND. ABH_PROJET <='"+MV_PAR02+"'"
	cFiltro	+= ".AND. ABH_CODCLI >='"+MV_PAR03+"'"
	cFiltro	+= ".AND. ABH_CODCLI <='"+MV_PAR05+"'"
	cFiltro	+= ".AND. ABH_LOJA >='"+MV_PAR04+"'"
	cFiltro += ".AND. ABH_LOJA <='"+MV_PAR06+"'"
	cFiltro	+= ".AND. ABH_CODPRO >='"+MV_PAR07+"'"
	cFiltro	+= ".AND. ABH_CODPRO <='"+MV_PAR08+"'"
	cFiltro	+= ".AND. DtoS(ABH_REFER) >='"+DtoS(MV_PAR09)+"'"
	cFiltro	+= ".AND. DtoS(ABH_ENTREG) <='"+DtoS(MV_PAR10)+"'"
	cFiltro	+= If(MV_PAR13==4,"",".AND. ABH_SITUAC	='"+AllTrim(Str(MV_PAR13))+"'")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua o filtro de acordo com a expressao do arquivo ABH (Projetos)									 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro, cKey )

#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAliasABH)->(LastRec()))
DbSelectArea(cAliasABH)

While !oReport:Cancel() .AND. !(cAliasABH)->(Eof()) .AND.;
	(cAliasABH)->ABH_FILIAL==xFilial("ABH")
         
	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf
	
	If ( cProjeto <> (cAliasABH)->ABH_PROJET )

		dbSelectArea("SA1")
		dbSetOrder(1)
		MsSeek(xFilial("SA1")+(cAliasABH)->ABH_CODCLI)
		dbSelectArea("SB1")
		dbSetOrder(1)
		MsSeek(xFilial("SB1")+(cAliasABH)->ABH_CODPRO)
		dbSelectArea("SE4")
		dbSetOrder(1)
		MsSeek(xFilial("SE4")+(cAliasABH)->ABH_CPAGPV)
                             
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a secao 1 (Projeto) ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection1:Init()
		oSection1:PrintLine()	
		oSection1:Finish()

		cProjeto := (cAliasABH)->ABH_PROJET
	EndIf

	If MV_PAR14 == 1 //Analitico
	
		lICabABI := .F.
		lICabABJ := .F.	

    	dbSelectArea(cAliasABI)
		dbSetOrder(1)
		MsSeek(xFilial("ABI")+(cAliasABH)->ABH_PROJET)
		While ( !Eof() .AND. (cAliasABI)->ABI_FILIAL==xFilial("ABI") .AND. (cAliasABI)->ABI_PROJET==(cAliasABH)->ABH_PROJET)
			dbSelectArea("SB1")
			dbSetOrder(1)
			MsSeek(xFilial("SB1")+(cAliasABI)->ABI_CODPRO)
			dbSelectArea("AAG")
			dbSetOrder(1)
			MsSeek(xFilial("AAG")+(cAliasABI)->ABI_CODPRB)
			If (cAliasABI)->ABI_ETAPA >= MV_PAR11 .AND. (cAliasABI)->ABI_ETAPA <= MV_PAR12
				If Empty(aColsABI)
					aAdd(aColsABI,{(cAliasABI)->ABI_ETAPA,;
						SubStr(AllTrim((cAliasABI)->ABI_DESCRI),1,30),;
						xMoeda((cAliasABI)->ABI_VALOR,(cAliasABH)->ABH_MOEDA,MV_PAR15),;
						(cAliasABI)->ABI_CODPRO,;
					 	(cAliasAAG)->AAG_DESCRI,;
						(cAliasABI)->ABI_INIPRV,;
						(cAliasABI)->ABI_FIMPRV,;
						(cAliasABI)->ABI_NUMOS,;
						(cAliasABI)->ABI_SITATU,;
						(cAliasABI)->ABI_NUMPV,;
						(cAliasABI)->ABI_ITEMPV,;
						(cAliasABI)->ABI_CODMEM})
      			EndIf
	    		
	    		dbSelectArea(cAliasABJ)
				dbSetOrder(1)
				MsSeek(xFilial("ABJ")+(cAliasABI)->ABI_PROJET+(cAliasABI)->ABI_ITEM)
				While ( !Eof() .AND. (cAliasABJ)->ABJ_FILIAL==xFilial("ABJ") .AND. (cAliasABJ)->ABJ_PROJET+(cAliasABJ)->ABJ_ITEM==(cAliasABI)->ABI_PROJET+(cAliasABI)->ABI_ITEM)
					dbSelectArea("AA1")
					dbSetOrder(1)
					MsSeek(xFilial("AA1")+(cAliasABJ)->ABJ_CODTEC)
					
					cAliasAB9	:= "AB9"
					dbSelectArea(cAliasAB9)
					dbSetOrder(4)
					MsSeek(xFilial("AB9")+(cAliasABJ)->ABJ_PROJET+(cAliasABJ)->ABJ_ITEM+(cAliasABJ)->ABJ_SUBITE)

					nHorasReal	:= 0
					nTotAtend	:= 0
					dIniReal	:= CToD( "" )
					dFimReal	:= CToD( "" )
				
					While ( !Eof() ) .AND. (cAliasAB9)->AB9_FILIAL==xFilial("AB9") .AND.; 
						(cAliasAB9)->AB9_TAREFA == (cAliasABJ)->ABJ_PROJET+(cAliasABJ)->ABJ_ITEM+(cAliasABJ)->ABJ_SUBITE
						
						nHorasReal	+=	SubtHoras((cAliasAB9)->AB9_DTINI, (cAliasAB9)->AB9_HRINI, (cAliasAB9)->AB9_DTFIM, (cAliasAB9)->AB9_HRFIM)
						dIniReal	:=	If((cAliasAB9)->AB9_DTINI<dIniReal .OR. Empty(dIniReal),(cAliasAB9)->AB9_DTINI,dIniReal)
						If (cAliasABJ)->ABJ_SITUAC == "1"
							dFimReal	:=	If((cAliasAB9)->AB9_DTFIM>dFimReal .OR. Empty(dIniReal),AB9->AB9_DTFIM,dFimReal)
						EndIf
						nTotAtend++
						dbSelectArea(cAliasAB9)
						dbSkip()
					End
					
					aAdd(aColsABJ,{(cAliasABJ)->ABJ_TAREFA,;
						(cAliasABJ)->ABJ_DESCRI,;
						HoraToInt((cAliasABJ)->ABJ_TPREVI,4),;
						HoraToInt((cAliasABJ)->ABJ_TORCAD,4),;
					 	nHorasReal,;//ABJ_TREALI
						(cAliasABJ)->ABJ_SITUAC,;
						(cAliasABJ)->ABJ_SITATU,;
						(cAliasABJ)->ABJ_CODTEC,;
						(cAliasAA1)->AA1_NOMTEC,;
					 	nTotAtend,;//ABJ_NATEND
					 	dIniReal,; //ABJ_INIREA
					 	dFimReal}) //ABJ_FIMREA
					 	
					nHorasReal	:= 0
					nTotAtend	:= 0
					dIniReal	:= CToD( "" )
					dFimReal	:= CToD( "" )
					cEtapa	:=	(cAliasABI)->ABI_PROJET+(cAliasABI)->ABI_ITEM
					dbSelectArea(cAliasABJ)
					dbSkip()
				End

				If cEtapa <> (cAliasABI)->ABI_PROJET+(cAliasABI)->ABI_ITEM .OR. !lQuery
					dIniReal	:= CToD( "" )
					dFimReal	:= CToD( "" )
					dIniCols	:= CToD( "" )
					dFimCols	:= CToD( "" )
					nPrevHr		:= 0
					nRealHr		:= 0
					nOrcaHr		:= 0
					cStatusEtp	:= ""
					For nCntFor := 1 To Len(aColsABJ)
						nPrevHr	+= aColsABJ[ nCntFor, 3 ]
						nRealHr	+= aColsABJ[ nCntFor, 5 ]
						nOrcaHr	+= aColsABJ[ nCntFor, 4 ]
						cStatTaref	:= aColsABJ[ nCntFor, 6 ]
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Marca a etapa como concluida apenas se todas as tarefas estiverem      ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						cStatusEtp	:= If( cStatusEtp == "2", cStatusEtp, cStatTaref )
						dIniCols	:= aColsABJ[ nCntFor, 11 ]
						dFimCols	:= aColsABJ[ nCntFor, 12 ]
						If !Empty( dIniCols )
							dIniReal := If( dIniCols<dIniReal .OR. Empty( dIniReal ), dIniCols, dIniReal )
						EndIf
						dFimReal := If( dFimCols>dFimReal .OR. Empty( dFimReal ), dFimCols, dFimReal )
					Next nCntFor
                        
					If Len(aColsABI) > 0
						oSection2:Init()
					EndIf
					For nCntFor := 1 To Len(aColsABI)
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Atualiza o valor das celulas da secao2³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						oSection2:Cell("ABI_ETAPA"):SetValue( aColsABI[nCntFor,1] )
						oSection2:Cell("ABI_DESCRI"):SetValue( aColsABI[nCntFor,2] )
						oSection2:Cell("ABI_VALOR"):SetValue( aColsABI[nCntFor,3] ) 
						oSection2:Cell("ABI_CODPRO"):SetValue( aColsABI[nCntFor,4] )
						oSection2:Cell("AAG_DESCRI"):SetValue( aColsABI[nCntFor,5] )
						oSection2:Cell("ABI_INIPRV"):SetValue( aColsABI[nCntFor,6] )
						oSection2:Cell("ABI_FIMPRV"):SetValue( aColsABI[nCntFor,7] )
						oSection2:Cell("ABI_NUMOS"):SetValue( aColsABI[nCntFor,8] )
						oSection2:Cell("ABI_SITUAC"):SetValue( If(cStatusEtp=="", aSituacABI[Val("2")], aSituacABI[Val(cStatusEtp)]) )
						oSection2:Cell("cStatus"):SetValue( aStatus[Val(aColsABI[nCntFor,9])] )
						oSection2:Cell("dIniReal"):SetValue( dIniReal )
						oSection2:Cell("dFimReal"):SetValue( If( cStatusEtp == "1", dFimReal, CToD( "" ) ) )
						oSection2:Cell("nPrevHr"):SetValue( IntToHora(nPrevHr,6) )
						oSection2:Cell("nOrcaHr"):SetValue( IntToHora(nOrcaHr,6) ) 
						oSection2:Cell("nRealHr"):SetValue( IntToHora(nRealHr,6) )
						oSection2:Cell("ABI_NUMPV"):SetValue( aColsABI[nCntFor,10] )
						oSection2:Cell("ABI_ITEMPV"):SetValue( aColsABI[nCntFor,11] )
					    
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Imprime a secao 2  ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		                oSection2:PrintLine()
					Next nCntFor
					If Len(aColsABI) > 0
						oSection2:Finish()  
						aColsABI := {}
					EndIf
                        
                    If Len(aColsABJ) > 0
						oSection3:Init()
					EndIf
					For nCntFor := 1 To Len(aColsABJ)
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Atualiza as celulas da secao 3 ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						oSection3:Cell("ABJ_TAREFA"):SetValue( aColsABJ[nCntFor,1] )
						oSection3:Cell("ABJ_DESCRI"):SetValue( aColsABJ[nCntFor,2] )
						oSection3:Cell("ABJ_TPREVI"):SetValue( IntToHora(aColsABJ[nCntFor,3],6) )
						oSection3:Cell("ABJ_TORCAD"):SetValue( IntToHora(aColsABJ[nCntFor,4],6) ) 
						oSection3:Cell("ABJ_TREALI"):SetValue( IntToHora(aColsABJ[nCntFor,5],6) ) 
						oSection3:Cell("ABJ_SITUAC"):SetValue( aSituacABI[Val(aColsABJ[nCntFor,6])] )
						oSection3:Cell("ABJ_SITATU"):SetValue( aStatus[Val(aColsABJ[nCntFor,7])] )
						oSection3:Cell("ABJ_CODTEC"):SetValue( aColsABJ[nCntFor,8] )
						oSection3:Cell("AA1_NOMTEC"):SetValue( aColsABJ[nCntFor,9] )
						oSection3:Cell("nTotAtend"):SetValue( aColsABJ[nCntFor,10] ) 
						oSection3:Cell("dIniReal"):SetValue( aColsABJ[nCntFor,11] )
						oSection3:Cell("dFimReal"):SetValue( aColsABJ[nCntFor,12] )
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Imprime a secao 3  ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						oSection3:PrintLine()
					Next nCntFor    
					If Len(aColsABJ) > 0
						oSection3:Finish()
						aColsABJ := {}
					EndIf
					
				EndIf
		
			EndIf
			dbSelectArea(cAliasABI)
			dbSkip()
		End

	EndIf

	If MV_PAR14 <> 1 .OR. !lQuery
		dbSelectArea(cAliasABH)
		dbSkip()
	EndIf
End

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR700R3 ³ Autor ³ Kleber Dias Gomes     ³ Data ³ 06/09/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Acompanhamento de Projeto.                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³  Data    ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TECR700R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local Titulo  := OemToAnsi(STR0001) //"Acompanhamento de Projeto"
Local cDesc1  := OemToAnsi(STR0002) //"Este programa ira emitir o Acompanhamento de Projeto conforme os "
Local cDesc2  := OemToAnsi(STR0003) //"parametros solicitados."
Local cDesc3  := OemToAnsi("") //""
Local cString := "ABH"  // Alias utilizado na Filtragem
Local lDic    := .F. 	// Habilita/Desabilita Dicionario
Local lComp   := .T. 	// Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro := .T. 	// Habilita/Desabilita o Filtro
Local wnrel   := "TECR700"  	// Nome do Arquivo utilizado no Spool
Local nomeprog:= "TECR700"  	// nome do programa

Private Tamanho := "G"	// P/M/G
Private Limite  := 220	// 80/132/220
Private aOrdem  := {}	// Ordem do Relatorio
Private cPerg   := "ATR700"  // Pergunta do Relatorio
Private aReturn := { STR0004, 1,STR0005, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
						//[1] Reservado para Formulario
						//[2] Reservado para N§ de Vias
						//[3] Destinatario
						//[4] Formato => 1-Comprimido 2-Normal
						//[5] Midia   => 1-Disco 2-Impressora
						//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
						//[7] Expressao do Filtro
						//[8] Ordem a ser selecionada
						//[9]..[10]..[n] Campos a Processar (se houver)

Private lEnd    := .F.// Controle de cancelamento do relatorio
Private m_pag   := 1  // Contador de Paginas
Private nLastKey:= 0  // Controla o cancelamento da SetPrint e SetDefault

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                            ³
//³ mv_par01        //  Projeto De                                  ³
//³ mv_par02        //  Projeto Ate                                 ³
//³ mv_par03        //  Cliente De                                  ³
//³ mv_par04        //  Loja De                                     ³
//³ mv_par05        //  Cliente Ate                                 ³
//³ mv_par06        //  Loja Ate                                    ³
//³ mv_par07        //  Produto De                                  ³
//³ mv_par08        //  Produto Ate                                 ³
//³ mv_par09        //  Data De                                     ³
//³ mv_par10        //  Data Ate                                    ³
//³ mv_par11        //  Etapa De                                    ³
//³ mv_par12        //  Etapa Ate                                   ³
//³ mv_par13        //  Situacao(1=Em Aberto;2=Cancelado;3=Concluido|
//|                              4=Todos)                           |
//³ mv_par14        //  Modelo(1=Analitico;2=Sintatico)             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	dbClearFilter()
	Return
Endif
SetDefault(aReturn,cString)

RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³ Kleber Dias Gomes     ³ Data ³17/06/2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controle de Fluxo do Relatorio.                             ³±±
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
Static Function ImpDet(lEnd,wnrel,cString,nomeprog,Titulo)

Local cAliasABH		:= ""
Local cAliasABI		:= ""
Local cAliasABJ		:= ""
Local cAliasSA1		:= ""
Local cAliasSB1		:= ""
Local cAliasSE4		:= ""
Local cAliasAA1		:= ""
Local cAliasAAG		:= ""
Local cAliasAB9		:= ""
Local cKey			:= ""
Local cArqInd		:= ""
Local cKeyAB9		:= ""
Local lQuery		:= .F.
Local cQuery		:= ""
Local cQryCpo		:= ""
Local cQueryAB9		:= ""
Local aSituacABH	:= {STR0006,STR0007,STR0008} //"EM ABERTO"###"CANCELADO"###"CONCLUIDO"
Local aSituacABI	:= {STR0009,STR0010}  //"CONCLUIDA"###"NAO CONCLUIDA"
Local aStatus		:= {STR0011,STR0012}  //"CONCLUIDA"###"NAO CONCLUIDA"
Local nStru			:= 0
Local Li			:= 100 // Contador de Linhas
Local cProjeto		:= ""
Local cEtapa		:= ""
Local nLi			:= 0
Local bFiltro		:= { || .T. }
Local aStruABH		:= {}
Local aStruABI		:= {}
Local aStruABJ		:= {}
Local cMemo			:= ""
Local nMemCount		:= 0
Local cLinha		:= ""
Local cSubCab0		:= ""
Local cSubCab1		:= ""
Local cSubCab2		:= ""
Local lICabABI		:= .F.
Local lICabABJ		:= .F.
Local aColsABJ		:= {}
Local aColsABI		:= {}
Local nHorasReal	:= 0
Local nTotAtend		:= 0
Local dIniReal		:= CToD( "" )
Local dFimReal		:= CToD( "" )
Local nCntFor		:= 0
Local nCntFor2		:= 0
Local cStatTaref	:= ""
Local cStatusEtp	:= ""
Local dIniCols		:= CToD( "" )
Local dFimCols		:= CToD( "" )
Local nPrevHr		:= 0
Local nRealHr		:= 0
Local nOrcaHr		:= 0
Local lFiltrou		:= .F.

		//                             1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17         18        19        20        21       22
		//         			 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local cCabec1 := STR0013  //"CLIENTE   NOME                                     PROJETO DESCRICAO                                DT.REFERENCIA DT.ENTREGA PRODUTO         DESCRICAO                      COND.PAGAMENTO  SITUACAO"
Local cCabec2 := STR0014  //"NOTAS"
		//					 XXXXXX-XX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99/99/9999    99/99/9999 XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XXXXXXXXX
		//					 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

dbSelectArea(cString)
SetRegua(LastRec())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecao dos registros validos para o processamento           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	lQuery		:= .T.

	ABH->(dbSetOrder(1))
	ABI->(dbSetOrder(1))
	ABJ->(dbSetOrder(1))	
	
	cAliasABH	:= GetNextAlias()
	cAliasABI	:= cAliasABH
	cAliasABJ	:= cAliasABH
	cAliasSA1	:= cAliasABH
	cAliasSB1	:= cAliasABH
	cAliasSE4	:= cAliasABH
	cAliasAA1	:= cAliasABH
	cAliasAAG	:= cAliasABH
	
	cQryCpo	:=	""
	aStruABH := ABH->(dbStruct())
	aStruABI := ABI->(dbStruct())
	For nStru := 1 To Len(aStruABI)
		If aStruABI[nStru,2] <> "M"
			cQryCpo	+= ", "+aStruABI[nStru,1]
		EndIf
	Next nStru
	aStruABJ := ABJ->(dbStruct())
	For nStru := 1 To Len(aStruABJ)
		If aStruABJ[nStru,2] <> "M"
			cQryCpo	+= ", "+aStruABJ[nStru,1]
		EndIf
	Next nStru

	cQuery	:= "SELECT A1_COD, A1_LOJA, A1_NOME, SB1.B1_COD, SB1.B1_DESC, SE4.E4_DESCRI, AA1.AA1_NOMTEC, AAG.AAG_DESCRI "
	cQuery   += cQryCpo
	cQuery   += ",ABH_FILIAL, ABH_PROJET, ABH_CODCLI, ABH_LOJA, 	ABH_CODPRO, ABH_REFER,	ABH_ENTREG, ABH_DESCRI,	ABH_CODMEM,	ABH_CPAGPV"
	cQuery   += ",ABH_MOEDA,	ABH_SITUAC "
	cQuery	+= " FROM "+RetSqlName("ABH")+" ABH, "+RetSqlName("ABI")+" ABI, "+RetSqlName("ABJ")+" ABJ, "
	cQuery	+= RetSqlName("SA1")+" SA1, "+RetSqlName("SB1")+" SB1, "+RetSqlName("SE4")+" SE4, "+RetSqlName("AA1")+" AA1, "
	cQuery   += RetSqlName("AAG")+" AAG"
	cQuery	+= " WHERE ABH_FILIAL='"+xFilial("ABH")+"'"
	cQuery	+= " AND ABH_PROJET	>='"+MV_PAR01+"'"
	cQuery	+= " AND ABH_PROJET	<='"+MV_PAR02+"'"
	cQuery	+= " AND ABH_CODCLI	>='"+MV_PAR03+"'"
	cQuery	+= " AND ABH_CODCLI	<='"+MV_PAR05+"'"
	cQuery	+= " AND ABH_LOJA >='"+MV_PAR04+"'"
	cQuery	+= " AND ABH_LOJA <='"+MV_PAR06+"'"
	cQuery	+= " AND ABH_CODPRO	>='"+MV_PAR07+"'"
	cQuery	+= " AND ABH_CODPRO	<='"+MV_PAR08+"'"
	cQuery	+= " AND ABH_REFER >='"+DtoS(MV_PAR09)+"'"
	cQuery	+= " AND ABH_ENTREG	<='"+DtoS(MV_PAR10)+"'"
	cQuery	+= If(MV_PAR13==4,""," AND ABH_SITUAC	='"+AllTrim(Str(MV_PAR13))+"'")
	cQuery	+= " AND ABI_FILIAL	= '" + xFilial("ABI") + "'"
	cQuery	+= " AND ABI_PROJET	= ABH_PROJET"
	cQuery	+= " AND ABI_ETAPA >='"+MV_PAR11+"'"
	cQuery	+= " AND ABI_ETAPA <='"+MV_PAR12+"'"
	cQuery	+= " AND ABJ_FILIAL = '"+xFilial("ABJ")+"'"
	cQuery	+= " AND ABJ_PROJET	= ABH_PROJET"
	cQuery	+= " AND ABJ_ITEM = ABI_ITEM"
	cQuery	+= " AND A1_FILIAL = '" + xFilial("SA1") + "'"
	cQuery	+= " AND A1_COD = ABH_CODCLI"
	cQuery	+= " AND A1_LOJA = ABH_LOJA"
	cQuery	+= " AND SB1.B1_FILIAL = '" + xFilial("SB1") + "'"
	cQuery	+= " AND SB1.B1_COD = ABH_CODPRO"
	cQuery	+= " AND SE4.E4_FILIAL = '" + xFilial("SE4") + "'"
	cQuery	+= " AND SE4.E4_CODIGO = ABH_CPAGPV"
	cQuery	+= " AND AA1.AA1_FILIAL = '" + xFilial("AA1") + "'"
	cQuery	+= " AND AA1.AA1_CODTEC = ABJ_CODTEC"
	cQuery	+= " AND AAG.AAG_FILIAL = '" + xFilial("AAG") + "'"
	cQuery	+= " AND AAG.AAG_CODPRB = ABI_CODPRB"
	cQuery	+= " AND AAG.D_E_L_E_T_=' '"
	cQuery	+= " AND AA1.D_E_L_E_T_=' '"
	cQuery	+= " AND SE4.D_E_L_E_T_=' '"
	cQuery	+= " AND ABH.D_E_L_E_T_=' '"
	cQuery	+= " AND ABI.D_E_L_E_T_=' '"
	cQuery	+= " AND ABJ.D_E_L_E_T_=' '"
	cQuery	+= " AND SA1.D_E_L_E_T_=' '"
	cQuery	+= " AND SB1.D_E_L_E_T_=' '"
    cQuery	+= " UNION "

	cQryCpo	:=	""
	For nStru := 1 To Len(aStruABI)
		If aStruABI[nStru,2] <> "M"
			cQryCpo	+= ", "+aStruABI[nStru,1]
		EndIf
	Next nStru
	For nStru := 1 To Len(aStruABJ)
		If aStruABJ[nStru,2] == "C" .OR. aStruABJ[nStru,2] == "D"
			cQryCpo	+= ", ' ' "+aStruABJ[nStru,1]
		ElseIf aStruABJ[nStru,2] == "N"
			cQryCpo	+= ", 0 "+aStruABJ[nStru,1]
		EndIf		
	Next nStru
	cQuery	+= "SELECT A1_COD, A1_LOJA, A1_NOME, SB1.B1_COD, SB1.B1_DESC, SE4.E4_DESCRI, AAG.AAG_DESCRI, ' ' AA1_NOMTEC"
	cQuery	+= cQryCpo
	cQuery   += ",ABH_FILIAL, ABH_PROJET, ABH_CODCLI, ABH_LOJA, 	ABH_CODPRO, ABH_REFER,	ABH_ENTREG, ABH_DESCRI,	ABH_CODMEM,	ABH_CPAGPV"
	cQuery   += ",ABH_MOEDA,	ABH_SITUAC "
	cQuery	+= " FROM "+RetSqlName("ABH")+" ABH, "+RetSqlName("ABI")+" ABI, "+RetSqlName("SE4")+" SE4, "+RetSqlName("AAG")+" AAG, "
	cQuery	+= RetSqlName("SA1")+" SA1, "+RetSqlName("SB1")+" SB1"
	cQuery	+= " WHERE ABH_FILIAL='"+xFilial("ABH")+"'"
	cQuery	+= " AND ABH_PROJET	>='"+MV_PAR01+"'"
	cQuery	+= " AND ABH_PROJET	<='"+MV_PAR02+"'"
	cQuery	+= " AND ABH_CODCLI	>='"+MV_PAR03+"'"
	cQuery	+= " AND ABH_CODCLI	<='"+MV_PAR05+"'"
	cQuery	+= " AND ABH_LOJA >='"+MV_PAR04+"'"
	cQuery	+= " AND ABH_LOJA <='"+MV_PAR06+"'"
	cQuery	+= " AND ABH_CODPRO	>='"+MV_PAR07+"'"
	cQuery	+= " AND ABH_CODPRO	<='"+MV_PAR08+"'"
	cQuery	+= " AND ABH_REFER >='"+DtoS(MV_PAR09)+"'"
	cQuery	+= " AND ABH_ENTREG	<='"+DtoS(MV_PAR10)+"'"
	cQuery	+= If(MV_PAR13==4,""," AND ABH_SITUAC	='"+AllTrim(Str(MV_PAR13))+"'")
	cQuery	+= " AND ABI_FILIAL = '"+xFilial("ABI")+"'"
	cQuery	+= " AND ABI_PROJET	= ABH_PROJET"
	cQuery	+= " AND ABI_ETAPA >= '"+MV_PAR11+"'"
	cQuery	+= " AND ABI_ETAPA <= '"+MV_PAR12+"'"
	cQuery	+= " AND NOT EXISTS ( SELECT ABJ_PROJET, ABJ_ITEM FROM "+RetSqlName( "ABJ" )+" ABJ"
	cQuery	+= " WHERE ABJ_FILIAL = '"+xFilial("ABJ")+"'"
	cQuery	+= " AND ABJ_PROJET	= ABI_PROJET"
	cQuery	+= " AND ABJ_ITEM = ABI_ITEM"
	cQuery	+= " AND ABJ.D_E_L_E_T_=' ')"
	cQuery	+= " AND A1_FILIAL = '" + xFilial("SA1") + "'"
	cQuery	+= " AND A1_COD = ABH_CODCLI"
	cQuery	+= " AND A1_LOJA = ABH_LOJA"
	cQuery	+= " AND SB1.B1_FILIAL = '" + xFilial("SB1") + "'"
	cQuery	+= " AND SB1.B1_COD = ABH_CODPRO"
	cQuery	+= " AND SE4.E4_FILIAL = '" + xFilial("SE4") + "'"
	cQuery	+= " AND SE4.E4_CODIGO = ABH_CPAGPV"
	cQuery	+= " AND AAG.AAG_FILIAL = '" + xFilial("AAG") + "'"
	cQuery	+= " AND AAG.AAG_CODPRB = ABI_CODPRB"
	cQuery	+= " AND AAG.D_E_L_E_T_=' '"
	cQuery	+= " AND SE4.D_E_L_E_T_=' '"
	cQuery	+= " AND ABH.D_E_L_E_T_=' '"
	cQuery	+= " AND ABI.D_E_L_E_T_=' '"
	cQuery	+= " AND SA1.D_E_L_E_T_=' '"
	cQuery	+= " AND SB1.D_E_L_E_T_=' '"
    cQuery	+= " UNION "

	cQryCpo	:=	""
	For nStru := 1 To Len(aStruABI)
		If aStruABI[nStru,2] == "C" .OR. aStruABI[nStru,2] == "D"
			cQryCpo	+= ", ' ' "+aStruABI[nStru,1]
		ElseIf aStruABI[nStru,2] == "N"
			cQryCpo	+= ", 0 "+aStruABI[nStru,1]
		EndIf
	Next nStru
	For nStru := 1 To Len(aStruABJ)
		If aStruABJ[nStru,2] == "C" .OR. aStruABJ[nStru,2] == "D"
			cQryCpo	+= ", ' ' "+aStruABJ[nStru,1]
		ElseIf aStruABJ[nStru,2] == "N"
			cQryCpo	+= ", 0 "+aStruABJ[nStru,1]
		EndIf		
	Next nStru

	cQuery	+= "SELECT A1_COD, A1_LOJA, A1_NOME, SB1.B1_COD, SB1.B1_DESC, SE4.E4_DESCRI, ' ' AA1_NOMTEC, ' ' AAG_DESCRI"
	cQuery	+= cQryCpo	
	cQuery   += ",ABH_FILIAL, ABH_PROJET, ABH_CODCLI, ABH_LOJA, 	ABH_CODPRO, ABH_REFER,	ABH_ENTREG, ABH_DESCRI,	ABH_CODMEM,	ABH_CPAGPV"
	cQuery   += ",ABH_MOEDA,	ABH_SITUAC "
	cQuery	+= " FROM "+RetSqlName("ABH")+" ABH, "+RetSqlName("SE4")+" SE4, "
	cQuery	+= RetSqlName("SA1")+" SA1, "+RetSqlName("SB1")+" SB1"
	cQuery	+= " WHERE ABH_FILIAL='"+xFilial("ABH")+"'"
	cQuery	+= " AND ABH_PROJET	>='"+MV_PAR01+"'"
	cQuery	+= " AND ABH_PROJET	<='"+MV_PAR02+"'"
	cQuery	+= " AND ABH_CODCLI	>='"+MV_PAR03+"'"
	cQuery	+= " AND ABH_CODCLI	<='"+MV_PAR05+"'"
	cQuery	+= " AND ABH_LOJA >='"+MV_PAR04+"'"
	cQuery	+= " AND ABH_LOJA <='"+MV_PAR06+"'"
	cQuery	+= " AND ABH_CODPRO	>='"+MV_PAR07+"'"
	cQuery	+= " AND ABH_CODPRO	<='"+MV_PAR08+"'"
	cQuery	+= " AND ABH_REFER >='"+DtoS(MV_PAR09)+"'"
	cQuery	+= " AND ABH_ENTREG <='"+DtoS(MV_PAR10)+"'"
	cQuery	+= If(MV_PAR13==4,""," AND ABH_SITUAC	='"+AllTrim(Str(MV_PAR13))+"'")
	cQuery	+= " AND NOT EXISTS ( SELECT ABI_PROJET FROM "+RetSqlName( "ABI" )+" ABI"
	cQuery	+= " WHERE ABI_FILIAL = '"+xFilial("ABI")+"'"
	cQuery	+= " AND ABI_PROJET	= ABH_PROJET"
	cQuery	+= " AND ABI_ETAPA >= '"+MV_PAR11+"'"
	cQuery	+= " AND ABI_ETAPA <= '"+MV_PAR12+"'"
	cQuery	+= " AND ABI.D_E_L_E_T_=' ')"
	cQuery	+= " AND A1_FILIAL = '" + xFilial("SA1") + "'"
	cQuery	+= " AND A1_COD = ABH_CODCLI"
	cQuery	+= " AND A1_LOJA = ABH_LOJA"
	cQuery	+= " AND SB1.B1_FILIAL = '" + xFilial("SB1") + "'"
	cQuery	+= " AND SB1.B1_COD = ABH_CODPRO"
	cQuery	+= " AND SE4.E4_FILIAL = '" + xFilial("SE4") + "'"
	cQuery	+= " AND SE4.E4_CODIGO = ABH_CPAGPV"
	cQuery	+= " AND SE4.D_E_L_E_T_=' '"
	cQuery	+= " AND ABH.D_E_L_E_T_=' '"
	cQuery	+= " AND SA1.D_E_L_E_T_=' '"
	cQuery	+= " AND SB1.D_E_L_E_T_=' '"

	cQuery	+= " ORDER BY "+SqlOrder(ABH->(IndexKey())+","+ABI->(IndexKey())+","+ABJ->(IndexKey()))

	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasABH,.T.,.T.)

	For nStru := 1 To Len(aStruABH)
		If aStruABH[nStru,2] <> "C" .AND. !Empty( ( cAliasABH )->( FieldPos( aStruABH[nStru,1] ) ) )
			TcSetField(cAliasABH,aStruABH[nStru,1],aStruABH[nStru,2],aStruABH[nStru,3],aStruABH[nStru,4])
		EndIf
	Next nStru
	For nStru := 1 To Len(aStruABI)
		If aStruABI[nStru,2] <> "C" .AND. !Empty( ( cAliasABI )->( FieldPos( aStruABI[nStru,1] ) ) )
			TcSetField(cAliasABI,aStruABI[nStru,1],aStruABI[nStru,2],aStruABI[nStru,3],aStruABI[nStru,4])
		EndIf
	Next nStru
	For nStru := 1 To Len(aStruABJ)
		If aStruABJ[nStru,2] <> "C" .AND. !Empty( ( cAliasABJ )->( FieldPos( aStruABJ[nStru,1] ) ) )
			TcSetField(cAliasABJ,aStruABJ[nStru,1],aStruABJ[nStru,2],aStruABJ[nStru,3],aStruABJ[nStru,4])
		EndIf
	Next nStru
#ELSE
    lQuery	:= .F.
	ABH->(dbSetOrder(1))
	cKey	:= ABH->(IndexKey())
	cArqInd	:= CriaTrab(,.F.)

	cQuery	:= "ABH_FILIAL=='"+xFilial("ABH")+"'"
	cQuery	+= ".AND. ABH_PROJET >='"+MV_PAR01+"'"
	cQuery	+= ".AND. ABH_PROJET <='"+MV_PAR02+"'"
	cQuery	+= ".AND. ABH_CODCLI >='"+MV_PAR03+"'"
	cQuery	+= ".AND. ABH_CODCLI <='"+MV_PAR05+"'"
	cQuery	+= ".AND. ABH_LOJA >='"+MV_PAR04+"'"
	cQuery	+= ".AND. ABH_LOJA <='"+MV_PAR06+"'"
	cQuery	+= ".AND. ABH_CODPRO >='"+MV_PAR07+"'"
	cQuery	+= ".AND. ABH_CODPRO <='"+MV_PAR08+"'"
	cQuery	+= ".AND. DtoS(ABH_REFER) >='"+DtoS(MV_PAR09)+"'"
	cQuery	+= ".AND. DtoS(ABH_ENTREG) <='"+DtoS(MV_PAR10)+"'"
	cQuery	+= If(MV_PAR13==4,"",".AND. ABH_SITUAC	='"+AllTrim(Str(MV_PAR13))+"'")

	cAliasABH 	:= "ABH"
	cAliasABI 	:= "ABI"
	cAliasABJ 	:= "ABJ"
	cAliasSA1	:= "SA1"
	cAliasSB1	:= "SB1"
	cAliasSE4	:= "SE4"
	cAliasAA1	:= "AA1"
	cAliasAAG	:= "AAG"

	dbSelectArea("ABH")
	IndRegua("ABH",cArqInd,cKey,,cQuery)
	dbGotop()

#ENDIF

If !Empty( aReturn[7] )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Constroi um code-block a partir do filtro do usuario. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	bFiltro := &( " { || ( cAliasABH )->( " + aReturn[ 7 ] + " ) } " )
EndIf

dbSelectArea(cAliasABH)

While ( !Eof() .AND. (cAliasABH)->ABH_FILIAL==xFilial("ABH") )
	If lEnd
		@ Prow()+1,001 PSAY STR0015 //"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If Eval( bFiltro ) 
		If ( li > 60 )
			li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
			li++
		EndIf
		
		If ( cProjeto <> (cAliasABH)->ABH_PROJET )
			If !Empty(cProjeto)
				@ li, 000 PSAY Replicate("_", Limite)
				li	:= li+2
			EndIf
	    	#IFNDEF TOP
				dbSelectArea("SA1")
				dbSetOrder(1)
				MsSeek(xFilial("SA1")+(cAliasABH)->ABH_CODCLI)
				dbSelectArea("SB1")
				dbSetOrder(1)
				MsSeek(xFilial("SB1")+(cAliasABH)->ABH_CODPRO)
				dbSelectArea("SE4")
				dbSetOrder(1)
				MsSeek(xFilial("SE4")+(cAliasABH)->ABH_CPAGPV)
			#ENDIF
	
			@ li,000 PSAY (cAliasSA1)->A1_COD+"-"+(cAliasSA1)->A1_LOJA
			@ li,010 PSAY (cAliasSA1)->A1_NOME
			@ li,051 PSAY (cAliasABH)->ABH_PROJET
			@ li,059 PSAY (cAliasABH)->ABH_DESCRI
			@ li,100 PSAY (cAliasABH)->ABH_REFER
			@ li,114 PSAY (cAliasABH)->ABH_ENTREG
			@ li,125 PSAY (cAliasSB1)->B1_COD
			@ li,141 PSAY (cAliasSB1)->B1_DESC
			@ li,172 PSAY (cAliasSE4)->E4_DESCRI
			@ li,188 PSAY aSituacABH[Val((cAliasABH)->ABH_SITUAC)]
			li++
	
			cMemo		:= MSMM((cAliasABH)->ABH_CODMEM)
			nMemCount	:= MlCount(cMemo,220)
			nLi			:= 0
			
			If !Empty(nMemCount)
				For nLi	:= 1 To nMemCount
					cLinha	:= MemoLine(cMemo,220,nLi)
					If li > 60
						li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
						li++
					EndIf
					@ li,000 PSAY cLinha
					li++
				Next nLi
			EndIf
			cProjeto := (cAliasABH)->ABH_PROJET
		EndIf
	
		If MV_PAR14 == 1 //Analitico
		
			lICabABI := .F.
			lICabABJ := .F.	
	
	    	#IFNDEF TOP
	    		dbSelectArea(cAliasABI)
				dbSetOrder(1)
				MsSeek(xFilial("ABI")+(cAliasABH)->ABH_PROJET)
				While ( !Eof() .AND. (cAliasABI)->ABI_FILIAL==xFilial("ABI") .AND. (cAliasABI)->ABI_PROJET==(cAliasABH)->ABH_PROJET)
					dbSelectArea("SB1")
					dbSetOrder(1)
					MsSeek(xFilial("SB1")+(cAliasABI)->ABI_CODPRO)
					dbSelectArea("AAG")
					dbSetOrder(1)
					MsSeek(xFilial("AAG")+(cAliasABI)->ABI_CODPRB)
					If (cAliasABI)->ABI_ETAPA >= MV_PAR11 .AND. (cAliasABI)->ABI_ETAPA <= MV_PAR12
						If Empty(aColsABI)
							aAdd(aColsABI,{(cAliasABI)->ABI_ETAPA,;
								SubStr(AllTrim((cAliasABI)->ABI_DESCRI),1,30),;
								xMoeda((cAliasABI)->ABI_VALOR,(cAliasABH)->ABH_MOEDA,MV_PAR15),;
								(cAliasABI)->ABI_CODPRO,;
							 	(cAliasAAG)->AAG_DESCRI,;
								(cAliasABI)->ABI_INIPRV,;
								(cAliasABI)->ABI_FIMPRV,;
								(cAliasABI)->ABI_NUMOS,;
								(cAliasABI)->ABI_SITATU,;
								(cAliasABI)->ABI_NUMPV,;
								(cAliasABI)->ABI_ITEMPV,;
								(cAliasABI)->ABI_CODMEM})
                        EndIf
			    		dbSelectArea(cAliasABJ)
						dbSetOrder(1)
						MsSeek(xFilial("ABJ")+(cAliasABI)->ABI_PROJET+(cAliasABI)->ABI_ITEM)
						While ( !Eof() .AND. (cAliasABJ)->ABJ_FILIAL==xFilial("ABJ") .AND. (cAliasABJ)->ABJ_PROJET+(cAliasABJ)->ABJ_ITEM==(cAliasABI)->ABI_PROJET+(cAliasABI)->ABI_ITEM)
							dbSelectArea("AA1")
							dbSetOrder(1)
							MsSeek(xFilial("AA1")+(cAliasABJ)->ABJ_CODTEC)
							
							cAliasAB9	:= "AB9"
							dbSelectArea(cAliasAB9)
							dbSetOrder(4)
							MsSeek(xFilial("AB9")+(cAliasABJ)->ABJ_PROJET+(cAliasABJ)->ABJ_ITEM+(cAliasABJ)->ABJ_SUBITE)
			#ELSE
				If !Empty((cAliasABI)->ABI_ITEM)
					If Empty(aColsABI)
						aAdd(aColsABI,{(cAliasABI)->ABI_ETAPA,;
							SubStr(AllTrim((cAliasABI)->ABI_DESCRI),1,30),;
							xMoeda((cAliasABI)->ABI_VALOR,(cAliasABH)->ABH_MOEDA,MV_PAR15),;
							(cAliasABI)->ABI_CODPRO,;
							(cAliasAAG)->AAG_DESCRI,;
							(cAliasABI)->ABI_INIPRV,;
							(cAliasABI)->ABI_FIMPRV,;
							(cAliasABI)->ABI_NUMOS,;
							(cAliasABI)->ABI_SITATU,;
							(cAliasABI)->ABI_NUMPV,;
							(cAliasABI)->ABI_ITEMPV,;
							(cAliasABI)->ABI_CODMEM})
					EndIf
					If !Empty((cAliasABJ)->ABJ_SUBITE)
						AB9->(dbSetOrder(4))
						cKeyAB9		:= AB9->(IndexKey())
						cAliasAB9	:= GetNextAlias()

						cQueryAB9	:= "SELECT AB9_FILIAL, AB9_TAREFA, AB9_DTINI, AB9_HRINI, AB9_DTFIM, AB9_HRFIM"
						cQueryAB9	+= " FROM "+RetSqlName("AB9")+" AB9"
						cQueryAB9	+= " WHERE AB9_FILIAL='"+xFilial("AB9")+"'"
						cQueryAB9	+= " AND AB9_TAREFA	='"+(cAliasABJ)->ABJ_PROJET+(cAliasABJ)->ABJ_ITEM+(cAliasABJ)->ABJ_SUBITE+"'"
						cQueryAB9	+= " AND AB9.D_E_L_E_T_=' '"

						cQueryAB9	+= " ORDER BY "+SqlOrder(cKeyAB9)
						cQueryAB9	:= ChangeQuery(cQueryAB9)
						dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQueryAB9),cAliasAB9,.F.,.T.)
						
						TcSetField(cAliasAB9,"AB9_DTINI","D",TamSx3("AB9_DTINI")[1],TamSx3("AB9_DTINI")[2])
						TcSetField(cAliasAB9,"AB9_DTFIM","D",TamSx3("AB9_DTFIM")[1],TamSx3("AB9_DTFIM")[2])
			#ENDIF
						nHorasReal	:= 0
						nTotAtend	:= 0
						dIniReal	:= CToD( "" )
						dFimReal	:= CToD( "" )
					
						While ( !Eof() ) .AND. (cAliasAB9)->AB9_FILIAL==xFilial("AB9") .AND.; 
						(cAliasAB9)->AB9_TAREFA == (cAliasABJ)->ABJ_PROJET+(cAliasABJ)->ABJ_ITEM+(cAliasABJ)->ABJ_SUBITE
							nHorasReal	+=	SubtHoras((cAliasAB9)->AB9_DTINI, (cAliasAB9)->AB9_HRINI, (cAliasAB9)->AB9_DTFIM, (cAliasAB9)->AB9_HRFIM)
							dIniReal	:=	If((cAliasAB9)->AB9_DTINI<dIniReal .OR. Empty(dIniReal),(cAliasAB9)->AB9_DTINI,dIniReal)
							If (cAliasABJ)->ABJ_SITUAC == "1"
								dFimReal	:=	If((cAliasAB9)->AB9_DTFIM>dFimReal .OR. Empty(dIniReal),AB9->AB9_DTFIM,dFimReal)
							EndIf
							nTotAtend++
							dbSelectArea(cAliasAB9)
							dbSkip()
						End
						
						#IFDEF TOP
							dbSelectArea(cAliasAB9)
							dbCloseArea()
							dbSelectArea("AB9")
						#ENDIF
						
						aAdd(aColsABJ,{(cAliasABJ)->ABJ_TAREFA,;
							(cAliasABJ)->ABJ_DESCRI,;
							HoraToInt((cAliasABJ)->ABJ_TPREVI,4),;
							HoraToInt((cAliasABJ)->ABJ_TORCAD,4),;
						 	nHorasReal,;//ABJ_TREALI
							(cAliasABJ)->ABJ_SITUAC,;
							(cAliasABJ)->ABJ_SITATU,;
							(cAliasABJ)->ABJ_CODTEC,;
							(cAliasAA1)->AA1_NOMTEC,;
						 	nTotAtend,;//ABJ_NATEND
						 	dIniReal,; //ABJ_INIREA
						 	dFimReal}) //ABJ_FIMREA
						 	
						nHorasReal	:= 0
						nTotAtend	:= 0
						dIniReal	:= CToD( "" )
						dFimReal	:= CToD( "" )
						cEtapa	:=	(cAliasABI)->ABI_PROJET+(cAliasABI)->ABI_ITEM
		    #IFNDEF TOP
							dbSelectArea(cAliasABJ)
							dbSkip()
						End
			#ELSE
					EndIf
					dbSelectArea(cAliasABJ)
					dbSkip()
					IncRegua()
			#ENDIF
					If cEtapa <> (cAliasABI)->ABI_PROJET+(cAliasABI)->ABI_ITEM .OR. !lQuery
						dIniReal	:= CToD( "" )
						dFimReal	:= CToD( "" )
						dIniCols	:= CToD( "" )
						dFimCols	:= CToD( "" )
						nPrevHr		:= 0
						nRealHr		:= 0
						nOrcaHr		:= 0
						cStatusEtp	:= ""
						For nCntFor := 1 To Len(aColsABJ)
							nPrevHr	+= aColsABJ[ nCntFor, 3 ]
							nRealHr	+= aColsABJ[ nCntFor, 5 ]
							nOrcaHr	+= aColsABJ[ nCntFor, 4 ]
							cStatTaref	:= aColsABJ[ nCntFor, 6 ]
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Marca a etapa como concluida apenas se todas as tarefas estiverem      ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							cStatusEtp	:= If( cStatusEtp == "2", cStatusEtp, cStatTaref )
							dIniCols	:= aColsABJ[ nCntFor, 11 ]
							dFimCols	:= aColsABJ[ nCntFor, 12 ]
							If !Empty( dIniCols )
								dIniReal := If( dIniCols<dIniReal .OR. Empty( dIniReal ), dIniCols, dIniReal )
							EndIf
							dFimReal := If( dFimCols>dFimReal .OR. Empty( dFimReal ), dFimCols, dFimReal )
						Next nCntFor

						For nCntFor := 1 To Len(aColsABI)
							lICabABJ := .F.
							If ( li > 60 ) .OR. ( !lICabABI .AND. li > 56 )
								li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
								li++
								lCabABI	:=	.F.
							EndIf
				
							If !lICabABI
								li++
								//                                 1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17         18        19        20        21       22
								//                		 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
								cSubCab0 :=				"----- -----------------------------  -------------- --------------- -----------------------------  ---------- ---------- -------- ------------- --------- ----------- ---------- --------- ---------- ---------- ------ ----"
								cSubCab1 :=	STR0016 //	"ETAPA DESCRICAO                               VALOR PRODUTO         PROBLEMA                       INI.PREV.  FIM PREV.  O.S.     SITUAC.REAL   ST.ATUAL  INICIO REAL FINAL REAL PREV.HR.  ORCADO HR. REALIZ.HR. P.V.   ITEM"
								cSubCab2 :=	STR0014 //	"NOTAS"
								//						"----- -----------------------------  -------------- --------------- -----------------------------  ---------- ---------- -------- ------------- --------- ----------- ---------- --------- ---------- ---------- ------ ----"
								//			 			 XX    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 999.999.999,99 XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99/99/9999 99/99/9999 XXXXXXXX XXXXXXXXXXXXX XXXXXXXXX 99/99/9999  99/99/9999 999999:99 999999:999 999999:999 XXXXXX XX
								//						 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
								@ li,000 PSAY cSubCab0
								li++
								@ li,000 PSAY cSubCab1
								li++
								@ li,000 PSAY cSubCab2
								li++
								@ li,000 PSAY cSubCab0
								li++
								lICabABI := .T.
							EndIf
							
							@ li,000 PSAY aColsABI[nCntFor,1]
							@ li,006 PSAY aColsABI[nCntFor,2]
							@ li,037 PSAY aColsABI[nCntFor,3] PICTURE "@E 999,999,999.99"
							@ li,052 PSAY aColsABI[nCntFor,4]
							@ li,068 PSAY aColsABI[nCntFor,5]
							@ li,099 PSAY aColsABI[nCntFor,6]
							@ li,110 PSAY aColsABI[nCntFor,7]
							@ li,121 PSAY aColsABI[nCntFor,8]
							@ li,130 PSAY If(cStatusEtp == "",aSituacABI[Val("2")],aSituacABI[Val(cStatusEtp)])
							@ li,144 PSAY aStatus[Val(aColsABI[nCntFor,9])]
							@ li,154 PSAY dIniReal
							@ li,166 PSAY If( cStatusEtp == "1", dFimReal, CToD( "" ) )
							@ li,177 PSAY IntToHora( nPrevHr, 6 ) PICTURE "@R 999999:99"
							@ li,187 PSAY IntToHora( nOrcaHr, 6 ) PICTURE "@R 999999:99"
							@ li,198 PSAY IntToHora( nRealHr, 6 ) PICTURE "@R 999999:99"
							@ li,209 PSAY aColsABI[nCntFor,10]
							@ li,216 PSAY aColsABI[nCntFor,11]
							li++

							cMemo		:= MSMM(aColsABI[nCntFor,12])
							nMemCount	:= MlCount(cMemo,220)
							nLi			:= 0
							
							If !Empty(nMemCount)
								For nLi	:= 1 To nMemCount
									cLinha	:= MemoLine(cMemo,220,nLi)
									lICabABJ := .F.
									If li > 60
										li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
										li++
										@ li,000 PSAY cSubCab0
										li++
										@ li,000 PSAY cSubCab1
										li++
										@ li,000 PSAY cSubCab2
										li++
										@ li,000 PSAY cSubCab0
										li++
									EndIf
									@ li,000 PSAY cLinha
									li++
								Next nLi
							EndIf
						Next nCntFor
						
						aColsABI	:= {}

	
						For nCntFor := 1 To Len(aColsABJ)
							lICabABI := .F.
							If ( li > 60 ) .OR. ( !lICabABJ .AND. li > 56 )
								li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
								li++
								lICabABJ := .F.
							EndIf
							If !lICabABJ
								li++
								//                    		     1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17         18        19        20        21       22
								//         	 		   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
								cSubCab0 :=			  "------ ---------------------------------------- ------------ ---------- ------------- ------------- ------------  ------- ------------------------------ ------------ -----------  ----------"
								cSubCab1 :=	STR0017 //"TAREFA DESCRICAO                                PREVISAO HR. ORCADO HR. REALIZADO HR. SITUAC.REAL   STATUS ATUAL  TECNICO NOME                           ATENDIMENTOS INICIO REAL  FINAL REAL"
								//					  "------ ---------------------------------------- ------------ ---------- ------------- ------------- ------------  ------- ------------------------------ ------------ -----------  ----------
								//			 		   XX     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 999:999      999:999    999:999       XXXXXXXXXXXXX XXXXXXXXX     XXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX           99 99/99/9999   99/99/9999
								@ li,000 PSAY cSubCab0
								li++
								@ li,000 PSAY cSubCab1
								li++
								@ li,000 PSAY cSubCab0
								li++
								lICabABJ := .T.
		    				EndIf
							@ li,000 PSAY aColsABJ[nCntFor,1]
							@ li,007 PSAY aColsABJ[nCntFor,2]
							@ li,048 PSAY IntToHora(aColsABJ[nCntFor,3],6) PICTURE "@R 999999:99"
							@ li,061 PSAY IntToHora(aColsABJ[nCntFor,4],6) PICTURE "@R 999999:99"
							@ li,072 PSAY IntToHora(aColsABJ[nCntFor,5],6) PICTURE "@R 999999:99"
							@ li,086 PSAY aSituacABI[Val(aColsABJ[nCntFor,6])]
							@ li,100 PSAY aStatus[Val(aColsABJ[nCntFor,7])]
							@ li,114 PSAY aColsABJ[nCntFor,8]
							@ li,122 PSAY aColsABJ[nCntFor,9]
							@ li,153 PSAY aColsABJ[nCntFor,10] PICTURE "@E 99"
							@ li,166 PSAY aColsABJ[nCntFor,11]
							@ li,179 PSAY aColsABJ[nCntFor,12]
							li++
						Next nCntFor
						aColsABJ	:= {}
					EndIf
	    	#IFNDEF TOP
					EndIf
					dbSelectArea(cAliasABI)
					dbSkip()
				End
			#ELSE
				Else
					dbSelectArea(cAliasABI)
					dbSkip()
					IncRegua()
				EndIf
			#ENDIF
		EndIf
	Else
		lFiltrou := .T.
	EndIf

	If MV_PAR14 <> 1 .OR. lFiltrou .OR. !lQuery
		lFiltrou	:= .F.
		dbSelectArea(cAliasABH)
		dbSkip()
		IncRegua()
	EndIf
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a integriade da rotina                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	dbSelectArea(cAliasABH)
	dbCloseArea()
	dbSelectArea("ABH")
#ELSE
	dbSelectArea(cAliasABH)
	RetIndex("ABH")
	FErase(cArqInd+OrdBagExt())	
#ENDIF

Set Device To Screen
Set Printer To
If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
EndIf
MS_FLUSH()

dbSelectArea("ABH")
RetIndex("ABH")

Return(.T.)

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

Return Tcr700RptDef()

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

Return Tcr700PrtRpt( oReport , GetNextAlias())

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