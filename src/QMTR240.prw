/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QMTR240.Ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QMTR240   ºAutor  ³Leandro Sabino      º Data ³  11/07/06	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ficha de Repe/Repro por periodo							  º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QMTR240()
Local oReport 

Private cAlias := GetNextAlias()

If TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ VARIµVEIS UTILIZADAS PARA PAR¶METROS                ³
	//³ mv_par01 : Instrumento Inicial                      ³
	//³ mv_par02 : Instrumento Final                        ³
	//³ mv_par03 : Periodo Inicial                          ³
	//³ mv_par04 : Periodo Final                            ³
	//³ mv_par05 : Departamento Inicial                     ³
	//³ mv_par06 : Departamento Final                       ³
	//³ mv_par07 : Familia de                               ³
	//³ mv_par08 : Familia ate                              ³
	//³ mv_par09 : Usuario de                               ³
	//³ mv_par10 : Usuario ate                              ³
	//³ mv_par11 : Fabricante de                            ³
	//³ mv_par12 : Fabricante ate                           ³
	//³ mv_par13 : No.Ensaiadores                           ³
	//³ mv_par14 : No.Ciclos (Medicoes)                     ³
	//³ mv_par15 : No.Pecas                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte("QMR240",.F.) 
    oReport := ReportDef()
    oReport:PrintDialog()
Else
	U_QMTR240R3()	// Executa versão anterior do fonte
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 11/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR240                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(lBat)
Local ctitulo  := OemToAnsi( STR0005 ) // "FICHA REPE/REPRO"
Local cDesc1   := OemToAnsi( STR0001 ) // "Este programa ira emitir a"
Local cDesc2   := OemToAnsi( STR0002 ) // "ficha de Repe/Repro."
Local oSection1 

DEFINE REPORT oReport NAME "QMTR240" TITLE cTitulo PARAMETER "QMR240" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)
oReport:SetLandscape()

DEFINE SECTION oSection1 OF oReport   TABLES cAlias TITLE cTitulo
DEFINE CELL NAME "cMed"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0015) SIZE 03 //"Med."
DEFINE CELL NAME "Pc01"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0016) SIZE 08 //"Peca 01"
DEFINE CELL NAME "Pc02"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0017) SIZE 08 //"Peca 02"
DEFINE CELL NAME "Pc03"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0018) SIZE 08 //"Peca 03"
DEFINE CELL NAME "Pc04"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0019) SIZE 08 //"Peca 04"
DEFINE CELL NAME "Pc05"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0020) SIZE 08 //"Peca 05"
DEFINE CELL NAME "Pc06"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0021) SIZE 08 //"Peca 06"
DEFINE CELL NAME "Pc07"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0022) SIZE 08 //"Peca 07"
DEFINE CELL NAME "Pc08"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0023) SIZE 08 //"Peca 08"
DEFINE CELL NAME "Pc09"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0024) SIZE 08 //"Peca 09"
DEFINE CELL NAME "Pc10"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0025) SIZE 08 //"Peca 10"
DEFINE CELL NAME "Pc11"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0026) SIZE 08 //"Peca 11"
DEFINE CELL NAME "Pc12"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0027) SIZE 08 //"Peca 12"
DEFINE CELL NAME "Pc13"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0028) SIZE 08 //"Peca 13"
DEFINE CELL NAME "Pc14"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0029) SIZE 08 //"Peca 14"
DEFINE CELL NAME "Pc15"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0030) SIZE 08 //"Peca 15"
DEFINE CELL NAME "Pc16"  OF oSection1 ALIAS "" TITLE OemToAnsi(STR0031) SIZE 08 //"Peca 16"

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 11/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR240                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport) 
Local oSection1   := oReport:Section(1)
Local nCntFor     := ""
Local nCntFor2    := ""
Local cInstr	  := ""
Local cCabec      := ""
Local aCampos     := {}
Local cChave 

dbSelectArea("QM4")
dbSetOrder(1)
dbSelectArea( "QM2" )
dbSetOrder(1)
dbSeek( xFilial() + mv_par01,  .T. )

MakeSqlExpr(oReport:uParam)
    
cChave := "%QM2_FILIAL,QM2_INSTR,QM2_REVINV%"

BeginSQL alias cAlias

	SELECT QM2.QM2_FILIAL, QM2.QM2_INSTR, QM2.QM2_REVINV, QM2.QM2_REVINS, QM2.QM2_TIPO, QM2.QM2_DEPTO, QM2.QM2_VALREP,
	       QM2.QM2_FABR  , QM2.QM2_RESP , QM2.QM2_STATUS 
	
	FROM %table:QM2% QM2 
	
	WHERE 
		QM2.QM2_FILIAL  = %xFilial:QM2% AND 
		QM2.QM2_INSTR	>= %Exp:mv_par01%  AND  
		QM2.QM2_INSTR	<= %Exp:mv_par02%  AND  
		QM2.QM2_VALREP  >= %Exp:DtoS(mv_par03)% AND  
		QM2.QM2_VALREP  <= %Exp:DtoS(mv_par04)% AND  
		QM2.QM2_DEPTO	>= %Exp:mv_par05%  AND  
		QM2.QM2_DEPTO	<= %Exp:mv_par06%  AND  
		QM2.QM2_TIPO	>= %Exp:mv_par07%  AND  
		QM2.QM2_TIPO	<= %Exp:mv_par08%  AND  
		QM2.QM2_FABR	>= %Exp:mv_par11%  AND  
		QM2.QM2_FABR	<= %Exp:mv_par12%  AND  
		QM2.QM2_RESP	>= %Exp:mv_par09%  AND  
		QM2.QM2_RESP	<= %Exp:mv_par10%  AND  
		QM2.%notDel% 

	ORDER BY %Exp:cChave%
	        
EndSql

	

Do While !Eof()

	TRB_FILIAL	:= &(cAlias+"->QM2_FILIAL")
	TRB_INSTR	:= &(cAlias+"->QM2_INSTR")
	TRB_REVINV	:= &(cAlias+"->QM2_REVINV")
	TRB_REVINS	:= &(cAlias+"->QM2_REVINS")
	TRB_TIPO	:= &(cAlias+"->QM2_TIPO")
	TRB_DEPTO	:= &(cAlias+"->QM2_DEPTO")
	TRB_VALREP	:= &(cAlias+"->QM2_VALREP")
	TRB_FABR	:= &(cAlias+"->QM2_FABR")
	TRB_RESP	:= &(cAlias+"->QM2_RESP")
	TRB_STATUS	:= &(cAlias+"->QM2_STATUS")
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pula as revisoes anteriores do mesmo instrumento             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If cInstr == TRB_FILIAL + TRB_INSTR 
      dbSkip()
      Loop   
   EndIf
   
   cInstr := TRB_FILIAL + TRB_INSTR 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se status do instrumento esta ativo				    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If	!QMTXSTAT(TRB_STATUS)			
		dbskip()
		loop
	EndIf

	QM4->(DbSeek(xFilial("QM4")+TRB_INSTR+TRB_REVINS))
	
	If cCabec <> TRB_INSTR 
		If !Empty(Alltrim(cCabec)) 
			oReport:EndPage()
		EndIf
		oSection1:Finish()
		oSection1:Init()
		oReport:SkipLine(1) 
		oReport:ThinLine()
		oReport:PrintText((TitSx3("QM2_INSTR")[1])+": "+TRB_INSTR +"   "+("Data")+": "+Right(TRB_VALREP,2)+"/"+SubStr(TRB_VALREP,5,2)+"/"+Left(TRB_VALREP,4),oReport:Row(),025) 
		oReport:SkipLine(1)	
		oReport:PrintText((TitSx3("QM4_PECA")[1]) +": "+repl('_',60) ,oReport:Row(),025) 
		oReport:SkipLine(1)	
		oReport:PrintText((TitSx3("QM4_CARACT")[1])+": "+repl('_',60),oReport:Row(),025) 
		oReport:SkipLine(1)	
		oReport:PrintText((TitSx3("QM4_NUMERO")[1])+": "+repl('_',60),oReport:Row(),025) 
		oReport:SkipLine(1)	
		oReport:PrintText((TitSx3("QM4_LIE")[1])+": "+If(QM4->(Found()),QM4->QM4_LIE,repl('_',20)) +"   "+(TitSx3("QM4_LSE")[1])+": "+If(QM4->(Found()),QM4->QM4_LSE,repl('_',20))+"   "+(TitSx3("QM4_TOLESP")[1])+": "+If(QM4->(Found()),QM4->QM4_TOLESP,repl('_',20)) ,oReport:Row(),025) 
		oReport:SkipLine(1)	
		oReport:PrintText(OemToAnsi(STR0009)+" :  " + StrZero(mv_par13,2),oReport:Row(),025)//'No.Ensaiadores'
		oReport:SkipLine(1)	
		oReport:PrintText(OemToAnsi(STR0010)+" :  " + StrZero(mv_par14,2),oReport:Row(),025)// 'No.Medicoes' 
		oReport:SkipLine(1)	
		oReport:PrintText(OemToAnsi(STR0011)+" :  " + StrZero(mv_par15,2),oReport:Row(),025)// 'No.Pecas' 
		oReport:SkipLine(1)	
		oReport:ThinLine()
		oReport:SkipLine(1)	 
	Endif
		
    cCabec := TRB_INSTR
	
	For nCntFor:= (mv_par15 + 1) to 16 //Numero de Pecas 
		Do Case
			Case nCntFor = 1 
				oSection1:Cell("Pc01"):Hide()
				oSection1:Cell("Pc01"):HideHeader()
			Case nCntFor = 2 
				oSection1:Cell("Pc02"):Hide()
				oSection1:Cell("Pc02"):HideHeader()
			Case nCntFor = 3 
				oSection1:Cell("Pc03"):Hide()
				oSection1:Cell("Pc03"):HideHeader()
			Case nCntFor = 4 
				oSection1:Cell("Pc04"):Hide() 
				oSection1:Cell("Pc04"):HideHeader()
			Case nCntFor = 5 
				oSection1:Cell("Pc05"):Hide()
				oSection1:Cell("Pc05"):HideHeader()
			Case nCntFor = 6 
				oSection1:Cell("Pc06"):Hide()
				oSection1:Cell("Pc06"):HideHeader()
			Case nCntFor = 7 
				oSection1:Cell("Pc07"):Hide()
				oSection1:Cell("Pc07"):HideHeader()
			Case nCntFor = 8 
				oSection1:Cell("Pc08"):Hide()
				oSection1:Cell("Pc08"):HideHeader()
			Case nCntFor = 9 
				oSection1:Cell("Pc09"):Hide()
				oSection1:Cell("Pc09"):HideHeader()
			Case nCntFor = 10
				oSection1:Cell("Pc10"):Hide()
				oSection1:Cell("Pc10"):HideHeader()
			Case nCntFor = 11
				oSection1:Cell("Pc11"):Hide()
				oSection1:Cell("Pc11"):HideHeader()
			Case nCntFor = 12
				oSection1:Cell("Pc12"):Hide()
				oSection1:Cell("Pc12"):HideHeader()
			Case nCntFor = 13
				oSection1:Cell("Pc13"):Hide()
				oSection1:Cell("Pc13"):HideHeader()
			Case nCntFor = 14
				oSection1:Cell("Pc14"):Hide()
				oSection1:Cell("Pc14"):HideHeader()
			Case nCntFor = 15
				oSection1:Cell("Pc15"):Hide()
				oSection1:Cell("Pc15"):HideHeader()
			Case nCntFor = 16
				oSection1:Cell("Pc16"):Hide()
				oSection1:Cell("Pc16"):HideHeader()

		EndCase
		
	Next
			
	For nCntFor := 1 to mv_par13 //Numero de Ensaiadores
	   /*	If nCntFor > 1 
			oReport:EndPage()
			oSection1:Finish()
			oSection1:Init()
			oReport:SkipLine(1) 
			oReport:ThinLine()
			oReport:PrintText((TitSx3("QM2_INSTR")[1])+": "+TRB_INSTR +"   "+("Data")+": "+Right(TRB_VALREP,2)+"/"+SubStr(TRB_VALREP,5,2)+"/"+Left(TRB_VALREP,4),oReport:Row(),025) 
			oReport:SkipLine(1)	
			oReport:PrintText((TitSx3("QM4_PECA")[1]) +": "+repl('_',60) ,oReport:Row(),025) 
			oReport:SkipLine(1)	
			oReport:PrintText((TitSx3("QM4_CARACT")[1])+": "+repl('_',60),oReport:Row(),025) 
			oReport:SkipLine(1)	
			oReport:PrintText((TitSx3("QM4_NUMERO")[1])+": "+repl('_',60),oReport:Row(),025) 
			oReport:SkipLine(1)	
			oReport:PrintText((TitSx3("QM4_LIE")[1])+": "+If(QM4->(Found()),QM4->QM4_LIE,repl('_',20)) +"   "+(TitSx3("QM4_LSE")[1])+": "+If(QM4->(Found()),QM4->QM4_LSE,repl('_',20)),oReport:Row(),025) 
			oReport:SkipLine(1)	
			oReport:PrintText(OemToAnsi(STR0009)+" :  " + StrZero(mv_par13,2),oReport:Row(),025)//'No.Ensaiadores'
			oReport:SkipLine(1)	
			oReport:PrintText(OemToAnsi(STR0010)+" :  " + StrZero(mv_par14,2),oReport:Row(),025)// 'No.Medicoes' 
			oReport:SkipLine(1)	
			oReport:PrintText(OemToAnsi(STR0011)+" :  " + StrZero(mv_par15,2),oReport:Row(),025)// 'No.Pecas' 
			oReport:SkipLine(1)	
			oReport:ThinLine()
			oReport:SkipLine(1)	 
	   	Endif */
		oSection1:Finish()		
		oSection1:Init()
		oReport:SkipLine(1) 
		oReport:ThinLine()
		oReport:PrintText(OemToAnsi(STR0012)+' '+StrZero(nCntFor,2)+':',oReport:Row(),025) // 'Ensaiador' 
		oReport:ThinLine()
		oReport:SkipLine(1)	
	    For nCntFor2 := 1 to mv_par14 //Numero de Medicoes
			oSection1:Cell("cMed"):SetValue(StrZero(nCntFor2,2)) 
			oReport:SkipLine(1) 
			oSection1:PrintLine()
		Next		
	Next
	
	dbSelectArea(cAlias)
	dbSkip()	
EndDo


QM2->(DbCloseArea())
&(cAlias)->(DbCloseArea())
QM4->(DbCloseArea())

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR240R3³ Autor ³ Wanderley Goncalves   ³ Data ³ 04.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ficha de Repe/Repro por periodo                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR240(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMTR240R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1   :=OemToAnsi( STR0001 ) // "Este programa ira emitir a"
Local cDesc2   :=OemToAnsi( STR0002 ) // "ficha de Repe/Repro."
Local cDesc3   :=""
Local wnrel
Local lImpLin2 := .T.
Local cString  :="QM2"

Private titulo                                 
Private cabec1    := ""
Private cabec2    := ""
Private aReturn   := { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 1, 2, 1, "",1 } // "Zebrado"###"Administra‡„o"
Private nomeprog  := "QMTR240"
Private nLastKey  := 0
Private cPerg     := "QMR240"
Private cTamanho  := "M"
Private Inclui	  := .F.	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("QMR240",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ VARIµVEIS UTILIZADAS PARA PAR¶METROS                ³
//³ mv_par01 : Instrumento Inicial                      ³
//³ mv_par02 : Instrumento Final                        ³
//³ mv_par03 : Periodo Inicial                          ³
//³ mv_par04 : Periodo Final                            ³
//³ mv_par05 : Departamento Inicial                     ³
//³ mv_par06 : Departamento Final                       ³
//³ mv_par07 : Familia de                               ³
//³ mv_par08 : Familia ate                              ³
//³ mv_par09 : Usuario de                               ³
//³ mv_par10 : Usuario ate                              ³
//³ mv_par11 : Fabricante de                            ³
//³ mv_par12 : Fabricante ate                           ³
//³ mv_par13 : No.Ensaiadores                           ³
//³ mv_par14 : No.Ciclos (Medicoes)                     ³
//³ mv_par15 : No.Pecas                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

titulo := OemToAnsi( STR0005 ) // "FICHA REPE/REPRO"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="QMTR240"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.,cTamanho)

If nLastKey = 27
   Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
   Return
Endif

RptStatus({|lEnd| A240Imp(@lEnd,wnRel,cString,lImpLin2)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ a240Imp  ³ Autor ³ Wanderley Goncalves   ³ Data ³ 04.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime corpo da ficha de R&R                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ a240Imp(lEnd,wnRel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function a240Imp(lEnd,wnRel,cString,lImpLin2)

Local cChave 
Local cInstr		:= ""

Private cIndice		:= ""
Private li        := 0
Private tamanho	:= "M"
Private nCol
Private lAbortPrint := .F.
Private cTitInstr	:= TitSx3("QM2_INSTR")[1]
Private cTitPeca	:= TitSx3("QM4_PECA")[1]
Private cCarac		:= TitSx3("QM4_CARACT")[1]
Private cTitNum		:= TitSx3("QM4_NUMERO")[1]
Private cTitLie		:= TitSx3("QM4_LIE")[1]
Private cTitLse		:= TitSx3("QM4_LSE")[1]
Private cTolEsp 	:= TitSx3("QM4_TOLESP")[1]
Private nCtUser := 0
Private lNoImprs := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

SetRegua(RecCount())

dbSelectArea( "QM2" )
dbSetOrder(1)
dbSeek( xFilial() + mv_par01,  .T. )


If mv_par15 < 14  // Numero de pecas
   nCOL := 6
Else
   nCOL := 1
EndIf

cChave := "QM2_FILIAL+QM2_INSTR+QM2_REVINV"
cQuery:= "SELECT QM2_FILIAL,QM2_INSTR,QM2_REVINV,QM2_REVINS,QM2_TIPO,QM2_DEPTO,"
cQuery+= "QM2_VALREP,QM2_FABR,QM2_RESP,QM2_STATUS "
cQuery+= "FROM "+RetSqlName("QM2")+" QM2, "
cQuery+= "WHERE "
cQuery+= "QM2.QM2_FILIAL = '"	+xFilial("QM2")+	"' AND "
cQuery+= "QM2.QM2_INSTR	>= '"	+ mv_par01 +	"' AND " 
cQuery+= "QM2.QM2_INSTR	<= '"	+ mv_par02 +	"' AND " 
cQuery+= "QM2.QM2_VALREP>= '"	+ DtoS(mv_par03) +	"' AND " 
cQuery+= "QM2.QM2_VALREP<= '"	+ DtoS(mv_par04) +	"' AND " 
cQuery+= "QM2.QM2_DEPTO	>= '"	+ mv_par05 +	"' AND " 
cQuery+= "QM2.QM2_DEPTO	<= '"	+ mv_par06 +	"' AND " 
cQuery+= "QM2.QM2_TIPO	>= '"	+ mv_par07 +	"' AND " 
cQuery+= "QM2.QM2_TIPO	<= '"	+ mv_par08 +	"' AND " 
cQuery+= "QM2.QM2_FABR	>= '"	+ mv_par11 +	"' AND " 
cQuery+= "QM2.QM2_FABR	<= '"	+ mv_par12 +	"' AND " 
cQuery+= "QM2.QM2_RESP	>= '"	+ mv_par09 +	"' AND " 
cQuery+= "QM2.QM2_RESP	<= '"	+ mv_par10 +	"' AND " 
cQuery+= "QM2.D_E_L_E_T_= ' ' "
cQuery += "ORDER BY " + SqlOrder(cChave)

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
TcSetField("TRB","QM2_VALREP","D",8,0)		
dbSelectArea( "TRB" )

Do While !Eof() 

	TRB_FILIAL	:= TRB->QM2_FILIAL
	TRB_INSTR	:= TRB->QM2_INSTR
	TRB_REVINV	:= TRB->QM2_REVINV
	TRB_REVINS	:= TRB->QM2_REVINS
	TRB_TIPO	:= TRB->QM2_TIPO
	TRB_DEPTO	:= TRB->QM2_DEPTO
	TRB_VALREP	:= TRB->QM2_VALREP
	TRB_FABR	:= TRB->QM2_FABR
	TRB_RESP	:= TRB->QM2_RESP
	TRB_STATUS	:= TRB->QM2_STATUS

   IncRegua()

   If lAbortPrint
      li := li + 1
      @li,001 PSAY OemToAnsi(STR0006) // "CANCELADO PELO OPERADOR"
      Exit
   EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pula as revisoes anteriores do mesmo instrumento             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If cInstr == TRB_FILIAL + TRB_INSTR 
      dbSkip()
      Loop   
   EndIf
   cInstr := TRB_FILIAL + TRB_INSTR 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se status do instrumento esta ativo				    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If	!QMTXSTAT(TRB_STATUS)			
		dbskip()
		loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao dos resgistros selecionados                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If li > 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
		@ li  ,000 PSAY Repl("*",132)
		li+=2
	   U_R240Cabec(.f.,nCOL,0)
	End

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime corpo da ficha                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	QMTXFRR(mv_par13,mv_par14,mv_par15,'P') // Corpo da Ficha por Periodo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Quebra de c¢pia                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 	li       := 80
	m_pag    := 1

	dbSelectArea("TRB")
	dbSkip()	
EndDo

If !Empty(cInstr)
	Roda( cbCont, cbTxt, Tamanho )
	Set Device To Screen
Endif	
If File(cIndice+OrdBagExt())
	Set Filter To
	RetIndex("QM2")
	dbClearInd()
	FErase(cIndice+OrdBagExt())
	dbCloseArea()
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

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R240CABEC³ Autor ³ Wanderley Goncalves   ³ Data ³ 03.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cabecalho de Ficha de Repe/Repro                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R240CABEC()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR240                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R240Cabec(wCAB,nCOL,nCnt)

Local nCntFor,nCntFor2

li+=2
@ li  , nCOL PSAY alltrim(cTitInstr)+' '+;  // 'Instrumento' 
						repl('.',16-len(alltrim(cTitInstr)))+;
                   ': ' + padr(TRB_INSTR,60) +space(20)+;
                   'Data : ' + DtoC(TRB_VALREP)
li+=2
@ li  , nCOL PSAY alltrim(cTitPeca)+' '+; // 'Peca'
						repl('.',16-len(alltrim(cTitPeca)))+;
                   ': ' + repl('_',60)
li+=2
@ li  , nCOL PSAY alltrim(cCarac)+' '+; // 'Caracteristica'
						repl('.',16-len(alltrim(cCarac)))+;
                   ': ' + repl('_',60)
li+=2
@ li  , nCOL PSAY alltrim(cTitNum)+' '+;  // Numero
						repl('.',16-len(alltrim(cTitNum)))+;
                   ': ' + repl('_',60)
li+=2

QM4->(DbSetOrder(1))
QM4->(DbSeek(xFilial("QM4")+TRB_INSTR+TRB_REVINS))

@ li  , nCOL PSAY alltrim(cTitLie)+' '+; // 'LIE' 
						repl('.',16-len(alltrim(TitSx3("QM4_LIE")[2])))+;
 	                ': ' + If(QM4->(Found()),QM4->QM4_LIE,repl('_',15))
@ li  , 40+nCOL PSAY alltrim(cTitLse)+' '+; // 'LSE'
						repl('.',16-len(alltrim(TitSx3("QM4_LSE")[2])))+;
 	                ': ' + If(QM4->(Found()),QM4->QM4_LSE,repl('_',15))
If QM4->QM4_TPMSA=="3"
	@ li  , 60+nCOL PSAY alltrim(cTolEsp)+' '+; // 'LSE'
						repl('.',16-len(alltrim(TitSx3("QM4_TOLESP")[2])))+;
 	                ': ' + If(QM4->(Found()),QM4->QM4_TOLESP,repl('_',20))
EndIf
li+=2
@ li  ,    nCOL PSAY OemToAnsi(STR0009)+" :  " + StrZero(mv_par13,2) // 'No.Ensaiadores'
@ li  , 49+nCOL PSAY OemToAnsi(STR0010)+" :  " + StrZero(mv_par14,2) // 'No.Medicoes'
@ li  , 93+nCOL PSAY OemToAnsi(STR0011)+" :  " + StrZero(mv_par15,2) // 'No.Pecas'

If wcab
	li+=2
   @ li  , nCOL PSAY repl('=',9*mv_par15+8)
	li++
   @ li  , nCOL PSAY '| ' + OemToAnsi(STR0012)+' '+StrZero(nCnt,2)+':' // 'Ensaiador'
   @ li  , nCOL+9*mv_par15+7 PSAY '|'
	li++
   @ li  , nCOL PSAY repl('-',9*mv_par15+8)
   For nCntFor := 1 to mv_par14
      If nCntFor == 1
			li++
         @ li  , nCOL PSAY '|      |'
         For nCntFor2 := 1 to mv_par15   
            @ li  ,pcol() PSAY   subs(alltrim(OemToAnsi(STR0013)),1,4)+StrZero(nCntFor2,2)+'  |'  // "PECA"
         Next
			li++
			@ li  , nCOL     PSAY repl('-',9*mv_par15+8)
      EndIf    
   Next
EndIf

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R240Valida ³ Autor ³Wanderley Gon‡alves  ³ Data ³ 03.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida quantidade de ensaiadores, pecas e ciclos           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R240Valida(cVAR)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cVar := indica tipo de campo                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Pergunte -> QMR240                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R240Valida(cVar)

Local lMessage := .F.
Local lRet := .T.
Local _bck

If cVar == "ENSR" .and. (mv_par13 < 2 .or. mv_par13 > 15 )
      lMessage := .t.
ElseIf cVar == "PECA" .and. (mv_par15 < 2 .or. mv_par15 > 15 )
      lMessage := .t.
ElseIf cVar == "CICL" .and. (mv_par14 < 1 .or. mv_par14 > 15 )
      lMessage := .t.
EndIf

If lMessage
	_bck := __cSx1Hlp	
   Help(" ",1,"QMTRAVISO")  	// Para ensaios Especifica‡„o ou Processo:
				// Min. ensaiadores, pecas ou ciclos:  2
                            	// Max. ensaiadores, pecas ou ciclos: 15
				// Para ensaios m‚todo curto:
				// 2 ensaiadores, 1 ciclo, 5 a 15 pe‡as
	__cSx1Hlp := _bck
   lRet := .F.
EndIf

Return(lRet)

