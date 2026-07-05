/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QMTR080.CH"
#Include "PROTHEUS.CH"
#include "report.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR080  ³ Autor ³ Cicero Cruz           ³ Data ³ 18.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Referencia cruzada. Instrumento x Instrumento Utilizado    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR080(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QMTR080()
Local oReport        
Private cInstAnt  := ""   
Private cAliasQM2 := "QM2"
Private cAliasQM3 := "QM3"
Private cAliasQMA := "QMC"
Private cAliasQMC := "QMA"
Private cAliasQMK := "QMK"
Private aEscDSom  := {}

If TRepInUse()
	// Interface de impressao
	oReport := ReportDef()
 	oReport:PrintDialog()
Else
	U_QMTR080R3()
EndIf

Return
         
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Cicero Cruz           ³ Data ³ 23/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ QMTR080                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport 
Local oSection1
Local aOrdem    := {}
Local cPerg		:="QMR080"

DEFINE REPORT oReport NAME "QMTR080" TITLE STR0003 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION STR0001+STR0002

aOrdem := {}

DEFINE SECTION oSection OF oReport TITLE STR0018 TABLES "QM3","QMK","QM2","QMA" //"Padrao x Instrumento"

DEFINE CELL NAME "QM3_PADRAO"   OF oSection ALIAS "QM3"
DEFINE CELL NAME "QM3_REVPAD"   OF oSection ALIAS "QM3" TITLE STR0016
DEFINE CELL NAME "QM3_DESCRI"   OF oSection ALIAS "QM3"
DEFINE CELL NAME "QMK_ESCALA"   OF oSection ALIAS "QMK" TITLE STR0017 SIZE 20
DEFINE CELL NAME "QM2_INSTR"    OF oSection ALIAS "QM2"
DEFINE CELL NAME "QM2_REVINS"   OF oSection ALIAS "QM2" TITLE STR0016 
DEFINE CELL NAME "QM2_TIPO"     OF oSection ALIAS "QM2" 
DEFINE CELL NAME "QM2_DEPTO"    OF oSection ALIAS "QM2" 
DEFINE CELL NAME "QM2_RESP"     OF oSection ALIAS "QM2"

DEFINE SECTION oLegenda1 OF oReport TITLE OemToAnsi(STR0019) //"Legenda" 
oLegenda1:SetHeaderSection()
DEFINE CELL NAME "TITULO"      OF oLegenda1           SIZE 120 ALIGN CENTER  

DEFINE SECTION oLegenda2 OF oReport TITLE OemToAnsi(STR0020)//"Legenda - Usuarios" 
DEFINE CELL NAME "COD"         OF oLegenda2            SIZE  15 TITLE STR0012      // "Codigo"
DEFINE CELL NAME "NOME"        OF oLegenda2            SIZE  30 TITLE STR0013      // "Nome"
DEFINE CELL NAME "NREDUZ"      OF oLegenda2            SIZE  15 TITLE STR0014      // "N. Reduz"

DEFINE SECTION oLegenda3 OF oReport TITLE OemToAnsi(STR0021) //"Legenda - Departamentos" 
DEFINE CELL NAME "COD"         OF oLegenda3            SIZE  15 TITLE STR0012       // "Codigo"
DEFINE CELL NAME "DEPTO"       OF oLegenda3            SIZE  30 TITLE STR0015       //"Departamento"

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³PrintRepor³ Autor ³ Cicero Cruz           ³ Data ³ 26.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao dos Textos	Reprogramacao R4	 				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTr160													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport( oReport )
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2) //oLegenda1
Local oSection3 := oReport:Section(3) //oLegenda2
Local oSection4 := oReport:Section(4) //oLegenda3
Local cFiltro   := ""
Local cPerg	    :="QMR080"  
Local cStrAnt   := ""
Local cStrQM2   := ""
Local cPadra    := ""
Local nX 		:= 0     
Local nI 		:= 0     
 
cAliasQM2 := "QM2"
cAliasQM3 := "QM3"
cAliasQMA := "QMA"
cAliasQMC := "QMC"
cAliasQMK := "QMK"

Pergunte(cPerg,.F.)  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   	MakeSqlExpr(oReport:uParam) 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:BeginQuery()	

cAliasQM3 := GetNextAlias()

cChave  := "1, 2"

cFiltro := ""

BeginSql Alias cAliasQM3                   

SELECT QM3.QM3_FILIAL,QM3.QM3_PADRAO,QM3.QM3_REVPAD,QM3.QM3_DESCRI,QM3.QM3_TIPPAD, QMK_ESCALA, 
            QM2_INSTR,QM2_REVINS,QM2_TIPO,QM2_DEPTO,QM2_RESP,QM2_REVINV	,QM3.QM3_TIPPAD	
 	FROM %table:QM3% QM3,
             %table:QMC% QMC, 
             %table:QMK% QMK,
             %table:QM2% QM2
	WHERE QM3.QM3_FILIAL = %xFilial:QM3% AND
          QM3.QM3_PADRAO BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
              QMC.QMC_FILIAL = QM3.QM3_FILIAL AND 
              QMC.QMC_PADRAO = QM3.QM3_PADRAO AND 
              QMK.QMK_FILIAL = QMC.QMC_FILIAL AND
              QMK.QMK_ESCALA = QMC.QMC_ESCALA AND
              QM2.QM2_FILIAL = QMK.QMK_FILIAL AND
              QM2.QM2_TIPO   = QMK.QMK_TIPO AND
              QM3.%notDel% AND
              QM2.%notDel% AND 
              QMK.%notDel% AND 
              QMC.%notDel% 
 
   
EndSql   
oSection1:EndQuery() 

While !&(cAliasQM3)->(Eof())
	
	Do Case
		Case mv_par03 == 2 
			If &(cAliasQM3+"->QM3_TIPPAD") != 'O'  
				&(cAliasQM3)->(dbSkip())
				Loop
			EndIf
		Case mv_par03 == 3 
			If &(cAliasQM3+"->QM3_TIPPAD") != 'S'  
				&(cAliasQM3)->(dbSkip())
				Loop
			EndIf
		Case mv_par03 == 4 
			If &(cAliasQM3+"->QM3_TIPPAD") != 'A'   
				&(cAliasQM3)->(dbSkip())
				Loop
			EndIf
	EndCase
	
	If &(cAliasQM3+"->QM3_PADRAO")+&(cAliasQM3+"->QMK_ESCALA")+&(cAliasQM3+"->QM2_INSTR") == cStrAnt
		&(cAliasQM3)->(dbSkip())
		Loop
	Else
		cStrAnt := &(cAliasQM3+"->QM3_PADRAO")+&(cAliasQM3+"->QMK_ESCALA")+&(cAliasQM3+"->QM2_INSTR")
	EndIf 

	If !Empty(AllTrim(oReport:Section(1):GetSqlExp("QM3")))
		If !&(oReport:Section(1):GetSqlExp("QM3"))
			&(cAliasQM3)->(dbSkip())
			Loop
		Endif
	EndIf


	If !Empty(AllTrim(oReport:Section(1):GetSqlExp("QMK")))
		If !&(oReport:Section(1):GetSqlExp("QMK"))
			&(cAliasQM3)->(dbSkip())
			Loop
		Endif
	EndIf

	If !Empty(AllTrim(oReport:Section(1):GetSqlExp("QM2")))
		If !&(oReport:Section(1):GetSqlExp("QM2"))
			&(cAliasQM3)->(dbSkip())
			Loop
		Endif
	EndIf

	Aadd(aEscDSom,{	&(cAliasQM3+"->QM3_PADRAO"),&(cAliasQM3+"->QM3_REVPAD"),&(cAliasQM3+"->QM3_DESCRI"),;
				&(cAliasQM3+"->QMK_ESCALA"),&(cAliasQM3+"->QM2_INSTR"),&(cAliasQM3+"->QM2_REVINS"),&(cAliasQM3+"->QM2_TIPO"),;
				&(cAliasQM3+"->QM2_DEPTO"),&(cAliasQM3+"->QM2_RESP"),&(cAliasQM3+"->QM2_REVINV")})

	&(cAliasQM3)->(dbSkip())
Enddo

aSort(aEscDSom,,,{|x,y| x[1]+x[2]+x[4]+x[5]+x[10]+x[7] < y[1]+y[2]+y[4]+y[5]+y[10]+y[7]})  

For nX := 1 To Len(aEscDSom)
	oSection1:Init()

	If aEscDSom[nx][1] <> cStrQM2
		oReport:SkipLine(1)
	Endif

	cStrQM2 := aEscDSom[nx][1]	
	DbSelectArea("QM3") 
	DbSetOrder(1)
	If QMA070UltR(aEscDSom[nx][1])<> aEscDSom[nX][2]
		loop
	Endif
    
	If aEscDSom[nx][1] <> cPadra
		oSection1:Cell("QM3_PADRAO"):SetValue(aEscDSom[nX][1])
		oSection1:Cell("QM3_REVPAD"):SetValue(aEscDSom[nX][2])
		oSection1:Cell("QM3_DESCRI"):SetValue(aEscDSom[nX][3]) 
		oSection1:Cell("QM3_PADRAO"):Show()
		oSection1:Cell("QM3_REVPAD"):Show()
		oSection1:Cell("QM3_DESCRI"):Show()
		cPadra := aEscDSom[nX][1]
	Else	
		oSection1:Cell("QM3_PADRAO"):Hide()
		oSection1:Cell("QM3_REVPAD"):Hide()
		oSection1:Cell("QM3_DESCRI"):Hide()
		cPadra := aEscDSom[nX][1]	
	Endif	

	oSection1:Cell("QMK_ESCALA"):SetValue(aEscDSom[nX][4])
	oSection1:Cell("QM2_INSTR"):SetValue(aEscDSom[nX][5])
	oSection1:Cell("QM2_REVINS"):SetValue(aEscDSom[nX][6])
	oSection1:Cell("QM2_TIPO"):SetValue(aEscDSom[nX][7])
	oSection1:Cell("QM2_DEPTO"):SetValue(aEscDSom[nX][8])
	oSection1:Cell("QM2_RESP"):SetValue(aEscDSom[nX][9])
	oSection1:PrintLine()

Next

If mv_par04 == 1 
	lFirst := .T.
	cOldUus := "" 

	If 	lFirst
		oSection2:Init()
		oReport:SkipLine(1)  
		oSection2:PrintLine()
		oSection2:Cell("TITULO"):SetValue(STR0009)    // "LEGENDA RESPONSAVEL(IS)/DEPARTAMENTO(S)"
		oSection2:PrintLine()
		lFirst := .F.
	EndIf
		
	aSort(aEscDSom,,,{|x,y| x[9] < y[9]})
	For nI := 1 To Len(aEscDSom)
		If cOldUus <> aEscDSom[nI][9]
			oSection3:Init()
			oSection3:Cell("COD"):SetValue(aEscDSom[nI][9])
			dbSelectArea("QAA")
			dbSetOrder(1)
			dbSeek(xFilial("QAA")+aEscDSom[nI][9])
			oSection3:Cell("NOME"):SetValue(QAA->QAA_NOME)
			oSection3:Cell("NREDUZ"):SetValue(QAA->QAA_APELID)
			oSection3:PrintLine()
            cOldUus := aEscDSom[nI][9]
		Endif	
	Next 

	aSort(aEscDSom,,,{|x,y| x[8] < y[8]})
	For nI := 1 To Len(aEscDSom)
		If cOldUus <> aEscDSom[nI][8]
			oSection4:Init()
			oSection4:Cell("COD"):SetValue(aEscDSom[nI][8])
			dbSelectArea("QAD")
			dbSetOrder(1)
			dbSeek(xFilial("QAD")+aEscDSom[nI][8])
			oSection4:Cell("DEPTO"):SetValue(QAD->QAD_DESC)
			oSection4:PrintLine() 
			cOldUus := aEscDSom[nI][8]
		Endif	
	Next 
EndIf
    
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³QMTR080R3 ³ Autor ³ Alessandro B. Freire  ³ Data ³ 29.08.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Referencia cruzada. Padrao x Instrumento.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_QMTR080(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ 		ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL. 			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³PROGRAM.  ³ DATA   ³ BOPS ³			MOTIVO DA ALTERACAO				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Denis  	 ³22/01/03³61870 ³Realizar impressao de padroes que estao sen-³±± 
±±³ 		 ³		  		 ³do utilizados em escalas do tipo soma.	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMTR080R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis 											 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1		:= OemToAnsi(STR0001) // "Este programa ir  emitir o relat¢rio de Referˆncia "
Local cDesc2		:= OemToAnsi(STR0002) // "cruzada entre padr”es e instrumentos"
Local cDesc3		:= ""
Local cString		:="QM3"
Local aOrd			:= {}
Local wnrel

Private titulo		:= OemToAnsi(STR0003) // "Ref. Cruzada: Padr„o x Instrumento"

Private cabec1		:= OemToAnsi(STR0004) // "Padrao           Rev Descricao                           Escala           Instrumento      Rev Familia          Depto.    Usuario "
Private cabec2		:= ""

Private aReturn		:= {OemToAnsi(STR0005),1,OemToAnsi(STR0006),1,2,1,"",1} // "Zebrado"###"Administra‡„o"
Private nomeprog	:= "QMTR080"
Private nLastKey	:= 0
Private cPerg		:= "QMR080"
Private cTamanho	:= "M"

/*
          1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Padrao             Rev   Descricao                             Instrumento        Rev   Familia            Departamento   Usuario
xxxxxxxxxxxxxxxx   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xxxxxxxxxxxxxxxx   xx    xxxxxxxxxxxxxxxx   xxxxxxxxx      xxxxxxxx

000-017-021-052-069-086-090-107-122
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas							³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("QMR080",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros								³
//³ mv_par01				// Padrao Inicial							³
//³ mv_par02				// Padrao Final								³
//³ mv_par03                // Tipo   Todos/Objetivo/Subjetivo/Atributo	³
//³ mv_par04                // Imprime Legenda ?						³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT						³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="QMTR080"
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,cTamanho)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

RptStatus({|lEnd| MTR080Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ MTR080IMP³ Autor ³ Alessandro B.Freire   ³ Data ³ 29.08.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime REFERENCIA CRUZADA: PADRAO x INSTRUMENTO           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ MTR080IMP(lEnd,wnRel,cString) 							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd	  - Acao do Codeblock								  ³±±
±±³			 ³ wnRel   - T¡tulo do relat¢rio 							  ³±±
±±³			 ³ cString - Mensagem										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function MTR080Imp(lEnd,wnRel,cString)

Local CbCont
Local CbTxt
Local Tamanho		:= " "
Local cStrPad		:= ""
Local nIndex
Local TRB_FILIAL	:= ""
Local TRB_TIPPAD	:= ""
Local cQuery		:= ""
Local cChave		:= ""	
Local cRespQ		:= ""
Local lFirst		:= .T.
Local nx			:= 1

Local cQueryQMC		:= ""
Local cChaveQMC		:= ""
Local cStrQM2		:= ""
Local lImpr			:= .T.

Private	TRB_PADRAO	:= ""
Private	TRB_REVPAD	:= ""
Private	TRB_DESCRI	:= ""
Private TM2_ESCALA	:= ""
Private cIndex		:= ""
Private cTipos		:= ""
Private cPadra		:= ""
Private cStrAnt     := ""
Private TM2_FILIAL	:= ""
Private TM2_TIPO	:= ""
Private TM2_INSTR	:= ""
Private TM2_REVINS	:= ""
Private TM2_DEPTO	:= ""
Private TM2_RESP	:= ""
Private aEscDSom	:= {}
Private aEscUsr		:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt 	:= SPACE(10)
cbcont	:= 0
li 		:= 80
m_pag 	:= 1

dbSelectArea("QM3")

cChave := "QM3_FILIAL+QM3_PADRAO"		
cQuery	:= "SELECT QM3_FILIAL,QM3_PADRAO,QM3_TIPPAD,QM3_REVPAD,QM3_DESCRI "
cQuery	+= "FROM "+RetSqlName("QM3")+" QM3 "
cQuery	+= "WHERE "
cQuery	+= "QM3.QM3_FILIAL = '"	+ xFilial("QM3")+ "' AND " 
cQuery	+= "QM3.QM3_PADRAO BetWeen '"	+ mv_par01+	"' AND '" + mv_par02 +	"' AND "

Do Case
	Case mv_par03 == 2 
		cQuery += "QM3.QM3_TIPPAD = 'O' AND "
	Case mv_par03 == 3 
		cQuery += "QM3.QM3_TIPPAD = 'S' AND "
	Case mv_par03 == 4 
		cQuery += "QM3.QM3_TIPPAD = 'A' AND "
EndCase

cQuery	+= "QM3.D_E_L_E_T_= ' ' "
cQuery += "ORDER BY " + SqlOrder(cChave) 			

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
dbSelectArea( "TRB" )

SetRegua(RecCount())

While ! Eof()

	TRB_FILIAL := TRB->QM3_FILIAL
	TRB_PADRAO := TRB->QM3_PADRAO
	TRB_TIPPAD := TRB->QM3_TIPPAD
	TRB_REVPAD := TRB->QM3_REVPAD
	TRB_DESCRI := TRB->QM3_DESCRI	
	
	IncRegua()
	
	IF lEnd
		@Prow()+1,001 PSAY OemToAnsi(STR0007) // "CANCELADO PELO OPERADOR"
		EXIT
	ENDIF

	If TRB_PADRAO == cStrpad

		dbSelectArea("TRB")   
		dbSkip()
		Loop
	Else
		cStrpad := TRB_PADRAO
	EndIf

	// Encontro padrao para ver em que escala ele esta sendo utilizado
	dbSelectArea("QMC")
	dbSetOrder(2)

	
	aEscDSom := {}

	cChaveQMC := "QMC_FILIAL+QMC_PADRAO"
	cQueryQMC := "SELECT QMC_FILIAL,QMC_PADRAO,QMC_ESCALA,QMK_FILIAL,QMK_TIPO, "
	cQueryQMC += "QMK_ESCALA,QM2_FILIAL,QM2_TIPO,QM2_INSTR,QM2_REVINS,QM2_RESP,QM2_DEPTO,QM2_REVINV "		
	cQueryQMC += "FROM "+RetSqlName("QMC")+"  QMC, "
	cQueryQMC += RetSqlName("QMK")+" QMK, "
	cQueryQMC += RetSqlName("QM2")+" QM2 "
	cQueryQMC += "WHERE "
	cQueryQMC += "QMC.QMC_FILIAL ='"	+ TRB_FILIAL+ "' AND " 
	cQueryQMC += "QMC.QMC_PADRAO ='"	+ TRB_PADRAO+ "' AND " 
	cQueryQMC += "QMK.QMK_FILIAL = QMC.QMC_FILIAL AND "
	cQueryQMC += "QM2.QM2_FILIAL = QMK.QMK_FILIAL AND "
	cQueryQMC += "QM2.QM2_TIPO = QMK.QMK_TIPO AND "
	cQueryQMC += "QMK.QMK_ESCALA = QMC.QMC_ESCALA AND "
	cQueryQMC += "QM2.D_E_L_E_T_= ' ' "+ " AND " +"QMK.D_E_L_E_T_= ' '"+ " AND " +"QMC.D_E_L_E_T_= ' '"
         	cQueryQMC += "ORDER BY " + SqlOrder(cChaveQMC)

	cQueryQMC := ChangeQuery(cQueryQMC)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQueryQMC),"TM2",.T.,.T.)
	dbSelectArea("TM2")
	TM2->(dbGotop())
	
	While ! Eof() 

		lImpr := .T.
			
		TM2_INSTR := TM2->QM2_INSTR
		If TM2_INSTR == cStrAnt
			dbSkip()
			Loop
		Else
			cStrAnt := TM2_INSTR
		Endif

		Aadd(aEscDSom,{TRB->QM3_PADRAO,TRB->QM3_REVPAD,TRB->QM3_DESCRI,;
				TM2->QMK_ESCALA,TM2->QM2_INSTR,	TM2->QM2_REVINS,TM2->QM2_TIPO,;
				TM2->QM2_DEPTO,TM2->QM2_RESP,TRB->QM3_FILIAL})

	    dbSelectArea("TM2")
	dbSkip()
	EndDo

	TM2->(dbCloseArea())

	// Encontro padrao para ver em que escala ele est  sendo usado.
	dbSelectArea("QMA")
	dbSetOrder(2)
	if dbSeek(xFilial("QMA") + TRB_PADRAO)

		cChaveQMC := "QMA_FILIAL+QMA_PADRAO"		
		cQueryQMC := "SELECT QMA_FILIAL,QMA_PADRAO,QMA_ESCALA,QMK_FILIAL,QMK_TIPO, "
		cQueryQMC += "QMK_ESCALA,QM2_FILIAL,QM2_TIPO,QM2_INSTR,QM2_REVINS,QM2_RESP,QM2_DEPTO,QM2_REVINV "		
		cQueryQMC += "FROM "+RetSqlName("QMA")+"  QMA, "
		cQueryQMC += RetSqlName("QMK")+" QMK, "
		cQueryQMC += RetSqlName("QM2")+" QM2 "
		cQueryQMC += "WHERE "
		cQueryQMC += "QMA.QMA_FILIAL ='"	+ TRB_FILIAL+ "' AND " 
		cQueryQMC += "QMA.QMA_PADRAO ='"	+ TRB_PADRAO+ "' AND " 
		cQueryQMC += "QMK.QMK_FILIAL = QMA.QMA_FILIAL AND "
		cQueryQMC += "QMK.QMK_ESCALA = QMA.QMA_ESCALA AND "
		cQueryQMC += "QM2.QM2_FILIAL = QMK.QMK_FILIAL AND "
		cQueryQMC += "QM2.QM2_TIPO = QMK.QMK_TIPO AND "
		cQueryQMC += "QM2.D_E_L_E_T_= ' ' "+ " AND " +"QMK.D_E_L_E_T_= ' '"+ " AND " +"QMA.D_E_L_E_T_= ' ' "
		cQueryQMC += "ORDER BY " + SqlOrder(cChaveQMC)
	
		cQueryQMC := ChangeQuery(cQueryQMC)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQueryQMC),"TM2",.T.,.T.)
		dbSelectArea("TM2")
	
		While ! Eof() 
                    
			lImpr := .T.
				
			If TM2->QMA_PADRAO+TM2->QMA_ESCALA+TM2->QM2_INSTR == cStrAnt
				dbSkip()
				Loop
			Else
				cStrAnt := TM2->QMA_PADRAO+TM2->QMA_ESCALA+TM2->QM2_INSTR
			EndIf

			If TM2->QM2_INSTR  == cStrQM2
				dbSkip()
				Loop
			Else
				cStrQM2 := TM2->QM2_INSTR
			EndIf

			Aadd(aEscDSom,{TRB->QM3_PADRAO,TRB->QM3_REVPAD,TRB->QM3_DESCRI,;
				TM2->QMA_ESCALA,TM2->QM2_INSTR,TM2->QM2_REVINS,TM2->QM2_TIPO,;
				TM2->QM2_DEPTO,TM2->QM2_RESP,TRB->QM3_FILIAL})
 
			dbSelectArea("TM2")
			dbSkip()
		EndDo

  			TM2->(dbCloseArea())
  		eNDIF		
		
	If lImpr
		Tr080ImpLin( Tamanho )	
	Endif	     
			
			lImpr := .F.
	//Soma todos os usuarios e departamentos utilizados
	If Len(aEscDSom) > 0
		For nx := 1 to Len(aEscDSom)
			Aadd(aEscUsr,{aEscDSom[nx][9],aEscDSom[nx][8]})
		Next nx	
	Endif	
	
	dbSelectArea("TRB")   

	dbSkip()
	
EndDo
/*
If Len(aEscDSom) > 0
	For nx := 1 to Len(aEscDSom)
		Aadd(aEscUsr,{aEscDSom[nx][9],aEscDSom[nx][8]})
	Next nx	
Endif	
*/

//Verifica se imprime legendas
If mv_par04 == 1
	cRespQ := ""
	li++
	li++
	@li,00 PSAY __PrtFatLine()
	li++
	@li,(120-Len(STR0009))/2 PSAY STR0009 //"LEGENDA RESPONSAVEL/DEPARTAMENTO"
	li++
	@li,00 PSAY __PrtFatLine()
	li++
	//Imprime nomes de usuarios e departamentos
	aSort(aEscUsr,,,{|x,y| x[1] < y[1]})    
	lFirst := .T.
	For nx := 1 To Len(aEscUsr)
		If cRespQ <> aEscUsr[nx][1]
			If li > 58
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			EndIf
			If lFirst
				@li,00 PSAY __PrtFatLine()
				li++
				//          1         2         3         4         5         6        7
				//0123456789012345678901234567890123456789012345678901234567890123456789
				//Codigo            Nome                                     Apelido
	
				@li,00 PSAY STR0010 //"Codigo            Nome                                     Apelido"
				li++
				@li,00 PSAY __PrtFatLine()
				li++
			Endif	
	
			If li > 58
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			EndIf
	
			lFirst := .F.
			@li,00 PSAY aEscUsr[nx][1]
			dbSelectArea("QAA")
			dbSetOrder(1)
			dbSeek(xFilial()+aEscUsr[nx][1])
			@li,18 PSAY QAA->QAA_NOME
			@li,59 PSAY QAA->QAA_APELID
			li++
		Endif
		cRespQ := aEscUsr[nx][1]
	Next nx
	cRespQ := ""
	lFirst := .t.
	li++
	li++
	aSort(aEscUsr,,,{|x,y| x[2] < y[2]})    
	
	For nx := 1 To Len(aEscUsr)
		If cRespQ <> aEscUsr[nx][2]
			If li > 58
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			EndIf
			If lFirst
				@li,00 PSAY __PrtFatLine()
				li++
				//          1         2         3         4         5         6        7
				//0123456789012345678901234567890123456789012345678901234567890123456789
				//Codigo            Departamento
	
				@li,00 PSAY STR0011 //"Codigo            Departamento"
				li++
				@li,00 PSAY __PrtFatLine()
				li++
			Endif	
			lFirst := .F.
	
			If li > 58
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			EndIf
			
			@li,00 PSAY aEscUsr[nx][2]
			dbSelectArea("QAD")
			dbSetOrder(1)
			dbSeek(xFilial()+aEscUsr[nx][2])
			@li,18 PSAY QAD->QAD_DESC
			li++
		Endif
		cRespQ := aEscUsr[nx][2]
	Next nx
Endif

Roda( cbCont, cbTxt, Tamanho )

Set Device To Screen

If File(cIndex+OrdBagExt())
	Set Filter To
	RetIndex("QM3")
	dbClearInd()
	FErase(cIndex+OrdBagExt())
	dbCloseArea()
Else	
	dbSelectArea("TRB")
	dbCloseArea()
	dbSelectArea("QM3")
	dbSetOrder(1)
EndIf

If aReturn[5] = 1
	Set Printer TO
	dbCommitall()
	ourspool(wnrel)
End

MS_FLUSH()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³Tr080ImpLi³ Autor ³ Alessandro B. Freire  ³ Data ³ 30.08.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ tr080ImpLin( Tamanho )									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ qmtr080  												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function Tr080ImpLin( Tamanho )

Local cAlias  := Alias()
Local nx	  := 1


/*
          1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Padrao             Rev   Descricao                             Instrumento        Rev   Familia            Departamento   Usuario
xxxxxxxxxxxxxxxx   xx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xxxxxxxxxxxxxxxx   xx    xxxxxxxxxxxxxxxx   xxxxxxxxx      xxxxxxxx

000-017-021-052-069-086-090-107-122
*/

For nx := 1 to Len(aEscDSom)
	If li > 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
	EndIf
	DbSelectArea("QM3")
	DbSetOrder(1)
	If QMA070UltR(aEscDSom[nx][1])<> aEscDSom[nX][2]
		loop
	Endif
	If aEscDSom[nx][1] <> cPadra
		@li,00 PSAY aEscDSom[nx][1]
		@li,17 PSAY aEscDSom[nx][2]
		@li,21 PSAY Left(aEscDSom[nx][3],30)
		cPadra := aEscDSom[nx][1]
	Else	
		cPadra := aEscDSom[nx][1]	
	Endif	

	@li,52  PSAY aEscDSom[nx][4]
	@li,69  PSAY aEscDSom[nx][5]
	@li,86  PSAY aEscDSom[nx][6]
	@li,90  PSAY aEscDSom[nx][7]
	@li,107 PSAY aEscDSom[nx][8]
	@li,122 PSAY aEscDSom[nx][9]
	li++
Next nx
Return NIL
