/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QMTR040.Ch"
#Include "PROTHEUS.CH"
#Include "report.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR040  ³ Autor ³ Cicero Cruz           ³ Data ³ 13.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Plano de Calibracao                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR040(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QMTR040()
Local oReport       
Private cAliasQM2 := "QM2"
Private aConta		:= Array(12)  
Private cStrAnt4	:= ""
                            
aConta := aFill(aConta,0)
  
If TRepInUse()
	// Interface de impressao
	oReport := ReportDef()
 	oReport:PrintDialog()
Else
	U_QMTR040R3()
EndIf

Return
         
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Cicero Cruz           ³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ QMTR040                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport 
Local oSection1
Local aOrdem    := {}
Local cPerg		:="QMR040"

/* Criacao do objeto REPORT
DEFINE REPORT oReport NAME <Nome do relatorio> ;
					  TITLE <Titulo> 		   ;
					  PARAMETER <Pergunte>     ;
					  ACTION <Bloco de codigo que sera executado na confirmacao da impressao> ;
					  DESCRIPTION <Descricao>
*/
DEFINE REPORT oReport NAME "QMTR040" TITLE STR0005 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION STR0001
oReport:SetLandscape()

aOrdem := {	STR0028 ,; 	//"Familia+Instr.+Rev+Depto." 
			STR0029,; 	// "Familia+Depto.+Instr.+Rev"
			STR0030} 	// "Depto.+Instr.+Rev+Familia" 
/*
Criacao do objeto secao utilizada pelo relatorio                               
DEFINE SECTION  <Nome> OF <Objeto TReport que a secao pertence>  ;
       TITLE  <Descricao da secao>                               ;
       TABLES <Tabelas a ser usadas>                             ;
       ORDERS <Array com as Ordens do relatorio>                 ;
       LOAD CELLS            									 ; // Carrega campos do SX3 como celulas
       TOTAL TEXT //Carrega ordens do Sindex
*/
DEFINE SECTION oSection  OF oReport TITLE STR0005 TABLES "QM2" ORDERS aOrdem

/*
DEFINE CELL NAME <Nome da celula do relatorio>                          ;
            OF <Objeto TSection que a secao pertence>                   ;
            ALIAS <Nome da tabela de referencia da celula>              ;
            TITLE <Titulo da celula>                                    ;
            Picture <Picture>                                           ;
            SIZE <Tamanho> 												;               
            PIXEL 														;//Informe se o tamanho esta em pixel 
            BLOCK <Bloco de codigo para impressao>
*/

DEFINE CELL NAME "QM2_TIPO"   OF oSection ALIAS "QM2" SIZE 16
DEFINE CELL NAME "QM2_INSTR"  OF oSection ALIAS "QM2" SIZE 15
DEFINE CELL NAME "QM2_REVINS" OF oSection ALIAS "QM2" SIZE  3 TITLE STR0031
DEFINE CELL NAME "QM2_DEPTO"  OF oSection ALIAS "QM2" SIZE  TAMSX3("QM2_DEPTO")[1] TITLE STR0032
DEFINE CELL NAME "QM2_RESP"   OF oSection ALIAS "QM2" SIZE  TAMSX3("QM2_RESP")[1]
DEFINE CELL NAME "QM2_FREQAF" OF oSection ALIAS "QM2" SIZE  3 TITLE STR0033+CRLF+STR0034
DEFINE CELL NAME "ORGCAL"     OF oSection             SIZE 15 TITLE STR0035+CRLF+STR0036 BLOCK {|| IIF(QM9->QM9_ORGAFE == "I", QM9->QM9_DEPTO, QM9->QM9_LABOR) }
DEFINE CELL NAME "QM2_SGUARD" OF oSection ALIAS "QM2" SIZE  3 TITLE STR0037
DEFINE CELL NAME "M01"        OF oSection             SIZE  8
DEFINE CELL NAME "M02"        OF oSection             SIZE  8
DEFINE CELL NAME "M03"        OF oSection             SIZE  8
DEFINE CELL NAME "M04"        OF oSection             SIZE  8
DEFINE CELL NAME "M05"        OF oSection             SIZE  8
DEFINE CELL NAME "M06"        OF oSection             SIZE  8
DEFINE CELL NAME "M07"        OF oSection             SIZE  8
DEFINE CELL NAME "M08"        OF oSection             SIZE  8
DEFINE CELL NAME "M09"        OF oSection             SIZE  8
DEFINE CELL NAME "M10"        OF oSection             SIZE  8
DEFINE CELL NAME "M11"        OF oSection             SIZE  8
DEFINE CELL NAME "M12"        OF oSection             SIZE  8    

DEFINE SECTION oTotal    OF oReport TITLE STR0043 //"Totalizadores" 
oTotal:SetHeaderSection()
DEFINE CELL NAME "TEXTO"      OF oTotal               SIZE 92   
DEFINE CELL NAME "T01"        OF oTotal               SIZE  7
DEFINE CELL NAME "T02"        OF oTotal               SIZE  7
DEFINE CELL NAME "T03"        OF oTotal               SIZE  7
DEFINE CELL NAME "T04"        OF oTotal               SIZE  8
DEFINE CELL NAME "T05"        OF oTotal               SIZE  8
DEFINE CELL NAME "T06"        OF oTotal               SIZE  8
DEFINE CELL NAME "T07"        OF oTotal               SIZE  8
DEFINE CELL NAME "T08"        OF oTotal               SIZE  8
DEFINE CELL NAME "T09"        OF oTotal               SIZE  8
DEFINE CELL NAME "T10"        OF oTotal               SIZE  8
DEFINE CELL NAME "T11"        OF oTotal               SIZE  8
DEFINE CELL NAME "T12"        OF oTotal               SIZE  8 

DEFINE SECTION oLegenda1 OF oReport TITLE STR0023 //"Legendas" 
oLegenda1:SetHeaderSection()
DEFINE CELL NAME "TITULO"      OF oLegenda1           SIZE 120 ALIGN CENTER  

DEFINE SECTION oLegenda2 OF oReport TITLE STR0044 //"Usuario(s)" 
DEFINE CELL NAME "COD"         OF oLegenda2            SIZE  15 TITLE STR0038
DEFINE CELL NAME "NOME"        OF oLegenda2            SIZE  30 TITLE STR0039
DEFINE CELL NAME "NREDUZ"      OF oLegenda2            SIZE  15 TITLE STR0040

DEFINE SECTION oLegenda3 OF oReport TITLE STR0045 //"Departamento(s)" 
DEFINE CELL NAME "COD"         OF oLegenda3            SIZE  15 TITLE STR0038
DEFINE CELL NAME "DEPTO"       OF oLegenda3            SIZE  30 TITLE STR0041

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³PrintRepor³ Autor ³ Cicero Cruz           ³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao R4	 		                            		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTr040													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport( oReport )
Local oSection1 := oReport:Section(1)  
Local oSection2 := oReport:Section(2)    
Local oSection3 := oReport:Section(3)     
Local oSection4 := oReport:Section(4)
Local oSection5 := oReport:Section(5)
Local cPerg		:= "QMR040"    
Local nJ        := 0
Local nX		:= 0        
Local lHaRegistros := .T.
Local cVar      := ""             
Local cOrdem    := ""
Local cChave    := ""        
Local aMeses	:= {STR0011,STR0012,STR0013,STR0014,STR0015,STR0016,; // "Jan"###"Fev"###"Mar"###"Abr"###"Mai"###"Jun"
STR0017,STR0018,STR0019,STR0020,STR0021,STR0022 } // "Jul"###"Ago"###"Set"###"Out"###"Nov"###"Dez"
Local nI := 0   
Local aLegR := {}

Pergunte(cPerg,.F.)           

Private dDataLim := U_AddMes( mv_par03, 11 )  // Mes atual + 11 = 12 meses

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   	MakeSqlExpr(oReport:uParam) 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:BeginQuery()	

cAliasQM2 := GetNextAlias()

If Upper(TcGetDb()) $ "ORACLE.INFORMIX"
	Do Case
		Case oSection1:GetOrder() == 1				
			cChave :=  "% 15, 3, 13, 16, 1 %"
		Case oSection1:GetOrder() == 2
			cChave := "% 15, 3, 1, 13,  16 %"
		Case oSection1:GetOrder() == 3
			cChave := "% 15, 1, 13, 16, 3 %"
	EndCase
Else
	Do Case
		Case oSection1:GetOrder() == 1
			cChave := "% QM2_FILIAL, QM2_TIPO, QM2_INSTR, QM2_REVINV, QM2_DEPTO %"
		Case oSection1:GetOrder() == 2
			cChave := "% QM2_FILIAL, QM2_TIPO, QM2_DEPTO, QM2_INSTR,  QM2_REVINV %"
		Case oSection1:GetOrder() == 3
			cChave := "% QM2_FILIAL, QM2_DEPTO, QM2_INSTR, QM2_REVINV, QM2_TIPO %"
	EndCase
EndIf
	

BeginSql Alias cAliasQM2

SELECT QM2.QM2_DEPTO,    QM2.QM2_RESP,   QM2.QM2_TIPO,  QM2.QM2_FABR,  QM2.QM2_STATUS,  QM2.QM2_SGUARD,  QM2.QM2_LAUDO,
       QM2.QM2_FREREP, QM2.QM2_FREQAF, QM2.QM2_VALREP, QM2.QM2_VALDAF,   QM2.QM2_FLAG,   QM2.QM2_INSTR, QM2.QM2_REVINS,
       QM2.QM2_FILIAL,     QM2_REVINV
 	FROM %table:QM2% QM2 	
	WHERE QM2.QM2_FILIAL = %xFilial:QM2% AND 
		  QM2.QM2_INSTR BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
	      QM2.QM2_DEPTO BETWEEN %Exp:mv_par04% AND %Exp:mv_par05% AND         
	      QM2.QM2_TIPO  BETWEEN %Exp:mv_par11% AND %Exp:mv_par12% AND
	      QM2.QM2_FABR  BETWEEN %Exp:mv_par13% AND %Exp:mv_par14% AND
	      QM2.QM2_RESP  BETWEEN %Exp:mv_par15% AND %Exp:mv_par16% AND 
	      QM2.QM2_VALDAF >=  %Exp:Dtos(mv_par03)% AND 
	      QM2.QM2_FLAG  = '1' AND
	      QM2.%notDel%  		 
	ORDER BY %Exp:cChave%  
 			
EndSql   
oSection1:EndQuery() 


While !&(cAliasQM2)->(Eof()) .and. lHaRegistros
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Revis„o anterior do instrumento n„o deve ser impresso		 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  	IF Alltrim(&(cAliasQM2+"->QM2_INSTR")) == Alltrim(cStrAnt4)
		dbSkip()
		Loop
	EndIf
	
	cStrAnt4 := &(cAliasQM2+"->QM2_INSTR")   
    
	
	IF Empty(&(cAliasQM2+"->QM2_FREQAF")) .or. Empty(&(cAliasQM2+"->QM2_VALDAF"))
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

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ lOk: Criada para verificar se ha movimentacoes dentro do pe- ³
	//³ riodo desejado pelo usuario.                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lOk		:= .F.
	aPrevRea := {}

	lOk := Tr040Prev(@lOk, &(cAliasQM2+"->QM2_FILIAL"), &(cAliasQM2+"->QM2_INSTR"), &(cAliasQM2+"->QM2_REVINS"), &(cAliasQM2+"->QM2_VALDAF"), &(cAliasQM2+"->QM2_FREQAF"), "R4")
	
	If ! lOk
		&(cAliasQM2)->(DBSkip())
		Loop
	EndIf

	Aadd(aLegR,{&(cAliasQM2+"->QM2_DEPTO"),&(cAliasQM2+"->QM2_RESP")})
	
  	For nX:=1 to 30
		oSection1:Init()
		oSection1:Cell("QM2_FREQAF"):SetValue(&(cAliasQM2+"->QM2_FREQAF"))
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
		oSection1:Cell("M01"):cTitle := aMeses[Val(SubStr(DTOC(MV_PAR03),4,2))] + "/" + SubStr(Str(Year(MV_PAR03),4),3,2) + CRLF + STR0027
		oSection1:Cell("M01"):SetValue((cVar))

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][2,1]),1,2)
		If ! Empty(aPrevRea[nX][2,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][2,2]),1,5)
		EndIf
		oSection1:Cell("M02"):cTitle := aMeses[Val(SubStr(DTOC(U_AddMes(MV_PAR03,1)),4,2))] + "/" + SubStr(Str(Year(U_AddMes(MV_PAR03,1)),4),3,2)  + CRLF + STR0027
		oSection1:Cell("M02"):SetValue((cVar))

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][3,1]),1,2)
		If ! Empty(aPrevRea[nX][3,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][3,2]),1,5)
		EndIf
		oSection1:Cell("M03"):cTitle := aMeses[Val(SubStr(DTOC(U_AddMes(MV_PAR03,2)),4,2))] + "/" + SubStr(Str(Year(U_AddMes(MV_PAR03,2)),4),3,2)  + CRLF + STR0027
		oSection1:Cell("M03"):SetValue((cVar))  
		
		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][4,1]),1,2)
		If ! Empty(aPrevRea[nX][4,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][4,2]),1,5)
		EndIf   
		oSection1:Cell("M04"):cTitle := aMeses[Val(SubStr(DTOC(U_AddMes(MV_PAR03,3)),4,2))] + "/" + SubStr(Str(Year(U_AddMes(MV_PAR03,3)),4),3,2)  + CRLF + STR0027
		oSection1:Cell("M04"):SetValue(cVar)
		

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][5,1]),1,2)
		If ! Empty(aPrevRea[nX][5,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][5,2]),1,5)
		EndIf
		oSection1:Cell("M05"):cTitle := aMeses[Val(SubStr(DTOC(U_AddMes(MV_PAR03,4)),4,2))] + "/" + SubStr(Str(Year(U_AddMes(MV_PAR03,4)),4),3,2)  + CRLF + STR0027
		oSection1:Cell("M05"):SetValue(cVar)
		
		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][6,1]),1,2)
		If ! Empty(aPrevRea[nX][6,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][6,2]),1,5)
		EndIf
		oSection1:Cell("M06"):cTitle := aMeses[Val(SubStr(DTOC(U_AddMes(MV_PAR03,5)),4,2))] + "/" + SubStr(Str(Year(U_AddMes(MV_PAR03,5)),4),3,2)  + CRLF + STR0027
		oSection1:Cell("M06"):SetValue(cVar)

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][7,1]),1,2)
		If ! Empty(aPrevRea[nX][7,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][7,2]),1,5)
		EndIf
		oSection1:Cell("M07"):cTitle := aMeses[Val(SubStr(DTOC(U_AddMes(MV_PAR03,6)),4,2))] + "/" + SubStr(Str(Year(U_AddMes(MV_PAR03,6)),4),3,2)  + CRLF + STR0027
		oSection1:Cell("M07"):SetValue(cVar)

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][8,1]),1,2)
		If ! Empty(aPrevRea[nX][8,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][8,2]),1,5)
		EndIf
		oSection1:Cell("M08"):cTitle := aMeses[Val(SubStr(DTOC(U_AddMes(MV_PAR03,7)),4,2))] + "/" + SubStr(Str(Year(U_AddMes(MV_PAR03,7)),4),3,2)  + CRLF + STR0027
		oSection1:Cell("M08"):SetValue(cVar)
		
		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][9,1]),1,2)
		If ! Empty(aPrevRea[nX][9,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][9,2]),1,5)
		EndIf
		oSection1:Cell("M09"):cTitle := aMeses[Val(SubStr(DTOC(U_AddMes(MV_PAR03,8)),4,2))] + "/" + SubStr(Str(Year(U_AddMes(MV_PAR03,8)),4),3,2)  + CRLF + STR0027
		oSection1:Cell("M09"):SetValue(cVar)
		
		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][10,1]),1,2)
		If ! Empty(aPrevRea[nX][10,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][10,2]),1,5)
		EndIf
		oSection1:Cell("M10"):cTitle := aMeses[Val(SubStr(DTOC(U_AddMes(MV_PAR03,9)),4,2))] + "/" + SubStr(Str(Year(U_AddMes(MV_PAR03,9)),4),3,2)  + CRLF + STR0027
		oSection1:Cell("M10"):SetValue(cVar)
		
		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][11,1]),1,2)
		If ! Empty(aPrevRea[nX][11,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][11,2]),1,5)
		EndIf
		oSection1:Cell("M11"):cTitle := aMeses[Val(SubStr(DTOC(U_AddMes(MV_PAR03,10)),4,2))] + "/" + SubStr(Str(Year(U_AddMes(MV_PAR03,10)),4),3,2)  + CRLF + STR0027
		oSection1:Cell("M11"):SetValue(cVar)

		cVar := ""      
		cVar := SubStr(DtoC(aPrevRea[nX][12,1]),1,2)
		If ! Empty(aPrevRea[nX][12,2])
			cVar += " "+SubStr(DtoC(aPrevRea[nX][12,2]),1,5)
		EndIf
		oSection1:Cell("M12"):cTitle := aMeses[Val(SubStr(DTOC(U_AddMes(MV_PAR03,11)),4,2))] + "/" + SubStr(Str(Year(U_AddMes(MV_PAR03,11)),4),3,2)  + CRLF + STR0027
		oSection1:Cell("M12"):SetValue(cVar)
		If nX > 1
			oSection1:Cell("QM2_TIPO"):Hide()
			oSection1:Cell("QM2_INSTR"):Hide()
			oSection1:Cell("QM2_REVINS"):Hide()
			oSection1:Cell("QM2_DEPTO"):Hide()
			oSection1:Cell("QM2_RESP"):Hide()
			oSection1:Cell("QM2_FREQAF"):Hide()
			oSection1:Cell("QM2_DEPTO"):Hide()
			oSection1:Cell("ORGCAL"):Hide()
			oSection1:Cell("QM2_SGUARD"):Hide()      
			oSection1:SetHeaderSection(.F.)
		EndIf
		oReport:ThinLine()
		oSection1:PrintLine()
		oSection1:Cell("QM2_TIPO"):Show()
		oSection1:Cell("QM2_INSTR"):Show()
		oSection1:Cell("QM2_REVINS"):Show()
		oSection1:Cell("QM2_DEPTO"):Show()
		oSection1:Cell("QM2_RESP"):Show()
		oSection1:Cell("QM2_FREQAF"):Show()
		oSection1:Cell("QM2_DEPTO"):Show()
		oSection1:Cell("ORGCAL"):Show()
		oSection1:Cell("QM2_SGUARD"):Show()   
		oSection1:SetHeaderSection(.T.)
	Next   
	&(cAliasQM2)->(DBSkip())
	oReport:FatLine()
EndDo      

oSection2:Init()
oSection2:Cell("TEXTO"):SetValue(STR0026) //"T O T A L   P R E V I S T O  :" 
oSection2:Cell("T01"):SetValue(Alltrim(Str(aConta[1])))
oSection2:Cell("T02"):SetValue(Alltrim(Str(aConta[2])))
oSection2:Cell("T03"):SetValue(Alltrim(Str(aConta[3])))
oSection2:Cell("T04"):SetValue(Alltrim(Str(aConta[4])))
oSection2:Cell("T05"):SetValue(Alltrim(Str(aConta[5])))
oSection2:Cell("T06"):SetValue(Alltrim(Str(aConta[6])))
oSection2:Cell("T07"):SetValue(Alltrim(Str(aConta[7])))
oSection2:Cell("T08"):SetValue(Alltrim(Str(aConta[8])))
oSection2:Cell("T09"):SetValue(Alltrim(Str(aConta[9])))
oSection2:Cell("T10"):SetValue(Alltrim(Str(aConta[10])))
oSection2:Cell("T11"):SetValue(Alltrim(Str(aConta[11])))
oSection2:Cell("T12"):SetValue(Alltrim(Str(aConta[12])))
oReport:ThinLine()   
oReport:SkipLine(1) 
oSection2:PrintLine()


If mv_par17 == 1 
	lFirst := .T.
	cOldUus := "" 

	If 	lFirst
		oSection3:Init()
		oReport:SkipLine(1)  
		oSection3:PrintLine()
		oSection3:Cell("TITULO"):SetValue(STR0023)
		oSection3:PrintLine()
		lFirst := .F.
	EndIf
		
	aSort(aLegR,,,{|x,y| x[2] < y[2]})
	For nI := 1 To Len(aLegR)
		If cOldUus <> aLegR[nI][2]
			dbSelectArea("QAA")
			dbSetOrder(1)
			If dbSeek(xFilial()+aLegR[nI][2])
				cOldUus := aLegR[nI][2]
				oSection4:Init()
				oSection4:Cell("COD"):SetValue(aLegR[nI][2])
				oSection4:Cell("NOME"):SetValue(QAA->QAA_NOME)
				oSection4:Cell("NREDUZ"):SetValue(QAA->QAA_APELID)
				oSection4:PrintLine()
            EndIf
		Endif	
	Next 

	aSort(aLegR,,,{|x,y| x[1] < y[1]})

	For nI := 1 To Len(aLegR)
		If cOldUus <> aLegR[nI][1]
			dbSelectArea("QAD")
			dbSetOrder(1)
			If dbSeek(xFilial()+aLegR[nI][1])
				cOldUus := aLegR[nI][1]
				oSection5:Init()
				oSection5:Cell("COD"):SetValue(aLegR[nI][1])
				oSection5:Cell("DEPTO"):SetValue(QAD->QAD_DESC)
				oSection5:PrintLine() 
            EndIf
		Endif	
	Next 
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ QMTR040R3³ Autor ³ Alessandro B. Freire  ³ Data ³ 23.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Plano de Calibracao										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_QMTR040R3(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Denis     ³Melhor³ Melhora de Performance - Utilizacao de Query's am-  ³±± 
±±³          ³      ³ biente Top e Arquivo Temporario para ambiente Code  ³±±
±±³          ³      ³ Base.												  ³±±
±±³Denis     ³Correc³ Acerto na descricao da funcao TcSrvType().          ³±± 
±±³Denis     ³Correc³ Listar as calibracoes previstas.                    ³±± 
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMTR040R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis											 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1		:= OemToAnsi(STR0001) // "Este programa ira emitir o Plano de Calibra‡„o dos Instrumentos"
Local cDesc2		:= ""
Local cDesc3		:= ""
Local cString		:="QM2"
Local aOrdem		:= {}
Local wnrel

Private titulo    := OemToAnsi(STR0005) // "Plano de Calibracao"
Private cabec1 	:= OemToAnsi(STR0010) // "                                                                     Freq.                                     |"
Private cabec2 	:= OemToAnsi(STR0002) // "Familia          Instrumento      Rev. Responsavel     Dias  Fabricante       Orgao Calibrador SG |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R."
Private aReturn	:= {OemToAnsi(STR0003),1,OemToAnsi(STR0004),1,2,1,"",1} // "Zebrado"###"Administra‡„o"
Private nomeprog	:="QMTR040"
Private nLastKey	:= 0
Private cPerg		:="QMR040"
Private cTamanho	:= "G"

/*
1 		  2			3			 4 		  5			6			 7 		  8			9			 0 		  1			2			 3 		  4			5			 6 		  7			8			 9 		  0			1
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Freq.                                      |Jan/98   |Fev/98   |Mar/98   |Abr/98   |Mai/98   |Jun/98   |Jul/98   |Ago/98   |Set/98   |Out/98   |Nov/98   |Dez/98
Familia          Instrumento      Rev. Responsavel     Dias  Fabricante       Orgao Calibrador SG |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.   |P.  R.
xxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxx  xx	xxxxxxxxxxxxxxx xxx	 xxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxx xxx|xx  xx/xx|xx  xx/xx|xx	xx/xx|xx  xx/xx|xx  xx/xx|xx	xx/xx|xx  xx/xx|xx  xx/xx|xx	xx/xx|xx  xx/xx|xx  xx/xx|xx	xx/xx
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("QMR040",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros						    ³
//³ mv_par01: Instrumento Inicial                                   ³
//³ mv_par02: Instrumento Final                                     ³
//³ mv_par03: Periodo Inicial                                       ³
//³ mv_par04: Departamento Inicial                                  ³
//³ mv_par05: Departamento Final                                    ³
//³ mv_par06: Orgao Calibrador Todos/Interno/Externo                ³
//³ mv_par07: Orgao Calibrador interno inicial                      ³
//³ mv_par08: Orgao Calibrador interno final                        ³
//³ mv_par09: Orgao Calibrador externo inicial                      ³
//³ mv_par10: Orgao Calibrador externo final                        ³
//³ mv_par11: Fam¡lia inicial                                       ³
//³ mv_par12: Fam¡lia final                                         ³
//³ mv_par13: Fabricante inicial                                    ³
//³ mv_par14: Fabricante final                                      ³
//³ mv_par15: Usu rio inicial                                       ³
//³ mv_par16: Usu rio final                                         ³
//³ mv_par17: Imprime Legenda Responsaveis/Departamentos            ³
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
wnrel:="QMTR040"
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrdem,.F.,cTamanho)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

RptStatus({|lEnd| MTr040Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ MTr040IMP³ Autor ³ Alessandro B.Freire   ³ Data ³ 23.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o plano de calibracao							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ MTr040IMP(lEnd,wnRel,cString) 							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd	  - A‡Æo do Codeblock								  ³±±
±±³			 ³ wnRel   - T¡tulo do relat¢rio 							  ³±±
±±³			 ³ cString - Mensagem										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MTr040Imp(lEnd,wnRel,cString)

Local CbCont
Local CbTxt
Local tamanho		:= "G"
Local nOrder		:= IndexOrd()
Local nIndice		:= 0
Local cChave		:= ""
Local nrecno		:= Recno()
Local cStrAnt		:= ""
Local lImprime 	:= .F.
Local nJ
Local nI
Local lOk
Local lTemPrev := .F.
Local cFiltroUser := aReturn[7]
Local nx			:= 1
Local aLegR			:= {}
Local cOldUus		:= ""
Local lFirst		:= .T.

Local cName	:= ""
Local cQryAd	:= ""
Local cQuery 	:= ""

Private	TRB_INSTR	:= ""
Private	TRB_REVINS	:= ""
Private	TRB_REVINV	:= ""
Private	TRB_DEPTO	:= ""
Private	TRB_TIPO	:= ""
Private	TRB_VALDAF	:= ""
Private	TRB_FREQAF	:= ""
Private	TRB_RESP	:= ""
Private	TRB_FABR	:= ""
Private	TRB_Local 	:= ""
Private	TRB_STATUS	:= ""
Private	TRB_SQUARD	:= ""
Private cIndice		:= ""
Private dDataLim	:= U_AddMes( mv_par03, 11 )
Private nRecQM2		:= 0
Private aRetorno  := {}
Private aPrevRea 	:= {}
Private aConta		:= Array(12)

aConta := aFill(aConta,0)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cabec1   += U_Tr040Monta( mv_par03 )
cbtxt 	:= SPACE(10)
cbcont	:= 0
li 		:= 80
m_pag 	:= 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Crio ¡ndice tempor rio para corresponder a ordem desejada.   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QM2")

	cQuery := "SELECT QM2_FILIAL,QM2_INSTR,QM2_REVINS,QM2_REVINV,QM2_VALDAF,QM2_FREQAF,"
	//Tratamento de campos de usuario no filtro da SetPrint
	If !Empty(cFiltroUser)
		For nX := 1 To QM2->(FCount())
			cName := QM2->(FieldName(nX))
			If AllTrim( cName ) $ cFiltroUser
				If !cName $ cQuery .And. !cName $ cQryAd
					cQryAd += cName +","
				Endif 	
			EndIf 			       	
		 Next nX
		If !Empty(cQryAd)
			cQuery += cQryAd		
		Endif	
	Endif    
	cQuery += "QM2_DEPTO,QM2_RESP,QM2_TIPO,QM2_FABR,QM2_STATUS,QM2_SGUARD,QM2_LAUDO,QM2.R_E_C_N_O_ QM2RECNO "
	cQuery += "FROM "+RetSqlName("QM2")+" QM2 "					
	cQuery += "WHERE "
	cQuery += "QM2.QM2_FILIAL = '"			+xFilial("QM2")+	"' AND "
	cQuery += "QM2.QM2_INSTR  >= '"	+ mv_par01 + "' AND " 
	cQuery += "QM2.QM2_INSTR  <= '" + mv_par02 + "' AND " 
	cQuery += "QM2.QM2_VALDAF >= '"	+ Dtos(mv_par03)+	"' AND " 
	cQuery += "QM2.QM2_DEPTO BetWeen '"		+ mv_par04 +		"' AND '" + mv_par05 + 			"' AND " 
	cQuery += "QM2.QM2_TIPO BetWeen '"		+ mv_par11 +		"' AND '" + mv_par12 + 			"' AND " 
	cQuery += "QM2.QM2_FABR BetWeen '"		+ mv_par13 +		"' AND '" + mv_par14 + 			"' AND " 
	cQuery += "QM2.QM2_RESP BetWeen '"		+ mv_par15 +		"' AND '" + mv_par16 + 			"' AND " 
	cQuery += "QM2.QM2_FLAG = '1' AND " 
	cQuery += "QM2.D_E_L_E_T_= ' ' "
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
	dbSelectArea( "TRB" )
	dbGoTop()

If BOF() .and. EOF()
	Help(" ",1,"RECNO")
End

SetRegua(RecCount())

While ! Eof()

	TRB_FILIAL	:= TRB->QM2_FILIAL
	TRB_INSTR	:= TRB->QM2_INSTR
	TRB_REVINS	:= TRB->QM2_REVINS
	TRB_REVINV	:= TRB->QM2_REVINV
	TRB_DEPTO	:= TRB->QM2_DEPTO
	TRB_TIPO	:= TRB->QM2_TIPO
	TRB_VALDAF	:= TRB->QM2_VALDAF
	TRB_FREQAF	:= TRB->QM2_FREQAF
	TRB_RESP	:= TRB->QM2_RESP
	TRB_FABR	:= TRB->QM2_FABR
	TRB_STATUS	:= TRB->QM2_STATUS
	TRB_LAUDO	:= TRB->QM2_LAUDO
	TRB_SGUARD	:= TRB->QM2_SGUARD 		
	nRecQM2		:= TRB->QM2RECNO 		
	
	IncRegua()
	
	IF lEnd
		@Prow()+1,001 PSAY OemToAnsi(STR0009)	//"CANCELADO PELO OPERADOR"
		EXIT
	ENDIF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Revis„o anterior do instrumento n„o deve ser impresso		 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF Alltrim(TRB_INSTR) == Alltrim(cStrAnt)
		dbSkip()
		Loop
	EndIf
	
	cStrAnt := TRB_INSTR
    
	//Verifica pasta filtro da SetPrint
	If !Empty(cFiltroUser) .and. !(&cFiltroUser)
		dbSkip()
		Loop		      
    Endif
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
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ lOk: Criada para verificar se ha movimentacoes dentro do pe- ³
	//³ riodo desejado pelo usuario.                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lOk		:= .F.
	aPrevRea := {}

	lOk := Tr040Prev(@lOk)
	
	If ! lOk
		dbSkip()
		Loop
	EndIf
	
	IF li > 53
		li := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
		li++
	End
	
	/*
	1 		  2			3			 4 		  5			6			 7 		  8			9			 0 		  1			2			 3 		  4			5			 6 		  7			8			 9 		  0			1
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	Freq.                                     |Jan/98  |Fev/98  |Mar/98  |Abr/98  |Mai/98  |Jun/98  |Jul/98  |Ago/98  |Set/98  |Out/98  |Nov/98  |Dez/98
	Familia          Instrumento      Rev Depto.        Responsavel          Dias Fabricante       Orgao Calibrador SG |P. R.   |P. R.   |P. R.   |P. R.   |P. R.   |P. R.   |P. R.   |P. R.   |P. R.   |P.  R.  |P.  R.  |P. R.
	xxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxx xx  xxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxx xxx  xxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxx xxx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx|xx xx/xx
	*/
	@li,00  PSAY Alltrim(SubStr(TRB_TIPO,1,16))
	@li,17  PSAY Alltrim(SubStr(TRB_INSTR,1,16))
	@li,34  PSAY Alltrim(SubStr(TRB_REVINS,1,3))
	@li,39  PSAY Alltrim(SubStr(TRB_DEPTO,1,13))
	@li,53  PSAY Alltrim(SubStr(TRB_RESP,1,10))
	@li,69  PSAY Alltrim(Str(TRB_FREQAF,4))
	If !Empty(TRB_FABR) //Campo Fabricante nao eh obrigatorio....
		@li,74  PSAY Alltrim(SubStr(TRB_FABR,1,15))
		@li,91  PSAY IIF(QM9->QM9_ORGAFE == "I", QM9->QM9_DEPTO, QM9->QM9_LABOR)
		If !Empty(TRB_SGUARD)
			@li,108 PSAY Alltrim(SubStr(TRB_SGUARD,1,3))
		Endif	
	Else 
		TRB_FABR := Space(15)
		@li,74  PSAY TRB_FABR
		@li,91  PSAY IIF(QM9->QM9_ORGAFE == "I", QM9->QM9_DEPTO, QM9->QM9_LABOR)
		@li,108 PSAY SubStr(TRB_SGUARD,1,3)
	Endif	

	//Preenche array para impressao de legenda
	Aadd(aLegR,{TRB_DEPTO,TRB_RESP})

	lTemPrev := .F.
	For nI := 1 to 30
		
		lImprime := .F.
		
		For nJ := 1 to 12
			If ! Empty(aPrevRea[nI][nJ,1])
				lImprime := .T.
				lTemPrev := .T.
				Exit
			EndIf
		Next nJ
		
		If ! lImprime
			Loop
		EndIf
		
		@li,111 PSAY "|" + (SubStr(DtoC(aPrevRea[nI][1,1]),1,2))
		If ! Empty(aPrevRea[nI][1,2])
			@li,115 PSAY (SubStr(DtoC(aPrevRea[nI][1,2]),1,5)) + "|"
		Else
			@li,115 PSAY "     |"
		EndIf
		
		@li,121 PSAY (SubStr(DtoC(aPrevRea[nI][2,1]),1,2))
		If ! Empty(aPrevRea[nI][2,2])
			@li,124 PSAY (SubStr(DtoC(aPrevRea[nI][2,2]),1,5)) + "|"
		Else
			@li,124 PSAY "     |"
		EndIf
		
		@li,130 PSAY (SubStr(DtoC(aPrevRea[nI][3,1]),1,2))
		If ! Empty(aPrevRea[nI][3,2])
			@li,133 PSAY (SubStr(DtoC(aPrevRea[nI][3,2]),1,5)) + "|"
		Else
			@li,133 PSAY "     |"
		EndIf
		
		@li,139 PSAY (SubStr(DtoC(aPrevRea[nI][4,1]),1,2))
		If ! Empty(aPrevRea[nI][4,2])
			@li,142 PSAY (SubStr(DtoC(aPrevRea[nI][4,2]),1,5)) + "|"
		Else
			@li,142 PSAY "     |"
		EndIf
		
		@li,148 PSAY (SubStr(DtoC(aPrevRea[nI][5,1]),1,2))
		If ! Empty(aPrevRea[nI][5,2])
			@li,151 PSAY (SubStr(DtoC(aPrevRea[nI][5,2]),1,5)) + "|"
		Else
			@li,151 PSAY "     |"
		Endif
		
		@li,157 PSAY (SubStr(DtoC(aPrevRea[nI][6,1]),1,2))
		If ! Empty(aPrevRea[nI][6,2])
			@li,160 PSAY (SubStr(DtoC(aPrevRea[nI][6,2]),1,5)) + "|"
		Else
			@li,160 PSAY "     |"
		EndIf
		
		@li,166 PSAY (SubStr(DtoC(aPrevRea[nI][7,1]),1,2))
		If ! Empty(aPrevRea[nI][7,2])
			@li,169 PSAY (SubStr(DtoC(aPrevRea[nI][7,2]),1,5)) + "|"
		Else
			@li,169 PSAY "     |"
		EndIf
		
		@li,175 PSAY (SubStr(DtoC(aPrevRea[nI][8,1]),1,2))
		If ! Empty(aPrevRea[nI][8,2])
			@li,178 PSAY (SubStr(DtoC(aPrevRea[nI][8,2]),1,5)) + "|"
		Else
			@li,178 PSAY "     |"
		EndIf
		
		@li,184 PSAY (SubStr(DtoC(aPrevRea[nI][9,1]),1,2))
		If ! Empty(aPrevRea[nI][9,2])
			@li,187 PSAY (SubStr(DtoC(aPrevRea[nI][9,2]),1,5)) + "|"
		Else
			@li,187 PSAY "     |"
		EndIf
		
		@li,193 PSAY (SubStr(DtoC(aPrevRea[nI][10,1]),1,2))
		If ! Empty(aPrevRea[nI][10,2])
			@li,196 PSAY (SubStr(DtoC(aPrevRea[nI][10,2]),1,5)) + "|"
		Else
			@li,196 PSAY "     |"
		EndIf
		
		@li,202 PSAY (SubStr(DtoC(aPrevRea[nI][11,1]),1,2))
		If ! Empty(aPrevRea[nI][11,2])
			@li,205 PSAY (SubStr(DtoC(aPrevRea[nI][11,2]),1,5)) + "|"
		Else
			@li,205 PSAY "     |"
		EndIf
		
		@li,211 PSAY (SubStr(DtoC(aPrevRea[nI][12,1]),1,2))
		If ! Empty(aPrevRea[nI][12,2])
			@li,214 PSAY (SubStr(DtoC(aPrevRea[nI][12,2]),1,5)) + "|"
		Else
			@li,214 PSAY "     |"
		EndIf
		li++

	Next nI

	If !lTemPrev
		li++
	EndIf
		
	@li,00 PSAY __PrtThinLine()
	li++

	dbSelectArea("TRB")	
	dbSkip()
	Loop
End

If Len(aPrevRea) > 0
	
	IF li > 53
		li := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
		li++
	End

	@li,00 PSAY __PrtThinLine()
	li++

	IF li > 53
		li := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
		li++
	End

	@li,000 PSAY OemToAnsi(STR0026)		//"T O T A L   P R E V I S T O  :" 

	@li,111 PSAY "|"
	@li,115 PSAY Alltrim(Str(aConta[1]))
	@li,120 PSAY "|"
	@li,124 PSAY Alltrim(Str(aConta[2]))
	@li,129 PSAY "|"
	@li,133 PSAY Alltrim(Str(aConta[3]))	 
	@li,138 PSAY "|"
	@li,142 PSAY Alltrim(Str(aConta[4]))
	@li,147 PSAY "|"
	@li,151 PSAY Alltrim(Str(aConta[5]))
	@li,156 PSAY "|"
	@li,160 PSAY Alltrim(Str(aConta[6]))
	@li,165 PSAY "|"
	@li,169 PSAY Alltrim(Str(aConta[7]))
	@li,174 PSAY "|"
	@li,178 PSAY Alltrim(Str(aConta[8]))
	@li,183 PSAY "|"
	@li,187 PSAY Alltrim(Str(aConta[9]))
	@li,192 PSAY "|"
	@li,196 PSAY Alltrim(Str(aConta[10]))
	@li,201 PSAY "|"
	@li,205 PSAY Alltrim(Str(aConta[11]))
	@li,210 PSAY "|"
	@li,214 PSAY Alltrim(Str(aConta[12]))
	@li,219 PSAY "|"
	li++

	IF li > 53
		li := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
		li++
	End
	@li,00 PSAY __PrtThinLine()

Endif

//Imprime legenda de responsaveis/departamentos
If mv_par17 == 1                              
	lFirst := .T.
	li++
	li++
	cOldUus := ""
	If li > 53
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
	Endif	
	aSort(aLegR,,,{|x,y| x[2] < y[2]})
	For nI := 1 To Len(aLegR)
		If lFirst
			@ li, 00 PSAY __PrtFatLine()
			li++
			If li > 53
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			Endif	
		
			@ li,(220-Len(STR0023))/2  PSAY STR0023 //"LEGENDA RESPONSAVEL(IS)/DEPARTAMENTO(S)"
		
			li++
			If li > 53
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			Endif	

			@ li, 00 PSAY __PrtFatLine()

			li++
			li++
			If li > 53
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			Endif	

			@ li, 00 PSAY __PrtThinLine()

			li++
			If li > 53
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
				li++
			Endif	
			@li,00 PSAY STR0024 //"          Codigo              Nome                                         Apelido"
			//          1         2         3         4         5         6         7         8         9         0         1
			//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
			//          Codigo              Nome                                         Apelido                  
			If li > 53
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			Endif	

			li++
			@ li, 00 PSAY __PrtThinLine()

			lFirst := .F.
		Endif 
		If cOldUus <> aLegR[nI][2]
			li++	
			If li > 53
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			Endif	

			@li,10 PSAY aLegR[nI][2]	

			dbSelectArea("QAA")
			dbSetOrder(1)
			dbSeek(xFilial()+aLegR[nI][2])
			if Empty(QAA->QAA_NOME)
				@li,30 PSAY OemToAnsi(STR0042)//"USUARIO NAO EXISTE OU FOI DELETADO"
				@li,75 PSAY OemToAnsi(STR0042)//"USUARIO NAO EXISTE OU FOI DELETADO"
			Else
				@li,30 PSAY QAA->QAA_NOME
				@li,75 PSAY QAA->QAA_APELID
			EndIf
		Endif	
		cOldUus := aLegR[nI][2]
	Next nI

	lFirst := .T.
	li++
	li++
	cOldUus := ""
	If li > 53
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
	Endif	
	aSort(aLegR,,,{|x,y| x[1] < y[1]})
	For nI := 1 To Len(aLegR)
		If lFirst
			@ li, 00 PSAY __PrtFatLine()
			li++
			If li > 53
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			Endif	

			@li,00 PSAY STR0025 //"          Codigo              Departamento"
			//          1         2         3         4         5         6         7         8         9         0         1
			//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
			//          Codigo              Departamento
			If li > 53
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			Endif	
            li++
			@ li, 00 PSAY __PrtThinLine()

			lFirst := .F.
		Endif 
		If cOldUus <> aLegR[nI][1]
			li++	
			If li > 53
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			Endif	

			@li,10 PSAY aLegR[nI][1]	

			dbSelectArea("QAD")
			dbSetOrder(1)
			dbSeek(xFilial()+aLegR[nI][1])
			@li,30 PSAY QAD->QAD_DESC
		Endif	
		cOldUus := aLegR[nI][1]
	Next nI
Endif

Roda( cbCont, cbTxt, Tamanho )

Set Device To Screen

dbSelectArea("TRB")
dbCloseArea()
dbSelectArea("QM2")
dbSetOrder(nOrder)	

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
±±³Fun‡…o	 ³ TR040Prev³ Autor ³ Alessandro B.Freire   ³ Data ³ 22.08.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna as datas previstas para calibracao				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ Tr040Prev() 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR040													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function TR040Prev( lret, cFilIns, cInst, cRev, cValDaf, cFreRep, cVers )

//Local aRetorno  := {}
Local nCol
Local dData
Local nI
Local aArea 
Local lReal := .F.
Local nColr    

Default cFilIns := TRB_FILIAL
Default cInst   := TRB_INSTR
Default cRev    := TRB_REVINS
Default cFreRep := TRB_FREQAF
Default cValDaf := TRB_VALDAF
Default cVers    := "R3"  

aArea := GetArea()
aRetorno  := {}
For nI := 1 to 30
	AAdd( aRetorno,{{CtoD("  /  /  ","DDMMYY"),CtoD("  /  /  ","DDMMYY")},;
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
dbSeek( cFilIns+cInst+cRev+DTOS(mv_par03), .T. )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Medicoes efetuadas.											 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While ! Eof() .And.	QM6->QM6_FILIAL+QM6->QM6_INSTR+QM6->QM6_REVINS == ;
		cFilIns+cInst+cRev
	
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
	
		If mv_par17 == 1
			If Year(QM6->QM6_DATA) == Year(mv_par03)
				nColR := Month(QM6->QM6_DATA)-Month(mv_par03) + 1
			Else
				nColR := 12 - Month(dDataLim) + Month(QM6->QM6_DATA)
			EndIf
        EndIf
        
		For nI := 1 to Len( aRetorno )
			If mv_par17 == 1
				If Empty(aRetorno[nI][nCol][1])
					lReal := .T.				
					aConta[nCol]++
					If nCol == nColr
						aRetorno[nI][nCol] := {QM6->QM6_DTPREV,QM6->QM6_DATA}
					Else
						aRetorno[nI][nCol] := {QM6->QM6_DTPREV,Ctod("  /  /  ")}
						aRetorno[nI][nColr]:= {Ctod("  /  /  "),QM6->QM6_DATA}			
					Endif	
					Exit
				EndIf
			Else
				If Empty(aRetorno[nI][nCol][1])
					lReal := .T.				
					aConta[nCol]++
					aRetorno[nI][nCol] := {QM6->QM6_DTPREV,QM6->QM6_DATA}
					Exit
				EndIf
			Endif
		Next nI
	EndIf
	lRet := .T.
	dbSkip()

EndDo
If TcSrvType() != "AS/400" .AND. cVers == "R3"
	dbSelectArea("TRB")
	dbGoTo(nRecQM2)
Else
	If cVers  == "R3"
		dbSelectArea("QM2")
		dbSetOrder(nOldOrd)
	EndIf
Endif

If cVers  == "R3"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Previsoes das proximas medicoes.									  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dData := TRB_VALDAF
Else
	dData := cValDaf
EndIf

While (dData <= dDataLim) .or. (Month(dData)==Month(dDataLim) .and.;
	Year(dData)==Year(dDataLim))
	
	If cVers  == "R3"
		If Eof()
			Exit
		EndIf
	EndIf
	
	If dData >= mv_par03 .or. ;
		( Month(dData) == Month(mv_par03) .and. Year(dData) == Year(mv_par03) )
		
		If Year(dData) == Year(mv_par03)
			nCol := Month(dData)-Month(mv_par03) + 1
		Else
			nCol := 12 - Month(dDataLim) + Month(dData)
		EndIf
		
		For nI := 1 to Len( aRetorno )
			If Empty(aRetorno[nI][nCol][1])
				If !lReal
					aConta[nCol]++
				aRetorno[nI][nCol] := { dData, CtoD("  /  /  ","DDMMYY") }
				Endif	
				Exit
			EndIf
		Next nI
	EndIf
	
	lReal := .F.
	If cVer == "R3"
		dData += TRB_FREQAF
	Else
		dData += cFreRep
	EndIf
	lRet  := .T.
	
EndDo
RestArea(aArea)

aPrevRea := aClone(aRetorno)
Return lRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ AddMes	³ Autor ³ Alessandro B.Freire   ³ Data ³ 22.08.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Adiciona <n> meses a data passada como parametro			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_AddMes( dData, nMeses ) 									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ dData 	 -> Data inicial								  ³±±
±±³			 ³ nMeses	 -> No. de Meses a se adicionar a data inicial	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR040													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AddMes( dData, nMeses )


Return(MonthSum(dData,nMeses))

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ TR040Fil ³ Autor ³ Alessandro B.Freire   ³ Data ³ 20.08.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Filtro do plano de calibracao 							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ Tr040Fil 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR040													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Tr040Fil()

Local cExpr := ""

cExpr := 'QM2_FILIAL=="'+ xFilial("QM2") + '".And.'
cExpr += 'QM2_INSTR>="' + mv_par01 + '".And.'
cExpr += 'QM2_INSTR<="' + mv_par02 + '".And.'
cExpr += 'DTOS(QM2_VALDAF)>="' + DTOS(mv_par03) + '".And.'
cExpr += 'QM2_DEPTO>="' + mv_par04 + '".And.'
cExpr += 'QM2_DEPTO<="' + mv_par05 + '".And.'
cExpr += 'QM2_TIPO>="' + mv_par11 + '".And.'
cExpr += 'QM2_TIPO<="' + mv_par12 + '".And.'
cExpr += 'QM2_FABR>="' + mv_par13 + '".And.'
cExpr += 'QM2_FABR<="' + mv_par14 + '".And.'
cExpr += 'QM2_RESP>="' + mv_par15 + '".And.'
cExpr += 'QM2_RESP<="' + mv_par16 + '".And.'
cExpr += 'QM2_FLAG == "1"'
Return(cExpr)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³tr040Monta³ Autor ³ Alessandro B. Freire  ³ Data ³ 25.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta a primeira linha do cabecalho                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_tr040Monta( dData )										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR040													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Tr040Monta()

Local aMeses	:= {STR0011,STR0012,STR0013,STR0014,STR0015,STR0016,; // "Jan"###"Fev"###"Mar"###"Abr"###"Mai"###"Jun"
STR0017,STR0018,STR0019,STR0020,STR0021,STR0022 } // "Jul"###"Ago"###"Set"###"Out"###"Nov"###"Dez"

Local dData    := mv_par03
Local cCab1    := ""
Local nI

For nI := 1 to 12
	cCab1 += aMeses[Month(dData)] + "/" + SubStr(Str(Year(dData),4),3,2)
	cCab1 += "  |"
	dData := U_AddMes(dData,1)
Next

Return( cCab1 )
