/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE  "TOTVS.CH"
#INCLUDE  "QDOR030.CH"
#INCLUDE  "Protheus.CH"
#include  "report.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QADR015   ºAutor  ³Telso Carneiro      º Data ³  30/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio Lista de Treinandos por Documento                º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function QDOR030()
Local oReport	

If !TRepInUse()
	Return U_QDOR030R3()	// Executa versão anterior do fonte
Endif                

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("QDR030",.F.)
oReport := ReportDef()
oReport:PrintDialog()

Return


Static Function ReportDef()
Local cTitulo	:= OemToAnsi(STR0001) // "LISTA DE TREINANDOS POR DOCUMENTO"
Local cDesc1 	:= OemToAnsi(STR0002) // "Este programa ir  imprimir uma rela‡„o de treinandos por"
Local cDesc2 	:= OemToAnsi(STR0003) // "documento, relacionando quem foi treinado em cada documento."
Local cString	:= "QD8"
Local wnrel  	:= "QDOR030"
Local cPerg   	:= "QDR030"
Local oReport
Local oSection1 
Local oSection2 
Local nLargBx	:= Eval({|| x:=Len(OemToAnsi(STR0012)),y:=Len(OemToAnsi(STR0013)),IF(x>=y,x,y)})
Local cFilCarg  := xFilial("QAC")   
Local cFilDep  	:= xFilial("QAD") 
Local nLargSl	:= Eval({|| x:=Len(OemToAnsi(STR0014)),y:=Len(OemToAnsi(STR0015)),IF(x>=y,x,y)})

Private cAliasQDA	:= "QDA"

DEFINE REPORT oReport NAME wnrel TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)

DEFINE SECTION oSection1 OF oReport TITLE OemToAnsi(STR0016) TABLES "QDA","QDH"  // "Treinamento"

DEFINE CELL NAME "QDA_DOCTO"  OF oSection1 ALIAS "QDA"
DEFINE CELL NAME "QDA_RV"     OF oSection1 ALIAS "QDA"
DEFINE CELL NAME "QDA_NUMERO" OF oSection1 ALIAS "QDA" 
DEFINE CELL NAME "QDA_ANO" 	  OF oSection1 ALIAS "QDA"
DEFINE CELL NAME "QDA_DTCAD"  OF oSection1 ALIAS "QDA"
DEFINE CELL NAME "QDA_DTFEC"  OF oSection1 ALIAS "QDA"
DEFINE CELL NAME "QDA_BAIXA"  OF oSection1 ALIAS "QDA" SIZE nLargBx BLOCK {|| If(QDA_BAIXA == "S",OemToAnsi(STR0012),OemToAnsi(STR0013))}

DEFINE SECTION oSection2 OF oSection1 TITLE OemToAnsi(STR0017) TABLES "QD8" // "Treinandos"

DEFINE CELL NAME "QD8_MAT"    OF oSection2 ALIAS "QD8" TITLE OemToAnsi(STR0018) Picture "@!" SIZE 20 BLOCK {|| IIF(IsInCallStack("PrintReport"),QA_NUSR((cAliasQDA)->QD8_FILMAT,(cAliasQDA)->QD8_MAT,.T.),)  } // "Treinando"
DEFINE CELL NAME "QD8_CARGO"  OF oSection2 ALIAS "QD8" TITLE OemToAnsi(STR0019) Picture "@!" SIZE 20 BLOCK {|| IIF(IsInCallStack("PrintReport"),QA_NFUNC((cAliasQDA)->QD8_CARGO,.T.,cFilCarg),) } // "Funcao"
DEFINE CELL NAME "QD8_DEPTO"  OF oSection2 ALIAS "QD8" TITLE OemToAnsi(STR0020) Picture "@!" SIZE 20 BLOCK {|| IIF(IsInCallStack("PrintReport"),QA_NDEPT((cAliasQDA)->QD8_DEPTO,.T.,cFilDep),) } // "Departamento"
DEFINE CELL NAME "QD8_SELECA" OF oSection2 ALIAS "QD8" TITLE OemToAnsi(STR0021) Picture "@!" SIZE nLargBx BLOCK {|| If((cAliasQDA)->QD8_SELECA == "S",OemToAnsi(STR0014),OemToAnsi(STR0015)) } // "Participante"
DEFINE CELL NAME "QD8_HISTOR" OF oSection2 ALIAS "QD8" TITLE OemToAnsi(STR0022) // "Justificativa"

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrinºAutor  ³Telso Carneiro      º Data ³  30/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio Personalizavel                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³QADR015()                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
                  
Static Function PrintReport(oReport) 

Local cQueryQDA	:= ""
Local cQueryQD8	:= ""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam) 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtro para treinamentos (Considera so os Baixados ou nao)    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cQueryQDA:="% "
	If mv_par05 == 2
		cQueryQDA+= " And QDA.QDA_BAIXA = 'S'"
	ElseIf mv_par05 == 3
		cQueryQDA+= " And QDA.QDA_BAIXA <>'S'"		
	EndIf        
	cQueryQDA+=" %"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtro para treinandos (Considera so participantes ou nao)       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	cQueryQD8:="% "
	If mv_par05 <> 3
	    If mv_par06 ==1
	       cQueryQD8+= "AND QD8.QD8_BAIXA = 'S'"
		ElseIf mv_par06 == 2
		   cQueryQD8+= "AND QD8.QD8_SELECA = 'S' AND QD8.QD8_BAIXA = 'S'"
		ElseIf mv_par06 == 3
		   cQueryQD8+= "AND QD8.QD8_SELECA = 'N'"
		EndIf
	EndIf	
	cQueryQD8+=" %"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatório da secao 1                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):BeginQuery()	
	
	cAliasQDA := GetNextAlias()
	
	BeginSql Alias cAliasQDA

	SELECT QDA.QDA_FILIAL,QDA.QDA_DOCTO,QDA.QDA_RV,QDA.QDA_ANO,QDA.QDA_NUMERO,QDA.QDA_BAIXA,
		QDA.QDA_DTCAD,QDA.QDA_DTFEC,
		QD8.QD8_FILIAL,QD8.QD8_FILMAT,QD8.QD8_MAT,QD8.QD8_DEPTO,QD8.QD8_CARGO,QD8.QD8_NUMERO,
		QD8.QD8_ANO,QD8.QD8_SELECA,QD8.QD8_HISTOR
	 	
	 	FROM %table:QDA% QDA 	
        JOIN %table:QD8% QD8
        	ON QDA.QDA_FILIAL=QD8.QD8_FILIAL AND 
			QDA.QDA_ANO=QD8.QD8_ANO AND 
			QDA.QDA_NUMERO=QD8.QD8_NUMERO AND 
			QD8.%notDel%       
			%Exp:cQueryQD8% 				
		WHERE QDA_FILIAL = %xFilial:QDA% AND 
			QDA.QDA_DOCTO BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
			QDA.QDA_RV BETWEEN %Exp:mv_par03% AND %Exp:mv_par04% AND
			QDA.%notDel%  		                
			%Exp:cQueryQDA%    

	ORDER BY QDA_FILIAL,QDA_DOCTO,QDA_RV,QDA_ANO,QDA_NUMERO
			
	EndSql 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar o Embedded SQL.                       ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):EndQuery()
	oReport:Section(1):Section(1):SetParentQuery()	
	oReport:Section(1):Section(1):SetParentFilter( { |cParam| (cAliasQDA)->QD8_FILIAL+(cAliasQDA)->QD8_ANO+(cAliasQDA)->QD8_NUMERO == cParam },{ || (cAliasQDA)->QDA_FILIAL+(cAliasQDA)->QDA_ANO+(cAliasQDA)->QDA_NUMERO })
	TRPosition():New(oReport:Section(1),"QDH", 1, {|| xFilial("QDH")+(cAliasQDA)->QDA_DOCTO+(cAliasQDA)->QDA_RV})

oReport:Section(1):Print()

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QDO30VSEL ºAutor  ³Telso Carneiro      º Data ³  08/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Controla a impressao do Treinamento atraves da verificacao º±±
±±º          ³ da presenca do treinandos conforme pergunte sx1            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function QDOR30SEL(cSeekQD8,cSel)
Local lRet		:=.F.

QD8->(DbSeek(cSeekQD8))
While QD8->(!Eof()) .And. QD8->QD8_FILIAL+QD8->QD8_ANO+QD8->QD8_NUMERO == cSeekQD8
	IF QD8->QD8_SELECA == cSel
		lRet:=.T.
		Exit
	Endif
	QD8->(DbSkip())
EndDo

Return(lRet)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QDOR030  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 09/07/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio Lista de Treinandos por Documento                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR030                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Eduardo S.  ³28/03/02³ META ³ Otimizacao e Melhoria.                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QDOR030R3()

Local cTitulo:= OemToAnsi(STR0001) // "LISTA DE TREINANDOS POR DOCUMENTO"
Local cDesc1 := OemToAnsi(STR0002) // "Este programa ir  imprimir uma rela‡„o de treinandos por"
Local cDesc2 := OemToAnsi(STR0003) // "documento, relacionando quem foi treinado em cada documento."
Local cDesc3 := ""
Local cString:= "QD8"
Local wnrel  := "QDOR030"
Local Tamanho:= "M"

Private cPerg   := "QDR030"
Private aReturn := {STR0004,1,STR0005, 1, 2, 1, "",1 } // "Zebrado"###"Administra‡„o"
Private nLastKey:=0
Private INCLUI  := .F.	// Colocada para utilizar as funcoes

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                               ³
//³ mv_par01	// De  Documento                                        ³
//³ mv_par02	// Ate Documento                                        ³
//³ mv_par03	// De  Revisao                                          ³
//³ mv_par04	// Ate Revisao                                          ³
//³ mv_par05	// Treinamentos   1- Todos 2- Realizados 3- Pendentes   ³
//³ mv_par06	// Treinando Real 1- Todos 2- Participou 3- N Participou³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

wnrel :=AllTrim(SetPrint(cString,wnrel,cPerg,ctitulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho))

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

RptStatus({|lEnd| QDOR030Imp(@lEnd,ctitulo,wnRel,tamanho)},ctitulo)

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QDOR030Imp³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 09/07/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Envia para funcao que faz a impressao do relatorio.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QDOR030Imp(lEnd,ctitulo,wnRel,tamanho)

Local cCabec1  := " "
Local cCabec2  := " "
Local cbtxt    := SPACE(10)
Local nTipo		:= 0
Local cbcont   := 0
Local cCampos1 := " "
Local cCampos2 := " "
Local cCompara1:= " "
Local cCompara2:= " "
Local cCondQD8 := ".T."
Local lCabec   := .T.
Local cIndex1  := CriaTrab(Nil,.F.)
Local cFiltro  := " "
Local cKey     := " "
Local cFilCarg := xFilial("QAC")
Local cFilDep  := xFilial("QAD")

DbSelectarea("QD8")
DbSetOrder(1)

DbSelectarea("QDA")
DbSetOrder(1)

cFiltro:= 'QDA->QDA_FILIAL == "'+xFilial("QDA")+'" .And. '
cFiltro+= 'QDA->QDA_DOCTO >= "'+mv_par01+'" .And. QDA->QDA_DOCTO <= "'+mv_par02+'" .And. '
cFiltro+= 'QDA->QDA_RV >= "'+mv_par03+'" .And. QDA->QDA_RV <= "'+mv_par04+'"'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtro para treinamentos (Considera so os Confirmados ou nao)    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par05 == 2
	cFiltro+= ' .And. QDA->QDA_BAIXA == "S"'
ElseIf mv_par05 == 3
	cFiltro+= ' .And. QDA->QDA_BAIXA <> "S"'
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtro para treinandos (Considera so participantes ou nao)       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par05 <> 3
    If mv_par06 == 1
		cCondQD8:= 'QD8->QD8_BAIXA=="S"'
	ElseIf mv_par06 == 2
		cCondQD8:= 'QD8->QD8_SELECA == "S".and. QD8->QD8_BAIXA=="S"'
	ElseIf mv_par06 == 3
		cCondQD8:= 'QD8->QD8_SELECA == "N"'
	EndIf
EndIf

cKey:= 'QDA->QDA_FILIAL+QDA->QDA_DOCTO+QDA->QDA_RV+QDA->QDA_ANO+QDA->QDA_NUMERO'
IndRegua("QDA",cIndex1,cKey,,cFiltro,OemToAnsi(STR0006))	//"Selecionando Registros.."

//         1         2         3         4         5         6         7         8
//12345678901234567890123456789012345678901234567890123456789012345678901234567890
//TREINANDO            FUNCAO          DEPARTAMENTO    NUMERO/ANO DATA     DATA
//                                                                SOLICIT. REALIZA.

cCabec1:= OemToAnsi(STR0007) //"TREINANDO            FUNCAO          DEPARTAMENTO    NUMERO/ANO DATA     DATA"
cCabec2:= OemToAnsi(STR0008)	//"                                                                SOLICIT. REALIZA."

li       := 80
m_pag    := 1

QDA->(DbSeek(xFilial("QDA")))
SetRegua(QDA->(RecCount())) // Total de Elementos da Regua

While QDA->(!Eof())
	lCabec   := .T.
	cCompara1:= QDA->QDA_FILIAL+QDA->QDA_DOCTO+QDA->QDA_RV
	cCampos1 := "QDA->QDA_FILIAL+QDA->QDA_DOCTO+QDA->QDA_RV"
	If lEnd
		li++
		@ PROW()+1,001 PSAY OemToAnsi(STR0009) //"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If li > 58
		Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,nTipo)
	EndIf
	While QDA->(!Eof()) .And. cCompara1 == &(cCampos1)
		IncRegua()
		cCompara2:= QDA->QDA_FILIAL+QDA->QDA_ANO+QDA->QDA_NUMERO
		cCampos2 := "QD8->QD8_FILIAL+QD8->QD8_ANO+QD8->QD8_NUMERO"
		If lEnd
			li++
			@ PROW()+1,001 PSAY OemToAnsi(STR0009) //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
		If li > 58
			Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,nTipo)
		EndIf
		
		QD8->(DbSeek(cCompara2))
		While QD8->(!Eof()) .And. cCompara2 == &(cCampos2)
			If FWModeAccess("QAC") == "E" //!Empty(cFilCarg)
				cFilCarg:= QD8->QD8_FILMAT
			EndIf
			If FWModeAccess("QAD") == "E" //!Empty(cFilDep)
				cFilDep:= QD8->QD8_FILMAT
			EndIf			
			If &(cCondQD8)
				If lCabec
					@ li,000 PSay Upper(STR0010)+AllTrim(QDA->QDA_DOCTO)+"/"+QDA->QDA_RV		//"Documento: "
					@ li,pCol()+2 PSay If(QDA->QDA_BAIXA == "S",OemToAnsi(STR0012),OemToAnsi(STR0013)) // sRealizado ### // Pendente "
					li++
					@ li,000 PSAY __PrtFatLine()
					li++
					lCabec := .F.
				EndIf
				If lEnd
					li++
					@ PROW()+1,001 PSAY OemToAnsi(STR0009) //"CANCELADO PELO OPERADOR"
					Exit
				EndIf
				If li > 58
					Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,nTipo)
				EndIf
				@ li,000 PSay Substr(QA_NUSR(QD8->QD8_FILMAT,QD8->QD8_MAT,.T.),1,20)
				@ li,021 PSay Substr(QA_NFUNC(QD8->QD8_CARGO,.T.,cFilCarg),1,15)
				@ li,037 PSay Substr(QA_NDEPT(QD8->QD8_DEPTO,.T.,cFilDep),1,15)
				@ li,053 PSay AllTrim(QD8->QD8_NUMERO)+"/"+QD8->QD8_ANO
				@ li,064 PSay QDA->QDA_DTCAD
				@ li,079 Psay QDA->QDA_DTFEC
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime o Historico de Justificativa Caso exista³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				@ li,pCol()+6  PSay iif(QD8->QD8_SELECA == "S",OemToAnsi(STR0014),OemToAnsi(STR0015))
				@ li,pCol()+10 PSay QD8->QD8_HISTOR
				li++
			EndIf
			QD8->(DbSkip())
		EndDo
		@ li,000 PSAY __PrtThinLine()
		li++
		QDA->(DbSkip())
	EndDo
	li++
EndDo

If li <> 80
	Roda(cbcont,cbtxt,tamanho)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve as ordens originais do arquivo                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("QDA")
Set Filter to

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indice de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cIndex1 += OrdBagExt()
Delete File &(cIndex1)

Set Device To Screen

If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
Endif
MS_FLUSH()

Return (.T.)

