/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR287.CH"
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR287  ³ Autor ³ Ricardo Berti         ³ Data ³ 20/05/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Divergencias em Multiplas Contagens           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR287()

Local oReport
Local lContagem:= SuperGetMv('MV_CONTINV',.F.,.F.)

If !lContagem
	Help(" ",1,"MR287CONTN") //"Esta opção somente poderá ser selecionada com o controle de contagens habilitado."

ElseIf TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:= ReportDef()
	oReport:PrintDialog()
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Ricardo Berti         ³ Data ³ 20/05/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR287			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oSection1
Local aOrdem    := {OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0008),OemToAnsi(STR0009)}		//' Por Codigo    '###' Por Tipo      '###' Por Grupo   '###' Por Descricao '###' Por Armazem  '
Local cAliasSB7 := GetNextAlias()
Local nTamB1Desc:= TamSX3("B1_DESC")[1]
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
oReport:= TReport():New("MATR287",STR0001,"MTR287", {|oReport| ReportPrint(oReport,aOrdem,cAliasSB7)},STR0002+STR0003+STR0004)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Produto de                           ³
//³ mv_par02             // Produto ate                          ³
//³ mv_par03             // De  Tipo                             ³
//³ mv_par04             // Ate Tipo                             ³
//³ mv_par05             // Do  Armazem                          ³
//³ mv_par06             // Ate Armazem                          ³
//³ mv_par07             // De  Grupo                            ³
//³ mv_par08             // Ate Grupo                            ³
//³ mv_par09             // Imprime Lote/Sub-Lote/NS             ³
//³ mv_par10             // Data de Contagem                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da secao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a secao.                   ³
//³ExpA4 : Array com as Ordens do relatorio                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection1:= TRSection():New(oReport,STR0011,{"SB1","SB7"},aOrdem) // "Lancamentos para Inventario - Contagens"
oSection1:SetNoFilter("SB7")

TRCell():New(oSection1,'B1_CODITE'	,cAliasSB7	,/*Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_COD'		,cAliasSB7	,		    ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)
TRCell():New(oSection1,'B1_DESC'	,cAliasSB7	,       	,/*Picture*/,nTamB1Desc ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_TIPO'	,cAliasSB7	,STR0014 	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_GRUPO'	,cAliasSB7	,			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_UM'		,cAliasSB7	,STR0012	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_LOCAL'	,cAliasSB7	,STR0013	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_LOCALIZ'	,cAliasSB7	,       	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_NUMSERI'	,cAliasSB7	,        	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_LOTECTL'	,cAliasSB7	,       	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_NUMLOTE'	,cAliasSB7	,        	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_CONTAGE'	,cAliasSB7	,			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_DOC'		,cAliasSB7	,			,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_QUANT'	,cAliasSB7	,	  	    ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³Marcos V. Ferreira   ³ Data ³20/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR285			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,aOrdem,cAliasSB7)

Local oSection1		:= oReport:Section(1)

Local aStrucSB1		:= {}
Local aProd			:= {}

Local cFieldProd	:= ""
Local cSB1Prod		:= ""
Local cName			:= ""
Local cSeek			:= ""
Local cSelect		:= ""
Local cSelAux		:= ""
Local cOrderBy		:= ""
Local cFilUsrSB1	:= ""
                                   
Local lVeic			:= Upper(SuperGetMV("MV_VEICULO", .F., "N")) == "S"
Local lProcInv		:= .F.
Local lContDiv		:= .F.

Local nOrder		:= oSection1:GetOrder()
Local nX			:= 0
Local nY			:= 0
Local nPosProd		:= 0

Local cSeekAnt := ""
Local lFirstLoop := .T.
Local aReg := {}


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + ' (' + AllTrim(aOrdem[nOrder]) + ')')

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Desliga as colunas que nao serao utilizadas no relatorio     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lVeic
	oSection1:Cell('B1_CODITE'):Disable()
	cFieldProd := 'B1_COD'
Else
	oSection1:Cell('B1_COD'):Disable()
	cFieldProd := 'B1_CODITE'
EndIf	

If mv_par09 == 2
	oSection1:Cell('B7_LOTECTL'	):Disable()
	oSection1:Cell('B7_NUMLOTE'	):Disable()
	oSection1:Cell('B7_NUMSERI'	):Disable()
EndIf

DbSelectArea('SB1')
SB1->(DbSetOrder(1))

aStrucSB1 := SB1->(DbStruct())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Esta rotina foi escrita para adicionar no select os campos         ³
//³usados no filtro do usuario. Quando houver, a rotina acrescenta    ³
//³somente os campos que forem adicionados ao filtro testando         ³
//³se os mesmos já existem no select.								  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   	
cSelect := "%"
cFilUsrSB1:= oSection1:GetAdvplExp()
cSelAux := "SB1.B1_FILIAL, SB1.B1_COD, SB1.B1_TIPO, SB1.B1_GRUPO, SB1.B1_DESC, SB1.B1_UM, SB1.B1_CODITE"
If !Empty(cFilUsrSB1)
    For nX := 1 To SB1->(FCount())
    	cName := SB1->(FieldName(nX))
    	If AllTrim( cName ) $ cFilUsrSB1
    		If aStrucSB1[nX,2] <> "M"  
    			If !cName $ cSelAux
    				cName := "SB1." + cName
    				cSelAux += ", " + cName 
    			EndIf 	
    		EndIf
    	EndIf 			       	
    Next nX 
EndIf
cSelect += cSelAux
cSelect += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ ORDER BY - Adicional                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cOrderBy := "%"
If nOrder == 1 //-- Por Codigo
	cOrderBy += "SB1.B1_FILIAL, SB7.B7_DATA, SB1." + cFieldProd + ", SB7.B7_LOCAL, SB7.B7_LOCALIZ, SB7.B7_NUMSERI, SB7.B7_LOTECTL, SB7.B7_NUMLOTE"
ElseIf nOrder == 2 //-- Por Tipo
	cOrderBy += " SB1.B1_FILIAL, SB7.B7_DATA, SB1.B1_TIPO, SB1." + cFieldProd + ", SB7.B7_LOCAL, SB7.B7_LOCALIZ, SB7.B7_NUMSERI, SB7.B7_LOTECTL, SB7.B7_NUMLOTE"
ElseIf nOrder == 3 //-- Por Grupo
	cOrderBy += " SB1.B1_FILIAL, SB7.B7_DATA, SB1.B1_GRUPO, SB1." + cFieldProd + ", SB7.B7_LOCAL, SB7.B7_LOCALIZ, SB7.B7_NUMSERI, SB7.B7_LOTECTL, SB7.B7_NUMLOTE"
ElseIf nOrder == 4 //-- Por Descricao
	cOrderBy += "SB1.B1_FILIAL, SB7.B7_DATA, SB1.B1_DESC, SB1."	+ cFieldProd + ", SB7.B7_LOCAL, SB7.B7_LOCALIZ, SB7.B7_NUMSERI, SB7.B7_LOTECTL, SB7.B7_NUMLOTE"
ElseIf nOrder == 5 //-- Por Local
	cOrderBy += "SB1.B1_FILIAL, SB7.B7_DATA, SB1.B1_LOCPAD, SB1."+ cFieldProd + ", SB7.B7_LOCAL, SB7.B7_LOCALIZ, SB7.B7_NUMSERI, SB7.B7_LOTECTL, SB7.B7_NUMLOTE"
EndIf
cOrderBy += "%"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da Query do relatorio                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:BeginQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ajusta Campo de Codigo do Produto                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSB1Prod := "%" + "SB1." + cFieldProd + "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio do Embedded SQL                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BeginSql Alias cAliasSB7

	SELECT	SB7.B7_FILIAL,
			SB7.B7_DATA, 
			SB7.B7_COD, 
			%Exp:cSelect%, 
			SB7.B7_LOCAL, 
			SB7.B7_LOCALIZ, 
			SB7.B7_LOTECTL, 
			SB7.B7_NUMLOTE, 
			SB7.B7_NUMSERI, 
			SB7.B7_CONTAGE,  
			SB7.B7_QUANT,
			SB7.B7_DOC,
			SB7.B7_ESCOLHA,
			SB7.B7_STATUS,
			SB7.R_E_C_N_O_
	FROM	%Table:SB7% SB7		
	JOIN	%Table:SB1% SB1 
	ON 		SB1.B1_FILIAL = %xFilial:SB1%  
			AND SB1.B1_COD = SB7.B7_COD
			AND SB1.%NotDel% 
	WHERE	SB7.B7_FILIAL = %xFilial:SB7%
			AND %Exp:cSB1Prod% >= %Exp:mv_par01% 
			AND %Exp:cSB1Prod% <= %Exp:mv_par02%
			AND SB1.B1_TIPO >= %Exp:mv_par03%  
			AND SB1.B1_TIPO <= %Exp:mv_par04% 
			AND SB7.B7_LOCAL >= %Exp:mv_par05%
			AND SB7.B7_LOCAL <= %Exp:mv_par06%
			AND SB1.B1_GRUPO >= %Exp:mv_par07%
			AND SB1.B1_GRUPO <= %Exp:mv_par08% 
			AND SB7.B7_DATA = %Exp:Dtos(mv_par10)% 
			AND SB7.%NotDel% 
	ORDER BY %Exp:cOrderBy%
EndSql

oSection1:EndQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Abertura do Arquivo de Trabalho                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAliasSB7)
oReport:SetMeter(SB1->(LastRec()))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento do Relatorio                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Init(.F.)

Do While !(cAliasSB7)->(Eof())
	
    cSeek := (cAliasSB7)->B7_FILIAL + DtoS((cAliasSB7)->B7_DATA) + (cAliasSB7)->B7_COD + (cAliasSB7)->B7_LOCAL + (cAliasSB7)->B7_LOCALIZ + (cAliasSB7)->B7_NUMSERI + (cAliasSB7)->B7_LOTECTL + (cAliasSB7)->B7_NUMLOTE
	
    If cSeek <> cSeekAnt

        If lFirstLoop
            lFirstLoop := .F.
        Else
            U_r287Print(cFieldProd, aReg, oSection1, oReport)
            aReg := {}
        EndIf

        cSeekAnt := cSeek

	EndIf

    aAdd(aReg, {(cAliasSB7)->&(cFieldProd),;	//aReg[x][1] = Codigo do Produto	
                (cAliasSB7)->B1_DESC,;			//aReg[x][2] = Descricao
                (cAliasSB7)->B1_TIPO,;			//aReg[x][3] = Tipo
                (cAliasSB7)->B1_GRUPO,;			//aReg[x][4] = Grupo
                (cAliasSB7)->B1_UM,;			//aReg[x][5] = Unidade Medida
                (cAliasSB7)->B7_LOCAL,;			//aReg[x][6] = Local
                (cAliasSB7)->B7_LOCALIZ,;		//aReg[x][7] = Endereco
                (cAliasSB7)->B7_NUMSERI,;		//aReg[x][8] = Serie
                (cAliasSB7)->B7_LOTECTL,;		//aReg[x][9] = Lote
                (cAliasSB7)->B7_NUMLOTE,;		//aReg[x][10] = SubLote
                (cAliasSB7)->B7_CONTAGE,;		//aReg[x][11] = Contagem
                (cAliasSB7)->B7_DOC,;			//aReg[x][12] = Documento
                (cAliasSB7)->B7_QUANT,;			//aReg[x][13] = Quantidade
                (cAliasSB7)->B7_ESCOLHA,;		//aReg[x][14] = Escolha
                (cAliasSB7)->B7_STATUS,;		//aReg[x][15] = Status de Processamento de Inventário
                (cAliasSB7)->R_E_C_N_O_ } )		//aReg[x][16] = Recno

	(cAliasSB7)->(DbSkip())

EndDo

U_r287Print(cFieldProd, aReg, oSection1, oReport)

oSection1:Finish()

Return

User Function r287Print(cFieldProd, aSec, oSection1, oReport)

    Local lContDiv := .F.
    Local nY := 0
	
	If Len(aSec) > 1 //Controle de múltipla contagem

		lContDiv := .F.	//Reset do controle de contagens divergentes a cada novo produto

		For nY := 1 To Len(aSec)
			 						
			If nY > 1 .And. !lContDiv //A partir da segunda contagem, se nao tiver inventário processado, compara as contagens para encontrar divergencias
				lContDiv := aSec[nY][13] <> aSec[nY-1][13] 
			EndIf
            
            If lContDiv // Se houver ao menos 1 divergência, a impressão ocorrerá independente do número de registros.
                Exit
            EndIf

		Next nY

		If lContDiv //Habilita a impressão somente de produtos que tenham contagem com quantidades divergentes

			oSection1:Cell(cFieldProd	):Show()
			oSection1:Cell('B1_DESC'	):Show()
			oSection1:Cell('B1_TIPO'	):Show()
			oSection1:Cell('B1_GRUPO'	):Show()
			oSection1:Cell('B1_UM'		):Show()
			oSection1:Cell('B7_LOCAL'	):Show()
			oSection1:Cell('B7_LOCALIZ'	):Show()
			oSection1:Cell('B7_NUMSERI'	):Show()
			oSection1:Cell('B7_LOTECTL'	):Show()
			oSection1:Cell('B7_NUMLOTE'	):Show()

			For nY := 1 To Len(aSec)
				If nY == 1
					oSection1:Cell(cFieldProd	):SetValue(aSec[nY][1])
					oSection1:Cell('B1_DESC'	):SetValue(aSec[nY][2])
					oSection1:Cell('B1_TIPO'	):SetValue(aSec[nY][3])
					oSection1:Cell('B1_GRUPO'	):SetValue(aSec[nY][4])
					oSection1:Cell('B1_UM'		):SetValue(aSec[nY][5])
					oSection1:Cell('B7_LOCAL'	):SetValue(aSec[nY][6])
					oSection1:Cell('B7_LOCALIZ'	):SetValue(aSec[nY][7])
				Else
					oSection1:Cell(cFieldProd	):Hide()
					oSection1:Cell('B1_DESC'	):Hide()
					oSection1:Cell('B1_TIPO'	):Hide()
					oSection1:Cell('B1_GRUPO'	):Hide()
					oSection1:Cell('B1_UM'		):Hide()
					oSection1:Cell('B7_LOCAL'	):Hide()
					oSection1:Cell('B7_LOCALIZ'	):Hide()
					oSection1:Cell('B7_NUMSERI'	):Hide()
					oSection1:Cell('B7_LOTECTL'	):Hide()
					oSection1:Cell('B7_NUMLOTE'	):Hide()
				EndIf 		
				If mv_par09 == 1
					oSection1:Cell('B7_NUMSERI'	):SetValue(aSec[nY][8])
					oSection1:Cell('B7_LOTECTL'	):SetValue(aSec[nY][9])
					oSection1:Cell('B7_NUMLOTE'	):SetValue(aSec[nY][10])
				EndIf
							
				oSection1:Cell('B7_CONTAGE'	):SetValue(aSec[nY][11])
				oSection1:Cell('B7_DOC'		):SetValue(aSec[nY][12])
				oSection1:Cell('B7_QUANT'	):SetValue(aSec[nY][13])
						
				oSection1:PrintLine()
			Next nY
			oReport:ThinLine()
		EndIf
	EndIf

Return
