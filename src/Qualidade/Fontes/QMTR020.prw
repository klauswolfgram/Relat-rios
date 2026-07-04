/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QMTR020.CH"
#INCLUDE "PROTHEUS.CH"


#DEFINE STRCOLUNA_1 "|             |                                       "
#DEFINE STRCOLUNA_2 "|             |            |                      "
#DEFINE STRCOLUNA_4 "|        |         |        |         |           "
#DEFINE STRCOLUNA_5 "|             |                                  |"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ QMTR020	³ Autor ³ Alessandro B. Freire  ³ Data ³ 30.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ficha de Calibra‡„o										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_QMTR020(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Antonio     ³19/07/99³22057 ³ Parametro de, ate para Status.           ³±±
±±³Antonio     ³30/01/00³      ³ Rodap‚ de data/hora por instrumento.     ³±±
±±³Antonio     ³02/02/00³      ³ Ajuste de lRodaImp e inclusÆo de cChvQMK.³±± 
±±³Denis M.    ³13/12/00³      ³ Inclusao do MV_PAR21 na pergunta QMR020. ³±±
±±³            ³        ³      ³ Esse parametro permiti ao usuario impri- ³±± 
±±³            ³        ³      ³ mir Fichas de Calibracao com status Atua-³±±
±±³            ³        ³      ³ liza "NAO".                              ³±±
±±³Denis M.    ³05/04/02³014517³ Impressao do Nome/Numero Procedimento ca-³±±
±±³            ³        ³      ³ dastrado na familia do instrumento qdo o ³±± 
±±³            ³        ³      ³ mesmo nao estiver informado no cadastro  ³±±
±±³            ³        ³      ³ de procedimentos de calibracao(QA5).     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMTR020()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis 														  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1		:=OemToAnsi( STR0001 ) 	// "Este programa ir  emitir a rela‡„o de"
Local cDesc2		:=OemToAnsi( STR0002 ) 	// "Fichas de Calibra‡„o de acordo com os"
Local cDesc3		:=OemToAnsi( STR0003 ) 	// "Parƒmetros selecionados."
Local cString		:="QM2"
Local wnrel

Private cTitulo   := OemToAnsi(STR0004) 	// "FICHA DE CALIBRACAO"
Private Cabec1    := ""
Private Cabec2    := ""
Private aReturn   := { OemToAnsi(STR0005), 1,OemToAnsi(STR0006), 1, 2, 1, "",1 } // "Zebrado"#"Administra‡„o"
Private cNomeProg :="QMTR020"
Private nLastKey  := 0
Private cPerg	   :="QMR020"
Private cTamanho  := "M"
Private cImpCbInst := ""
Private cOldInst   := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas 							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("QMR020",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros									³
//³ mv_par01				// Instrumento Inicial							³ 
//³ mv_par02				// Instrumento Final 							³
//³ mv_par03				// Periodo Inicial								³
//³ mv_par04				// Periodo Final								³
//³ mv_par05				// Departamento Inicial 						³
//³ mv_par06				// Departamento Final							³
//³ mv_par07				// Orgao Calibrador Todos/Interno/Externo       ³
//³ mv_par08				// Org.Calib.Intr.Inicial  					  	³
//³ mv_par09				// Org.Calib.Intr.Final    					    ³
//³ mv_par10				// Org.Calib.Extr.Inicial  					    ³
//³ mv_par11				// Org.Calib.Extr.Final    					    ³
//³ mv_par12				// Familia Inicial                          	³
//³ mv_par13				// Familia Final 								³
//³ mv_par14				// Fabricante Inicial							³
//³ mv_par15				// Fabricante Final								³
//³ mv_par16				// Status de  		                       		³
//³ mv_par17                // Status ate                               	³
//³ mv_par18				// Usu rio Inicial 								³
//³ mv_par19				// Usu rio Final 								³
//³ mv_par20				// Quebra p/ Instrumento Sim/Nao				³
//³ mv_par21				// Imprime desabilitado  Sim/Nao 			  	³                                            
//³ mv_par22				// Dados do Usuario/Responsavel ? 			  	³ 			  	
//³ mv_par23				// Considera Venc. da Calibracao ?			  	³ 			  	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT 						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "QMTR020"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,"",,cTamanho)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

RptStatus({|lEnd| U_r020Imp(@lEnd,wnRel,cString)},cTitulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ r020Imp  ³ Autor ³ Alessandro B. Freire  ³ Data ³ 30.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ficha de Calibra‡„o										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_QMTR020(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Iuri Seto   ³25/07/00³      ³ Inclusao do Tipo de Calibracao Relogio.  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function r020Imp( lEnd, wnRel, cString )

Local nNumMed := 0
Local nEspec  := 0
Local nToler  := 0
Local lImprime:= .F.
Local cbCont  := 0
Local cbTxt   := ""
Local lRodaImp:= .F.
Local cRevEsc := ""
Local cChvQMK := ""
Local cChvQMG := ""
Local cEscala := ""
Local cInstrCab := ""
Local cFaixa  := "",cStatus := ""
Local cRevQMA := "00"
Local cTipTol := ""
Local cKey		
Local cQuery := ""
Local cFiltroUser := aReturn[7]
Local cCampo1 := ""
Local cPict1 := ""

Private TRB_FILIAL
Private TRB_INSTR
Private	TRB_REVINS
Private	TRB_REVINV
Private	TRB_VALDAF
Private	TRB_FREQAF
Private	TRB_TIPO
Private	TRB_RESP
Private	TRB_DEPTO	
Private	TRB_FABR	
Private	TRB_STATUS	
Private	TRB_LOCAL	
Private	TRB_LAUDO	
Private	TRB_NSEFAB	
Private	TRB_FILRES	
Private	TRB_DESQM1

Private cCabec1 := ""
Private cCabec2 := ""
Private cCabec3 := ""
Private cCabec4 := ""
Private cCabec5 := ""
Private cCabec6 := ""
Private lFirst  := .F.
Private cIndex  := ""	
Private nLimite := 132
Private cUniMed := ""
m_pag := 1
li 	:= 80

QM3->(dbSetOrder(1))

dbSelectArea("QM2")
dbSetOrder(01)
cQuery := "SELECT QM2_FILIAL,QM2_INSTR,QM2_REVINS,QM2_REVINV,QM2_VALDAF,QM2_FREQAF,QM2_NSEFAB,"
cQuery += "QM2_DEPTO,QM2_RESP,QM2_TIPO,QM2_FABR,QM2_STATUS,QM2_LAUDO,QM2_LOCAL,QM2_FLAG,QM2_FILRES,"
cQuery += "QM1_FILIAL,QM1_TIPO,QM1_DESCR "
cQuery += "FROM "+RetSqlName("QM2")+" QM2, "					
cQuery += RetSqlName("QM1")+" QM1 "
cQuery += "WHERE "
cQuery += "QM2.QM2_FILIAL = '"			+xFilial("QM2")+	"' AND "
cQuery += "QM2.QM2_INSTR  BetWeen '"	+ mv_par01 +		"' AND '" + mv_par02 +			"' AND " 
cQuery += "QM2.QM2_DEPTO BetWeen '"		+ mv_par05 +		"' AND '" + mv_par06 + 			"' AND " 
cQuery += "QM2.QM2_TIPO BetWeen '"		+ mv_par12 +		"' AND '" + mv_par13 + 			"' AND " 
cQuery += "QM2.QM2_FABR BetWeen '"		+ mv_par14 +		"' AND '" + mv_par15 + 			"' AND " 
cQuery += "QM2.QM2_STATUS BetWeen '"	+ mv_par16 +		"' AND '" + mv_par17 + 			"' AND " 
cQuery += "QM2.QM2_RESP BetWeen '"		+ mv_par18 +		"' AND '" + mv_par19 + 			"' AND "  
cQuery += "QM2.QM2_FLAG = '1' AND QM1.QM1_FILIAL = QM2.QM2_FILIAL AND " 		
cQuery += "QM1.QM1_TIPO =  QM2.QM2_TIPO  AND " 
cQuery += "QM2.D_E_L_E_T_= ' ' "+ " AND " +"QM1.D_E_L_E_T_= ' ' "

If aReturn[8] == 1 
	cKey	:= "QM2_FILIAL+QM2_INSTR+QM2_REVINV"
    //cQuery  += "ORDER BY " + SqlOrder(cKey)
Endif	

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
TcSetField("TRB","QM2_VALDAF","D",8,0)
dbSelectArea( "TRB" )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Loop at‚ o £ltimo instrumento selecionado.					    ³
//³ Loop do instrumento.											³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(RecCount())
lAbortPrint := .F.
While !Eof()

	TRB_FILIAL	:= TRB->QM2_FILIAL
	TRB_INSTR	:= TRB->QM2_INSTR
	TRB_REVINS	:= TRB->QM2_REVINS
	TRB_REVINV	:= TRB->QM2_REVINV
	TRB_VALDAF	:= TRB->QM2_VALDAF
	TRB_FREQAF	:= TRB->QM2_FREQAF						
	TRB_TIPO	:= TRB->QM2_TIPO
	TRB_RESP	:= TRB->QM2_RESP	
	TRB_DEPTO	:= TRB->QM2_DEPTO
	TRB_FABR	:= TRB->QM2_FABR	
	TRB_STATUS	:= TRB->QM2_STATUS
	TRB_LOCAL	:= TRB->QM2_LOCAL
	TRB_LAUDO	:= TRB->QM2_LAUDO		
	TRB_NSEFAB	:= TRB->QM2_NSEFAB	 
	TRB_FILRES	:= TRB->QM2_FILRES
	TRB_DESQM1	:= TRB->QM1_DESCR			
	
	IncRegua()
	If lAbortPrint
		Exit
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se n„o est  entre as validades informadas n„o imprime.		    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (( TRB_VALDAF < mv_par03 ) .Or. ;
		( TRB_VALDAF > mv_par04 )) .And.;
		mv_par23 == 1 // Considera vencimento da calibração Sim / Nao
		dbSelectArea("TRB")
		dbSkip()
		Loop
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno e externo                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 1
		If ! Calibrador(0,mv_par08,mv_par09,mv_par10,mv_par11,TRB_INSTR,TRB_REVINS)
			dbSelectArea("TRB")
			dbSkip()
			Loop
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 2
		If ! Calibrador(1,mv_par08,mv_par09,,,TRB_INSTR,TRB_REVINS)
			dbSelectArea("TRB")
			dbSkip()
			Loop
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. externo                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 3
		If ! Calibrador(2,,,mv_par10,mv_par11,TRB_INSTR,TRB_REVINS)
			dbSelectArea("TRB")
			dbSkip()
			Loop
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se status do instrumento esta com atualiza ativo,dependendo do parametro MV_PAR21.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    If mv_par21 == 2
	   If !QMTXSTAT(TRB_STATUS)
			dbSelectArea("TRB")
		  dbskip()
		  loop
	   EndIf
	Endif   

	If !Empty(cFiltroUser) .and. !TRB->(&cFiltroUser)
		dbskip()
		Loop		      
    Endif

	QAA->(dbSetOrder(1))
	QAA->(dbSeek(TRB_FILRES+TRB_RESP))
	cInstrCab := ""

    QMP->(dbSetOrder(1))
    QMP->(dbSeek(xFilial("QMP")+TRB_STATUS))
    cStatus := QMP->QMP_DESCR
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define o cabe‡alho do instrumento.       						³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Cabec1 := ""
	Cabec2 := ""
	
	cCabec1 :=  STR0007 + TRB_INSTR			+ " " 					+ ;		// "INSTRUMENTO..: "
				STR0045 + TRB_REVINS		+ " " 					+ ;		// "REV.: "
				STR0008 + Alltrim(TRB_DEPTO)         + " " 			+ ;	 	// "DEPARTAMENTO.: "
				STR0009 + Str(TRB_FREQAF,4) + OemToAnsi(STR0037) 	+ ;		// "FREQ.AFERICAO: "
				STR0010 + DtoC(TRB_VALDAF)                     	  	 		// "VALIDADE: "
	
	cCabec2 := STR0011 + U_Mtr020Proc(TRB_TIPO)                  // "PROCEDIMENTO.: "
	
	If MV_PAR22 == 1 //Apelido
		cCabec3 := STR0012 + TRB_LOCAL + "          " + ;		// "LOCALIZACAO"
		STR0013 + TRB_NSEFAB+ "    " + ;						// "No. DE SERIE"
		Upper(TitSx3("QM2_RESP")[1])+" : " + QAA->QAA_APELID	// APELIDO
	ElseIf MV_PAR22 == 2 //Codigo
		cCabec3 := STR0012 + TRB_LOCAL + "          " + ;		// "LOCALIZACAO"
		STR0013 + TRB_NSEFAB+ "    " + ;						// "No. DE SERIE"
		Upper(TitSx3("QM2_RESP")[1])+" : " + QAA->QAA_MAT		// MATRICULA
	Else  //Nome Completo
		cCabec3 := STR0012 + TRB_LOCAL + "          " + ;		// "LOCALIZACAO"
		STR0013 + TRB_NSEFAB+ "    " + ;						// "No. DE SERIE"
		Upper(TitSx3("QM2_RESP")[1])+" : " + QAA->QAA_NOME		// NOME DO RESPONSAVEL
	Endif	
	cCabec4 := OemToAnsi(STR0036) + TRIM(UPPER(cUserName)) + "             " +;      // ""EMISSOR......: "
 	           Trim(Upper(TitSx3("QM2_STATUS")[1]))  + ".......: " +;
	           Trim(Upper(cStatus)) + "              "+;
	           Alltrim(Upper(QaTit("QM2_TIPO",7)))+"......: "+TRB_TIPO

	cCabec5 := OemToAnsi(STR0043)+TRB_DESQM1   //Desc. Familia	
	                     
	cCabec6 := STR0044
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura as escalas amarradas a Familia							³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QMK")
	dbSetOrder(1)
	If dbSeek( xFilial("QMK") + TRB_TIPO )
		cChvQMK := QMK->QMK_TIPO+QMK->QMK_REVTIP
	Else
		dbSelectArea("TRB")
		dbSkip()
		Loop
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Quebra por instrumento.                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cImpCbInst := TRB_INSTR + TRB_REVINS
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Loop das escalas.											    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While QMK->(!Eof()) .And. xFilial("QMK") == QMK->QMK_FILIAL ;
		.And. QMK->QMK_TIPO+QMK->QMK_REVTIP == cChvQMK
		
		lImprime := IIF( mv_par20 == 2, .T., .F. )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pega o numero de medicoes no cadastro de escalas. 			    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		QM9->(dbSetOrder(1))
		QM9->(dbSeek(xFilial("QM9")+QMK->QMK_ESCALA))
		nNumMed := QM9->QM9_NROMED
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica quais escalas devem ser impressas					    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		QMR->(dbSetOrder(1))
		QMR->(dbSeek(xFilial("QMR")+TRB_INSTR+TRB_REVINS+QMK->QMK_ESCALA))
		
		cEscala := ""
		
		If QMR->QMR_CAOBRI == "S"
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ INSTRUMENTOS COM TIPO DE AFERICAO 1,2,3 		   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If QM9->QM9_TIPAFE $ "1|2|3|9"
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Procura os pontos amarrados as escalas.					     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea("QMC")  // PadrÆo / Escalas
				dbSetOrder(1)
				QMC->(dbSeek(xFilial("QMC")+QMK->QMK_ESCALA+;
				inverte(QM9->QM9_REVESC)) )
				
				cRevEsc := QMC->QMC_REVESC
				
				While QMC->(!Eof()) .And. xFilial("QMC") == QMC->QMC_FILIAL ;
					.And. ( QMC->QMC_REVESC == cRevEsc ) ;
					.And. ( QMC->QMC_ESCALA == QMK->QMK_ESCALA )
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Posiciona no QM3: Pontos.               	       	   ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					dbSelectArea("QM3") // Padrao / Calibracao
					dbSetOrder(1)
					QM3->(dbSeek( xFilial("QM3") + QMC->QMC_PADRAO ))
					SAH->(dbSetOrder(1))
					SAH->(dbSeek(xFilial("SAH")+QM3->QM3_UNIMED))
					
					lRodaImp := .T.
					
					If cInstrCab <> TRB_INSTR + TRB_REVINS
						r020Inst()
						cInstrCab := TRB_INSTR + TRB_REVINS
					EndIf
					
					If !(QMK->QMK_FILIAL+QMK->QMK_ESCALA == cEscala)
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Cabe‡alho das escalas.	         			           ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If QM9->QM9_TIPAFE$"1"
							r020Escala(1)  // com uma coluna.
						ElseIf QM9->QM9_TIPAFE$"2"
							r020Escala(2)  // com duas colunas.
						ElseIf QM9->QM9_TIPAFE$"3|9"
							r020Escala(4)
						EndIf
						
						cEscala := QMK->QMK_FILIAL+QMK->QMK_ESCALA
					EndIf
					
					If QM3->QM3_TIPPAD != "A" .And. QM9->QM9_NROMED > 0
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ 1§ Linha de impressÆo para padrÆo com  medi‡äes         ³
						//³ com valores.                                            ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						li++
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Faz a troca de p g. se necess rio.        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					    r020Cab(.T.) // Imprime linha na pr¢x. p g.
						
//             10       20         30        40        50        60        70        80        90        100       110       120
//   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
//	"|Padrao          | Rev | Especificado | Tol.Minima | Tol.Maxima |Tp.Calc.Tol| Valor       | Obs.                               |"
//	"|Padrao          | Rev | Especificado | Tol.Minima | Tol.Maxima |Tp.Calc.Tol| Vlr Inicial | Vlr Final  | Obs.                  |"												
//  "|                |     |              |            |            |           |  Valor Inicial   |   Valor Final    |              |"
//  "|Padrao          | Rev | Especificado | Tol.Minima | Tol.Maxima |Tp.Calc.Tol| Subida | Descida | Subida | Descida |Obs.          |"
																																								
						@li, 00 PSAY "|"
						@li, 01 PSAY QM3->QM3_PADRAO
						@li, 17 PSAY "|"
						@li, 19 PSAY QM3->QM3_REVPAD
						@li, 23 PSAY "|"
						@li, 24 PSAY PadR(AllTrim(QM3->QM3_ESPEC),10) 						// "Especificado: "
						@li, 38 PSAY "|"
						@li, 39 PSAY PadR(AllTrim(QMC->QMC_TOLMIN),10) 					// "Toler.Minima: "                     
						@li, 51 PSAY "|"						
						@li, 52 PSAY PadR(AllTrim(QMC->QMC_TOLER),10) 						// "Toler.Maxima: "						
						@li, 64 PSAY "|"												
						@li, 65 PSAY SubStr(QMTCBox("QMC_TIPTOL",QMC->QMC_TIPTOL),5,10) 	// "Tip.Calc.Tolerancia
//			10		  20        30        40        50        60        70		  80        90        100       110       120								
//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//|                |     |              |            |            |           |             |                                       "						
						If QM9->QM9_TIPAFE$"1"
							@li, 76 PSAY STRCOLUNA_1  // "|                                    |"
						ElseIf QM9->QM9_TIPAFE$"2"
							@li, 76 PSAY STRCOLUNA_2 // "|             |            |                      "
						ElseIf QM9 ->QM9_TIPAFE$"3|9"
							@li, 76 PSAY STRCOLUNA_4 // "|                     |                     |" 
						EndIf
						@li, 131 PSAY "|"
						
						li++
						If li > 55
							@ li,00  PSAY __PrtThinLine()
							li := 66 // For‡a a quebra de p g.
						EndIf
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Faz a troca de p g. se necess rio.        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						r020Cab(.F.) // NÆo imprime linha na pr¢x. p g.
						@ li,00 PSAY __PrtThinLine()
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ A fun‡Æo r020Medic  monta as linhas com as colunas ³
						//³  em branco para preenchimento pelo usu rio.        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If QM9->QM9_TIPAFE$"1"
							U_r020Medic( nNumMed -1, 76 , STRCOLUNA_1)
						ElseIf QM9->QM9_TIPAFE$"2"
							U_r020Medic( nNumMed -1, 76 , STRCOLUNA_2)
						ElseIf QM9->QM9_TIPAFE$"3|9"
							U_r020Medic( nNumMed -1, 76, STRCOLUNA_4)
						EndIf
						
					ElseIf QM9->QM9_NROMED == 0   //COLETA == "N"
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Trata laborat¢rios externos.                       ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						r020MedExt()
						
					Else
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Imprime a linha para atributos.                       ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If QM9->QM9_TIPAFE$"1" // 1 Coluna
							r020Atrib( 1 ) // "|               |              | [  ] APROVADO                       "
						ElseIf QM9->QM9_TIPAFE$"2"  // 2 Colunas
							r020Atrib(2 ) //	"|               |              | [  ] APROVADO       | [  ] REPROVADO"
						ElseIf QM9->QM9_TIPAFE$"3|9" // 4 Colunas
							r020Atrib(4 ) //	"|               |              | [  ] APROVADO       | [  ] REPROVADO"
						EndIf
						
					EndIf
					
					dbSelectArea( "QMC" )
					
					QMC->(dbSkip())
					
				EndDo
				
			ElseIf QM9->QM9_TIPAFE $ "5"
				dbSelectArea("QM9")				
				If xFilial("QM9")+QM9->QM9_ESCALA == QM9->QM9_FILIAL+QMK->QMK_ESCALA 
					//Pega sempre a ultima revisao da escala
					cRevQMA := QM9->QM9_REVESC	                      
				Endif		
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ INSTRUMENTOS COM TIPO DE AFERICAO 5 - SOMA.          ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea( "QMA" )
				dbSetOrder(1)
				dbSeek( xFilial("QMA") + QMK->QMK_ESCALA + cRevQMA )
				cChvQMA := QMA->QMA_ESCALA+QMA->QMA_REVESC
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Posiciona no QM3: Pontos.               	         	  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				QM3->(dbSeek( xFilial("QM3") + QMA->QMA_PADRAO ))
				SAH->(dbSetOrder(1))
				SAH->(dbSeek(xFilial("SAH")+QM3->QM3_UNIMED))
				
				lRodaImp := .T.
				
				If cInstrCab <> TRB_INSTR + TRB_REVINS
					r020Inst()
					cInstrCab := TRB_INSTR + TRB_REVINS
				EndIf
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Cabe‡alho das escalas.                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				r020Escala(2) // 2 Colunas.
				
				While QMA->(!Eof()) ;
					.And.  QMA->QMA_ESCALA+QMA->QMA_REVESC == cChvQMA ;
					.And. QMA->QMA_FILIAL == xFilial("QMA")
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Faz a troca de p g. se necess rio.        ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					r020Cab(.F.) // NÆo imprime linha na pr¢x. p g.
					
					cChvFaixa := QMA->QMA_ESCALA +QMA->QMA_REVESC + QMA->QMA_FAIXA
					nToler    := 0
					nEspec    := 0
					nTolMin	  := 0	
					
					While QMA->QMA_ESCALA+QMA->QMA_REVESC+QMA->QMA_FAIXA == cChvFaixa ;
						.And.	QMA->QMA_FILIAL == xFilial("QMA") ;
						.And. !QMA->(EOF())
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Reposiciona o QM3 para cada reg em QMA. O 1§ ‚ desnec...³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						QM3->(dbSeek( xFilial("QM3") + QMA->QMA_PADRAO ))
						
						If !QM3->(Found())  // s¢ pra garantir...
							QMA->(dbSkip())
							Loop
						EndIf
						
						If QM3->QM3_TIPPAD == "A"
							Exit
						Else
							li++
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Faz a troca de p g. se necess rio.        ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						    r020Cab(.T.) // Imprime linha na pr¢x. p g.
							
							@li, 00 PSAY "|"
							@li, 01 PSAY QM3->QM3_PADRAO
							@li, 17 PSAY "|"
							@li, 19 PSAY QM3->QM3_REVPAD
							@li, 23 PSAY "|"
							@li, 24 PSAY PadL(AllTrim(QM3->QM3_ESPEC),10)	// "Especificado: "
							@li, 38 PSAY "|"
							@li, 39 PSAY PadL(AllTrim(QMA->QMA_TOLMIN),10)	// "Tol.Minima "
							@li, 51 PSAY "|"
							@li, 52 PSAY PadL(AllTrim(QMA->QMA_TOLER),10)	// "Tol.Maxima "
							@li, 64 PSAY "|"
							@li, 65 PSAY SubStr(QMTCBox("QMA_TIPTOL",QMA->QMA_TIPTOL),5,10)
							@li, 76 PSAY "|XXXXXXXXXXXXX|XXXXXXXXXXXX|"
							@li,131 PSAY "|"
							li++
							If li > 55
								@ li,00  PSAY __PrtThinLine()
								li := 66 // For‡a a quebra de p g.
							EndIf
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³ Faz a troca de p g. se necess rio.        ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							r020Cab(.F.) // NÆo imprime linha na pr¢x. p g.
							@ li,00  PSAY __PrtThinLine()
							
							cFaixa := QMA->QMA_FAIXA
							nEspec += SuperVal( QM3->QM3_ESPEC )
							nToler := IIF( nToler > SuperVal(QMA->QMA_TOLER)	,;
							nToler					,;
							SuperVal(QMA->QMA_TOLER) )
						
							nTolMin := IIF( nTolMin > SuperVal(QMA->QMA_TOLMIN)	,;
							nTolMin					,;
							SuperVal(QMA->QMA_TOLMIN) )
							cTipTol := QMA->QMA_TIPTOL
						EndIf
						
						
						QMA->(dbSkip())
					EndDo
					
					cCampo1 := "QM3_ESPEC"
					cPict1 := QA_PICT(cCampo1,QM3->&(cCampo1))
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Para QM3_TIPPAD == "A" o looping anterior ter  que      ³
					//³ acontecer necessariamente apenas 1 vez, sendo v lido    ³
					//³ testar o atributo pelo QM3.                             ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If QM9->QM9_NROMED > 0  ;
						.And.  QM3->QM3_TIPPAD != "A"   //COLETA != "N"
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ 1§ Linha de impressÆo para padrÆo com  medi‡äes         ³
						//³ com valores.                                            ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						li++
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Faz a troca de p g. se necess rio.        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					    r020Cab(.T.) // Imprime linha na pr¢x. p g.
						@li, 00 PSAY "|"
						@li, 01 PSAY Alltrim(cFaixa)
						@li, 17 PSAY "|"
						@li, 23 PSAY "|"
						@li, 24 PSAY  PadL(AllTrim(Transform(nEspec, cPict1)),10)
						@li, 38 PSAY "|"
						@li, 39 PSAY  PadL(AllTrim(Transform(nTolMin, cPict1)),10)
						@li, 51 PSAY "|"
						@li, 52 PSAY  PadL(AllTrim(Transform(nToler, cPict1)),10)	
						@li, 64 PSAY "|"											
						@li, 65 PSAY SubStr(QMTCBox("QMA_TIPTOL",cTipTol),5,10) 
						@li, 76 PSAY STRCOLUNA_2 // "|                     |                     |"
						@li,131 PSAY "|"
						li++
						If li > 55
							@ li,00  PSAY __PrtThinLine()
							li := 66 // For‡a a quebra de p g.
						EndIf
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Faz a troca de p g. se necess rio.        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						r020Cab(.F.) // NÆo imprime linha na pr¢x. p g.
						@ li,00  PSAY __PrtThinLine()
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ A fun‡Æo r020Medic monta as linhas com as colunas ³
						//³  em branco para preenchimento pelo usu rio.       ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						U_r020Medic( nNumMed - 1, 76, STRCOLUNA_2)
						
					ElseIf QM9->QM9_NROMED == 0    //COLETA == "N"
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Trata laborat¢rios externos.                       ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						r020MedExt()
						
					ElseIf QM3->QM3_TIPPAD = "A"
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Imprime a linha para atributos.                    ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						r020Atrib(2 ) //	"|               |              | [  ] APROVADO       | [  ] REPROVADO"
						QMA->(dbSkip())
					EndIf
					
				EndDo
				
				
			ElseIf  QM9->QM9_TIPAFE$"4|8"
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ INSTRUMENTOS COM TIPO DE AFERICAO - 3                      ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea( "QMG" )
				dbSetOrder(1)
				dbSeek( xFilial("QMG") + TRB_INSTR + TRB_REVINS )
				cChvQMG := QMG->QMG_INSTR + QMG->QMG_REVINS
				cEscala := ""
				
				While QMG->(!Eof()) .And. QMG->QMG_INSTR + QMG->QMG_REVINS == cChvQMG ;
					.And.  xFilial("QMG") == QMG->QMG_FILIAL
					
					SAH->(dbSetOrder(1))
					SAH->(dbSeek(xFilial("SAH")+QMG->QMG_UNIMED))
					cUniMed := SAH->AH_UMRES 
					
					If lFirst
					   r020Cab(.T.)
					Endif   
  				    lFirst := .T.
					If cInstrCab <> TRB_INSTR + TRB_REVINS
						r020Inst()
						cInstrCab := TRB_INSTR + TRB_REVINS
					EndIf
					
					If !(QMK->QMK_ESCALA ==  cEscala)
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Constr¢i o cabe‡alho dos padr”es.		       	       ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						r020EscQMG()
						cEscala := QMK->QMK_ESCALA
					EndIf
					
					lRodaImp := .T.
					
					If QMG->QMG_TIPCAL != "A" .And. QM9->QM9_NROMED > 0
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ 1§ Linha de impressÆo para padrÆo com  medi‡äes         ³
						//³ com valores.                                            ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						li++
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Faz a troca de p g. se necess rio.        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						//r020Cab(.T.) // Imprime linha na pr¢x. p g.
						//           1         2         3         4         5         6         7         8         9         10        11
					    // 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
					    //"|Ponto           | Especificado | LIE        | LSE        |Tp.Calc.Tol| Unid.Med. | Valor       | Obs.:                            |"										
						
						@li, 00 PSAY "|"
						@li, 01 PSAY QMG->QMG_PONTO
						@li, 17 PSAY "|"
						@li, 18 PSAY Padr(AllTrim(QMG->QMG_NOMIN),10) // "Especificado: "
						@li, 32 PSAY "|"
						@li, 33 PSAY Padr(AllTrim(QMG->QMG_LIE),10)
						@li, 45 PSAY "|"
						@li, 46 PSAY Padr(AllTrim(QMG->QMG_LSE),10)
						@li, 58 PSAY "|"
						@li, 59 PSAY SubStr(QMTCBox("QMG_TIPTOL",QMG->QMG_TIPTOL),5,10)
					
						//             10       20         30        40        50        60        70        80        90        100       110       120       130
						//   0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
						//  "|Ponto           | Especificado | LIE        | LSE        |Tp.Calc.Tol| Vlr Final       | Vlr Final       | Obs.:                  |"								
						If QM9->QM9_TIPAFE$"4"
							@li, 70 PSAY "|"//STRCOLUNA_1 
							@li, 72 PSAY cUniMed
    						@li, 82 PSAY STRCOLUNA_5
						ElseIf QM9->QM9_TIPAFE$"8"
							@li, 70 PSAY STRCOLUNA_2 
						EndIf
						@li,131 PSAY "|"
						li++
						If li > 55
							@ li,00  PSAY __PrtThinLine()
							li := 66 // For‡a a quebra de p g.
						EndIf
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Faz a troca de p g. se necess rio.        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

					    r020Cab(.T.) // NÆo imprime linha na pr¢x. p g.
						
						@ li,00  PSAY __PrtThinLine()
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ A fun‡Æo r020Medic monta as linhas com as colunas  ³
						//³  em branco para preenchimento pelo usu rio.        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If QM9->QM9_TIPAFE$"4"      
							U_r020Medic( nNumMed -1, 82, STRCOLUNA_5)							
						ElseIf QM9->QM9_TIPAFE$"8"
							U_r020Medic( nNumMed -1, 70, STRCOLUNA_2)
						EndIf
						
					ElseIf QM9->QM9_NROMED == 0 //COLETA == "N"
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Trata laborat¢rios externos.                       ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						r020MedExt()
						
					ElseIf QMG->QMG_TIPCAL == "A"
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Imprime a linha para atributos.                    ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						r020AtQMG()
					EndIf
					
					QMG->(dbSkip())
					
				EndDo
			ElseIf  Empty(QM9->QM9_TIPAFE) .or. Alltrim(QM9->QM9_TIPAFE)==""
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Trata laborat¢rios externos.                       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				r020MedExt()
			EndIf
		EndIf
		
		dbSelectArea( "QMK" )
		dbSetOrder(1)
		cPula := QMK->QMK_ESCALA + QMK->QMK_TIPO + QMK->QMK_REVTIP
		While QMK->(!Eof()) .and. QMK->QMK_ESCALA + QMK->QMK_TIPO+ QMK->QMK_REVTIP == cPula
			dbSkip()
		EndDo
	EndDo
	dbSelectArea("TRB")
	
	dbSkip()
	
	If lRodaImp
		
		nRodaLim := 56
		
		//           1         2         3         4         5         6         7         8         9        10        11        12        13
		//  0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		// "| Data :    /    /      | Hora Inicial:      :        | Hora Final  :      :        | Metrologista :
		li++
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a troca de p g. se necess rio.        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    r020Cab(.T.,58) // Imprime linha na pr¢x. p g.
		
		@ li,00  PSAY __PrtFatLine()
//		@ li,00  PSAY Repl( "=", nLimite )
		li++
		@ li,00  PSAY STR0032 // "| Data :    /    /"
		@ li,24  PSAY STR0033 // "| Hora Inicial:      :"
		@ li,54  PSAY STR0034 // "| Hora Final  :      :"
		@ li,84  PSAY STR0035 // "| Metrologista : "
		@ li,131 PSAY "|"
		li++
		@ li,00  PSAY __PrtFatLine()
		
		lRodaImp := .F.
	EndIf
	
EndDo

If li <> 80
	Roda( cbCont, cbTxt, cTamanho )
EndIf

Set Device To Screen

dbSelectArea("TRB")
dbCloseArea()

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
±±³Fun‡ao	 ³r020Medic ³ Autor ³ Antonio Aurelio       ³ Data ³ 20.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Constroi os cabecalhos de medi‡”es						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR020													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function r020Medic( nNumMed , nPos, cCol )
Local i		 := 1
Default nPos := 63
Default cCol := "|                     |                     |"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Constr¢i o cabe‡alho das medicoes.  						    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

For i = 1 To nNumMed
	li++
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a troca de p g. se necess rio.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    r020Cab(.T.) // Imprime linha na pr¢x. p g.
	@li,00   PSAY "|"
	@li,nPos PSAY cCol
	@li,131  PSAY "|"
	If i < nNumMed
		li++
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifico se esta no final da p g.         ³
		//³ e for‡o o fechamento da caixa.            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If li > 55
			@ li,00  PSAY __PrtThinLine()
			li := 66 // For‡a a quebra de p g.
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a troca de p g. se necess rio.        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !r020Cab(.T.) // Imprime linha na pr¢x. p g.
			@li,00 PSAY "|"
			@ li,00  PSAY __PrtThinLine()
		Else
			li-- // Ajuste aqui
		EndIf
	EndIf
Next

If nNumMed > 0
	li++
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a troca de p g. se necess rio.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	r020Cab(.F.) // Imprime linha na pr¢x. p g.
	@ li,00  PSAY __PrtThinLine()
EndIf

Return( NIL )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³Mtr020Sec ³ Autor ³ Alessandro B. Freire  ³ Data ³ 24.04.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna os padroes secundarios utilizados na escala        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR020Sec( )                     						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR020													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Mtr020Sec()

Local cOldAlias	:= Alias()
Local aArrayQMH := {}
Local aArrayRet := {}
Local nPos      := 0
Local nx		:= 1
Local cChave    := ""
Local cQuery	:= ""	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime os padroes secundarios.     				   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "QMH" )
dbSetOrder(1)
dbSeek( xFilial("QMH") + QMK->QMK_ESCALA )
If Found()
	cChave := "QMH_FILIAL+QMH_ESCALA"
	cQuery := "SELECT QMH_FILIAL,QMH_ESCALA,QMH_PADSEC "
	cQuery += "FROM "+RetSqlName("QMH")+" "
	cQuery += "WHERE "
	cQuery += "QMH_FILIAL = '" +xFilial("QMH")+	"' AND "
	cQuery += "QMH_ESCALA = '" + QMK->QMK_ESCALA + "' AND "	
	cQuery += "D_E_L_E_T_= ' ' "
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Montagem da ordem para Informix                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cQuery += " ORDER BY " + SqlOrder(cChave)
	
	cQuery := ChangeQuery(cQuery)
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TQH",.T.,.T.)
	
	While ! Eof() 
		If Ascan(aArrayQMH,AllTrim( TQH->QMH_PADSEC )) == 0
			Aadd(aArrayQMH,AllTrim( TQH->QMH_PADSEC ))
		Endif
		dbSkip()
	EndDo
	TQH->(dbCloseArea()	)
Endif
dbSelectArea( cOldAlias )

If Len(aArrayQMH) > 0
	For nx := 1 to Len(aArrayQMH)
		If nPos > 91 .or. nx == 1
			Aadd(aArrayRet,aArrayQMH[nx])
			nPos := 0
			nPos :=  nPos + Len(aArrayQMH[nx])
		Else
			aArrayRet[Len(aArrayRet)] += " / "+aArrayQMH[nx]
			nPos :=  nPos + (Len(aArrayQMH[nx]) + 3)
		Endif		
	Next		
Endif

Return( aArrayRet )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³Mtr020Proc³ Autor ³ Alessandro B. Freire  ³ Data ³ 24.04.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o procedimento de calibracao do instrumento.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_MTR020Proc()                     						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR020													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Mtr020Proc(TRB_TIPO)
Local cOldAlias := Alias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Encontra o tipo do instrumento.                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "QM1" )
dbSetOrder( 1 )
dbSeek( xFilial("QM1") + TRB_TIPO )
TRB_DESQM1 := QM1->QM1_DESCR
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Encontra o procedimento de calibracao amarrado ao tipo          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "QA5")
dbSetOrder( 1 )
If QA5->(dbSeek( xFilial("QA5") + "C" + QM1->QM1_PROCAL ))
	dbSelectArea( cOldAlias )
	Return( AllTrim( QA5->QA5_NORMA ) + " - " + AllTrim ( QA5->QA5_DESCRI ) )
Else
	dbSelectArea( cOldAlias )
	Return( AllTrim( QM1->QM1_PROCAL ))
Endif

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo	 ³r020Cab   ³ Autor ³ Antonio Aurelio       ³ Data ³ 20.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cabe‡alho.                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR020													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function r020Cab(lLnImpr, nLnLim)
Local lRet

Default lLnImpr := .T.
Default nLnLim := 55

lRet := .F.

If li > nLnLim
	
	Cabec(cTitulo,"","",cNomeprog,cTamanho,IIF(aReturn[4]==1,15,18) )
	li := 5
	@ li,00  PSAY __PrtFatLine()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ cOldInst ‚ private em r020Imp, e ‚ atualizada apenas em r020Inst   ³
	//³ que ‚ quando se imprime todo cabe‡alho de instrumento.             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cImpCbInst == cOldInst
		li++
		li++
		@li,00 PSAY cCabec1
		li++
	Else
		r020Inst()
		cOldInst := cImpCbInst
	EndIf
	
	If lLnImpr
		li++
		@ li,00  PSAY __PrtThinLine()
	EndIf
	li++
	lRet := .T.
EndIf

Return lRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³r020Instr ³ Autor ³ Antänio Aur‚lio       ³ Data ³ 20.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cabe‡alho.                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR020													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function r020Inst()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Quebra por instrumento.                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par20 == 1 .And. li > 4
	li := 66
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a troca de p g. se necess rio.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If li > 55  // Imprime todo o 'bloco' ou pula de p g.
	Cabec(cTitulo,"","",cNomeprog,cTamanho,IIF(aReturn[4]==1,15,18) )
	li := 5
	@ li,00  PSAY __PrtThinLine()
EndIf

li++
@li,00 PSAY cCabec1
li++
@Li,00 PSAY cCabec2
li++
@li,00 PSAY cCabec3
li++
@li,00 PSAY cCabec4
li++
@li,00 PSAY cCabec5
li++
@li,00 PSAY cCabec6
li++
@ li,00  PSAY __PrtFatLine()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ cOldInst ‚ verificada em r020Cab.                      ³
//³ cImpCbInst ‚ atualizada quando se troca de instrumento.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cOldInst := cImpCbInst

Return .T.


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³r020Atrib ³ Autor ³ Ant“nio Aur‚lio       ³ Data ³ 20.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime a linha para atributos.                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR020													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function r020Atrib(nCol)

li++
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a troca de p g. se necess rio.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
r020Cab(.T.) // Imprime linha na pr¢x. p g.

@li,00  PSAY "|"
@li,01  PSAY PadR(QM3->QM3_PADRAO,16)
@li,17  PSAY "|"
@li,19  PSAY PadR(QM3->QM3_REVPAD,3)
@li,23  PSAY "|"
If nCol = 1
	@li, 38 PSAY "|"
	@li, 51 PSAY "|"	
	@li, 64 PSAY "|"		
	@li, 76 PSAY STR0026 //  "| [ ] APROVADO        |"
	@li,131 PSAY "|"
	li++
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico se esta no final da p g.         ³
	//³ e for‡o o fechamento da caixa.            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If li > 55
		@ li,00  PSAY __PrtThinLine()
		li := 66 // For‡a a quebra de p g.
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a troca de p g. se necess rio.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    r020Cab(.T.) // Imprime linha na pr¢x. p g.
	
	@li,00  PSAY "|"
	@li,76  PSAY STR0027 // "|[ ] REPROVADO|"
	@li,131 PSAY "|"
ElseIf nCol == 2
	@li, 38 PSAY "|"
	@li, 51 PSAY "|"	
	@li, 64 PSAY "|"		
	@li, 76 PSAY STR0029  // "|               |              | [  ] APROVADO         [  ] REPROVADO      |                       |"
	@li,131 PSAY "|"	
ElseIf nCol == 4
	@li, 38 PSAY "|"
	@li, 51 PSAY "|"	
	@li, 64 PSAY "|"		
	@li, 76 PSAY  STR0030 // "|              | [  ] APROVADO            [  ] REPROVADO        |                  |"
EndIf

li++
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifico se esta no final da p g. e for‡o o fechamento da caixa. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If li > 55
	@ li,00  PSAY __PrtThinLine()
	li := 66 // For‡a a quebra de p g.
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a troca de p g. se necess rio.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
r020Cab(.F.) // NÆo imprime linha na pr¢x. p g.
@ li,00  PSAY __PrtThinLine()

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³r020AtQMG ³ Autor ³ Antänio Aur‚lio       ³ Data ³ 20.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime a linha para atributos.                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR020													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function r020AtQMG()

li++
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a troca de p g. se necess rio.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
r020Cab(.T.) // Imprime linha na pr¢x. p g.

@li, 00 PSAY "|"
@li, 01 PSAY QMG->QMG_PONTO
@li, 17 PSAY "|"
@li, 32 PSAY "|"       
@li, 45 PSAY "|"       
@li, 58 PSAY "|"        
@li, 70 PSAY "|"       

If QM9->QM9_TIPAFE$"4"
	@li,72 PSAY cUniMed
	@li,82 PSAY STR0026
	@li,131 PSAY "|"
	li++
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico se esta no final da p g.         ³
	//³ e for‡o o fechamento da caixa.            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If li > 55
		@ li,00  PSAY __PrtThinLine()
		li := 66 // For‡a a quebra de p g.
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a troca de p g. se necess rio.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    r020Cab(.T.) // Imprime linha na pr¢x. p g.
	
	@li,00 PSAY "|"
	@li,17 PSAY "|"
	@li,32 PSAY "|"
	@li,45 PSAY "|"
	@li,58 PSAY "|"        
	@li,70 PSAY "|"       
	@li,82 PSAY STR0027	// "| [ ] REPROVADO       |"	
ElseIf QM9->QM9_TIPAFE$"8"
	@li,70 PSAY STR0028	// "| [ ] APROVADO           [ ] REPROVADO      |"
EndIf
@li,131 PSAY "|"

li++
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifico se esta no final da p g.         ³
//³ e for‡o o fechamento da caixa.            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If li > 55
	@ li,00  PSAY __PrtThinLine()
	li := 66 // For‡a a quebra de p g.
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a troca de p g. se necess rio.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
r020Cab(.F.) // NÆo imprime linha na pr¢x. p g.
@ li,00  PSAY __PrtThinLine()

Return NIL


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³r020Escala³ Autor ³ Ant“nio Aur‚lio       ³ Data ³ 20.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime a linha para atributos.                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR020													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function r020Escala(nCol)
Local aArrays	:={}
Local nx		:= 1
Local lPadSec	:= .F.
Default nCol	:= 1

li++
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a troca de p g. se necess rio.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
r020Cab(.F.,45) // NÆo imprime linha na pr¢x. p g.

@li,000 PSAY STR0014 + QMK->QMK_ESCALA		// "FAIXA.: "
@li,030 PSAY STR0045 + QMK->QMK_REVTIP		// "REV.: "
@li,042 PSAY STR0015 + QM3->QM3_UNIMED + ;	// "UNIDADE DE MEDIDA: "
If(SAH->(Found())," - " + SAH->AH_DESCPO," ")
	li++

	aArrays := U_Mtr020Sec()

	For nx := 1 To Len(aArrays)
		If nx == 1 // Se passar a primeira vez imprime cabec+dados
			lPadSec := .T.
			@li,00 PSAY STR0016 + aArrays[nx]
			li++		
		Else //So imprime os dados
			@li,19 PSAY aArrays[nx]		
			li++
		Endif
	Next nx
    
    If !lPadSec
		@li,00 PSAY STR0016    	
    Endif
	li++
	@li,00 PSAY STR0017 // "INSTRUMENTO UTILIZADO:"
	li++
	@ li,00  PSAY __PrtThinLine()
	li++              
//             10       20         30        40        50        60        70        80        90        100
//   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//	"|Padrao          | Rev |Especificado| Tol.Minima | Tol.Maxima |Tp.Calc.Tol| Valor       | Obs.                               |"

	If nCol == 1
		@li, 00 PSAY "|" + STR0018	// "Padrao"
		@li, 17 PSAY "| " + SubsTR(OemToAnsi(STR0019),1,3)+" " // "Rev"
		@li, 23 PSAY STR0020 // "|Especificado| Tol.Minima | Tol.Maxima |Tip.Calc.Toler.|Valor           | Obs.:                                        |"
	ElseIf nCol == 2
		@li, 00 PSAY "|" + STR0018 // "Padrao"
		@li, 17 PSAY "| " + SubsTR(OemToAnsi(STR0019),1,3) // "Rev"
		@li, 23 PSAY STR0021 // "| Especificado | Tol.Minima | Tol.Minima | Vlr Inicial | Vlr Final  | Obs.                  |"
	ElseIf nCol == 4
		@li, 00 PSAY "|"
		@li, 17 PSAY "| "
		@li, 00 PSAY STR0022 // |  Valor Inicial         |   Valor Final         |                  |"
		li++
		@li, 00  PSAY STR0023 // "| Padrao            | Revisao   | Especificado  | Tolerancia   |  Subida    | Descida   |  Subida   | Descida   | Obs.             |"
	EndIf
	li++                                   
	@ li,00  PSAY __PrtThinLine()
	
	
	Return NIL
	
	/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Fun‡…o	 ³r020EscQMG³ Autor ³ Ant“nio Aur‚lio       ³ Data ³ 20.03.00 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descri‡…o ³ Imprime a linha para atributos.                            ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³ Uso		 ³ QMTR020													  ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
	/*/
	Static Function r020EscQMG()
	Local aArrays := {}
	Local nx := 1	
	Local lPadSec := .F.
	li++
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a troca de p g. se necess rio.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	r020Cab(.T.,48) // Imprime linha na pr¢x. p g.
	
	@li,000 PSAY STR0014 + QMK->QMK_ESCALA // "ESCALA.: "
	dbSelectArea("QM9")
	dbSetOrder(1)
	If dbSeek(xFilial("QM9")+QMK->QMK_ESCALA+QMK->QMK_REVINV)
		dbSelectArea("SAH")
		dbSetOrder(1)
		If dbSeek(xFilial("SAH")+QM9->QM9_UNIMED)
			@li,029 PSAY STR0015 + SAH->AH_UNIMED + ; // "UNIDADE DE MEDIDA:"
			" - " + SAH->AH_DESCPO
		Endif	
	Endif	
	li++
	aArrays := U_Mtr020Sec()
	For nx := 1 To Len(aArrays)
		If nx == 1 // Se passar a primeira vez imprime cabec+dados
			lPadSec := .T.
			@li,00 PSAY STR0016 + aArrays[nx]
			li++		
		Else //So imprime os dados
			@li,19 PSAY aArrays[nx]		
			li++
		Endif
	Next nx
	If !lPadSec
		@li,00 PSAY STR0016		
	Endif
	li++
	@li,00 PSAY STR0017 // "INSTRUMENTO UTILIZADO:"
	li++
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a troca de p g. se necess rio.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	r020Cab(.F.,56) // NÆo imprime linha na pr¢x. p g.
	@ li,00  PSAY __PrtThinLine()
	li++
	If QM9->QM9_TIPAFE$"4"		// 1 Coluna
		@li,00 PSAY STR0024  
	ElseIf QM9->QM9_TIPAFE$"8"	// 2 Colunas
		@li,00 PSAY STR0025
	EndIf
	li++
	@ li,00  PSAY __PrtThinLine()
	
	Return NIL
		
		/*/
		ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
		±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
		±±³Fun‡…o	 ³r020MedExt³ Autor ³ Ant“nio Aur‚lio       ³ Data ³ 20.03.00 ³±±
		±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
		±±³Descri‡…o ³ Imprime linha para lab. externos                           ³±±
		±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
		±±³ Uso		 ³ QMTR020													  ³±±
		±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
		±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
		ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
		/*/
		Static Function r020MedExt()
		
		li++
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a troca de p g. se necess rio.        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		r020Cab(.T.) // Imprime linha na pr¢x. p g.
		@li,00  PSAY "|"
		@li,02  PSAY STR0031  // "* * * * * *   M E D I C O E S   R E A L I Z A D A S   P O R   L A B O R A T O R I O   E X T E R N O   * * * * * *"
		@li,131 PSAY "|"
		li++
		If li > 55
			@ li,00  PSAY __PrtThinLine()
			li := 66 // For‡a a quebra de p g.
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a troca de p g. se necess rio.        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		r020Cab(.F.) // NÆo imprime linha na pr¢x. p g.
		@ li,00  PSAY __PrtThinLine()
		
		Return .T.
