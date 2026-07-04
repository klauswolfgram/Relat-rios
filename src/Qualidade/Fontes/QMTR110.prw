/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QMTR110.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR110  ³ Autor ³ Cicero Cruz           ³ Data ³ 14.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Plano de Movimentacao                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR110(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QMTR110()
Local oReport       
Private cAliasQM2 	:= "QM2" 
Private cInstrAnt 	:= "" 
Private aMov 		:= {}
Private aMov2 		:= {}
                            
If TRepInUse()
	// Interface de impressao
	oReport := ReportDef()
 	oReport:PrintDialog()
Else
	U_QMTR110R3()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Cicero Cruz           ³ Data ³ 14.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ QMTR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport 
Local oSection1
Local aOrdem    := {}
Local cPerg		:="QMR110"

/* Criacao do objeto REPORT
DEFINE REPORT oReport NAME <Nome do relatorio> ;
					  TITLE <Titulo> 		   ;
					  PARAMETER <Pergunte>     ;
					  ACTION <Bloco de codigo que sera executado na confirmacao da impressao> ;
					  DESCRIPTION <Descricao>
*/
DEFINE REPORT oReport NAME "QMTR110" TITLE STR0001 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION STR0002+STR0003+STR0004 //"Plano de Localizacao"###"Este programa emite a movimentacao"###"dos instrumentos para afericao"###"conforme os parametros solicitados."
oReport:SetLandscape(.F.)

aOrdem := {	STR0005 ,; 	// "Familia/Instrumento"
			STR0006	,; 	// "Familia/Depto"
			STR0007 }  	// "Depto/Instrumento"
/*
Criacao do objeto secao utilizada pelo relatorio                               
DEFINE SECTION  <Nome> OF <Objeto TReport que a secao pertence>  ;
       TITLE  <Descricao da secao>                               ;
       TABLES <Tabelas a ser usadas>                             ;
       ORDERS <Array com as Ordens do relatorio>                 ;
       LOAD CELLS            									 ; // Carrega campos do SX3 como celulas
       TOTAL TEXT //Carrega ordens do Sindex
*/
DEFINE SECTION oSection1  OF oReport TITLE STR0001 TABLES "QM2" ORDERS aOrdem

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
                                                             
DEFINE CELL NAME "QM2_TIPO"   OF oSection1 ALIAS "QM2" SIZE  16
DEFINE CELL NAME "QM2_INSTR"  OF oSection1 ALIAS "QM2" SIZE  16
DEFINE CELL NAME "QM2_REVINS" OF oSection1 ALIAS "QM2" SIZE   3 TITLE STR0016    // "Rev."
DEFINE CELL NAME "QM2_DEPTO"  OF oSection1 ALIAS "QM2" SIZE   7 TITLE STR0017  // "Depart."
DEFINE CELL NAME "QM2_RESP"   OF oSection1 ALIAS "QM2" SIZE   7
DEFINE CELL NAME "QM2_FREQAF" OF oSection1 ALIAS "QM2" SIZE   3 TITLE STR0018+CRLF+STR0019 // "Freq."###"Dias"
DEFINE CELL NAME "ORGCAL"     OF oSection1             SIZE  15 TITLE STR0020+CRLF+STR0021 BLOCK {|| IIF(QM9->QM9_ORGAFE == "I", QM9->QM9_DEPTO, QM9->QM9_LABOR) }  // "Orgao"###"Calibrador"
DEFINE CELL NAME "QM2_SGUARD" OF oSection1 ALIAS "QM2" SIZE   3 TITLE STR0022 // "SG"
DEFINE CELL NAME "M01"        OF oSection1             SIZE  30
DEFINE CELL NAME "M02"        OF oSection1             SIZE  30
DEFINE CELL NAME "M03"        OF oSection1             SIZE  30
DEFINE CELL NAME "M04"        OF oSection1             SIZE  30    

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
Local cPerg		:= "QMR110"  
Local lImp      := .T.  
Local cDados    := " "  
Local nCntFor   := 0   
Local aMeses    := { STR0023, STR0024, STR0025, STR0026, STR0027, STR0028, STR0029, STR0030, STR0031, STR0032, STR0033, STR0034 }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros :                                                           ³
//³ MV_PAR01 : Instrumento de                                              ³
//³ MV_PAR02 : Instrumento ate                                             ³
//³ MV_PAR03 : Periodo Inicial                                             ³
//³ MV_PAR04 : Periodo Final                                               ³
//³ MV_PAR05 : Depto Inicial                                               ³
//³ MV_PAR06 : Depto Final                                                 ³
//³ MV_PAR07 : Orgao Calibrador -> Todos/Externo/Interno                   ³
//³ MV_PAR08 : Orgao Calibrador Interno de ?                               ³
//³ MV_PAR09 : Orgao Calibrador Interno ate?                               ³
//³ MV_PAR10 : Orgao Calibrador Externo de ?                               ³
//³ MV_PAR11 : Orgao Calibrador Externo ate?                               ³
//³ MV_PAR12 : Familia de ?                                                ³
//³ MV_PAR13 : Familia ate?                                                ³
//³ MV_PAR14 : Fabricante de?                                              ³
//³ MV_PAR15 : Fabricante ate?                                             ³
//³ MV_PAR16 : Usuario de ?                                                ³
//³ MV_PAR17 : Usuario ate?                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)           

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
		cChave := "% QM2_FILIAL, QM2_TIPO, QM2_INSTR, QM2_REVINV, QM2_DEPTO %"
	Case oSection1:GetOrder() == 2
		cChave := "% QM2_FILIAL, QM2_TIPO, QM2_DEPTO, QM2_INSTR,  QM2_REVINV %"
	Case oSection1:GetOrder() == 3
		cChave := "% QM2_FILIAL, QM2_DEPTO, QM2_INSTR, QM2_REVINV, QM2_TIPO %"
EndCase


BeginSql Alias cAliasQM2

SELECT QM2.QM2_DEPTO, QM2.QM2_RESP,  QM2.QM2_TIPO,  QM2.QM2_FABR,  QM2.QM2_STATUS,  QM2.QM2_SGUARD,  QM2.QM2_LAUDO,
       QM2.QM2_FREREP, QM2.QM2_FREQAF, QM2.QM2_VALREP, QM2.QM2_VALDAF, QM2.QM2_FLAG, QM2.QM2_INSTR, QM2.QM2_REVINS,
       QM2.QM2_FILIAL
 	FROM %table:QM2% QM2 	
	WHERE QM2.QM2_FILIAL = %xFilial:QM2% AND 
		  QM2.QM2_INSTR BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
	      QM2.QM2_DEPTO BETWEEN %Exp:mv_par05% AND %Exp:mv_par06% AND         
	      QM2.QM2_TIPO  BETWEEN %Exp:mv_par12% AND %Exp:mv_par13% AND
	      QM2.QM2_FABR  BETWEEN %Exp:mv_par14% AND %Exp:mv_par15% AND
	      QM2.QM2_RESP  BETWEEN %Exp:mv_par16% AND %Exp:mv_par17% AND 
	      QM2.%notDel%  		 
	ORDER BY %Exp:cChave%  
 			
EndSql   
oSection1:EndQuery() 

oSection1:Init()

While !(cAliasQM2)->(Eof())
	lImp := U_MTR110_CON()
    If lImp
		nCntFor := Len(aMov2)

	    cDados := " "
		If !Empty(aMov2[nCntFor][01])
			cDados := aMov2[nCntFor][01]
		Endif
		If 	!Empty(aMov2[nCntFor][02])
			If !aMov2[nCntFor][02] == "00"
				cDados += " "+aMov2[nCntFor][02]
			Else 
				cDados += "   "					
			Endif
		Endif
		If 	!Empty(aMov2[nCntFor][03])
			cDados += " "+aMov2[nCntFor][03]
		Endif
		If 	!Empty(aMov2[nCntFor][04])
			cDados += " "+aMov2[nCntFor][04]
		Endif                      
		
		oSection1:Cell("M01"):cTitle += PadC ( aMeses[MONTH(MV_PAR03)]+"/"+Str(Year(MV_PAR03),4), 30, "_") + CRLF + STR0035
		oSection1:Cell("M01"):SetValue(cDados)		
		
		cDados := " "
		//Impressao do Segundo Mes
		If !Empty(aMov2[nCntFor][05])
			cDados := aMov2[nCntFor][05]
		Endif
		If 	!Empty(aMov2[nCntFor][06])
			If !aMov2[nCntFor][06] == "00"
				cDados += " "+aMov2[nCntFor][06]
			Else 
				cDados += "   "					
			Endif
		Endif
		If !Empty(aMov2[nCntFor][07])
			cDados += " "+aMov2[nCntFor][07]
		Endif
		If !Empty(aMov2[nCntFor][08])
			cDados += " "+aMov2[nCntFor][08]
		Endif   
		oSection1:Cell("M02"):cTitle += PADC(aMeses[MONTH(AddMes(MV_PAR03,1))]+"/"+Str(Year(AddMes(MV_PAR03,1)),4), 30, "_")  + CRLF + STR0035
		oSection1:Cell("M02"):SetValue(cDados)
		
		cDados := " "
		//Impressao do Terceiro Mes		
		If !Empty(aMov2[nCntFor][09])
			cDados := aMov2[nCntFor][09]
		Endif
		If !Empty(aMov2[nCntFor][10])
			If !aMov2[nCntFor][10] == "00"
				cDados += " "+aMov2[nCntFor][10]
			Else 
				cDados += "   "					
			Endif
		Endif
		If !Empty(aMov2[nCntFor][11])
			cDados += " "+aMov2[nCntFor][11]
		Endif
		If !Empty(aMov2[nCntFor][12])
			cDados += " "+aMov2[nCntFor][12]
		Endif     
		oSection1:Cell("M03"):cTitle +=  PADC(aMeses[MONTH(AddMes(MV_PAR03,2))]+"/"+Str(Year(AddMes(MV_PAR03,2)),4), 30, "_") + CRLF + STR0035
		oSection1:Cell("M03"):SetValue(cDados)
				
		cDados := " "
		//Impressao do Quarto Mes
		If !Empty(aMov2[nCntFor][13])
			cDados := aMov2[nCntFor][13]
		Endif
		If !Empty(aMov2[nCntFor][14])   
			If !aMov2[nCntFor][14] == "00"
				cDados += " "+aMov2[nCntFor][14]
			Else 
				cDados += "   "					
			Endif
		Endif
		If !Empty(aMov2[nCntFor][15])
			cDados += " "+aMov2[nCntFor][15]
		Endif
		If !Empty(aMov2[nCntFor][16])
			cDados += " "+aMov2[nCntFor][16]
		Endif         
		oSection1:Cell("M04"):cTitle +=  PADC(aMeses[MONTH(AddMes(MV_PAR03,3))]+"/"+Str(Year(AddMes(MV_PAR03,3)),4), 30, "_") + CRLF + STR0035
		oSection1:Cell("M04"):SetValue(cDados)

		oSection1:PrintLine()	
	Else
		oSection1:Cell("M01"):SetValue(" ")
		oSection1:Cell("M02"):SetValue(" ")
		oSection1:Cell("M03"):SetValue(" ")
		oSection1:Cell("M04"):SetValue(" ")	
	EndIf
	&(cAliasQM2)->(DbSkip())	
EndDo  
oSection1:Finish()
	
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³MTR110_CON³ Autor ³ Cicero Cruz			³ Data ³ 12.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Condicao de impressão da Linha                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR110_CON(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR110           										  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MTR110_CON()
Local lRet 		:= .T.
Local nMes 		:= 0
Local nMov2 	:= 0
Local nCont 	:= 0
Local nCntFor 	:= 0

If !Empty(cInstrAnt) 
	If cInstrAnt == &(cAliasQM2+"->QM2_FILIAL")+&(cAliasQM2+"->QM2_INSTR")+&(cAliasQM2+"->QM2_REVINS")
		lRet := .F.
	Else		   
		cInstrAnt := &(cAliasQM2+"->QM2_FILIAL")+&(cAliasQM2+"->QM2_INSTR")+&(cAliasQM2+"->QM2_REVINS")
	EndIf
EndIf
cInstrAnt := &(cAliasQM2+"->QM2_FILIAL")+&(cAliasQM2+"->QM2_INSTR")+&(cAliasQM2+"->QM2_REVINS")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se status do instrumento esta com atualiza ativo       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !QMTXSTAT(&(cAliasQM2+"->QM2_STATUS")) .AND. 	lRet  
	lRet := .F.
EndIf

If lRet
    
	aMov := {}
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona Registros                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QM1")
	dbSetOrder(1)
	dbSeek(xFilial("QM1")+&(cAliasQM2+"->QM2_TIPO"),.F.)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica os Orgaos Calibradores do Instrumento                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QMK")
	dbSetOrder(1)
	dbSeek(xFilial("QMK")+&(cAliasQM2+"->QM2_TIPO"),.F.) 

	lRet := .F.
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as Movimentacoes dos Instrumentos                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QML")
	dbSetOrder(2)
	dbSeek(xFilial("QML")+&(cAliasQM2+"->QM2_INSTR")+&(cAliasQM2+"->QM2_REVINS")+Dtos(MV_PAR03),.T.)
	While ( !Eof() .And. xFilial("QML")==QML_FILIAL .And.;
		QML->QML_DTRET <= MV_PAR04 .And.;
		QML->QML_INSTR == &(cAliasQM2+"->QM2_INSTR") .And.;
		QML->QML_REVINS == &(cAliasQM2+"->QM2_REVINS") )
		If Year(MV_PAR03) == Year(QML->QML_DTRET)
			nMes := Month(QML->QML_DTRET)+Year(QML->QML_DTRET)-Month(MV_PAR03)-Year(MV_PAR03)+1
		Else
			If Month(QML->QML_DTRET) == 1     .and. Month(MV_PAR03) == 10
				nMes := 4
			ElseIf Month(QML->QML_DTRET) == 2 .and. Month(MV_PAR03) == 11
				nMes := 4
			ElseIf Month(QML->QML_DTRET) == 1 .and. Month(MV_PAR03) == 11
				nMes := 3
			ElseIf Month(QML->QML_DTRET) == 3 .and. Month(MV_PAR03) == 12
				nMes := 4
			ElseIf Month(QML->QML_DTRET) == 2 .and. Month(MV_PAR03) == 12
				nMes := 3
			ElseIf Month(QML->QML_DTRET) == 1 .and. Month(MV_PAR03) == 12
				nMes := 2
			Else
				nMes := 5
			Endif
		Endif
		If ( nMes <= 4 )
			aadd(aMov,{nMes,Ctod("  /  /  ","DDMMYY"),Ctod("  /  /  ","DDMMYY"),QML->QML_DTRET,QML->QML_DTCOL})
			lRet := .T.
		EndIf     
		dbSelectArea("QML")
		dbSkip()
	EndDo


	dbSelectArea("QM9")
	dbSetOrder(1)
	dbSeek(xFilial("QM9")+QMK->QMK_ESCALA,.F.)
	
	If ( MV_PAR07!=1 .AND. lRet ) //Todos
		
		If ( MV_PAR07 == 2 .AND.; // Externo
    		( QM9->QM9_ORGAFE=="E" .And.; 
 		         ( QM9->QM9_LABOR < MV_PAR10 .OR.;
			        QM9->QM9_LABOR > MV_PAR11 ) ) )
			
			lRet := .F.
					
		Elseif ( MV_PAR07 == 3 .AND.; // Interno
		         ( QM9->QM9_ORGAFE=="I" .And.;
			       (QM9->QM9_DEPTO < MV_PAR08 .OR.;
			        QM9->QM9_DEPTO > MV_PAR09) ) ) 
			
			lRet := .F.	 
				
		EndIf
			
	ElseIf (( QM9->QM9_ORGAFE=="I" .And.;
			(QM9->QM9_DEPTO < MV_PAR08 .OR.;
			QM9->QM9_DEPTO > MV_PAR09) ) .Or. ;
		 (	QM9->QM9_ORGAFE=="E" .And.;
			(QM9->QM9_LABOR < MV_PAR10 .And. ;
			QM9->QM9_LABOR > MV_PAR11) )) .AND. lRet
		
		lRet := .F.
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as Calibracoes dos Instrumentos (somente se apresentar movimentacao .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QM6")
	dbSetOrder(1)
	dbSeek(xFilial("QM6")+&(cAliasQM2+"->QM2_INSTR")+&(cAliasQM2+"->QM2_REVINS")+Dtos(MV_PAR03),.T.)
	While ( !Eof() .And. xFilial("QM6") == QM6->QM6_FILIAL .And.;
		&(cAliasQM2+"->QM2_INSTR") == QM6->QM6_INSTR  .And.;
		&(cAliasQM2+"->QM2_REVINS") == QM6->QM6_REVINS .And.;
		QM6->QM6_DATA <= MV_PAR04)
		If Year(MV_PAR03) == Year(QM6->QM6_DATA)
			nMes := Month(QM6->QM6_DATA)+Year(QM6->QM6_DATA)-Month(MV_PAR03)-Year(MV_PAR03)+1
		Else
			If Month(QM6->QM6_DATA) == 1     .and. Month(MV_PAR03) == 10
				nMes := 4
			ElseIf Month(QM6->QM6_DATA) == 2 .and. Month(MV_PAR03) == 11
				nMes := 4
			ElseIf Month(QM6->QM6_DATA) == 1 .and. Month(MV_PAR03) == 11
				nMes := 3
			ElseIf Month(QM6->QM6_DATA) == 3 .and. Month(MV_PAR03) == 12
				nMes := 4
			ElseIf Month(QM6->QM6_DATA) == 2 .and. Month(MV_PAR03) == 12
				nMes := 3
			ElseIf Month(QM6->QM6_DATA) == 1 .and. Month(MV_PAR03) == 12
				nMes := 2
			Else
				nMes := 5
			Endif
		Endif
		If ( nMes <= 4 )
			nCont := 0
			For nCntFor := 1 To Len(aMov)
				If aMov[nCntFor,1]==nMes .And. aMov[nCntFor,3]<=QM6->QM6_DATA
					nCont++
					aMov[nCntFor,2] := QM6->QM6_DTPREV
					aMov[nCntFor,3] := QM6->QM6_DATA
				EndIf
			Next nCntFor
			If ( nCont == 0 )
				aadd(aMov,{nMes,QM6->QM6_DTPREV,QM6->QM6_DATA,Ctod("  /  /  ","DDMMYY"),Ctod("  /  /  ","DDMMYY")})
			EndIf
		EndIf
		dbSelectArea("QM6")
		dbSkip()
	EndDo  
	If ( Len(aMov) > 0 )
		aMov := aSort(aMov,,,{|x,y| x[1]<y[1]})  
	Else
		lRet := .F.
	EndIf
	For nCntFor := 1 To Len(aMov)
		Do Case
			Case ( aMov[nCntFor][1] == 1 )
				aadd(aMov2,Afill(Array(16),""))
				nMov2 := Len(aMov2)
				aMov2[nMov2][1] := Dtoc(aMov[nCntFor][2])
				aMov2[nMov2][2] := StrZero(Day(aMov[nCntFor][3]),2)
				aMov2[nMov2][3] := SubStr(Dtoc(aMov[nCntFor][4]),1,5)
				If mv_par18 == 1
					aMov2[nMov2][4] := Dtoc(aMov[nCntFor][5])
				Else
					If aMov[nCntFor][5] <= dDataBase
						aMov2[nMov2][4] := Dtoc(aMov[nCntFor][5])
					Endif
				Endif
			Case ( aMov[nCntFor][1] == 2 )
				nMov2 := Len(aMov2)
				If ( nMov2 == 0 )
					aadd(aMov2,Afill(Array(16),""))
					nMov2 := Len(aMov2)
				EndIf
				aMov2[nMov2][5] := Dtoc(aMov[nCntFor][2])
				aMov2[nMov2][6] := StrZero(Day(aMov[nCntFor][3]),2)
				aMov2[nMov2][7] := SubStr(Dtoc(aMov[nCntFor][4]),1,5)
				If mv_par18 == 1
					aMov2[nMov2][8] := Dtoc(aMov[nCntFor][5])
				Else
					If aMov[nCntFor][5] <= dDataBase
						aMov2[nMov2][8] := Dtoc(aMov[nCntFor][5])
					Endif
				Endif
			Case ( aMov[nCntFor][1] == 3 )
				nMov2 := Len(aMov2)
				If ( nMov2 == 0 )
					aadd(aMov2,Afill(Array(16),""))
					nMov2 := Len(aMov2)
				EndIf
				aMov2[nMov2][09] := Dtoc(aMov[nCntFor][2])
				aMov2[nMov2][10] := StrZero(Day(aMov[nCntFor][3]),2)
				aMov2[nMov2][11] := SubStr(Dtoc(aMov[nCntFor][4]),1,5)
				If mv_par18 == 1
					aMov2[nMov2][12] := Dtoc(aMov[nCntFor][5])
				Else
					If aMov[nCntFor][5] <= dDataBase
						aMov2[nMov2][12] := Dtoc(aMov[nCntFor][5])
					Endif
				Endif
			Case ( aMov[nCntFor][1] == 4 )
				nMov2 := Len(aMov2)
				If ( nMov2 == 0 )
					aadd(aMov2,Afill(Array(16),""))
					nMov2 := Len(aMov2)
				EndIf
				aMov2[nMov2][13] := Dtoc(aMov[nCntFor][2])
				aMov2[nMov2][14] := StrZero(Day(aMov[nCntFor][3]),2)
				aMov2[nMov2][15] := SubStr(Dtoc(aMov[nCntFor][4]),1,5)
				If mv_par18 == 1
					aMov2[nMov2][16] := Dtoc(aMov[nCntFor][5])
				Else
					If aMov[nCntFor][5] <= dDataBase
						aMov2[nMov2][16] := Dtoc(aMov[nCntFor][5])
					Endif
				Endif
		EndCase
	Next nCntFor	    
EndIf
Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³QMTR110R3 ³ Autor ³ Eduardo Riera         ³ Data ³ 02.07.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Plano de Localizacao de Instrumentos.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³	MOTIVO DA ALTERACAO					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Denis Martins ³04/12/00³Verif.³Correcao na impressao do cabecalho(Esta-³±±
±±³              ³        ³      ³va imprimindo duas vezes os meses.)     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

/*/

User Function QMTR110R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local Titulo  := OemToAnsi(STR0001) //"Plano de Localizacao"  
Local cDesc1  := OemToAnsi(STR0002) //"Este programa emite a movimentacao" 
Local cDesc2  := OemToAnsi(STR0003) //"dos instrumentos para afericao"  
Local cDesc3  := OemToAnsi(STR0004) //"conforme os parametros solicitados." 

Local cString := "QM2"  // Alias utilizado na Filtragem
Local lDic    := .F. // Habilita/Desabilita Dicionario
Local lComp   := .F. // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro := .T. // Habilita/Desabilita o Filtro
Local wnrel   := "QMTR110"  // Nome do Arquivo utilizado no Spool
Local nomeprog:= "QMTR110"  // nome do programa

Private Tamanho := "G" // P/M/G
Private Limite  := 220 // 80/132/220
Private aOrdem  := {	STR0005,; //"Familia/Instrumento"
							STR0006,;	//"Familia/Depto"
							STR0007}  //"Depto/Instrumento"
								// Ordem do Relatorio
Private cPerg   := "QMR110"  // Pergunta do Relatorio
Private aReturn := { STR0008, 1,STR0009, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
						// [1] Reservado para Formulario
						// [2] Reservado para N§ de Vias
						//	[3] Destinatario
						//	[4] Formato => 1-Comprimido 2-Normal
						// [5] Midia   => 1-Disco 2-Impressora
						//	[6] Porta ou Arquivo 1-LPT1... 4-COM1...
						//	[7] Expressao do Filtro
						//	[8] Ordem a ser selecionada
						//	[9]..[10]..[n] Campos a Processar (se houver)
Private lEnd    := .F.
Private m_pag   := 1 // Contador de Paginas
Private nLastKey:= 0 // Controla o cancelamento da SetPrint e SetDefault

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros :                                                           ³
//³ MV_PAR01 : Instrumento de                                              ³
//³ MV_PAR02 : Instrumento ate                                             ³
//³ MV_PAR03 : Periodo Inicial                                             ³
//³ MV_PAR04 : Periodo Final                                               ³
//³ MV_PAR05 : Depto Inicial                                               ³
//³ MV_PAR06 : Depto Final                                                 ³
//³ MV_PAR07 : Orgao Calibrador -> Todos/Externo/Interno                   ³
//³ MV_PAR08 : Orgao Calibrador Interno de ?                               ³
//³ MV_PAR09 : Orgao Calibrador Interno ate?                               ³
//³ MV_PAR10 : Orgao Calibrador Externo de ?                               ³
//³ MV_PAR11 : Orgao Calibrador Externo ate?                               ³
//³ MV_PAR12 : Familia de ?                                                ³
//³ MV_PAR13 : Familia ate?                                                ³
//³ MV_PAR14 : Fabricante de?                                              ³
//³ MV_PAR15 : Fabricante ate?                                             ³
//³ MV_PAR16 : Usuario de ?                                                ³
//³ MV_PAR17 : Usuario ate?                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
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

If nLastKey==27 
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
Endif

RptStatus({|lEnd| A110Imp(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ a110Imp  ³ Autor ³ Eduardo Riera         ³ Data ³02.07.1998³±±
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

Static Function A110Imp(lEnd,wnrel,cString,nomeprog,Titulo)

Local li      := 100 // Contador de Linhas
Local lImp    := .F. // Indica se algo foi impresso
Local cbCont  := 0   // Numero de Registros Processados
Local cbText  := ""  // Mensagem do Rodape
Local cSeek	  := ""  // Inicio
Local aOrgao	:= {}  // Orgao Calibrador
Local aMov		:= {}// Movimentacao
Local aMov2
Local nMov2
Local aMeses[4]    	// Meses
Local nCntFor := 0   // Contador
Local nMes    := 0
Local nCont   := 0
Local cCabec1 := ""
Local cCabec2 := ""
Local lImpQm2 := .F.
Local cInstr  := ""
Local nContador := 0
Local nIndex
Local cQuery := ""
Local TRB_FILIAL
Local TRB_INSTR	
Local TRB_REVINS
Local TRB_REVINV
Local TRB_STATUS
Local TRB_FABR	
Local TRB_RESP 	
Local TRB_FREQAF
Local TRB_SGUARD
Local TRB_TIPO	
Local TRB_DEPTO

Private lAbortPrint := .F.
Private cIndex := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Preenche a Matriz Meses conforme o MV_PAR03                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCntFor := Month(MV_PAR03) To Month(MV_PAR03)+3
    If nCntFor <= 12 
	   aMeses[nCntFor-Month(MV_PAR03)+1] := PadC(MesExtenso(nCntFor)+"/"+StrZero(Year(MV_PAR03),4),32)
	Else
	   nContador++
	   aMeses[nCntFor-Month(MV_PAR03)+1] := PadC(MesExtenso(nContador)+"/"+StrZero(Year(MV_PAR03)+1,4),32)
	Endif   
Next nCntFor

cCabec1 := OemToAnsi(STR0010)
cCabec1 += aMeses[1]+aMeses[2]+aMeses[3]+aMeses[4]
cCabec2 := STR0011	
//           1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//"Tipo             Instrumento          Depto     	   Resp.      Dias Fabricante       SG | Previsao  R. Retir  Devolucao| Previsao  R. Retir  Devolucao| Previsao  R. Retir  Devolucao| Previsao  R. Retir  Devolucao"
// XXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXX-XX  XXXXXXXXXXXXX XXXXXXXXXX 9999 XXXXXXXXXXXXXXXX XXX|99/99/9999 99 99/99 99/99/9999|99/99/9999 99 99/99 99/99/9999|99/99/9999 99 99/99 99/99/9999|99/99/9999 99 99/99 99/99/9999
// 1234567890123456 1234567890123456-XX  1234567890123 1234567890 1234 1234567890123456 	

dbSelectArea(cString)

cQuery := "SELECT QM2_FILIAL,QM2_INSTR,QM2_REVINS,QM2_TIPO,QM2_DEPTO,QM2_STATUS,"
cQuery += "QM2_FABR,QM2_REVINV,QM2_RESP,QM2_FREQAF,QM2_SGUARD "
cQuery += "FROM "+RetSqlName("QM2")+" QM2 "
cQuery += "WHERE "
cQuery += "QM2.QM2_FILIAL = '"			+xFilial("QM2")+	"' AND "
cQuery += "QM2.QM2_INSTR  BetWeen '"	+ mv_par01 +		"' AND '" + mv_par02 +			"' AND " 
cQuery += "QM2.QM2_DEPTO BetWeen '"		+ mv_par05 +		"' AND '" + mv_par06 + 			"' AND " 
cQuery += "QM2.QM2_TIPO BetWeen '"		+ mv_par12 +		"' AND '" + mv_par13 + 			"' AND " 
cQuery += "QM2.QM2_FABR BetWeen '"		+ mv_par14 +		"' AND '" + mv_par15 + 			"' AND " 
cQuery += "QM2.QM2_RESP BetWeen '"		+ mv_par16 +		"' AND '" + mv_par17 + 			"' AND " 
cQuery += "QM2.D_E_L_E_T_= ' ' "
  	    Do Case
	Case ( aReturn[8] == 1) // Familia/Instrumento/Departamento
		cSeek := "QM2_FILIAL+QM2_TIPO+QM2_INSTR+QM2_DEPTO" 
	Case ( aReturn[8] == 2)	// Familia/Departamento/Instrumento
		cSeek := "QM2_FILIAL+QM2_TIPO+QM2_DEPTO+QM2_INSTR" 
	Case ( aReturn[8] == 3)	// Departamento/Instrumento/
		cSeek := "QM2_FILIAL+QM2_DEPTO+QM2_INSTR"
EndCase
cQuery += "ORDER BY " + SqlOrder(cSeek)
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
dbSelectArea( "TRB" )

SetRegua(LastRec())

While !Eof()

	TRB_FILIAL	:= TRB->QM2_FILIAL
	TRB_INSTR	:= TRB->QM2_INSTR
	TRB_REVINS	:= TRB->QM2_REVINS
	TRB_REVINV	:= TRB->QM2_REVINV
	TRB_STATUS	:= TRB->QM2_STATUS
	TRB_FABR	:= TRB->QM2_FABR
	TRB_RESP 	:= TRB->QM2_RESP
	TRB_FREQAF	:= TRB->QM2_FREQAF
	TRB_SGUARD	:= TRB->QM2_SGUARD
	TRB_TIPO	:= TRB->QM2_TIPO
	TRB_DEPTO	:= TRB->QM2_DEPTO

   IncRegua()
	
	If lAbortPrint
	   li = li + 1
      @ li,001 PSAY STR0012 //"CANCELADO PELO OPERADOR"
      Exit
   EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pula as revisoes anteriores do mesmo instrumento             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While cInstr==TRB_FILIAL + TRB_INSTR + TRB_REVINS
		dbSkip()
		
		TRB_FILIAL := TRB->QM2_FILIAL
		TRB_INSTR  := TRB->QM2_INSTR
		
		Loop                 
	EndDo
   cInstr :=TRB_FILIAL+TRB_INSTR+TRB_REVINS 

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica se status do instrumento esta com atualiza ativo       ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If !QMTXSTAT(TRB_STATUS)       
      dbskip()
      loop
   EndIf
	
	lImp 		:= .T.
	aOrgao	:= {}
	aMov 		:= {}
	lImpQm2  := .F.
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona Registros                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QM1")
	dbSetOrder(1)
	dbSeek(xFilial("QM1")+TRB_TIPO,.F.)
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica os Orgaos Calibradores do Instrumento                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QMK")
	dbSetOrder(1)
	dbSeek(xFilial("QMK")+TRB_TIPO,.F.)
	
	While ( !Eof() .And. xFilial("QMK")==QMK->QMK_FILIAL .And.;
				TRB_TIPO == QMK->QMK_TIPO .And.;
				TRB_REVINV == QMK->QMK_REVINV )
				
			dbSelectArea("QM9")
			dbSetOrder(1)
			dbSeek(xFilial("QM9")+QMK->QMK_ESCALA,.F.)
			If (( QM9->QM9_ORGAFE=="I" .And.;
					QM9->QM9_DEPTO >= MV_PAR08 .And.;
					QM9->QM9_DEPTO <= MV_PAR09 ) .Or. ;
				 (	QM9->QM9_ORGAFE=="E" .And.;
					QM9->QM9_LABOR >= MV_PAR10 .And. ;
					QM9->QM9_LABOR <= MV_PAR11 ))
				If ( QM9->QM9_ORGAFE=="I" .And. ( MV_PAR07!=2 ))
					aadd( aOrgao , QM9->QM9_DEPTO )
				Else
					If ( MV_PAR07!=3 )
						aadd( aOrgao , QM9->QM9_LABOR )
					EndIf				
				EndIf
			EndIf
			dbSelectArea("QMK")
			dbSkip()						
		EndDo
		If ( Empty(aOrgao) )
			aadd(aOrgao,"")
		EndIf
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica as Movimentacoes dos Instrumentos                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("QML")
		dbSetOrder(2)
		dbSeek(xFilial("QML")+TRB_INSTR+TRB_REVINS+Dtos(MV_PAR03),.T.)
		While ( !Eof() .And. xFilial("QML")==QML_FILIAL .And.;
					QML->QML_DTRET <= MV_PAR04 .And.;
					QML->QML_INSTR == TRB_INSTR .And.;
					QML->QML_REVINS == TRB_REVINS )
            If Year(MV_PAR03) == Year(QML->QML_DTRET)
		       nMes := Month(QML->QML_DTRET)+Year(QML->QML_DTRET)-Month(MV_PAR03)-Year(MV_PAR03)+1
		    Else
		       If Month(QML->QML_DTRET) == 1     .and. Month(MV_PAR03) == 10
		          nMes := 4
		       ElseIf Month(QML->QML_DTRET) == 2 .and. Month(MV_PAR03) == 11
		          nMes := 4
		       ElseIf Month(QML->QML_DTRET) == 1 .and. Month(MV_PAR03) == 11
		          nMes := 3
		       ElseIf Month(QML->QML_DTRET) == 3 .and. Month(MV_PAR03) == 12
		          nMes := 4
		       ElseIf Month(QML->QML_DTRET) == 2 .and. Month(MV_PAR03) == 12
		          nMes := 3
		       ElseIf Month(QML->QML_DTRET) == 1 .and. Month(MV_PAR03) == 12   
		          nMes := 2
		       Else 
		          nMes := 5   
		       Endif   
			Endif
		    If ( nMes <= 4 )
				aadd(aMov,{nMes,Ctod("  /  /  ","DDMMYY"),Ctod("  /  /  ","DDMMYY"),QML->QML_DTRET,QML->QML_DTCOL})
				lImpQm2 := .T.
			EndIf			
			dbSelectArea("QML")
			dbSkip()
		EndDo
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica as Calibracoes dos Instrumentos.                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("QM6")
		dbSetOrder(1)
		dbSeek(xFilial("QM6")+TRB_INSTR+TRB_REVINS+Dtos(MV_PAR03),.T.)
		While ( !Eof() .And. xFilial("QM6")==QM6->QM6_FILIAL .And.;
								TRB_INSTR==QM6->QM6_INSTR  .And.;
								TRB_REVINS==QM6->QM6_REVINS .And.;
								QM6->QM6_DATA <= MV_PAR04)
			If Year(MV_PAR03) == Year(QM6->QM6_DATA)
		       nMes := Month(QM6->QM6_DATA)+Year(QM6->QM6_DATA)-Month(MV_PAR03)-Year(MV_PAR03)+1
		    Else
		       If Month(QM6->QM6_DATA) == 1     .and. Month(MV_PAR03) == 10
		          nMes := 4
		       ElseIf Month(QM6->QM6_DATA) == 2 .and. Month(MV_PAR03) == 11
		          nMes := 4
		       ElseIf Month(QM6->QM6_DATA) == 1 .and. Month(MV_PAR03) == 11
		          nMes := 3
		       ElseIf Month(QM6->QM6_DATA) == 3 .and. Month(MV_PAR03) == 12
		          nMes := 4
		       ElseIf Month(QM6->QM6_DATA) == 2 .and. Month(MV_PAR03) == 12
		          nMes := 3
		       ElseIf Month(QM6->QM6_DATA) == 1 .and. Month(MV_PAR03) == 12   
		          nMes := 2
		       Else 
		          nMes := 5   
		       Endif   
			Endif
			If ( nMes <= 4 )
				nCont := 0
				For nCntFor := 1 To Len(aMov)
					If aMov[nCntFor,1]==nMes .And. aMov[nCntFor,3]<=QM6->QM6_DATA
						nCont++
						aMov[nCntFor,2] := QM6->QM6_DTPREV
						aMov[nCntFor,3] := QM6->QM6_DATA
					EndIf
				Next nCntFor
				If ( nCont == 0 )
					aadd(aMov,{nMes,QM6->QM6_DTPREV,QM6->QM6_DATA,Ctod("  /  /  ","DDMMYY"),Ctod("  /  /  ","DDMMYY")})
				EndIf
			EndIf			
			dbSelectArea("QM6")
			dbSkip()							
		EndDo
                          
        If Len(aMov) > 0
		   If ( li > 60 ) .and. lImpQm2
			  li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,15)
			  li++
		   Endif

		   If ( lImpQm2 )
			@ Li,000 PSAY TRB_TIPO
			@ Li,017 PSAY Alltrim(TRB_INSTR)+"-"+TRB_REVINS
			@ Li,038 PSAY TRB_DEPTO
			@ Li,052 PSAY TRB_RESP
			@ Li,063 PSAY TRB_FREQAF			PICTURE "@9999"
			@ Li,068 PSAY SubStr(TRB_FABR,1,15)
//			@ Li,084 PSAY aOrgao[1]
			@ Li,085 PSAY TRB_SGUARD
			  If ( Len(aMov) > 0 )
				aMov := aSort(aMov,,,{|x,y| x[1]<y[1]})
			  EndIf
			  aMov2 := {}
			  For nCntFor := 1 To Len(aMov)
				Do Case
					Case ( aMov[nCntFor][1] == 1 )
						aadd(aMov2,Afill(Array(16),""))
						nMov2 := Len(aMov2)
						aMov2[nMov2][1] := Dtoc(aMov[nCntFor][2])
						aMov2[nMov2][2] := StrZero(Day(aMov[nCntFor][3]),2)
						aMov2[nMov2][3] := SubStr(Dtoc(aMov[nCntFor][4]),1,5)
						If mv_par18 == 1
							aMov2[nMov2][4] := Dtoc(aMov[nCntFor][5])
						Else
							If aMov[nCntFor][5] <= dDataBase
								aMov2[nMov2][4] := Dtoc(aMov[nCntFor][5])
							Endif
						Endif	
					Case ( aMov[nCntFor][1] == 2 )
						nMov2 := aScan(aMov2,{|x| Empty(x[5]+x[6]+x[7]+x[8])})
						If ( nMov2 == 0 )
							aadd(aMov2,Afill(Array(16),""))
							nMov2 := Len(aMov2)
						EndIf
						aMov2[nMov2][5] := Dtoc(aMov[nCntFor][2])
						aMov2[nMov2][6] := StrZero(Day(aMov[nCntFor][3]),2)
						aMov2[nMov2][7] := SubStr(Dtoc(aMov[nCntFor][4]),1,5)
						If mv_par18 == 1
							aMov2[nMov2][8] := Dtoc(aMov[nCntFor][5])
						Else
							If aMov[nCntFor][5] <= dDataBase
								aMov2[nMov2][8] := Dtoc(aMov[nCntFor][5])
							Endif	
						Endif
					Case ( aMov[nCntFor][1] == 3 )
						nMov2 := aScan(aMov2,{|x| Empty(x[9]+x[10]+x[11]+x[12])})
						If ( nMov2 == 0 )
							aadd(aMov2,Afill(Array(16),""))
							nMov2 := Len(aMov2)
						EndIf
						aMov2[nMov2][09] := Dtoc(aMov[nCntFor][2])
						aMov2[nMov2][10] := StrZero(Day(aMov[nCntFor][3]),2)
						aMov2[nMov2][11] := SubStr(Dtoc(aMov[nCntFor][4]),1,5)
						If mv_par18 == 1
							aMov2[nMov2][12] := Dtoc(aMov[nCntFor][5])
						Else
							If aMov[nCntFor][5] <= dDataBase
								aMov2[nMov2][12] := Dtoc(aMov[nCntFor][5])
							Endif	
						Endif
					Case ( aMov[nCntFor][1] == 4 )
						nMov2 := aScan(aMov2,{|x| Empty(x[13]+x[14]+x[15]+x[16])})
						If ( nMov2 == 0 )
							aadd(aMov2,Afill(Array(16),""))
							nMov2 := Len(aMov2)
						EndIf
						aMov2[nMov2][13] := Dtoc(aMov[nCntFor][2])
						aMov2[nMov2][14] := StrZero(Day(aMov[nCntFor][3]),2)
						aMov2[nMov2][15] := SubStr(Dtoc(aMov[nCntFor][4]),1,5)
						If mv_par18 == 1
							aMov2[nMov2][16] := Dtoc(aMov[nCntFor][5])
						Else
							If aMov[nCntFor][5] <= dDataBase
								aMov2[nMov2][16] := Dtoc(aMov[nCntFor][5])
							Endif	
						Endif	
				  EndCase
				  For nCont := 1 To Len(aMov2[nMov2])
					If (Empty(aMov2[nMov2,nCont])) .Or.;
						 aMov2[nMov2,nCont]==Dtoc(Ctod("  /  /  ","DDMMYY")) .Or.;
						 aMov2[nMov2,nCont]=="00"
						aMov2[nMov2,nCont] := ""
					Endif
				  Next nCont 
			  Next nCntFor
			  For nCntFor := 1 To Len(aMov2)
				If !Empty(aMov2[nCntFor][01])
					@ Li,089 PSAY aMov2[nCntFor][01]
				Endif
				If 	!Empty(aMov2[nCntFor][02])
					@ Li,100 PSAY aMov2[nCntFor][02]
				Endif
				If 	!Empty(aMov2[nCntFor][03])
					@ Li,103 PSAY aMov2[nCntFor][03]
				Endif
				If 	!Empty(aMov2[nCntFor][04])
					@ Li,109 PSAY aMov2[nCntFor][04]
				Endif	
                //Impressao do Segundo Mes
				If !Empty(aMov2[nCntFor][05])
					@ Li,120 PSAY aMov2[nCntFor][05]
				Endif
				If 	!Empty(aMov2[nCntFor][06])
					@ Li,131 PSAY aMov2[nCntFor][06]
				Endif
				If !Empty(aMov2[nCntFor][07])
					@ Li,134 PSAY aMov2[nCntFor][07]
				Endif	
				If !Empty(aMov2[nCntFor][08])
					@ Li,140 PSAY aMov2[nCntFor][08]
				Endif	
				If !Empty(aMov2[nCntFor][09])
					@ Li,151 PSAY aMov2[nCntFor][09]
				Endif
				If !Empty(aMov2[nCntFor][10])
					@ Li,162 PSAY aMov2[nCntFor][10]
				Endif	
				If !Empty(aMov2[nCntFor][11])				
					@ Li,165 PSAY aMov2[nCntFor][11]
				Endif
				If !Empty(aMov2[nCntFor][12])				
					@ Li,171 PSAY aMov2[nCntFor][12]
				Endif	
                //Impressao do Terceiro Mes
				If !Empty(aMov2[nCntFor][13])								
					@ Li,182 PSAY aMov2[nCntFor][13]       
				Endif	
				If !Empty(aMov2[nCntFor][14])									
					@ Li,193 PSAY aMov2[nCntFor][14]       
				Endif	
				If !Empty(aMov2[nCntFor][15])									
					@ Li,196 PSAY aMov2[nCntFor][15]       
				Endif	
				If !Empty(aMov2[nCntFor][16])									
					@ Li,202 PSAY aMov2[nCntFor][16]
				Endif	
				Li ++
			  Next nCntFor
			  li++
			  cbCont++
		  EndIf
		Endif  
		dbSelectArea("TRB")
		dbSkip()	
EndDo
If Len(aMov) >= 1 
   If ( lImp )
	  Roda(cbCont,cbText,Tamanho)
   Endif	  
EndIf

Set Device To Screen

	dbSelectArea("TRB")
	dbCloseArea()
	dbSelectArea("QM2")

If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
EndIf

MS_FLUSH()
Return(.T.)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QMR110DiasºAutor  ³Denis Martins       º Data ³  10/17/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Calcula a data limite dos meses a serem impressos.          º±±
±±º          ³Maximo: 4 meses                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ X1_VALID - QMR110 (MV_PAR04)                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function QMR110Dias()
Local lRet := .T.
Local IsBissexto := .f.
Local dDataRet	 
Local dDataAux	 

If lRet
	lRet := NaoVazio()
Endif       

If lRet
	dDataAux := MV_PAR03+120
	IsBissexto := (Int(Year(dDataAux)/4) == (Year(dDataAux)/4))

	If IsBissexto 
		dDataRet := "29/"
	Else
		dDataRet := "28/"
	EndIf

	If SubStr(Str(Month(dDataAux)),14,18) $ " 1| 3| 5| 7| 8| 10| 12"
		If !IsBissexto
			dDataRet := "31/"
		Endif	
	ElseIf SubStr(Str(Month(dDataAux)),14,18) $ " 4| 6| 9| 11"
		If !IsBissexto
			dDataRet :=	"30/"
		Endif	
	Endif   	

	dDataRet += StrZero(Month(dDataAux),2) + "/"+StrZero(Year(dDataAux),4)

	dDataRet := CToD(dDataRet,"DDMMYY")

	If MV_PAR03 > MV_PAR04
		MV_PAR03 := MV_PAR04	
	Endif

	If MV_PAR04 > dDataRet .or. Empty(MV_PAR04)
		MessageDlg(OemToAnsi(STR0014)+Chr(13)+OemToAnsi(STR0015),,3)//"Nao e permitido data superior a 4 meses do periodo inicial. O sistema ira sugerir o periodo limite"
		MV_PAR04 := dDataRet
	Endif
Endif

Return lRet
