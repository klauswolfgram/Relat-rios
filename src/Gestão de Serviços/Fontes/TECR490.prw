/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR490.CH"
#INCLUDE "REPORT.CH"

#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR490"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR490   ³ Autor ³ Eduardo Riera         ³ Data ³ 19.11.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Analise do Itens Utilizados x Itens Cobrados.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³18/08/2006³ Cleber M.     ³Bops 99268: Conversao para relatorio perso- ³±±
±±³          ³               ³nalizavel (Release 4).                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TECR490()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

If !FindFunction("TRepInUse") .OR. !TRepInUse()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa versao anterior do fonte³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	U_TECR490R3()
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ MV_PAR01 : Emissao de                                                  ³
	//³ MV_PAR02 : Emissao Ate                                                 ³
	//³ MV_PAR03 : Produto de                                                  ³
	//³ MV_PAR04 : Produto Ate                                                 ³
	//³ MV_PAR05 : Nr.O.S  de                                                  ³
	//³ MV_PAR06 : Nr.O.S  Ate                                                 ³
	//³ MV_PAR07 : Cliente de                                                  ³
	//³ MV_PAR08 : Cliente Ate                                                 ³
	//³ MV_PAR09 : Lista Quais     ? Tudo Diferencas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte("ATR490",.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := Tcr490RptDef()
	oReport:PrintDialog()
EndIf

RestArea( aArea )
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr490RptDef ºAutor  ³Cleber Martinez     º Data ³  18/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR490 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr490RptDef()
Local oReport				// Objeto do relatorio
Local oSection1				// Objeto da secao 1
Local aOrdem 			:= {STR0005,STR0006,STR0007} 	//"OS"###"Cliente"###"Produto/Eqto"
Local cAlias1			:= "AB7"						// Pega o proximo Alias Disponivel
Local nTamABA_CODPRO	:= TamSX3("ABA_CODPRO")[1]		//Tamanho do campo ABA_CODPRO 
Local nTamABA_VALUNIT:= TamSX3("AB8_VUNIT")[1]+TamSX3("AB8_VUNIT")[2] + 8 //Aumentando o campo para apresentar o valor inteiro quando possuir mais de 14 digitos
Local nTamABA_VALTOT := TamSX3("AB8_TOTAL")[1]+TamSX3("AB8_TOTAL")[2] + 8
Local nTamOSItem	:= 	TamSX3("AB7_NUMOS")[1]+TamSX3("AB7_ITEM")[1] + 2	
Local nTamCodCli	:= 	TamSX3("AB7_CODCLI")[1] + 4	

#IFDEF TOP
	cAlias1	:= GetNextAlias()
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR490" TITLE STR0001 PARAMETER "ATR490" ACTION {|oReport| Tcr490PrtRpt(oReport, aOrdem, cAlias1)} DESCRIPTION STR0002+STR0003+STR0004 TOTAL TEXT STR0020 TOTAL IN COLUMN //"TOTAL GERAL"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0030 TABLES "AB7","AB8","ABA","AAG" ORDERS aOrdem  // "Itens da ordem de serviço"

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		DEFINE CELL NAME "OS" 			OF oSection1 TITLE RetTitle("AB7_NUMOS") + "\" + Alltrim(RetTitle("AB7_ITEM")) SIZE nTamOSItem BLOCK {||  (cAlias1)->AB7_NUMOS+"-"+(cAlias1)->AB7_ITEM }
		DEFINE CELL NAME "Cliente" 		OF oSection1 TITLE Alltrim(RetTitle("AB7_CODCLI")) SIZE nTamCodCli BLOCK {|| (cAlias1)->AB7_CODCLI }
		DEFINE CELL NAME "AB7_CODPRO" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AB7_CODPRB" 	OF oSection1 ALIAS "AB7" 
		DEFINE CELL NAME "AAG_DESCRI" 	OF oSection1 ALIAS "AAG"
		DEFINE CELL NAME "cProdABA" 	OF oSection1 ALIAS " " TITLE STR0021 SIZE nTamABA_CODPRO	//"Produto"
		DEFINE CELL NAME "AB6_MOEDA" 	OF oSection1 ALIAS "AB6" ALIGN CENTER
		DEFINE CELL NAME "nQtdABA"		OF oSection1 ALIAS " " TITLE STR0022 PICTURE PesqPict("ABA","ABA_QUANT",14)	ALIGN RIGHT	//"Qtde Utiliz"
		DEFINE CELL NAME "nVlrABA" 		OF oSection1 ALIAS " " TITLE STR0023 PICTURE PesqPict("SB1","B1_PRV1",14)   SIZE nTamABA_VALUNIT ALIGN RIGHT	//"Valor Utiliz"
		DEFINE CELL NAME "nTotABA"	 	OF oSection1 ALIAS " " TITLE STR0024 PICTURE PesqPict("SB1","B1_PRV1",14)	  SIZE nTamABA_VALTOT ALIGN RIGHT	//"Total Utiliz"
		DEFINE CELL NAME "nQtdAB8"	 	OF oSection1 ALIAS " " TITLE STR0025 PICTURE PesqPict("AB8","AB8_QUANT",14) ALIGN RIGHT	//"Qtde Cobrada"
		DEFINE CELL NAME "nVlrAB8"	 	OF oSection1 ALIAS " " TITLE STR0026 PICTURE PesqPict("AB8","AB8_VUNIT",14) SIZE nTamABA_VALUNIT ALIGN RIGHT	//"Valor Cobrado"
		DEFINE CELL NAME "nTotAB8" 		OF oSection1 ALIAS " " TITLE STR0027 PICTURE PesqPict("AB8","AB8_TOTAL",14) SIZE nTamABA_VALTOT ALIGN RIGHT	//"Total Cobrado"
		DEFINE CELL NAME "nQtdDif"		OF oSection1 ALIAS " " TITLE STR0028 PICTURE PesqPict("AB8","AB8_TOTAL",14) ALIGN RIGHT //"Qtde (Difer.)"
		DEFINE CELL NAME "nTotDif" 		OF oSection1 ALIAS " " TITLE STR0029 PICTURE PesqPict("AB8","AB8_TOTAL",14) SIZE nTamABA_VALTOT ALIGN RIGHT //"Valor (Difer.)"
        
		oSection1:SetHeaderPage(.T.)
		
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr490PrtRptºAutor  ³Cleber Martinez     º Data ³  21/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±º          ³aOrdem:  Array com as ordens de impressao disponiveis      	º±±
±±º          ³cAlias1: Alias principal do relatorio                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR490 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr490PrtRpt( oReport, aOrdem, cAlias1 )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local oBreak										// Quebra de secao (Cliente ou Produto)
Local lImp    := .F. 								// Indica se algo foi impresso
Local lImpAB7 := .F. 								// Indica se algo foi impresso
Local nOrdem 	:= 1								// Ordem definida pelo usuario
Local cOrderBy	:= ""								// Chave de ordenacao
Local cIndexKey := ""								// Indice do filtro (CodeBase)
Local cQuebra 	:= ""								// Conteudo da quebra do relatorio
Local cFiltro	:= ""								// Filtro da tabela (CodeBase)
Local nLin 		:= 0								// Guarda a linha atual impressa

Local cProdABA:= ""									// Campo ABA_CODPRO
Local cProdAB8:= ""									// Campo AB8_CODPRO
Local nQtdABA := 0									// Qtde do arq. ABA
Local nQtdAB8 := 0									// Qtde do arq. AB8
Local nQtdDif := 0									// Diferenca de qtde 
Local nTotABA := 0									// Total do arq. ABA
Local nTotAB8 := 0									// Total do arq. AB8
Local nTotDif := 0									// Diferenca de total
Local nVlrAB8 := 0									// Valor do arq. AB8
Local nVlrABA := 0									// Valor do arq. ABA
Local nPMoeda := 0									// Posicao da moeda no array
Local nTMoeda := 0									// Indice usado em lacos For...Next
Local aTotal  := {}									// Array com os totais por Moeda

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega a ordem escolhida pelo usuario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem := oSection1:GetOrder() 
If nOrdem <= 0
	nOrdem := 1
EndIf
        
Do Case
	Case ( nOrdem == 1 ) 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a ordenacao por Ordem de Serv.   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOrderBy := "% AB7_FILIAL,AB7_NUMOS,AB7_EMISSA %"
		cIndexKey := "AB7_FILIAL+AB7_NUMOS+Dtos(AB7_EMISSA)"
	Case ( nOrdem == 2 )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a ordenacao e quebra por Cliente ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOrderBy := "% AB7_FILIAL,AB7_CODCLI,AB7_EMISSA %"
		cIndexKey := "AB7_FILIAL+AB7_CODCLI+Dtos(AB7_EMISSA)"		
		oBreak := TRBreak():New(oSection1,oSection1:Cell("AB7_CODCLI"),STR0018,.F.)
	Case ( nOrdem == 3 ) 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a ordenacao e quebra por Produto ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOrderBy := "% AB7_FILIAL,AB7_CODPRO,AB7_EMISSA %"
		cIndexKey := "AB7_FILIAL+AB7_CODPRO+Dtos(AB7_EMISSA)"
		oBreak := TRBreak():New(oSection1,oSection1:Cell("AB7_CODPRO"),STR0019,.F.)
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao das funcoes de totalizacao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRFunction():New(oSection1:Cell("nQtdABA"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.T.) 
TRFunction():New(oSection1:Cell("nVlrABA"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nTotABA"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nQtdAB8"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nVlrAB8"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nTotAB8"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nQtdDif"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oSection1:Cell("nTotDif"),NIL,"SUM",oBreak,"",/*cPicture*/,/*uFormula*/,.F.,.T.)

#IFDEF TOP
	DbSelectArea("AB7")
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR490")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	AB7_FILIAL,	AB7_NUMOS,	AB7_ITEM,	AB7_CODCLI,
				AB7_CODPRO,	AB7_CODPRB,	AB7_EMISSA
		
		FROM %table:AB7% AB7
		
		WHERE	AB7_FILIAL = %xfilial:AB7%		AND
				AB7_EMISSA >= %exp:DtoS(mv_par01)%		AND
				AB7_EMISSA <= %exp:DtoS(mv_par02)%		AND				
				AB7_CODPRO >= %exp:mv_par03%	AND
				AB7_CODPRO <= %exp:mv_par04%	AND	
				AB7_NUMOS >= %exp:mv_par05%		AND 
				AB7_NUMOS <= %exp:mv_par06%		AND
				AB7_CODCLI >= %exp:mv_par07%	AND
				AB7_CODCLI <= %exp:mv_par08%	AND
				AB7.%notDel%

		ORDER BY %exp:cOrderBy%
	EndSql
	
	END REPORT QUERY oSection1 

#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR490")

	DbSelectArea( cAlias1 ) 
	DbSetOrder(1)

	cFiltro := "AB7_FILIAL=='"+xFilial("AB7")+"'.And."
	cFiltro += "Dtos(AB7_EMISSA)>='"+Dtos(MV_PAR01)+"'.And."
	cFiltro += "Dtos(AB7_EMISSA)<='"+Dtos(MV_PAR02)+"'.And."
	cFiltro += "AB7_CODPRO>='"+MV_PAR03+"'.And."
	cFiltro += "AB7_CODPRO<='"+MV_PAR04+"'.And."
	cFiltro += "AB7_NUMOS>='"+MV_PAR05+"'.And."
	cFiltro += "AB7_NUMOS<='"+MV_PAR06+"'.And."
	cFiltro += "AB7_CODCLI>='"+MV_PAR07+"'.And."
	cFiltro += "AB7_CODCLI<='"+MV_PAR08+"'"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua o filtro de acordo com a expressao do arquivo AB7 (Itens da OS)								 ³
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

oSection1:Init()
                
While !oReport:Cancel() .AND. !(cAlias1)->(Eof())

	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf
	
	dbSelectArea("SA1")
	dbSetOrder(1)
	MsSeek(xFilial("SA1")+(cAlias1)->AB7_CODCLI)
	dbSelectArea("AAG")
	dbSetOrder(1)
	MsSeek(xFilial("AAG")+(cAlias1)->AB7_CODPRB)
	dbSelectArea("AB6")
	dbSetOrder(1)
	MsSeek(xFilial("AB6")+(cAlias1)->AB7_NUMOS)
   	nQtdAB8	:= 0
	nQtdABA	:= 0
	nVlrAB8	:= 0
	nVlrABA	:= 0
	nTotAB8	:= 0
	nTotABA	:= 0
	nQtdDif  := 0
	nTotDif  := 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Processa as Diferencas do Atendimento e da OS                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("ABA")
	dbSetOrder(3)
	MsSeek(xFilial("ABA")+(cAlias1)->AB7_NUMOS+(cAlias1)->AB7_ITEM)
   	While ( !ABA->( Eof() ) .And. xFilial("ABA") == ABA->ABA_FILIAL .And.;
							(cAlias1)->AB7_NUMOS+(cAlias1)->AB7_ITEM == ABA->ABA_NUMOS )
      	
      	cProdABA:= ABA->ABA_CODPRO
      	nQtdABA += ABA->ABA_QUANT
		
		nVlrABA += At450Tab(cProdABA,AB6->AB6_TABELA,ABA->ABA_QUANT,AB6->AB6_CODCLI,AB6->AB6_LOJA,AB6->AB6_MOEDA)
      	dbSelectArea("ABA")
		dbSkip()
		If ( cProdABA <> ABA->ABA_CODPRO )
			dbSelectArea("AB8")
			dbSetOrder(5)
			MsSeek(xFilial("AB8")+(cAlias1)->AB7_NUMOS+(cAlias1)->AB7_ITEM+cProdABA)
			While ( !AB8->( Eof() ) .And. xFilial("AB8") == AB8->AB8_FILIAL .And.;
										(cAlias1)->AB7_NUMOS == AB8->AB8_NUMOS .And.;
										(cAlias1)->AB7_ITEM  == AB8->AB8_ITEM .And.;
										cProdABA			== AB8->AB8_CODPRO )

            	nQtdAB8 += AB8->AB8_QUANT
				nVlrAB8 += AB8->AB8_PRCLIS
				dbSelectArea("AB8")
				dbSkip()
			End
			
			If ( (MV_PAR09 == 1 .Or. nQtdAb8<>nQtdABA .Or. nVlrAb8<>nVlrAbA ) )
		
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Calcula os valores e atualiza o valor das celulas ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nTotAb8 := nQtdAb8 * nVlrAB8
				nTotAbA := nQtdAbA * nVlrABA
				nQtdDif := nQtdAB8 - nQtdABA
				nTotDif := nTotAb8 - nTotAbA
		        
				oSection1:Cell("cProdABA"):SetValue(cProdABA)
				oSection1:Cell("nQtdAB8"):SetValue(nQtdAb8)
				oSection1:Cell("nVlrAB8"):SetValue(nVlrAb8)
				oSection1:Cell("nQtdABA"):SetValue(nQtdAbA)
				oSection1:Cell("nVlrABA"):SetValue(nVlrAbA)
				oSection1:Cell("nTotAB8"):SetValue(nTotAb8)
				oSection1:Cell("nTotABA"):SetValue(nTotAbA)
				oSection1:Cell("nQtdDif"):SetValue(nQtdDif)
				oSection1:Cell("nTotDif"):SetValue(nTotDif)
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime a secao 1 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !isBlind()
		       	oSection1:PrintLine()
				EndIf
				If Empty(nPMoeda:=aScan(aTotal,{|x|x[1]==Str(AB6->AB6_MOEDA,1)}))
					aAdd(aTotal,{Str(AB6->AB6_MOEDA,1),{nQtdABA,;
														nQtdABA,;
														nQtdAB8,;
														nQtdAB8,;
														nQtdDif,;
														nQtdDif,;
														nVlrABA,;
														nVlrABA,;
														nVlrAB8,;
														nVlrAB8,;
														nTotABA,;
														nTotABA,;
														nTotAB8,;
														nTotAB8,;
														nTotDif,;
														nTotDif}})
				Else
					aTotal[nPMoeda,2,01] += nQtdABA
					aTotal[nPMoeda,2,02] += nQtdABA
					aTotal[nPMoeda,2,03] += nQtdAB8
					aTotal[nPMoeda,2,04] += nQtdAB8
					aTotal[nPMoeda,2,05] += nQtdDif
					aTotal[nPMoeda,2,06] += nQtdDif
					aTotal[nPMoeda,2,07] += nVlrABA
					aTotal[nPMoeda,2,08] += nVlrABA
					aTotal[nPMoeda,2,09] += nVlrAB8
					aTotal[nPMoeda,2,10] += nVlrAB8
					aTotal[nPMoeda,2,11] += nTotABA
					aTotal[nPMoeda,2,12] += nTotABA
					aTotal[nPMoeda,2,13] += nTotAB8
					aTotal[nPMoeda,2,14] += nTotAB8
					aTotal[nPMoeda,2,15] += nTotDif
					aTotal[nPMoeda,2,16] += nTotDif
				EndIf
            	lImpAB7 := .T.
				lImp := .T.
			EndIf
			nQtdAB8	:= 0
			nQtdABA	:= 0
			nVlrAB8	:= 0
			nVlrABA	:= 0
			nTotAb8  := 0
			nTotABA  := 0
			nQtdDif  := 0
			nTotDif  := 0
		EndIf
	End
   	
	nQtdAB8	:= 0
	nQtdABA	:= 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Processa as Diferencas entre a OS e o Atendimento                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   	dbSelectArea("AB8")
	dbSetOrder(5)
	MsSeek(xFilial("AB8")+(cAlias1)->AB7_NUMOS+(cAlias1)->AB7_ITEM)
   	While ( !AB8->( Eof() ) .And. xFilial("AB8") == AB8->AB8_FILIAL .And.;
										(cAlias1)->AB7_NUMOS == AB8->AB8_NUMOS .And.;
										(cAlias1)->AB7_ITEM  == AB8->AB8_ITEM )
		cProdAB8:= AB8->AB8_CODPRO
      	nQtdAB8 += AB8->AB8_QUANT
		nVlrAB8 += At450Tab(cProdAB8,AB6->AB6_TABELA,AB8->AB8_QUANT,AB6->AB6_CODCLI,AB6->AB6_LOJA,AB6->AB6_MOEDA)
      	dbSelectArea("AB8")
		dbSkip()
		If ( cProdAB8 != AB8->AB8_CODPRO )
			dbSelectArea("ABA")
			dbSetOrder(3)
			If ( !MsSeek(xFilial("ABA")+(cAlias1)->AB7_NUMOS+(cAlias1)->AB7_ITEM+cProdAB8) )

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Calcula os valores e atualiza o valor das celulas ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
				nTotAb8 := nQtdAb8 * nVlrAB8
				nTotAbA := nQtdAbA * nVlrABA
				nQtdDif := nQtdAB8 - nQtdABA
				nTotDif := nTotAb8 - nTotAbA
				
				oSection1:Cell("cProdABA"):SetValue(cProdAB8)
				oSection1:Cell("nQtdAB8"):SetValue(nQtdAb8)
				oSection1:Cell("nVlrAB8"):SetValue(nVlrAb8)
				oSection1:Cell("nQtdABA"):SetValue(nQtdAbA)
				oSection1:Cell("nVlrABA"):SetValue(nVlrAbA)
				oSection1:Cell("nTotAB8"):SetValue(nTotAb8)
				oSection1:Cell("nTotABA"):SetValue(nTotAbA)
				oSection1:Cell("nQtdDif"):SetValue(nQtdDif)
				oSection1:Cell("nTotDif"):SetValue(nTotDif)
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime a secao 1 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !isBlind()
		       	oSection1:PrintLine()
				EndIf
				
				If Empty(nPMoeda:=aScan(aTotal,{|x|x[1]==Str(AB6->AB6_MOEDA,1)}))
					aAdd(aTotal,{Str(AB6->AB6_MOEDA,1),{nQtdABA,;
														nQtdABA,;
														nQtdAB8,;
														nQtdAB8,;
														nQtdDif,;
														nQtdDif,;
														nVlrABA,;
														nVlrABA,;
														nVlrAB8,;
														nVlrAB8,;
														nTotABA,;
														nTotABA,;
														nTotAB8,;
														nTotAB8,;
														nTotDif,;
														nTotDif}})
				Else
					aTotal[nPMoeda,2,01] += nQtdABA
					aTotal[nPMoeda,2,02] += nQtdABA
					aTotal[nPMoeda,2,03] += nQtdAB8
					aTotal[nPMoeda,2,04] += nQtdAB8
					aTotal[nPMoeda,2,05] += nQtdDif
					aTotal[nPMoeda,2,06] += nQtdDif
					aTotal[nPMoeda,2,07] += nVlrABA
					aTotal[nPMoeda,2,08] += nVlrABA
					aTotal[nPMoeda,2,09] += nVlrAB8
					aTotal[nPMoeda,2,10] += nVlrAB8
					aTotal[nPMoeda,2,11] += nTotABA
					aTotal[nPMoeda,2,12] += nTotABA
					aTotal[nPMoeda,2,13] += nTotAB8
					aTotal[nPMoeda,2,14] += nTotAB8
					aTotal[nPMoeda,2,15] += nTotDif
					aTotal[nPMoeda,2,16] += nTotDif
				EndIf
				lImpAB7 := .T.
				lImp := .T.
			EndIf
			nQtdAB8	:= 0
			nQtdABA	:= 0
			nVlrAB8	:= 0
			nVlrABA	:= 0
			nTotAb8  := 0
			nTotABA  := 0
			nQtdDif  := 0
			nTotDif  := 0
		EndIf
	End
	dbSelectArea(cAlias1)
	dbSkip()
End
oSection1:Finish()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR490R3 ³ Autor ³ Eduardo Riera         ³ Data ³ 19.11.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Analise do Itens Utilizados x Itens Cobrados.               ³±±
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

User Function TECR490R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local Titulo  := OemToAnsi(STR0001) //"Comparativo Atendimento X Ordem de Servico"
Local cDesc1  := OemToAnsi(STR0002) //"    Este programa emite um Comparativo dos itens utilizados no atendimento da "
Local cDesc2  := OemToAnsi(STR0003) //"Ordem de Servico com os itens efetivamente cobrados, conforme os parametros   "
Local cDesc3  := OemToAnsi(STR0004) //"Solicitados"
Local cString := "AB7"  // Alias utilizado na Filtragem
Local lDic    := .F. // Habilita/Desabilita Dicionario
Local lComp   := .T. // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro := .T. // Habilita/Desabilita o Filtro
Local wnrel   := "TECR490"  // Nome do Arquivo utilizado no Spool
Local nomeprog:= "TECR490"  // nome do programa

Private Tamanho := "G" // P/M/G
Private Limite  := 220 // 80/132/220
Private aOrdem  := {STR0005,STR0006,STR0007} //"OS"###"Cliente"###"Produto/Eqto"
Private cPerg   := "ATR490"  // Pergunta do Relatorio
Private aReturn := { STR0008, 1,STR0009, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ MV_PAR01 : Emissao de                                                  ³
//³ MV_PAR02 : Emissao Ate                                                 ³
//³ MV_PAR03 : Produto de                                                  ³
//³ MV_PAR04 : Produto Ate                                                 ³
//³ MV_PAR05 : Nr.O.S  de                                                  ³
//³ MV_PAR06 : Nr.O.S  Ate                                                 ³
//³ MV_PAR07 : Cliente de                                                  ³
//³ MV_PAR08 : Cliente Ate                                                 ³
//³ MV_PAR09 : Lista Quais     ? Tudo Diferencas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrinter                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
Endif
SetDefault(aReturn,cString)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
Endif
#IFDEF WINDOWS
	RptStatus({|lEnd| ImpDet(	@lEnd,	wnRel,	cString,	nomeprog,;
								Titulo	)},	Titulo)
#ELSE
	ImpDet(	.F.,	wnrel,	cString,	nomeprog,;
			Titulo	)
#ENDIF

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³ Eduardo Riera         ³ Data ³02.07.1998³±±
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
±±³06/09/2006³ Cleber M.     ³Bops 99268: Alteracao no layout para caber  ³±±
±±³          ³               ³todas as colunas na pagina.                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ImpDet(	lEnd,	wnrel,	cString,	nomeprog,;
						Titulo	)

Local li      := 100 // Contador de Linhas
Local lImp    := .F. // Indica se algo foi impresso
Local lImpAB7 := .F. // Indica se algo foi impresso
Local cbCont  := 0   // Numero de Registros Processados
Local cbText  := ""  // Mensagem do Rodape
Local cQuery  := ""
Local cArqInd := CriaTrab(,.F.)
Local cChave  := ""
Local cQuebra := ""
Local cProdABA:= ""
Local cProdAB8:= ""
Local nQtdABA := 0
Local nQtdAB8 := 0
Local nQtdDif := 0
Local nTotABA := 0
Local nTotAB8 := 0
Local nTotDif := 0
Local nVlrAB8 := 0
Local nVlrABA := 0
Local nPMoeda := 0
Local nTMoeda := 0
Local aTotal  := {}
//
//                                     1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                           0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Local cCabec1	:= STR0010 //"NR.OS     CLIENTE   PRODUTO/EQTO    OCORRENCIA/PROBLEMA                             PRODUTO         MOEDA <                 UTILIZADO                > <                  COBRADO                 > <          DIFERENCA         >"
Local cCabec2	:= STR0011 //"                                                                                                        QUANTIDADE          VALOR          TOTAL     QUANTIDADE          VALOR          TOTAL      QUANTIDADE          VALOR"
//							  999999-99 XXXXXX-XX XXXXXXXXXXXXXXX XXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX           XXXXXXXXXXXXXXX 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99 999,999,999.99  999,999,999.99 999,999,999.99
dbSelectArea(cString)
SetRegua(LastRec())
cQuery += "AB7_FILIAL=='"+xFilial("AB7")+"'.And."
cQuery += "Dtos(AB7_EMISSAO)>='"+Dtos(MV_PAR01)+"'.And."
cQuery += "Dtos(AB7_EMISSAO)<='"+Dtos(MV_PAR02)+"'.And."
cQuery += "AB7_CODPRO>='"+MV_PAR03+"'.And."
cQuery += "AB7_CODPRO<='"+MV_PAR04+"'.And."
cQuery += "AB7_NUMOS>='"+MV_PAR05+"'.And."
cQuery += "AB7_NUMOS<='"+MV_PAR06+"'.And."
cQuery += "AB7_CODCLI>='"+MV_PAR07+"'.And."
cQuery += "AB7_CODCLI<='"+MV_PAR08+"'"
Do Case
	Case ( aReturn[8] == 1 ) //OS
		cChave := "AB7_FILIAL+AB7_NUMOS+Dtos(AB7_EMISSAO)"
		Titulo += STR0012 // "[ OS ]"
	Case ( aReturn[8] == 2 ) //Cliente
		cChave := "AB7_FILIAL+AB7_CODCLI+Dtos(AB7_EMISSAO)"
		Titulo += STR0013 // "[ CLIENTE ]"
	Case ( aReturn[8] == 3 ) //Produto/Eqto
		cChave := "AB7_FILIAL+AB7_CODPRO+Dtos(AB7_EMISSAO)"
		Titulo += STR0014 // "[ PRODUTO ]"
EndCase
IndRegua("AB7",cArqInd,cChave,,cQuery)
MsSeek(xFilial("AB7"))
While ( !AB7->( Eof() ) .And. xFilial("AB7") == AB7->AB7_FILIAL )
	#IFNDEF WINDOWS
		If LastKey() = 286
			lEnd := .T.
		EndIf
	#ENDIF
	If lEnd
		@ Prow()+1,001 PSAY STR0015 //"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If ( li > 60 )
		li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
		li++
	EndIf
	dbSelectArea("SA1")
	dbSetOrder(1)
	MsSeek(xFilial("SA1")+AB7->AB7_CODCLI)
	dbSelectArea("AAG")
	dbSetOrder(1)
	MsSeek(xFilial("AAG")+AB7->AB7_CODPRB)
	dbSelectArea("AB6")
	dbSetOrder(1)
	MsSeek(xFilial("AB6")+AB7->AB7_NUMOS)
   	nQtdAB8	:= 0
	nQtdABA	:= 0
	nVlrAB8	:= 0
	nVlrABA	:= 0
	nTotAB8	:= 0
	nTotABA	:= 0
	nQtdDif  := 0
	nTotDif  := 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Processa as Diferencas do Atendimento e da OS                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("ABA")
	dbSetOrder(3)
	MsSeek(xFilial("ABA")+AB7->AB7_NUMOS+AB7->AB7_ITEM)
   	While ( !ABA->( Eof() ) .And. xFilial("ABA") == ABA->ABA_FILIAL .And.;
								AB7->AB7_NUMOS+AB7->AB7_ITEM == ABA->ABA_NUMOS )
      	cProdABA:= ABA->ABA_CODPRO
      	nQtdABA += ABA->ABA_QUANT
		
		nVlrABA += At450Tab(cProdABA,AB6->AB6_TABELA,ABA->ABA_QUANT,AB6->AB6_CODCLI,AB6->AB6_LOJA,AB6->AB6_MOEDA)
      	dbSelectArea("ABA")
		dbSkip()
		If ( cProdABA != ABA->ABA_CODPRO )
			dbSelectArea("AB8")
			dbSetOrder(5)
			MsSeek(xFilial("AB8")+AB7->AB7_NUMOS+AB7->AB7_ITEM+cProdABA)
			While ( !AB8->( Eof() ) .And. xFilial("AB8") == AB8->AB8_FILIAL .And.;
										AB7->AB7_NUMOS == AB8->AB8_NUMOS .And.;
										AB7->AB7_ITEM  == AB8->AB8_ITEM .And.;
										cProdABA			== AB8->AB8_CODPRO )
            	nQtdAB8 += AB8->AB8_QUANT
				nVlrAB8 += AB8->AB8_PRCLIS
				dbSelectArea("AB8")
				dbSkip()
			End
			If ( (MV_PAR09 == 1 .Or. nQtdAb8!=nQtdABA .Or. ;
											 nVlrAb8!=nVlrAbA ) )
				Do Case
					Case ( aReturn[8] == 2 )
						If ( cQuebra != AB7->AB7_CODCLI )
							@ Li,000 PSAY STR0016+SA1->A1_NOME //"CLIENTE: "		
							Li+=2
						EndIf
						cQuebra := AB7->AB7_CODCLI
					Case ( aReturn[8] == 3 )
						If ( cQuebra != AB7->AB7_CODPRO )
							dbSelectArea("SB1")
							dbSetOrder(1)
							MsSeek(xFilial("SB1")+AB7->AB7_CODPRO)
							@ Li,000 PSAY STR0017+SB1->B1_DESC //"PRODUTO/EQTO: "
							Li+=2
						EndIf
						cQuebra := AB7->AB7_CODPRO
				EndCase
				nTotAb8 := nQtdAb8 * nVlrAB8
				nTotAbA := nQtdAbA * nVlrABA
				nQtdDif := nQtdAB8 - nQtdABA
				nTotDif := nTotAb8 - nTotAbA
				@ Li,000 PSAY AB7->AB7_NUMOS+"-"+AB7->AB7_ITEM
				@ Li,010 PSAY AB7->AB7_CODCLI
				@ Li,020 PSAY AB7->AB7_CODPRO 
				@ Li,036 PSAY AB7->AB7_CODPRB
				@ Li,043 PSAY PadR(AAG->AAG_DESCRI,20)
				@ Li,064 PSAY PadR(cProdABA,15)
				@ Li,080 PSAY Str(AB6->AB6_MOEDA,1)
				@ Li,086 PSAY nQtdABA		PICTURE PesqPict("ABA","ABA_QUANT",14)
				@ Li,101 PSAY nVlrABA      PICTURE PesqPict("SB1","B1_PRV1",14)
				@ Li,116 PSAY nTotABA      PICTURE Tm(nTotABA,14)
				@ Li,131 PSAY nQtdAB8		PICTURE PesqPict("AB8","AB8_QUANT",14)
				@ Li,146 PSAY nVlrAB8      PICTURE PesqPict("AB8","AB8_VUNIT",14)
				@ Li,161 PSAY nTotAB8      PICTURE Tm(nTotAB8,14)
				@ Li,177 PSAY nQtdDif      PICTURE TM(nQtdDif,14)
				@ Li,192 PSAY nTotDif      PICTURE Tm(nTotDif,14)
				Li++
				If Empty(nPMoeda:=aScan(aTotal,{|x|x[1]==Str(AB6->AB6_MOEDA,1)}))
					aAdd(aTotal,{Str(AB6->AB6_MOEDA,1),{nQtdABA,;
																		nQtdABA,;
																		nQtdAB8,;
																		nQtdAB8,;
																		nQtdDif,;
																		nQtdDif,;
																		nVlrABA,;
																		nVlrABA,;
																		nVlrAB8,;
																		nVlrAB8,;
																		nTotABA,;
																		nTotABA,;
																		nTotAB8,;
																		nTotAB8,;
																		nTotDif,;
																		nTotDif}})
				Else
					aTotal[nPMoeda,2,01] += nQtdABA
					aTotal[nPMoeda,2,02] += nQtdABA
					aTotal[nPMoeda,2,03] += nQtdAB8
					aTotal[nPMoeda,2,04] += nQtdAB8
					aTotal[nPMoeda,2,05] += nQtdDif
					aTotal[nPMoeda,2,06] += nQtdDif
					aTotal[nPMoeda,2,07] += nVlrABA
					aTotal[nPMoeda,2,08] += nVlrABA
					aTotal[nPMoeda,2,09] += nVlrAB8
					aTotal[nPMoeda,2,10] += nVlrAB8
					aTotal[nPMoeda,2,11] += nTotABA
					aTotal[nPMoeda,2,12] += nTotABA
					aTotal[nPMoeda,2,13] += nTotAB8
					aTotal[nPMoeda,2,14] += nTotAB8
					aTotal[nPMoeda,2,15] += nTotDif
					aTotal[nPMoeda,2,16] += nTotDif
				EndIf
            	lImpAB7 := .T.
				lImp := .T.
			EndIf
			nQtdAB8	:= 0
			nQtdABA	:= 0
			nVlrAB8	:= 0
			nVlrABA	:= 0
			nTotAb8  := 0
			nTotABA  := 0
			nQtdDif  := 0
			nTotDif  := 0
		EndIf
	End
   	
	nQtdAB8	:= 0
	nQtdABA	:= 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Processa as Diferencas entre a OS e o Atendimento                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   	dbSelectArea("AB8")
	dbSetOrder(5)
	MsSeek(xFilial("AB8")+AB7->AB7_NUMOS+AB7->AB7_ITEM)
   	While ( !AB8->( Eof() ) .And. xFilial("AB8") == AB8->AB8_FILIAL .And.;
										AB7->AB7_NUMOS == AB8->AB8_NUMOS .And.;
										AB7->AB7_ITEM  == AB8->AB8_ITEM )
		cProdAB8:= AB8->AB8_CODPRO
      	nQtdAB8 += AB8->AB8_QUANT
		nVlrAB8 += At450Tab(cProdAB8,AB6->AB6_TABELA,AB8->AB8_QUANT,AB6->AB6_CODCLI,AB6->AB6_LOJA,AB6->AB6_MOEDA)
      	dbSelectArea("AB8")
		dbSkip()
		If ( cProdAB8 != AB8->AB8_CODPRO )
			dbSelectArea("ABA")
			dbSetOrder(3)
			If ( !MsSeek(xFilial("ABA")+AB7->AB7_NUMOS+AB7->AB7_ITEM+cProdAB8) )
				Do Case
					Case ( aReturn[8] == 2 )
						If ( cQuebra != AB7->AB7_CODCLI )
							@ Li,000 PSAY STR0016+SA1->A1_NOME //"CLIENTE: "		
							Li+=2
						EndIf
						cQuebra := AB7->AB7_CODCLI
					Case ( aReturn[8] == 3 )
						If ( cQuebra != AB7->AB7_CODPRO )
							dbSelectArea("SB1")
							dbSetOrder(1)
							MsSeek(xFilial("SB1")+AB7->AB7_CODPRO)
							@ Li,000 PSAY STR0017+SB1->B1_DESC //"PRODUTO/EQTO: "
							Li+=2
						EndIf
						cQuebra := AB7->AB7_CODPRO
				EndCase
				nTotAb8 := nQtdAb8 * nVlrAB8
				nTotAbA := nQtdAbA * nVlrABA
				nQtdDif := nQtdAB8 - nQtdABA
				nTotDif := nTotAb8 - nTotAbA
				@ Li,000 PSAY AB7->AB7_NUMOS+"-"+AB7->AB7_ITEM
				@ Li,010 PSAY AB7->AB7_CODCLI
				@ Li,020 PSAY AB7->AB7_CODPRO
				@ Li,036 PSAY AB7->AB7_CODPRB
				@ Li,043 PSAY PadR(AAG->AAG_DESCRI,20)
				@ Li,064 PSAY PadR(cProdAB8,15)
				@ Li,080 PSAY Str(AB6->AB6_MOEDA,1)				
				@ Li,086 PSAY nQtdABA		PICTURE PesqPict("ABA","ABA_QUANT",14)
				@ Li,101 PSAY nVlrABA      PICTURE PesqPict("SB1","B1_PRV1",14)
				@ Li,116 PSAY nTotABA      PICTURE Tm(nTotABA,14)
				@ Li,131 PSAY nQtdAB8		PICTURE PesqPict("AB8","AB8_QUANT",14)
				@ Li,146 PSAY nVlrAB8      PICTURE PesqPict("AB8","AB8_VUNIT",14)
				@ Li,161 PSAY nTotAB8      PICTURE Tm(nTotAB8,14)
				@ Li,177 PSAY nQtdDif      PICTURE TM(nQtdDif,14)
				@ Li,192 PSAY nTotDif      PICTURE Tm(nTotDif,14)
				Li++
				If Empty(nPMoeda:=aScan(aTotal,{|x|x[1]==Str(AB6->AB6_MOEDA,1)}))
					aAdd(aTotal,{Str(AB6->AB6_MOEDA,1),{nQtdABA,;
																		nQtdABA,;
																		nQtdAB8,;
																		nQtdAB8,;
																		nQtdDif,;
																		nQtdDif,;
																		nVlrABA,;
																		nVlrABA,;
																		nVlrAB8,;
																		nVlrAB8,;
																		nTotABA,;
																		nTotABA,;
																		nTotAB8,;
																		nTotAB8,;
																		nTotDif,;
																		nTotDif}})
				Else
					aTotal[nPMoeda,2,01] += nQtdABA
					aTotal[nPMoeda,2,02] += nQtdABA
					aTotal[nPMoeda,2,03] += nQtdAB8
					aTotal[nPMoeda,2,04] += nQtdAB8
					aTotal[nPMoeda,2,05] += nQtdDif
					aTotal[nPMoeda,2,06] += nQtdDif
					aTotal[nPMoeda,2,07] += nVlrABA
					aTotal[nPMoeda,2,08] += nVlrABA
					aTotal[nPMoeda,2,09] += nVlrAB8
					aTotal[nPMoeda,2,10] += nVlrAB8
					aTotal[nPMoeda,2,11] += nTotABA
					aTotal[nPMoeda,2,12] += nTotABA
					aTotal[nPMoeda,2,13] += nTotAB8
					aTotal[nPMoeda,2,14] += nTotAB8
					aTotal[nPMoeda,2,15] += nTotDif
					aTotal[nPMoeda,2,16] += nTotDif
				EndIf
				lImpAB7 := .T.
				lImp := .T.
			EndIf
			nQtdAB8	:= 0
			nQtdABA	:= 0
			nVlrAB8	:= 0
			nVlrABA	:= 0
			nTotAb8  := 0
			nTotABA  := 0
			nQtdDif  := 0
			nTotDif  := 0
		EndIf
	End
	dbSelectArea(cString)
	dbSkip()
	Do Case
		Case ( aReturn[8] == 2 .And. lImpAB7 )
			If ( cQuebra != AB7->AB7_CODCLI )
				For nTMoeda := 1 To Len(aTotal)
					dbSelectArea("SA1")
					dbSetOrder(1)
					MsSeek(xFilial("SA1")+cQuebra)
					@ Li,000 PSAY STR0018+cQuebra+" "+SA1->A1_NOME	//"TOTAL DO CLIENTE: "
					@ Li,080 PSAY aTotal[nTMoeda,1]
					@ Li,086 PSAY aTotal[nTMoeda,2,01]		PICTURE Tm(aTotal[nTMoeda,2,01],14)
					@ Li,101 PSAY aTotal[nTMoeda,2,07]		PICTURE Tm(aTotal[nTMoeda,2,07],14)
					@ Li,116 PSAY aTotal[nTMoeda,2,11]		PICTURE Tm(aTotal[nTMoeda,2,11],14)
					@ Li,131 PSAY aTotal[nTMoeda,2,03]		PICTURE Tm(aTotal[nTMoeda,2,03],14)
					@ Li,146 PSAY aTotal[nTMoeda,2,09]		PICTURE Tm(aTotal[nTMoeda,2,09],14)
					@ Li,161 PSAY aTotal[nTMoeda,2,13]		PICTURE Tm(aTotal[nTMoeda,2,13],14)
					@ Li,177 PSAY aTotal[nTMoeda,2,05]		PICTURE Tm(aTotal[nTMoeda,2,05],14)
					@ Li,192 PSAY aTotal[nTMoeda,2,15]		PICTURE Tm(aTotal[nTMoeda,2,15],14)
					Li+=2
					lImpAb7 := .F.
					aTotal[nTMoeda,2,01] := 0
					aTotal[nTMoeda,2,03] := 0
					aTotal[nTMoeda,2,05] := 0
					aTotal[nTMoeda,2,07] := 0
					aTotal[nTMoeda,2,09] := 0
					aTotal[nTMoeda,2,11] := 0
					aTotal[nTMoeda,2,13] := 0
					aTotal[nTMoeda,2,15] := 0
				Next nTMoeda
				Li+=2
			EndIf
	EndCase
	dbSelectArea(cString)
	cbCont++
	IncRegua()
End
If ( lImp )
	For nTMoeda := 1 To Len(aTotal)
		@ Li,000 PSAY STR0020	//"TOTAL GERAL: "
		@ Li,080 PSAY aTotal[nTMoeda,1]		
		@ Li,086 PSAY aTotal[nTMoeda,2,02]		PICTURE Tm(aTotal[nTMoeda,2,02],14)
		@ Li,101 PSAY aTotal[nTMoeda,2,08]		PICTURE Tm(aTotal[nTMoeda,2,08],14)
		@ Li,116 PSAY aTotal[nTMoeda,2,12]		PICTURE Tm(aTotal[nTMoeda,2,12],14)
		@ Li,131 PSAY aTotal[nTMoeda,2,04]		PICTURE Tm(aTotal[nTMoeda,2,04],14)
		@ Li,146 PSAY aTotal[nTMoeda,2,10]		PICTURE Tm(aTotal[nTMoeda,2,10],14)
		@ Li,161 PSAY aTotal[nTMoeda,2,14]		PICTURE Tm(aTotal[nTMoeda,2,14],14)
		@ Li,177 PSAY aTotal[nTMoeda,2,06]		PICTURE Tm(aTotal[nTMoeda,2,06],14)
		@ Li,192 PSAY aTotal[nTMoeda,2,16]		PICTURE Tm(aTotal[nTMoeda,2,16],14)
		Li++
	Next nTMoeda
	Roda(cbCont,cbText,Tamanho)
EndIf
Set Device To Screen
Set Printer To
dbSelectArea("AB7")
dbClearFilter()
RetIndex("AB7")
Ferase(cArqInd+OrdBagExt())
If ( aReturn[5] == 1 )
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()
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

Return Tcr490RptDef()

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

Return Tcr490PrtRpt( oReport , {STR0005,STR0006,STR0007} , GetNextAlias())

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