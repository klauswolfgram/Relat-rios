/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QMTR050.Ch"
#INCLUDE  "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ QMTR050  ³ Autor ³ Cicero Cruz           ³ Data ³ 08/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Plano de Repe/Repro                                        |±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAQMT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QMTR050()

Local oReport

If TRepInUse()
	// Interface de impressao
	oReport := ReportDef()
 	oReport:PrintDialog()
Else
	U_QMTR050R3()
EndIf

Return
                                                              
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Cicero Cruz           ³ Data ³ 06/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ QMTR050                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport 
Local oSection1
Local aOrdem    := {}

Private cPerg		:="QMR050"

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
oReport:= TReport():New("QMTR050",STR0005,cPerg, {|oReport| ReportPrint(oReport)},STR0001) // "Plano de Repe/Repro" ### "Este programa ira emitir o Plano de Repe/Repro dos Instrumentos"
oReport:SetLandscape(.T.)

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
aOrdem := {	OemToAnsi(STR0006),; 	// "Familia+Instr.+Depto."
			OemToAnsi(STR0007),; 	// "Familia+Depto.+Instr."
			OemToAnsi(STR0008)} 	// "Depto.+Instr.+Familia" 

oSection1 := TRSection():New(oReport,STR0016,{"QM2"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/) // "Documento"
TRCell():New(oSection1,"QM2_TIPO"  ,"QM2",,,16,,)
TRCell():New(oSection1,"QM2_INSTR" ,"QM2",,,15,,)
TRCell():New(oSection1,"QM2_REVINS","QM2",STR0025,,3,,)//"Rev."
TRCell():New(oSection1,"QM2_DEPTO" ,"QM2",STR0026,,10,,)//"Depart."
TRCell():New(oSection1,"QM2_RESP"  ,"QM2",,,7,,)
TRCell():New(oSection1,"QM2_FREQAF","QM2",STR0027+CRLF+STR0028,,3,.T.,)//"Freq."##"Dias"
TRCell():New(oSection1,"QM2_FABR"  ,"QM2",,,3,,)
TRCell():New(oSection1,"QM2_DEPTO" ,"QM2",STR0029,,16,,)//"Orgao Calibrador"
TRCell():New(oSection1,"QM2_SGUARD","QM2",STR0024,,2,,)//"SG"
TRCell():New(oSection1,"JAN"      ,"    ",STR0011+"/",,8,,)
TRCell():New(oSection1,"FEV"      ,"    ",STR0012+"/",,8,,)
TRCell():New(oSection1,"MAR"      ,"    ",STR0013+"/",,8,,)
TRCell():New(oSection1,"ABR"      ,"    ",STR0014+"/",,8,,)
TRCell():New(oSection1,"MAI"      ,"    ",STR0015+"/",,8,,)
TRCell():New(oSection1,"JUN"      ,"    ",STR0016+"/",,8,,)
TRCell():New(oSection1,"JUL"      ,"    ",STR0017+"/",,8,,)
TRCell():New(oSection1,"AGO"      ,"    ",STR0018+"/",,8,,)
TRCell():New(oSection1,"SET"      ,"    ",STR0019+"/",,8,,)
TRCell():New(oSection1,"OUT"      ,"    ",STR0020+"/",,8,,)
TRCell():New(oSection1,"NOV"      ,"    ",STR0021+"/",,8,,)
TRCell():New(oSection1,"DEZ"      ,"    ",STR0022+"/",,8,,)

Return oReport


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Cicero Cruz            ³ Data ³ 06/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint  deve ser criada para todos os³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1: Objeto Report do Relatório                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ QMTR050                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local cPerg		:="QMR050"          
Local nJ        := 0
Local nX		:= 0        
Local lHaRegistros := .T.
Local cVar      := ""             
Local cOrdem    := ""
Local cChave    := ""
Local cAliasQM2 := "QM2"
lTop := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01:  Instrumento Inicial									³
//³ mv_par02:  Instrumento Final									³
//³ mv_par03:  Periodo Inicial										³
//³ mv_par04:  Departamento Inicial									³
//³ mv_par05:  Departamento Final									³
//³ mv_par06:  Orgao Calibrador Todos/Interno/Externo				³
//³ mv_par07:  Org.Calib.Int. Inicial								³
//³ mv_par08:  Org.Calib.Int. Final									³
//³ mv_par09:  Org.Calib.Ext. Inicial								³ 
//³ mv_par10:  Org.Calib.Ext. Final									³
//³ mv_par11:  Fam¡lia Inicial										³
//³ mv_par12:  Fam¡lia Final										³
//³ mv_par13:  Fabricante Inicial									³
//³ mv_par14:  Fabricante Final										³
//³ mv_par15:  Usu rio Inicial										³
//³ mv_par16:  Usu rio Final										³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)           

Private dDataLim := AddMes( mv_par03, 11 )  // Mes atual + 11 = 12 meses

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam) 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:BeginQuery()	
cAliasQM2 := GetNextAlias()
Do Case
	Case oSection1:GetOrder() == 1
		cChave := "%QM2_FILIAL, QM2_TIPO, QM2_INSTR, QM2_REVINV, QM2_DEPTO%"
	Case oSection1:GetOrder() == 2
		cChave := "%QM2_FILIAL, QM2_TIPO, QM2_DEPTO, QM2_INSTR,  QM2_REVINV%"
	Case oSection1:GetOrder() == 3
		cChave := "%QM2_FILIAL, QM2_DEPTO, QM2_INSTR, QM2_REVINV, QM2_TIPO%"
EndCase


BeginSql Alias cAliasQM2

SELECT QM2.QM2_FILIAL, QM2.QM2_INSTR,  QM2.QM2_REVINV, QM2.QM2_REVINS, QM2.QM2_TIPO,   QM2.QM2_DEPTO,
	   QM2.QM2_FREREP, QM2.QM2_VALREP, QM2.QM2_FABR,   QM2.QM2_RESP,   QM2.QM2_STATUS, QM2.QM2_SGUARD, 
	   QM2.QM2_VALDAF, QM2.QM2_FLAG
 	FROM %table:QM2% QM2 	
	WHERE QM2.QM2_FILIAL = %xFilial:QM2% AND 
		  QM2.QM2_INSTR BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
	      QM2.QM2_DEPTO BETWEEN %Exp:mv_par04% AND %Exp:mv_par05% AND         
	      QM2.QM2_TIPO  BETWEEN %Exp:mv_par11% AND %Exp:mv_par12% AND
	      QM2.QM2_FABR  BETWEEN %Exp:mv_par13% AND %Exp:mv_par14% AND
	      QM2.QM2_RESP  BETWEEN %Exp:mv_par15% AND %Exp:mv_par16% AND
	      QM2.QM2_FLAG  = '1' AND
	      QM2.%notDel%  		                
	ORDER BY %Exp:cChave%  
 			
EndSql   
oSection1:EndQuery()

While !&(cAliasQM2)->(Eof()) .and. lHaRegistros
	IF Empty(&(cAliasQM2+"->QM2_FREREP")) .or. Empty(&(cAliasQM2+"->QM2_VALREP"))
		&(cAliasQM2)->(dbSkip())
		Loop
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno e externo                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par06 == 1
		If ! Calibrador(0,mv_par07,mv_par08,mv_par09,mv_par10,&(cAliasQM2+"->QM2_INSTR"),&(cAliasQM2+"->QM2_REVINS"))
			&(cAliasQM2)->(dbSkip())
			Loop
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par06 == 2
		If ! Calibrador(1,mv_par07,mv_par08,,,&(cAliasQM2+"->QM2_INSTR"),&(cAliasQM2+"->QM2_REVINS"))
			&(cAliasQM2)->(dbSkip())
			Loop
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. externo                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par06 == 3
		If ! Calibrador(2,,,mv_par09,mv_par10,&(cAliasQM2+"->QM2_INSTR"),&(cAliasQM2+"->QM2_REVINS"))
			&(cAliasQM2)->(dbSkip())
			Loop
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se status do instrumento esta com atualiza ativo       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !QMTXSTAT(&(cAliasQM2+"->QM2_STATUS"))
		&(cAliasQM2)->(dbskip())
		loop
	EndIf

	lOk		:= .F.
	aPrevRea := Tr050Prev(@lOk, &(cAliasQM2+"->QM2_FILIAL"), &(cAliasQM2+"->QM2_INSTR"), &(cAliasQM2+"->QM2_REVINS"), &(cAliasQM2+"->QM2_VALDAF"), &(cAliasQM2+"->QM2_FREREP"), "R4")  
	
  	For nX:=1 to 30
		oSection1:Init()
		oSection1:Cell("QM2_FREQAF"):SetValue(&(cAliasQM2+"->QM2_FREREP"))
		lImprime := .F.
		
		For nJ := 1 to 12
			If ! Empty(aPrevRea[nX][nJ,1])
				lImprime := .T.
				Exit
			EndIf
		Next nJ
		
		If ! lImprime
			Loop
		EndIf

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][1,1]),1,2)
		If ! Empty(aPrevRea[nX][1,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][1,2]),1,5)
		EndIf
		oSection1:Cell("JAN"):cTitle += SubStr(DTOC(MV_PAR03),9,2) + CRLF + STR0023
		oSection1:Cell("JAN"):SetValue((cVar))

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][2,1]),1,2)
		If ! Empty(aPrevRea[nX][2,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][2,2]),1,5)
		EndIf
		oSection1:Cell("FEV"):cTitle += SubStr(DTOC(MV_PAR03),9,2) + CRLF + STR0023
		oSection1:Cell("FEV"):SetValue((cVar))

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][3,1]),1,2)
		If ! Empty(aPrevRea[nX][3,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][3,2]),1,5)
		EndIf
		oSection1:Cell("MAR"):cTitle += SubStr(DTOC(MV_PAR03),9,2) + CRLF + STR0023
		oSection1:Cell("MAR"):SetValue((cVar))  
		
		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][4,1]),1,2)
		If ! Empty(aPrevRea[nX][4,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][4,2]),1,5)
		EndIf   
		oSection1:Cell("ABR"):cTitle += SubStr(DTOC(MV_PAR03),9,2) + CRLF + STR0023
		oSection1:Cell("ABR"):SetValue(cVar)
		

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][5,1]),1,2)
		If ! Empty(aPrevRea[nX][5,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][5,2]),1,5)
		EndIf
		oSection1:Cell("MAI"):cTitle += SubStr(DTOC(MV_PAR03),9,2) + CRLF + STR0023
		oSection1:Cell("MAI"):SetValue(cVar)
		
		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][6,1]),1,2)
		If ! Empty(aPrevRea[nX][6,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][6,2]),1,5)
		EndIf
		oSection1:Cell("JUN"):cTitle += SubStr(DTOC(MV_PAR03),9,2) + CRLF + STR0023
		oSection1:Cell("JUN"):SetValue(cVar)

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][7,1]),1,2)
		If ! Empty(aPrevRea[nX][7,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][7,2]),1,5)
		EndIf
		oSection1:Cell("JUL"):cTitle += SubStr(DTOC(MV_PAR03),9,2) + CRLF + STR0023
		oSection1:Cell("JUL"):SetValue(cVar)

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][8,1]),1,2)
		If ! Empty(aPrevRea[nX][8,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][8,2]),1,5)
		EndIf
		oSection1:Cell("AGO"):cTitle += SubStr(DTOC(MV_PAR03),9,2) + CRLF + STR0023
		oSection1:Cell("AGO"):SetValue(cVar)
		
		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][9,1]),1,2)
		If ! Empty(aPrevRea[nX][9,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][9,2]),1,5)
		EndIf
		oSection1:Cell("SET"):cTitle += SubStr(DTOC(MV_PAR03),9,2) + CRLF + STR0023
		oSection1:Cell("SET"):SetValue(cVar)
		
		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][10,1]),1,2)
		If ! Empty(aPrevRea[nX][10,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][10,2]),1,5)
		EndIf
		oSection1:Cell("OUT"):cTitle += SubStr(DTOC(MV_PAR03),9,2) + CRLF + STR0023
		oSection1:Cell("OUT"):SetValue(cVar)
		
		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][11,1]),1,2)
		If ! Empty(aPrevRea[nX][11,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][11,2]),1,5)
		EndIf
		oSection1:Cell("NOV"):cTitle += SubStr(DTOC(MV_PAR03),9,2) + CRLF + STR0023
		oSection1:Cell("NOV"):SetValue(cVar)

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][12,1]),1,2)
		If ! Empty(aPrevRea[nX][12,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][12,2]),1,5)
		EndIf
		oSection1:Cell("DEZ"):cTitle += SubStr(DTOC(MV_PAR03),9,2) + CRLF + STR0023
		oSection1:Cell("DEZ"):SetValue(cVar)
		If nX > 1
			oSection1:Cell("QM2_TIPO"):Hide()
			oSection1:Cell("QM2_INSTR"):Hide()
			oSection1:Cell("QM2_REVINS"):Hide()
			oSection1:Cell("QM2_DEPTO"):Hide()
			oSection1:Cell("QM2_RESP"):Hide()
			oSection1:Cell("QM2_FREQAF"):Hide()
			oSection1:Cell("QM2_DEPTO"):Hide()
			oSection1:Cell("QM2_FABR"):Hide()
			oSection1:Cell("QM2_SGUARD"):Hide()
			oSection1:SetHeaderSection(.F.)
		EndIf
		oSection1:PrintLine()
		oSection1:Cell("QM2_TIPO"):Show()
		oSection1:Cell("QM2_INSTR"):Show()
		oSection1:Cell("QM2_REVINS"):Show()
		oSection1:Cell("QM2_DEPTO"):Show()
		oSection1:Cell("QM2_RESP"):Show()
		oSection1:Cell("QM2_FREQAF"):Show()
		oSection1:Cell("QM2_FABR"):Show()
		oSection1:Cell("QM2_DEPTO"):Show()
		oSection1:Cell("QM2_SGUARD"):Show()
		oSection1:SetHeaderSection(.T.)
	Next
	&(cAliasQM2)->(DBSkip())
EndDo
    
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Qmtr050	³ Autor ³ Alessandro B. Freire  ³ Data ³ 23.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Plano de Repe/Repro			                 			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_Qmtr050(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Denis     ³Melhor³ Melhora de Performance - Utilizacao de Query's am-  ³±± 
±±³          ³      ³ biente Top e Arquivo Temporario para ambiente Code  ³±±
±±³          ³      ³ Base.												  ³±±
±±³Denis     ³F.744 ³ Acerto no layout do relatorio.                      ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMTR050R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis 										     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1		:= OemToAnsi(STR0001) // "Este programa ira emitir o Plano de Repe/Repro dos Instrumentos"
Local cDesc2		:= ""
Local cDesc3		:= ""
Local cString		:="QM2"
Local aOrdem		:= {}
Local wnrel   

Private titulo    := OemToAnsi(STR0005) // "Plano de Repe/Repro"
Private cabec1 	:= OemToAnsi(STR0010) // "                                                                     Freq.                                     |"
Private cabec2 	:= OemToAnsi(STR0002) // "Familia          Instrumento      Rev. Depart.  Responsavel          Dias  Fabricante       Orgao Calibrador SG |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R."
Private aReturn	:= {OemToAnsi(STR0003),1,OemToAnsi(STR0004),1,2,1,"",1} // "Zebrado"###"Administra‡„o" 
Private nomeprog	:="QMTR050"
Private nLastKey	:= 0
Private cPerg		:="QMR050"
Private cTamanho	:= "G"

/*
			 1 		  2			3			 4 		  5			6			 7 		  8			9			 0 		  1			2			 3 		  4			5			 6 		  7			8			 9 		  0			1
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
                                                       Freq.                                      |Jan/98   |Fev/98   |Mar/98   |Abr/98   |Mai/98   |Jun/98   |Jul/98   |Ago/98   |Set/98   |Out/98   |Nov/98   |Dez/98
Familia          Instrumento      Rev. Responsavel     Dias  Fabricante       Orgao Calibrador SG |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.
xxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxx  xx	xxxxxxxxxxxxxxx xxx	 xxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxx xxx|xx  xx/xx|xx  xx/xx|xx	xx/xx|xx  xx/xx|xx  xx/xx|xx	xx/xx|xx  xx/xx|xx  xx/xx|xx	xx/xx|xx  xx/xx|xx  xx/xx|xx	xx/xx
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas 							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("QMR050",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01:  Instrumento Inicial									³
//³ mv_par02:  Instrumento Final									³
//³ mv_par03:  Periodo Inicial										³
//³ mv_par04:  Departamento Inicial									³
//³ mv_par05:  Departamento Final									³
//³ mv_par06:  Orgao Calibrador Todos/Interno/Externo				³
//³ mv_par07:  Org.Calib.Int. Inicial								³
//³ mv_par08:  Org.Calib.Int. Final									³
//³ mv_par09:  Org.Calib.Ext. Inicial								³ 
//³ mv_par10:  Org.Calib.Ext. Final									³
//³ mv_par11:  Fam¡lia Inicial										³
//³ mv_par12:  Fam¡lia Final										³
//³ mv_par13:  Fabricante Inicial									³
//³ mv_par14:  Fabricante Final										³
//³ mv_par15:  Usu rio Inicial										³
//³ mv_par16:  Usu rio Final										³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordenacao dos registros										 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aOrdem := { OemToAnsi(STR0006),; // "Familia+Instr.+Depto."
				OemToAnsi(STR0007),; // "Familia+Depto.+Instr."
				OemToAnsi(STR0008) } // "Depto.+Instr.+Familia" 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT 						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="QMTR050"
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrdem,.F.,cTamanho)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif


RptStatus({|lEnd| MTr050Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ MTr050IMP³ Autor ³ Alessandro B.Freire   ³ Data ³ 23.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o plano de calibracao 							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ MTr050IMP(lEnd,wnRel,cString) 							  ³±±
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
Static Function MTr050Imp(lEnd,wnRel,cString)

Local CbCont
Local CbTxt
Local lHaRegistros:= .T.
Local tamanho		:= "G"
Local nOrder		:= IndexOrd()
Local nIndice		:= 0
Local cChave		:= ""
Local nrecno		:= Recno()
Local aPrevRea		:= {}
Local lImprime		:= .F.
Local nJ 	  
Local nI
Local cQuery
Private dDataLim := AddMes( mv_par03, 11 )  // Mes atual + 11 = 12 meses

Private cIndice		:= ""
Private	TRB_FILIAL	
Private	TRB_INSTR	
Private	TRB_REVINS	
Private	TRB_REVINV	
Private	TRB_DEPTO	
Private	TRB_TIPO	
Private	TRB_FABR	
Private	TRB_RESP	
Private	TRB_VALREP	
Private	TRB_FREREP	
Private	TRB_STATUS	
Private	TRB_SGUARD	
Private	TRB_VALDAF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cabec1   += U_Qmt050Mont( mv_par03 )
cbtxt 	:= SPACE(10)
cbcont	:= 0
li 		:= 80
m_pag 	:= 1

cQuery:= "SELECT QM2_FILIAL,QM2_INSTR,QM2_REVINV,QM2_REVINS,QM2_TIPO,QM2_DEPTO,"
cQuery+= "QM2_FREREP,QM2_VALREP,QM2_FABR,QM2_RESP,QM2_STATUS,QM2_SGUARD,QM2_VALDAF,QM2_FLAG "
cQuery+= "FROM "+RetSqlName("QM2")+" QM2, "
cQuery+= "WHERE "
cQuery+= "QM2.QM2_FILIAL = '"	+xFilial("QM2")+	"' AND "
cQuery+= "QM2.QM2_INSTR	>= '"	+ mv_par01 +	"' AND " 
cQuery+= "QM2.QM2_INSTR	<= '"	+ mv_par02 +	"' AND " 
cQuery+= "QM2.QM2_DEPTO	>= '"	+ mv_par04 +	"' AND " 
cQuery+= "QM2.QM2_DEPTO	<= '"	+ mv_par05 +	"' AND " 
cQuery+= "QM2.QM2_TIPO	>= '"	+ mv_par11 +	"' AND " 
cQuery+= "QM2.QM2_TIPO	<= '"	+ mv_par12 +	"' AND " 
cQuery+= "QM2.QM2_FABR	>= '"	+ mv_par13 +	"' AND " 
cQuery+= "QM2.QM2_FABR	<= '"	+ mv_par14 +	"' AND " 
cQuery+= "QM2.QM2_RESP	>= '"	+ mv_par15 +	"' AND " 
cQuery+= "QM2.QM2_RESP	<= '"	+ mv_par16 +	"' AND " 
cQuery+= "QM2.QM2_FLAG  = '1' AND " 
cQuery+= "QM2.D_E_L_E_T_= ' ' "
Do Case
	Case aReturn[8] == 1
		cChave := "QM2_FILIAL+QM2_TIPO+QM2_INSTR+QM2_REVINV+QM2_DEPTO"
	Case aReturn[8] == 2
		cChave := "QM2_FILIAL+QM2_TIPO+QM2_DEPTO+QM2_INSTR+QM2_REVINV"
	Case aReturn[8] == 3
		cChave := "QM2_FILIAL+QM2_DEPTO+QM2_INSTR+QM2_REVINV+QM2_TIPO"
EndCase
    	cQuery += "ORDER BY " + SqlOrder(cChave)

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
TcSetField("TRB","QM2_VALDAF","D",8,0)
TcSetField("TRB","QM2_VALREP","D",8,0)		
dbSelectArea( "TRB" )

If BOF() .and. EOF()
	lHaRegistros := .F.
End

SetRegua(RecCount())

While ! Eof() .and. lHaRegistros

	TRB_FILIAL	:= TRB->QM2_FILIAL
	TRB_INSTR	:= TRB->QM2_INSTR 
	TRB_REVINS	:= TRB->QM2_REVINS				
	TRB_REVINV	:= TRB->QM2_FILIAL
	TRB_DEPTO	:= TRB->QM2_DEPTO
	TRB_TIPO	:= TRB->QM2_TIPO
	TRB_FABR	:= TRB->QM2_FABR
	TRB_RESP	:= TRB->QM2_RESP
	TRB_VALREP	:= TRB->QM2_VALREP
	TRB_FREREP	:= TRB->QM2_FREREP
	TRB_STATUS	:= TRB->QM2_STATUS
	TRB_SGUARD	:= TRB->QM2_SGUARD
	TRB_VALDAF	:= TRB->QM2_VALDAF

	IncRegua()

	 If lEnd
		@Prow()+1,001 PSAY OemToAnsi(STR0009)	//"CANCELADO PELO OPERADOR"
		EXIT
	Endif

	IF Empty(TRB_FREREP) .or. Empty(TRB_VALREP)
		dbSkip()
		Loop
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno e externo                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par06 == 1
		If ! Calibrador(0,mv_par07,mv_par08,mv_par09,mv_par10,TRB_INSTR,TRB_REVINS)
			dbSkip()
			Loop			
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par06 == 2
		If ! Calibrador(1,mv_par07,mv_par08,,,TRB_INSTR,TRB_REVINS)
			dbSkip()
			Loop
		EndIf
	EndIf
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. externo                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par06 == 3
		If ! Calibrador(2,,,mv_par09,mv_par10,TRB_INSTR,TRB_REVINS)
			dbSkip()
			Loop
		EndIf
	EndIf
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica se status do instrumento esta com atualiza ativo       ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If !QMTXSTAT(TRB_STATUS)       
      dbskip()
      loop
   EndIf
	
	lOk		:= .F.
	aPrevRea := Tr050Prev(@lOk)
	
	If ! lOk
		dbSelectArea("TRB")
		dbSkip()
		Loop
	EndIf   
	
	IF li > 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
	End

/*
			 1 		  2			3			 4 		  5			6			 7 		  8			9			 0 		  1			2			 3 		  4			5			 6 		  7			8			 9 		  0			1
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
                                                                     Freq.                                      |Jan/98  |Fev/98  |Mar/98  |Abr/98  |Mai/98  |Jun/98  |Jul/98  |Ago/98  |Set/98  |Out/98  |Nov/98  |Dez/98
Familia          Instrumento      Rev Depto.    Responsavel          Dias  Fabricante       Orgao Calibrador SG |P. R.   |P. R.   |P. R.   |P. R.   |P. R.   |P. R.   |P. R.   |P. R.   |P. R.   |P.  R.  |P.  R.  |P. R.
xxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxx xx  xxxxxxxxx xxxxxxxxxxxxxxxxxxxx xxxx  xxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxx xxx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx
*/	
	@li,00  PSAY TRB_TIPO
	@li,17  PSAY TRB_INSTR
	@li,34  PSAY Substr(TRB_REVINS,1,3)
	@li,38  PSAY Substr(TRB_DEPTO,1,10)
	@li,52  PSAY SubStr(TRB_RESP,1,20)
	@li,69  PSAY StrZero(TRB_FREREP,4)
	@li,75  PSAY Substr(TRB_FABR,1,16)
	@li,92  PSAY Substr(TRB_DEPTO,1,16)
	@li,109 PSAY Substr(TRB_SGUARD,1,3)
	For nI := 1 to 30
	
		lImprime := .F.
		
		For nJ := 1 to 12
			If ! Empty(aPrevRea[nI][nJ,1])
				lImprime := .T.
				Exit
			EndIf
		Next nJ
		
		If ! lImprime
			Loop
		EndIf
		
		@li,112 PSAY "|" + (SubStr(DtoC(aPrevRea[nI][1,1]),1,2)) 
		If ! Empty(aPrevRea[nI][1,2])
			@li,116 PSAY (SubStr(DtoC(aPrevRea[nI][1,2]),1,5)) + "|"
		Else
			@li,116 PSAY "     |"			
		EndIf
					
		@li,122 PSAY (SubStr(DtoC(aPrevRea[nI][2,1]),1,2))
		If ! Empty(aPrevRea[nI][2,2])
			@li,125 PSAY (SubStr(DtoC(aPrevRea[nI][2,2]),1,5)) + "|"
		Else
			@li,125 PSAY "     |"			
		EndIf			
		
		@li,131 PSAY (SubStr(DtoC(aPrevRea[nI][3,1]),1,2))
		If ! Empty(aPrevRea[nI][3,2])
			@li,134 PSAY (SubStr(DtoC(aPrevRea[nI][3,2]),1,5)) + "|"
		Else
			@li,134 PSAY "     |"			
		EndIf			
		
		@li,140 PSAY (SubStr(DtoC(aPrevRea[nI][4,1]),1,2))
		If ! Empty(aPrevRea[nI][4,2])
			@li,143 PSAY (SubStr(DtoC(aPrevRea[nI][4,2]),1,5)) + "|"
		Else
			@li,143 PSAY "     |"			
		EndIf			
		
		@li,149 PSAY (SubStr(DtoC(aPrevRea[nI][5,1]),1,2))
		If ! Empty(aPrevRea[nI][5,2])
			@li,152 PSAY (SubStr(DtoC(aPrevRea[nI][5,2]),1,5)) + "|"
		Else
			@li,152 PSAY "     |"			
		Endif			
		
		@li,158 PSAY (SubStr(DtoC(aPrevRea[nI][6,1]),1,2))
		If ! Empty(aPrevRea[nI][6,2])
			@li,161 PSAY (SubStr(DtoC(aPrevRea[nI][6,2]),1,5)) + "|"
		Else
			@li,161 PSAY "     |"			
		EndIf			
		
		@li,167 PSAY (SubStr(DtoC(aPrevRea[nI][7,1]),1,2))
		If ! Empty(aPrevRea[nI][7,2])
			@li,170 PSAY (SubStr(DtoC(aPrevRea[nI][7,2]),1,5)) + "|"
		Else
			@li,170 PSAY "     |"			
		EndIf			
		
		@li,176 PSAY (SubStr(DtoC(aPrevRea[nI][8,1]),1,2))
		If ! Empty(aPrevRea[nI][8,2])
			@li,179 PSAY (SubStr(DtoC(aPrevRea[nI][8,2]),1,5)) + "|"
		Else
			@li,179 PSAY "     |"			
		EndIf			
		
		@li,185 PSAY (SubStr(DtoC(aPrevRea[nI][9,1]),1,2))
		If ! Empty(aPrevRea[nI][9,2])
			@li,188 PSAY (SubStr(DtoC(aPrevRea[nI][9,2]),1,5)) + "|"
		Else
			@li,188 PSAY "     |"			
		EndIf			
		
		@li,194 PSAY (SubStr(DtoC(aPrevRea[nI][10,1]),1,2))
		If ! Empty(aPrevRea[nI][10,2])
			@li,197 PSAY (SubStr(DtoC(aPrevRea[nI][10,2]),1,5)) + "|"
		Else
			@li,197 PSAY "     |"			
		EndIf			
		
		@li,203 PSAY (SubStr(DtoC(aPrevRea[nI][11,1]),1,2))
		If ! Empty(aPrevRea[nI][11,2])
			@li,206 PSAY (SubStr(DtoC(aPrevRea[nI][11,2]),1,5)) + "|"
		Else
			@li,206 PSAY "     |"			
		EndIf			
		
		@li,212 PSAY (SubStr(DtoC(aPrevRea[nI][12,1]),1,2))
		If ! Empty(aPrevRea[nI][12,2])
			@li,215 PSAY (SubStr(DtoC(aPrevRea[nI][12,2]),1,5)) + "|"
		Else
			@li,215 PSAY "     |"			
		EndIf			
		li++
	Next nI
	
	@li,00 PSAY Repl("-",220)			 
	li++
	
	dbSelectArea("TRB")
	dbSkip()
End

If lHaRegistros
	Roda( cbCont, cbTxt, Tamanho )
	Set Device To Screen
Endif	

If File(cIndice+OrdBagExt())
	Set Filter To
	RetIndex("QM2")
	dbSetOrder(nOrder)
	dbGoto(nRecno)
	FErase(cIndice+OrdBagExt())
Else	
	dbSelectArea("TRB")
	dbCloseArea()
	dbSelectArea("QM2")
	dbSetOrder(1)
EndIf

If aReturn[5] = 1
	Set Printer TO
	dbCommitall()
	ourspool(wnrel)
End

MS_FLUSH()
                                                                       
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ TR050Prev³ Autor ³ Alessandro B.Freire   ³ Data ³ 22.08.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna as datas previstas para calibracao				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ Tr050Prev() 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR050													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function TR050Prev( lret, cFilIns, cInst, cRev, cValDaf, cFreRep, cVers )

Local nOldOrd	 := IndexOrd()
Local aRetorno   := {}
Local nCol
Local dData
Local nI

Default cFilIns := TRB_FILIAL
Default cInst   := TRB_INSTR
Default cRev    := TRB_REVINS
Default cFreRep := TRB_FREREP
Default cValDaf := TRB_VALDAF
Default cVers    := "R3"           

For nI := 1 to 30
	AAdd( aRetorno,{;
	{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")},;
	{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")},;
	{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")},;
	{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")},;
	{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")},;
	{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")},;
	{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")},;
	{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")},;
	{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")},;
	{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")},;
	{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")},;
	{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")} } )
Next nI

dbSelectArea("QM6")
dbSetOrder(1)
dbSeek( cFilial+cInst+cRev+DTOS(mv_par03), .T. )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Medicoes efetuadas.											 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While ! Eof() .And.	QM6->QM6_FILIAL+QM6->QM6_INSTR+QM6->QM6_REVINS == 	cFilIns+cInst+cRev
	
	If ( dDataLim < QM6->QM6_DTPREV ) .And. ;
		(Month(QM6->QM6_DTPREV)+Year(QM6->QM6_DTPREV) != ;
		Month(dDataLim)+Year(dDataLim) )
		dbSkip()
		Loop
	EndIf
	
	If QM6->QM6_DTPREV >= mv_par03 .or. ;
		(Month(QM6->QM6_DTPREV) == Month(mv_par03) .and.;
		Year(QM6->QM6_DTPREV) == Year(mv_par03) )
		
		If Year(QM6->QM6_DTPREV) == Year(mv_par03)
			nCol := Month(QM6->QM6_DTPREV)-Month(mv_par03) + 1
		Else
			nCol := 12 - Month(dDataLim) + Month(QM6->QM6_DTPREV)
		EndIf
		
		For nI := 1 to Len( aRetorno )
			If Empty(aRetorno[nI][nCol][1])
				aRetorno[nI][nCol] := { QM6->QM6_DTPREV, QM6->QM6_DATA }
				Exit
			EndIf
		Next nI
	EndIf
	
	lret := .T.
	dbSkip()
	
EndDo

If cVers  == "R3"
	dbSelectArea("QM2")
	dbSetOrder(nOldOrd)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Previsoes das proximas medicoes.									  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dData := TRB_VALDAF
Else
	dData := cValDaf
EndIf

While (dData <= dDataLim) .or. ;
	( Month(dData) == Month(dDataLim) .and. Year(dData) == Year(dDataLim) )
	
	If dData >= mv_par03 .or. ;
		( Month(dData) == Month(mv_par03) .and. Year(dData) == Year(mv_par03) )
		
		If Year(dData) == Year(mv_par03)
			nCol := Month(dData)-Month(mv_par03) + 1
		Else
			nCol := 12 - Month(dDataLim) + Month(dData)
		EndIf
		
		For nI := 1 to Len( aRetorno )
			If Empty(aRetorno[nI][nCol][1])
				aRetorno[nI][nCol] := { dData, CtoD("  /  /  ","DDMMYY") }
				Exit
			EndIf
		Next nI
	EndIf
	
	If cVer == "R3"
		dData += TRB_FREREP
	Else
		dData += cFreRep
	EndIf
	
	lret := .T.
	
	If cFreRep == 0
	   Exit            
	EndIf
EndDo

Return(aRetorno)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ AddMes	³ Autor ³ Alessandro B.Freire   ³ Data ³ 22.08.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Adiciona <n> meses a data passada como parametro			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ AddMes( dData, nMeses ) 									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ dData 	 -> Data inicial								  ³±±
±±³			 ³ nMeses	 -> No. de Meses a se adicionar a data inicial	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR050													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function AddMes( dData, nMeses )
Local IsBissexto := (Int(Year(dData)/4) == (Year(dData)/4))

dDataRet := StrZero(Day(dData),2) + "/"

If Month(dData) + nMeses == 2
	If IsBissexto .And. Day(dData) > 29
		dDataRet := "29/"
	EndIf
	If ! IsBissexto .And. Day(dData) > 28
		dDataRet := "28/"
	EndIf
EndIf

nMes := Month(dData)+nMeses

If nMes > 12
	nAno := StrZero(Year(dData)+Int(nMes/12),4)
	nMes := nMes - 12
Else
	nAno := StrZero(Year(dData),4)
EndIf

If SubStr(Str(nMes),14,18) $ " 1| 3| 5| 7| 8| 10| 12"
	dDataRet := "31/"
ElseIf SubStr(Str(nMes),14,18) $ " 4| 6| 9| 11"
	dDataRet :=	"30/"
Endif
dDataRet += StrZero(nMes,2) + "/"+nAno

Return(CtoD(dDataRet,"DDMMYY"))

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ TR050Fil ³ Autor ³ Alessandro B.Freire   ³ Data ³ 20.08.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Filtro do plano de calibracao 							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ Tr050Fil 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR050													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Tr050Fil()

Local cExpr := ""
cExpr := 'QM2_FILIAL == "'+ xFilial("QM2") + '" .And. '
cExpr += 'QM2_INSTR >= "' + mv_par01       + '" .And. '
cExpr += 'QM2_INSTR <= "' + mv_par02       + '" .And. ' 
cExpr += 'QM2_DEPTO >= "' + mv_par04       + '" .And. '
cExpr += 'QM2_DEPTO <= "' + mv_par05       + '" .And. '
cExpr += 'QM2_TIPO  >= "' + mv_par11       + '" .And. '
cExpr += 'QM2_TIPO  <= "' + mv_par12       + '" .And. '
cExpr += 'QM2_FABR  >= "' + mv_par13       + '" .And. '
cExpr += 'QM2_FABR  <= "' + mv_par14       + '" .And. '
cExpr += 'QM2_RESP  >= "' + mv_par15       + '" .And. '
cExpr += 'QM2_RESP  <= "' + mv_par16       + '" .And. '
cExpr += 'QM2_FLAG  == "1"' //'" '

Return( cExpr )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³Qmt050Mont³ Autor ³ Alessandro B. Freire  ³ Data ³ 25.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta a primeira linha do cabecalho                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_Qmt050Mont( dData )										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR050													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Qmt050Mont()

Local aMeses	:= {STR0011,STR0012,STR0013,STR0014,STR0015,STR0016,; // "Jan"###"Fev"###"Mar"###"Abr"###"Mai"###"Jun"
                   STR0017,STR0018,STR0019,STR0020,STR0021,STR0022 } // "Jul"###"Ago"###"Set"###"Out"###"Nov"###"Dez"

Local dData    := mv_par03
Local cCab1    := ""
Local nI
For nI := 1 to 12
	cCab1 += aMeses[Month(dData)] + "/" + SubStr(Str(Year(dData),4),3,2)
	cCab1 += "  |"
	dData := AddMes(dData,1)
Next 
							
Return( cCab1 )