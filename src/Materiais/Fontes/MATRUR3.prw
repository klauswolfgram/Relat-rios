/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "matrur3.ch"
#INCLUDE "Protheus.ch"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Defines das posicoes do array aItens ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#DEFINE _DATA		1
#DEFINE _DOCTO		2
#DEFINE _CLIENTE	3
#DEFINE _VALOR		4
#DEFINE _IVAMAIOR	5
#DEFINE _IVAMENOR	6
#DEFINE _COFIS		7
#DEFINE _VALLIQ 	8
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MATRUR3   ³ Autor ³Sergio S. Fuzinaka     ³ Data ³ 18.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Livros Fiscais de Compras Normales                          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³Uruguai                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MatrUr3()

Local oReport

If FindFunction("TRepInUse") .And. TRepInUse()
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	U_MatrUr3R3()
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef  ³ Autor ³Sergio S. Fuzinaka     ³ Data ³10.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±³          ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                       ³±±
±±³          ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oEmpresa
Local oLinha
Local cReport	:= "MATRUR3"
Local cPerg		:= "MTRUR3"
Local cTitulo	:= OemToAnsi(STR0020)
Local cDesc		:= OemToAnsi(STR0021)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New(cReport,cTitulo,cPerg,{|oReport| ReportPrint(oReport)},cDesc)
oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)
Pergunte(oReport:uParam,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oEmpresa:=TRSection():New(oReport,OemToAnsi(STR0022),{"SM0"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
TRCell():New(oEmpresa,"M0_NOMECOM","SM0",OemToAnsi(STR0022),/*Picture*/,40,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oEmpresa,"M0_ENDENT","SM0",OemToAnsi(STR0023),/*Picture*/,30,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oEmpresa,"M0_CGC","SM0",OemToAnsi(STR0024),/*Picture*/,14,/*lPixel*/,/*{|| code-block de impressao }*/)

oLinha:=TRSection():New(oReport,OemToAnsi(STR0035),{"SF3","SA2"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
TRCell():New(oLinha,"F3_ENTRADA","SF3",OemToAnsi(STR0027),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oLinha,"F3_NFISCAL","SF3",OemToAnsi(STR0028),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oLinha,"A2_NOME","SA2",OemToAnsi(STR0029),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oLinha,"VLR","",OemToAnsi(STR0030),PesqPict("SF3","F3_VALCONT"),TamSx3("F3_VALCONT")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oLinha,"IVA23","",OemToAnsi(STR0031),PesqPict("SF3","F3_VALIMP1"),TamSx3("F3_VALIMP1")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oLinha,"IVA14","",OemToAnsi(STR0032),PesqPict("SF3","F3_VALIMP1"),TamSx3("F3_VALIMP1")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oLinha,"COFIS","",OemToAnsi(STR0033),PesqPict("SF3","F3_VALIMP1"),TamSx3("F3_VALIMP1")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oLinha,"VLRLIQ","",OemToAnsi(STR0034),PesqPict("SF3","F3_VALCONT"),TamSx3("F3_VALCONT")[1],/*lPixel*/,/*{|| code-block de impressao }*/)

TRFunction():New(oLinha:Cell("VLR"),NIL,"SUM",/*oBreak*/,/*cTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oLinha:Cell("IVA23"),NIL,"SUM",/*oBreak*/,/*cTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oLinha:Cell("IVA14"),NIL,"SUM",/*oBreak*/,/*cTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oLinha:Cell("COFIS"),NIL,"SUM",/*oBreak*/,/*cTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.T.)
TRFunction():New(oLinha:Cell("VLRLIQ"),NIL,"SUM",/*oBreak*/,/*cTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.T.)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Sergio S. Fuzinaka     ³ Data ³04.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                            ³±±
±±³          ³                                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local cCondicao := ""
Local cAliasSF3	:= "SF3"
Local cCabec	:= OemToAnsi(STR0020)+OemToAnsi(STR0025)+DtoC(mv_par01)+OemToAnsi(STR0026)+DtoC(mv_par02)
Local aItens	:= {}
Local aImpostos	:= {}
Local aImpAux	:= {}
Local cChave	:= ""
Local cClieFor	:= ""
Local cLoja		:= ""
Local nValCont	:= 0
Local nI		:= 0
Local nZ		:= 0
Local cNomeCom	:= ""
Local cEndEnt	:= ""
Local cCGC		:= ""
Local dEntrada	:= CtoD("")
Local cNFiscal	:= ""
Local cNome		:= ""
Local nVlr		:= 0
Local nIVA23	:= 0
Local nIVA14	:= 0
Local nCOFIS	:= 0
Local nVlrLiq	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Altera o titulo para impressao                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(cCabec)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta aImpostos com as informacoes de cada imposto     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SFB")
dbSetOrder(1)
dbGoTop()

AAdd(aImpostos,{"IVA|IV3",""})                
AAdd(aImpostos,{"IV2|IV4",""})                
AAdd(aImpostos,{"COF",""})
While !SFB->(EOF()) 
	If aScan(aImpostos,{|x| SFB->FB_CODIGO $ x[1]}) > 0
		aImpostos[aScan(aImpostos,{|x| SFB->FB_CODIGO $ x[1]})][2] := SFB->FB_CPOLVRO
	EndIf	
	dbSkip()
Enddo                 
aSort(aImpostos,,,{|x,y| x[2] < y[2]})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta array auxiliar de impostos  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AAdd(aImpAux,{"BA1",""})                
AAdd(aImpAux,{"BA2",""})                
AAdd(aImpAux,{"BA3",""})              
SFB->(dbGoTop()) 
While !SFB->(EOF()) 
	If aScan(aImpAux,{|x| SFB->FB_CODIGO $ x[1]}) > 0
		aImpAux[aScan(aImpAux,{|x| SFB->FB_CODIGO $ x[1]})][2] := SFB->FB_CPOLVRO
	EndIf	
	dbSkip()
Enddo                 
aSort(aImpAux,,,{|x,y| x[2] < y[2]}) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SF3")
dbSetOrder(1)

#IFDEF TOP
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatório da secao 1                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(2):BeginQuery()	
	
	cAliasSF3 := GetNextAlias()
			
	BeginSql Alias cAliasSF3
		SELECT SF3.*
		FROM %table:SF3% SF3
		WHERE F3_FILIAL = %xFilial:SF3%	AND 
			F3_ENTRADA	>=	%Exp:mv_par01%	AND 
			F3_ENTRADA	<=	%Exp:mv_par02%	AND 
			F3_TIPOMOV	=	'C'				AND 
			SF3.%NotDel% 
		ORDER BY %Order:SF3%
	EndSql 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar o Embedded SQL.                       ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar o Embedded SQL.                       ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr(oReport:uParam)

	cCondicao := "F3_FILIAL == '"+xFilial("SF3")+"' .And. "
	cCondicao += "F3_TIPOMOV == 'C' .And. "
	cCondicao += "Dtos(F3_ENTRADA) >= '"+Dtos(mv_par01)+"' .And. "
	cCondicao += "Dtos(F3_ENTRADA) <= '"+Dtos(mv_par02)+"'"

	oReport:Section(2):SetFilter(cCondicao,IndexKey())
	
#ENDIF		

oReport:Section(1):Cell("M0_NOMECOM"):SetBlock({|| cNomeCom})
oReport:Section(1):Cell("M0_ENDENT"):SetBlock({|| cEndEnt})
oReport:Section(1):Cell("M0_CGC"):SetBlock({|| cCGC})

oReport:Section(2):Cell("F3_ENTRADA"):SetBlock({|| dEntrada})
oReport:Section(2):Cell("F3_NFISCAL"):SetBlock({|| cNFiscal})
oReport:Section(2):Cell("A2_NOME"):SetBlock({|| cNome})
oReport:Section(2):Cell("VLR"):SetBlock({|| nVlr})
oReport:Section(2):Cell("IVA23"):SetBlock({|| nIVA23})
oReport:Section(2):Cell("IVA14"):SetBlock({|| nIVA14})
oReport:Section(2):Cell("COFIS"):SetBlock({|| nCOFIS})
oReport:Section(2):Cell("VLRLIQ"):SetBlock({|| nVlrLiq})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inclui as posicoes dos campos de impostos no array aImpostos ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nZ:=1 To Len(aImpostos)
	AAdd(aImpostos[nZ],FieldPos("F3_BASIMP"+aImpostos[nZ][2]))
	AAdd(aImpostos[nZ],FieldPos("F3_VALIMP"+aImpostos[nZ][2]))
	AAdd(aImpAux[nZ],FieldPos("F3_BASIMP"+aImpAux[nZ][2]))
	AAdd(aImpAux[nZ],FieldPos("F3_VALIMP"+aImpAux[nZ][2]))
Next	          

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo TrPosition()                                                     ³
//³                                                                        ³
//³Posiciona em um registro de uma outra tabela. O posicionamento será     ³
//³realizado antes da impressao de cada linha do relatório.                ³
//³                                                                        ³
//³                                                                        ³
//³ExpO1 : Objeto Report da Secao                                          ³
//³ExpC2 : Alias da Tabela                                                 ³
//³ExpX3 : Ordem ou NickName de pesquisa                                   ³
//³ExpX4 : String ou Bloco de código para pesquisa. A string será macroexe-³
//³        cutada.                                                         ³
//³                                                                        ³				
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cNomeCom	:= SM0->M0_NOMECOM
cEndEnt		:= SM0->M0_ENDENT
cCGC		:= SM0->M0_CGC
oReport:SetMeter(1)
oReport:Section(1):Init()
oReport:Section(1):PrintLine() 	
oReport:Section(1):Finish()	

dbSelectArea(cAliasSF3)
dbGoTop()
oReport:SetMeter((cAliasSF3)->(LastRec()))
oReport:Section(2):Init()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime a secao da carga                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While !oReport:Cancel() .And. !(cAliasSF3)->(Eof())

	aItens := {}
	oReport:IncMeter()

	If !(FieldGet(aImpAux[1][3]) > 0 .Or. FieldGet(aImpAux[2][3]) > 0 .Or. FieldGet(aImpAux[3][3]) > 0)

		cChave	:=	(cAliasSf3)->F3_FILIAL+DTOS((cAliasSF3)->F3_ENTRADA)+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+;
					(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA+(cAliasSF3)->F3_CFO+(cAliasSF3)->F3_ESPECIE+(cAliasSF3)->F3_TIPOMOV

		dEntrada	:= (cAliasSF3)->F3_ENTRADA                                                   
		cNFiscal	:= (cAliasSF3)->F3_NFISCAL
		cClieFor	:= (cAliasSF3)->F3_CLIEFOR
		cLoja		:= (cAliasSF3)->F3_LOJA
		nValCont	:= (cAliasSF3)->F3_VALCONT

		If Len(cClieFor) > 0
			If (cAliasSF3)->F3_TIPO $ "B"
				SA1->(dbGoTop())
				SA1->(dbSetOrder(1))				
				If SA1->(dbSeek(xFilial("SA1")+cClieFor+cLoja))
					cNome := TransForm(SA1->A1_NOME,PesqPict("SA1","A1_NOME"))
				Else 
					cNome := SubStr(cClieFor,1,40)
				EndIf
			Else
				SA2->(dbGoTop())
				SA2->(dbSetOrder(1))				
				If SA2->(dbSeek(xFilial("SA2")+cClieFor+cLoja))
					cNome := TransForm(SA2->A2_NOME,PesqPict("SA2","A2_NOME"))
				Else 
					cNome := SubStr(cClieFor,1,40)
				EndIf
			EndIf	
		EndIf
	
		AAdd(aItens,{dEntrada,cNFiscal,cNome,nValCont,0,0,0,0,(cAliasSF3)->F3_TIPO})
		
		For nI:=1 To Len(aImpostos)
			Do Case
				Case  aImpostos[nI][1] $ "IV2|IV4" .And. aImpostos[nI][4] > 0
					aItens[Len(aItens)][_IVAMAIOR] := FieldGet(aImpostos[nI][4])
				Case  aImpostos[nI][1] $ "IVA|IV3" .And. aImpostos[nI][4] > 0
					aItens[Len(aItens)][_IVAMENOR] := FieldGet(aImpostos[nI][4])
				Case  aImpostos[nI][1] $ "COF" .And. aImpostos[nI][4] > 0
					aItens[Len(aItens)][_COFIS]    := FieldGet(aImpostos[nI][4])
			EndCase							
		Next  
		
		(cAliasSF3)->(dbSkip())
		
		While (cAliasSF3)->F3_FILIAL+DTOS((cAliasSF3)->F3_ENTRADA)+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA+(cAliasSF3)->F3_CFO+;
			  (cAliasSF3)->F3_ESPECIE+(cAliasSF3)->F3_TIPOMOV == cChave 
			  
			aItens[Len(aItens)][_VALOR] += FieldGet(FieldPos("F3_VALCONT"))
			
			For nI:=1 To Len(aImpostos)
				Do Case
					Case  aImpostos[nI][1] $ "IV2|IV4" .And. aImpostos[nI][4] > 0
						aItens[Len(aItens)][_IVAMAIOR]  += FieldGet(aImpostos[nI][4])
					Case  aImpostos[nI][1] $ "IVA|IV3" .And. aImpostos[nI][4] > 0
						aItens[Len(aItens)][_IVAMENOR]  += FieldGet(aImpostos[nI][4])
					Case  aImpostos[nI][1] $ "COF" .And. aImpostos[nI][4] > 0
						aItens[Len(aItens)][_COFIS]  += FieldGet(aImpostos[nI][4])
				EndCase							
			Next  
			
			(cAliasSF3)->(dbSkip())  
		Enddo	

		aItens[Len(aItens)][_VALLIQ] += aItens[Len(aItens)][_VALOR] - (aItens[Len(aItens)][_IVAMAIOR] +;
										aItens[Len(aItens)][_IVAMENOR] + aItens[Len(aItens)][_COFIS])
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a somatoria dos totais a serem apresentados no relatorio        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If aItens[1][Len(aItens[1])] <> "D"
			nVlr	:= aItens[1][_VALOR]
			nIVA23	:= aItens[1][_IVAMAIOR]
			nIVA14	:= aItens[1][_IVAMENOR]
			nCOFIS	:= aItens[1][_COFIS]
			nVlrLiq	:= aItens[1][_VALLIQ]
		Else                               
			nVlr	:= (aItens[1][_VALOR] * -1)
			nIVA23	:= (aItens[1][_IVAMAIOR] * -1)
			nIVA14	:= (aItens[1][_IVAMENOR] * -1)
			nCOFIS	:= (aItens[1][_COFIS] * -1)
			nVlrLiq	:= (aItens[1][_VALLIQ] * -1)
		EndIf	   
	
		oReport:Section(2):PrintLine() 	
	Else
		dbSelectArea((cAliasSF3))
		dbSkip()
	Endif
Enddo
oReport:Section(2):Finish()	

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MATRUR3R3 º Autor ³ Paulo Eduardo      º Data ³  07/11/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Funcao para impressao de livros fiscais de Compras Normalesº±±
±±º          ³ para o Uruguai.                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Localizacoes                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MatrUR3R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1       := STR0001 //"Este programa tem como objetivo imprimir relatorio "
Local cDesc2       := STR0002 //"de Livros Fiscais de Compras para o Uruguai"
Local cDesc3       := ""
Local cPict        := ""
Local titulo       := STR0003 //"Livro Fiscal de Compras"
Local nLin         := 80
Local Cabec1       := ""
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd         := {}
Private lEnd       := .F.
Private lAbortPrint:= .F.
Private limite     := 220
Private tamanho    := "G"
Private nomeprog   := "MATRUR3" 
Private nTipo      := 18
Private aReturn    := { STR0004, 1, STR0005, 2, 2, 1, "", 1} //"Zebrado"###"Administracao"
Private nLastKey   := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "MATRUR3" 
Private cPerg      := "MTRUR3"
Private cString    := ""
Private cAliasSF3
Private aItens, aImpostos, aImpAux
Private nTotal    := 0, nTotIVA23 := 0
Private nTotIVA14 := 0, nTotCOFIS := 0, nTotNeto := 0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cString := "SF3"

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,Tamanho,,.T.)

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta aImpostos com as informacoes de cada imposto     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SFB")
DbSetOrder(1)
DbGoTop()

aImpostos := {}
AAdd(aImpostos,{"IVA|IV3",""})                
AAdd(aImpostos,{"IV2|IV4",""})                
AAdd(aImpostos,{"COF",""})
While !SFB->(EOF()) 
	If aScan(aImpostos,{|x| SFB->FB_CODIGO $ x[1]}) > 0
		aImpostos[aScan(aImpostos,{|x| SFB->FB_CODIGO $ x[1]})][2] := SFB->FB_CPOLVRO
	EndIf	
	DbSkip()
EndDo                 
aSort(aImpostos,,,{|x,y| x[2] < y[2]})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta array auxiliar de impostos  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aImpAux := {}                                 
AAdd(aImpAux,{"BA1",""})                
AAdd(aImpAux,{"BA2",""})                
AAdd(aImpAux,{"BA3",""})              
SFB->(DbGoTop()) 
While !SFB->(EOF()) 
	If aScan(aImpAux,{|x| SFB->FB_CODIGO $ x[1]}) > 0
		aImpAux[aScan(aImpAux,{|x| SFB->FB_CODIGO $ x[1]})][2] := SFB->FB_CPOLVRO
	EndIf	
	DbSkip()
EndDo                 
aSort(aImpAux,,,{|x,y| x[2] < y[2]}) 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os cabecalhos do relatorio                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                        
titulo := STR0006 +space(1)+ DTOC(mv_par01) +space(1)+ STR0007 +space(1)+ DTOC(mv_par02) //"Livro de Compras de"###"a"
                                  
Cabec1 := Padr(STR0008,10," ") +space(5)+ Padr(STR0009,12," ") +space(5)+ Padr(STR0010,40," ") +space(10)+ PadL(STR0011,17," ") +space(10)+; //"Data"###"Documento"###"Cliente"###"Valor"
		PadL("IVA 23%",17," ") +space(10)+ PadL("IVA 14%",17," ") +space(10)+ PadL("COFIS",17," ") +space(10)+ PadL(STR0013,17," ") //"Valor Liquido"
	
If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| MUr3Imprime(Cabec1,Cabec2,Titulo,nLin) },Titulo)								

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³MUR3IMPRIMEº Autor ³ AP6 IDE            º Data ³  31/10/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS  º±±
±±º          ³ monta a janela com a regua de processamento.                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MUr3Imprime(Cabec1,Cabec2,Titulo,nLin)

Local nY := 1
Local cbcont:=0,cbtxt:=space(10)
Local cCond, cArqTrab, cOrdem, cChave
Local cFornLivro, cFornecedor
Local dDataEntr
Local nValor 	   :=0
Local nOrdSF3      := 1, nZ:= 1, nI:=1
Local cCGCDesc := Rtrim(RetTitle("A2_CGC"))
Local aCabec := {STR0014 +space(1)+ SM0->M0_NOMECOM +Padc("",130)+padL(STR0015+space(1)+STRZERO(m_pag,3,0),81),; //"Empresa:"###"Pagina:"
		STR0016 +space(1)+ Alltrim(SM0->M0_ENDENT)+" - "+ AllTrim(SM0->M0_CIDENT)+" - "+ AllTrim(SM0->M0_ESTENT)+; //"Endereco:"
		Padc(Titulo,130) + PadL(STR0008+": "+DTOC(dDataBase),111),; //"Data"
		cCGCDesc + ": " + Transform(SM0->M0_CGC,PesqPict("SA2","A2_CGC"))}

#IFDEF TOP
Local cQuery:=""
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta query para selecao dos itens a serem mostrados³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cAliasSF3:="F3TMP"
	If Select(cAliasSF3)<>0
  		DbSelectArea(cAliasSF3)
  		DbCloseArea()
	Endif            
	
	cQuery := "SELECT * FROM "+RetSqlName("SF3")+" "+cAliasSF3+" "
   cQuery += "WHERE F3_FILIAL='"+ xFilial("SF3")+"'"+" AND F3_TIPOMOV = 'C' AND "
   cQuery += "F3_ENTRADA >= '"+Dtos(mv_par01)+"'"+" AND F3_ENTRADA <= '"+Dtos(mv_par02)+"'"
	cQuery +=" AND D_E_L_E_T_<>'*' ORDER BY " 
	cQuery +="F3_ENTRADA,F3_NFISCAL,F3_SERIE,F3_CLIEFOR,F3_LOJA,F3_CFO"
	cQuery :=ChangeQuery(cQuery)
	MsAguarde({|| dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasSF3,.F.,.T.)},STR0017) //"Selecionando registros..."
	TCSetField(cAliasSF3,"F3_ENTRADA","D",8,0)
#ELSE
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta IndRegua para selecao do itens³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cAliasSF3:="SF3"
	DbSelectArea(cAliasSF3)
	DbGoTop()         

	nOrdSF3 := IndexOrd()

	cCond := cAliasSF3+"->F3_FILIAL == '"+ xFilial(cAliasSF3) + "' "
	cCond += ".and. "+cAliasSF3+"->F3_TIPOMOV =='C' .and."
	cCond += "Dtos("+cAliasSF3+"->F3_ENTRADA) >= '"+ Dtos(mv_par01) +"' .and. "
	cCond += "Dtos("+cAliasSF3+"->F3_ENTRADA) <= '"+ Dtos(mv_par02) +"'"
	cArqTrab := CriaTrab(Nil,.F.)
	cOrdem:=SF3->(IndexKey())
	IndRegua(cAliasSF3,cArqTrab,cOrdem,,cCond,STR0017) //"Selecionando registros..."
#ENDIF    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inclui as posicoes dos campos de impostos no array aImpostos ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nZ:=1 To Len(aImpostos)
	AAdd(aImpostos[nZ],FieldPos("F3_BASIMP"+aImpostos[nZ][2]))
	AAdd(aImpostos[nZ],FieldPos("F3_VALIMP"+aImpostos[nZ][2]))
	AAdd(aImpAux[nZ],FieldPos("F3_BASIMP"+aImpAux[nZ][2]))
	AAdd(aImpAux[nZ],FieldPos("F3_VALIMP"+aImpAux[nZ][2]))
Next	          

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(RecCount())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta array de com os itens do SF3  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aItens := {}
While !(cAliasSF3)->(EOF())
	If !(FieldGet(aImpAux[1][3]) > 0 .Or. FieldGet(aImpAux[2][3]) > 0 .Or. FieldGet(aImpAux[3][3]) > 0)
		cChave := (cAliasSf3)->F3_FILIAL+DTOS((cAliasSF3)->F3_ENTRADA)+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+;
					(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA+(cAliasSF3)->F3_CFO+(cAliasSF3)->F3_ESPECIE+(cAliasSF3)->F3_TIPOMOV
		dDataEntr := (cAliasSF3)->F3_ENTRADA                                                   
		cDocumento:= (cAliasSF3)->F3_NFISCAL
		cFornLivro := (cAliasSF3)->F3_CLIEFOR
		If Len(cFornLivro) > 0
			If (cAliasSf3)->F3_TIPO <> "B"
				SA2->(DbGoTop())
				If SA2->(MsSeek(xFilial()+cFornLivro))
					cFornecedor := TransForm(SA2->A2_NOME,PesqPict("SA2","A2_NOME"))
				Else 
					cFornecedor := SubStr(cFornLivro,1,40)
				EndIf
			Else                
				SA1->(DbGoTop())
				If SA1->(MsSeek(xFilial()+cFornLivro))
					cFornecedor := TransForm(SA1->A1_NOME,PesqPict("SA1","A1_NOME"))
				Else 
					cFornecedor := SubStr(cFornLivro,1,40)
				EndIf
			EndIf	
		EndIf	
		nValor  := (cAliasSF3)->F3_VALCONT
		AAdd(aItens,{dDataEntr,cDocumento,cFornecedor,nValor,0,0,0,0,(cAliasSF3)->F3_TIPO})
		
		For nI:=1 To Len(aImpostos)
			Do Case
				Case  aImpostos[nI][1] $ "IV2|IV4" .And. aImpostos[nI][4] > 0
					aItens[Len(aItens)][_IVAMAIOR] := FieldGet(aImpostos[nI][4])
				Case  aImpostos[nI][1] $ "IVA|IV3" .And. aImpostos[nI][4] > 0
					aItens[Len(aItens)][_IVAMENOR] := FieldGet(aImpostos[nI][4])
				Case  aImpostos[nI][1] $ "COF" .And. aImpostos[nI][4] > 0
					aItens[Len(aItens)][_COFIS]    := FieldGet(aImpostos[nI][4])
			EndCase							
		Next  
		
		(cAliasSF3)->(DbSkip())
		
		While (cAliasSF3)->F3_FILIAL+DTOS((cAliasSF3)->F3_ENTRADA)+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA+(cAliasSF3)->F3_CFO+;
			  (cAliasSF3)->F3_ESPECIE+(cAliasSF3)->F3_TIPOMOV == cChave 
			aItens[Len(aItens)][_VALOR] += FieldGet(FieldPos("F3_VALCONT"))
			For nI:=1 To Len(aImpostos)
				Do Case
					Case  aImpostos[nI][1] $ "IV2|IV4" .And. aImpostos[nI][4] > 0
						aItens[Len(aItens)][_IVAMAIOR]  += FieldGet(aImpostos[nI][4])
					Case  aImpostos[nI][1] $ "IVA|IV3" .And. aImpostos[nI][4] > 0
						aItens[Len(aItens)][_IVAMENOR]  += FieldGet(aImpostos[nI][4])
					Case  aImpostos[nI][1] $ "COF" .And. aImpostos[nI][4] > 0
						aItens[Len(aItens)][_COFIS]  += FieldGet(aImpostos[nI][4])
				EndCase							
			Next  
			
			(cAliasSF3)->(DbSkip())        
		EndDo	
		aItens[Len(aItens)][_VALLIQ] += aItens[Len(aItens)][_VALOR] - (aItens[Len(aItens)][_IVAMAIOR] +;
										aItens[Len(aItens)][_IVAMENOR] + aItens[Len(aItens)][_COFIS])
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a somatoria dos totais a serem apresentados no relatorio        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If aItens[1][Len(aItens[1])] <> "D"
			nTotal    += aItens[1][_VALOR]
			nTotIVA23 += aItens[1][_IVAMAIOR]
			nTotIVA14 += aItens[1][_IVAMENOR]
			nTotCOFIS += aItens[1][_COFIS]
			nTotNeto  += aItens[1][_VALLIQ]
		Else                               
			nTotal    -= aItens[1][_VALOR]
			nTotIVA23 -= aItens[1][_IVAMAIOR]
			nTotIVA14 -= aItens[1][_IVAMENOR]
			nTotCOFIS -= aItens[1][_COFIS]
			nTotNeto  -= aItens[1][_VALLIQ]
		EndIf	   
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o cancelamento pelo usuario...                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		If lAbortPrint
			@nLin,00 PSAY STR0018 //"*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do cabecalho do relatorio. . .                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		If nLin > 58 // Salto de Página. Neste caso o formulario tem 58 linhas...
			nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo,aCabec)
			nLin ++
		Endif
		
		@nLin,00   PSAY Padr(aItens[nY][_DATA],10)
		@nLin,15   PSAY aItens[nY][_DOCTO]
		@nLin,32   PSAY aItens[nY][_CLIENTE]
		If aItens[1][Len(aItens[1])] <> "D"
			@nLin,82   PSAY Transform(aItens[nY][_VALOR],PesqPict("SF3","F3_VALCONT"))
			@nLin,108  PSAY Transform(aItens[nY][_IVAMAIOR],PesqPict("SF3","F3_VALIMP1"))
			@nLin,135  PSAY Transform(aItens[nY][_IVAMENOR],PesqPict("SF3","F3_VALIMP1"))
			@nLin,162  PSAY Transform(aItens[nY][_COFIS],PesqPict("SF3","F3_VALIMP1"))
			@nLin,190  PSAY Transform(aItens[nY][_VALLIQ],PesqPict("SF3","F3_VALCONT"))
		Else	                                                                        
			@nLin,82   PSAY Transform(aItens[nY][_VALOR]*-1,PesqPict("SF3","F3_VALCONT"))
			@nLin,108  PSAY Transform(aItens[nY][_IVAMAIOR]*-1,PesqPict("SF3","F3_VALIMP1"))
			@nLin,135  PSAY Transform(aItens[nY][_IVAMENOR]*-1,PesqPict("SF3","F3_VALIMP1"))
			@nLin,162  PSAY Transform(aItens[nY][_COFIS]*-1,PesqPict("SF3","F3_VALIMP1"))
			@nLin,190  PSAY Transform(aItens[nY][_VALLIQ]*-1,PesqPict("SF3","F3_VALCONT"))
		EndIf	
		
		nLin := nLin + 1 // Avanca a linha de impressao
		aItens := {}
	Else
		(cAliasSF3)->(DbSkip())
	EndIf		
EndDo	

If nTotal <> 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta linha de totais do relatorio.                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                                    
	nLin := nLin + 2
	                 
	@nLin,00   PSAY STR0019                                        //"TOTAIS GERAIS"
	@nLin,82   PSAY Transform(nTotal,PesqPict("SF3","F3_VALCONT"))
	@nLin,108  PSAY Transform(nTotIVA23,PesqPict("SF3","F3_VALIMP1"))
	@nLin,135  PSAY Transform(nTotIVA14,PesqPict("SF3","F3_VALIMP1"))
	@nLin,162  PSAY Transform(nTotCOFIS,PesqPict("SF3","F3_VALIMP1"))
	@nLin,190  PSAY Transform(nTotNeto,PesqPict("SF3","F3_VALCONT"))
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta rodape da pagina                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	roda(cbcont,cbtxt,"G")
EndIf                     

#IFDEF TOP                                              
	DbSelectArea(cAliasSF3)
	DbCloseArea()
#ELSE	
	RetIndex(cAliasSF3)
	(cAliasSF3)->(DbSetOrder(nOrdSF3))
	cArqTrab+=OrdBagExt()
	File(cArqTrab)
	Ferase(cArqTrab)
#ENDIF	
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
SET DEVICE TO SCREEN
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif
	
MS_FLUSH()
Fim := .F.
	
Return

