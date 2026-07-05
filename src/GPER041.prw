/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER041.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER041   ºAutor  ³Silvia Taguti       º Data ³  10/01/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio para complemento da Cuota Mutual - Uruguai        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º         ACTUALIZACIONES EFECTUADAS DESDE LA CODIFICACION INICIAL      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºProgramador ³ Fecha  ³ BOPS ³  Motivo de la Alteracao                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºTatiane     ³10/08/06³100711³ Conversao para relatorio personalizavel  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programador  ³ Data     ³ FNC            ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³±±
±±³Rogerio R.   ³29/07/2009³00000018278/2009³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±± 
±±³Francisco Jr ³23/09/2009³00000028371/2009³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Gper041()

Local oReport 

Private cCCCuota	:= ""
Private nDisseCot := 0
Private nFuncs    := 0
Private nTotcmc	:= 0
Private cPicVlr 	:= TM(99999999,12,MsDecimais(1))

	If FindFunction("TRepInUse") .And. TRepInUse()

		//-- Interface de impressao
		Pergunte("GPR041",.F.)
	   oReport := ReportDef()
   	oReport:PrintDialog()
 	Else
 		U_Gper041R3()
	EndIF    

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ R.H. - Tatiane Matias ³ Data ³ 10.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do relatorio                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
                                  
//-- Objeto Relatorio
Local oReport  

//-- Objeto Section
Local oSection1

Local aOrd		:= {STR0003}			// "Matricula"
Local	cDesc		:=	STR0001 + ". "+STR0002	// "Folha de Pagamento" # "Ser  impresso de acordo com os parametros solicitados pelo usuario."

	//-- Inicio definicao do Relatorio
	DEFINE REPORT oReport NAME "GPER041" TITLE OemToAnsi(STR0006) PARAMETER "GPR041" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION cDesc TOTAL IN COLUMN
                                     
		//-- Section de Funcionario
		DEFINE SECTION oSection1 OF oReport TABLES "SRA" TITLE STR0013 ORDERS aOrd TOTAL IN COLUMN
		oSection1:SetHeaderBreak(.T.)
		oSection1:SetLineStyle(.T.)
				
			DEFINE CELL NAME "REFERENCIA" OF oSection1 TITLE STR0012 BLOCK {|| StrZero(Month(dDataRef),2)+"/"+StrZero(Year(dDataRef),4) } SIZE 7
			DEFINE CELL NAME "BENEF" 		OF oSection1 TITLE STR0008 BLOCK {|| nFuncs } 								PICTURE cPicVlr SIZE 15
			DEFINE CELL NAME "IMPOSTO" 	OF oSection1 TITLE STR0011 BLOCK {|| nTotCmc } 								PICTURE cPicVlr SIZE 15
			DEFINE CELL NAME "VALOR" 		OF oSection1 TITLE STR0009 BLOCK {|| nDisseCot }							PICTURE cPicVlr SIZE 15
			DEFINE CELL NAME "COMPL" 		OF oSection1 TITLE STR0007 BLOCK {|| (nDisseCot * nFuncs)-nTotCMC }	PICTURE cPicVlr SIZE 15
			DEFINE CELL NAME "CC" 	  		OF oSection1 TITLE STR0013 BLOCK {|| Padl(cCCCuota,14) }	SIZE 15
                                                                
			oSection1:Cell("REFERENCIA"):SetCellBreak(.T.)
			oSection1:Cell("BENEF"):SetCellBreak(.T.)
			oSection1:Cell("IMPOSTO"):SetCellBreak(.T.)
			oSection1:Cell("VALOR"):SetCellBreak(.T.)
			oSection1:Cell("COMPL"):SetCellBreak(.T.)
			oSection1:Cell("CC"):SetCellBreak(.T.)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PrintReport³ Autor ³ R.H. - Tatiane Matias   ³ Data ³ 08.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Liquidos - Relatorio Personalizavel                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis Locais                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//-- Objeto

Local oSection1 	:= oReport:Section(1) 		// Funcionario

//-- String
Local cAcessaSRA  := &("{ || " + ChkRH("GPER030","SRA","2") + "}")
Local cMesAnoRef	:= ""
Local cMesArqRef  := ""
Local cArqMov     := ""
Local nReg			:= 0
//-- Array
Local aOrdBag     := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis Privadas                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//-- String
Private cAliasMov := ""

//-- Array
Private aCodFol  	:= {}  
Private aInfo   	:= {}

dDataRef := mv_par01
lAguinal := If(mv_par02 == 1,.T.,.F.)
cFilDe   := mv_par03
cFilAte  := mv_par04
cCcDe    := mv_par05
cCcAte   := mv_par06
cMatDe   := mv_par07
cMatAte  := mv_par08
cSituacao:= mv_par09    //  Situacao         
cCategoria:= mv_par10    // Categorias a serem calculadas

cMesAnoRef := StrZero(Month(dDataRef),2) + StrZero(Year(dDataRef),4)
cMesArqRef := cMesAnoRef

#IFDEF TOP
	cAliasQry := GetNextAlias()

	//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeSqlExpr("GPR041")
	cSitQuery := ""
	//-- Modifica variaveis para a Query
	For nReg:=1 to Len(cSituacao)
		cSitQuery += "'"+Subs(cSituacao,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cSituacao)
			cSitQuery += "," 
		Endif
	Next nReg     
	cSitQuery := "%" + cSitQuery + "%"
	oSection1:BeginQuery()

	cCatQuery := ""
	For nReg:=1 to Len(cCategoria)
		cCatQuery += "'"+Subs(cCategoria,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cCategoria)
			cCatQuery += "," 
		Endif
	Next nReg        
	cCatQuery := "%" + cCatQuery + "%"

	cOrdem := "%RA_FILIAL,RA_MAT%"

	BeginSql alias cAliasQry

	SELECT *
	FROM %table:SRA% SRA 
	WHERE	SRA.RA_FILIAL 	>= %exp:MV_PAR03% AND SRA.RA_FILIAL	<= %exp:MV_PAR04% AND
			SRA.RA_CC 		>= %exp:MV_PAR05% AND SRA.RA_CC		<= %exp:MV_PAR06% AND
			SRA.RA_MAT 		>= %exp:MV_PAR07% AND SRA.RA_MAT	<= %exp:MV_PAR08% AND
			SRA.RA_SITFOLH  IN (%exp:Upper(cSitQuery)%) AND
		    SRA.RA_CATFUNC	IN (%exp:Upper(cCatQuery)%)	AND
		  	SRA.%notDel%   
			ORDER BY %exp:cOrdem%
	EndSql
	oSection1:EndQuery()
#ELSE                      
	cAliasQry 	:= "SRA"

	//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeAdvplExpr("GPR041")

	cIndCond	:= "RA_FILIAL+RA_MAT"

	cCond	:= '(cAliasQry)->RA_FILIAL 	>= "' 	+ MV_PAR03	 + '".AND.  (cAliasQry)->RA_FILIAL	<= "'	+ MV_PAR04 + '".AND.'
	cCond	+= '(cAliasQry)->RA_CC		>= "'  	+ MV_PAR05 	 + '".AND. 	(cAliasQry)->RA_CC   	<= "'	+ MV_PAR06 + '".AND.'
	cCond	+= '(cAliasQry)->RA_MAT		>= "' 	+ MV_PAR07 	 + '".AND. 	(cAliasQry)->RA_MAT 	<= "'	+ MV_PAR08 + '".AND.'
	cCond	+= '(cAliasQry)->RA_SITFOLH $ "'    + cSituacao  + '".AND.  (cAliasQry)->RA_CATFUNC $ "' 	+ cCategoria +'"'

  	oSection1:SetFilter(cCond,cIndCond) 

#ENDIF	

	dbSelectArea( cAliasQry )
	dbGoTop()
	
	//-- Define o total da regua da tela de processamento do relatorio
	oReport:SetMeter((cAliasQry)->( RecCount() ))  

	cFilialAnt := Space(FWGETTAMFILIAL)
	cMatAnt := ""
	
	While !(cAliasQry)->(EOF())
	
		//-- Incrementa a régua da tela de processamento do relatório
  		oReport:IncMeter()
                                
		//-- Verifica se o usuário cancelou a impressão do relatorio
		If oReport:Cancel()
			Exit
		EndIf               

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Consiste Parametrizacao do Intervalo de Impressao            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ((cAliasQry)->RA_MAT < cMatDe)     .Or. ((cAliasQry)->Ra_MAT > cMatAte)     .Or. ;
			((cAliasQry)->RA_CC < cCcDe)       .Or. ((cAliasQry)->Ra_CC > cCcAte)
			(cAliasQry)->(dbSkip(1))
			Loop
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica Data Demissao         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cSitFunc := (cAliasQry)->RA_SITFOLH
		dDtPesqAf:= CTOD("01/" + Left(cMesAnoRef,2) + "/" + Right(cMesAnoRef,4),"DDMMYY")
		If cSitFunc == "D" .And. (!Empty((cAliasQry)->RA_DEMISSA) .And. MesAno((cAliasQry)->RA_DEMISSA) > MesAno(dDtPesqAf))
			cSitFunc := " "
		Endif	
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Consiste situacao e categoria dos funcionarios			     |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !( cSitFunc $ cSituacao ) .OR.  ! ( (cAliasQry)->RA_CATFUNC $ cCategoria )
			dbSkip()
			Loop
		Endif
		If cSitFunc $ "D" .And. Mesano((cAliasQry)->RA_DEMISSA) # Mesano(dDataRef)
			dbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Consiste controle de acessos e filiais validas				 |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	 	If !((cAliasQry)->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
	  		dbSkip()
	    	Loop
	  	EndIf
	
		If (cAliasQry)->RA_Filial # cFilialAnt
			If ! Fp_CodFol(@aCodFol,(cAliasQry)->Ra_Filial) .Or. ! fInfo(@aInfo,(cAliasQry)->Ra_Filial)
				Exit
			Endif
			dbSelectArea((cAliasQry))
			cFilialAnt := (cAliasQry)->RA_FILIAL
		Endif
	
		dbSelectArea("SRC")
		dbSetOrder(1)
		If dbSeek((cAliasQry)->RA_FILIAL + (cAliasQry)->RA_MAT)
			While !Eof() .And. SRC->RC_FILIAL+SRC->RC_MAT == (cAliasQry)->RA_FILIAL+(cAliasQry)->RA_MAT
	      	If (SRC->RC_PD == aCodFol[309,1]) .or. (SRC->RC_PD == aCodFol[356,1]) .Or.(SRC->RC_PD == aCodFol[357,1])
					If RC_MAT <> cMatAnt
						nFuncs++
						cMatAnt	:=	SRC->RC_MAT
					Endif
					nTotCMC	+=	SRC->RC_VALOR
				Endif	
	    		If SRC->RC_PD == aCodFol[303,1]
					nTotCMC	+=	SRC->RC_VALOR
				Endif
				DbSkip()
			Enddo
		Endif
		If lAguinal
			dbSelectArea( "SRI" )
			dbSetOrder(1)
			If dbSeek((cAliasQry)->RA_FILIAL + (cAliasQry)->RA_MAT)
				While !Eof() .And. SRI->RI_FILIAL+SRI->RI_MAT == (cAliasQry)->RA_FILIAL+(cAliasQry)->RA_MAT
	      		If SRI->RI_PD == aCodFol[359,1]
						nTotCMC	+=	SRI->RI_VALOR
					Endif	
	 				DbSkip()
				Enddo
		   Endif
		Endif	
		DbSelectArea((cAliasQry))
		dbSkip() 
	EndDo       
	
	oReport:PrintText(STR0010+aInfo[3]+" "+cFilialAnt+" - "+aInfo[1])
	oReport:ThinLine()
	oReport:SkipLine()
	
	If nTotCmc > 0
		If nTotCmc < (nDisseCot * nFuncs)
			oSection1:Init()
			oSection1:PrintLine()
			oSection1:Finish()
	   Endif
	Endif   
	   
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona arq. defaut do Siga caso Imp. Mov. Anteriores      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty( cAliasMov )
		fFimArqMov( cAliasMov , aOrdBag , cArqMov )
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Termino do relatorio                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SRC")
	dbSetOrder(1)          // Retorno a ordem 1
	dbSelectArea("SRI")
	dbSetOrder(1)          // Retorno a ordem 1
	
Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER041R3 ºAutor  ³Silvia Taguti       º Data ³  10/01/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio para complemento da Cuota Mutual - Uruguai        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Gper041R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1 	:= STR0001		//"Folha de Pagamento"
Local cDesc2 	:= STR0002		//"Ser  impresso de acordo com os parametros solicitados pelo usuario."
Local cDesc3 	:= " "		   //"Obs. Dever  ser impressa uma Folha/Resumo para cada Tipo de Contrato."
Local cString	:= "SRA"        				// alias do arquivo principal (Base)
Local aOrd      := {STR0003}		//"C.Custo do Cadastro"###"Matricula"###"Nome"###"C.Custo do Movto."###"C.Custo + Nome"
Local cMesAnoRef

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn := { STR0004, 1,STR0005, 1, 2, 1,"",1 }	//"Zebrado"###"Administra‡„o"
Private nomeprog:= "GPER041"
Private nTipo   := "P"
Private aLinha  := {},nLastKey := 0
Private cPerg   := "GPR041" 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas na funcao IMPR                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Titulo	:= STR0006		//"IMPRESSŽO DA FOLHA DE PAGAMENTO"
Private AT_PRG  := "GPER041"
Private wCabec0 := 1
Private wCabec1 := ""
Private CONTFL  := 1
Private LI      := 0
Private Tamanho:= "M"
Private cCabec
Private nOrdem
Private aInfo   := {}
Private cTipCC, cRefOco

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("GPR041",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="GPER041"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        //  Data de Referencia para a impressao      ³
//³ mv_par02        //  Aguinaldo                                ³
//³ mv_par03        //  Filial  De                               ³
//³ mv_par04        //  Filial  Ate                              ³
//³ mv_par05        //  Centro de Custo De                       ³
//³ mv_par06        //  Centro de Custo Ate                      ³
//³ mv_par07        //  Matricula De                             ³
//³ mv_par08        //  Matricula Ate                            ³
//³ mv_par09        //  Situacao                                 ³
//³ mv_par10        //  Categoria                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dDataRef := mv_par01
lAguinal := If(mv_par02 == 1,.T.,.F.)
cFilDe   := mv_par03
cFilAte  := mv_par04
cCcDe    := mv_par05
cCcAte   := mv_par06
cMatDe   := mv_par07
cMatAte  := mv_par08
cSituacao:= mv_par09    //  Situacao         
cCateg   := mv_par10    // Categorias a serem calculadas

cMesAnoRef := StrZero(Month(dDataRef),2) + StrZero(Year(dDataRef),4)

RptStatus({|lEnd| R041Imp(@lEnd,wnRel,cString,cMesAnoRef)},Titulo)  // Chamada do Relatorio

Set Device To Screen

If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif

MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R041IMP  ³ Autor ³ R.H. - Silvia Taguti  ³ Data ³ 01.10.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento Para emissao do Relatorio                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ R041IMP(lEnd,Wnrel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R041Imp(lEnd,WnRel,cString,cMesAnoRef)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lIgual                 //Vari vel de retorno na compara‡ao do SRC
Local cArqNew                //Vari vel de retorno caso SRC # SX3
Local aOrdBag     := {}
Local cMesArqRef  
Local cArqMov     := ""
Local aCodBenef   := {}
Local cAcessaSRA  := &("{ || " + ChkRH("GPER030","SRA","2") + "}")
Local cAcessaSRC  := &("{ || " + ChkRH("GPER030","SRC","2") + "}")
Local cAcessaSRI  := &("{ || " + ChkRH("GPER030","SRI","2") + "}")
Local nX				:=	0
Local nDisseCot   := 0
Local Tamanho     := "M"                      
Local cCCCuota
Private cAliasMov := ""
Private aCodFol  	:= {}  
Private nFuncs    := 0
Private nTotcmc	:= 0

cMesArqRef := cMesAnoRef

dbSelectArea( "SRA")
dbSetOrder(1)

dbGoTop()

dbSeek(cFilDe + cMatDe,.T.)
cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
cFim    := cFilAte + cMatAte

SetRegua(RecCount())   // Total de elementos da regua
cFilialAnt := Space(FWGETTAMFILIAL)
cMatAnt := ""

While !SRA->(EOF()) .And. &cInicio <= cFim

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua Processamento                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  	IncRegua()  // Anda a regua

	If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	Endif	 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Parametrizacao do Intervalo de Impressao            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (SRA->RA_MAT < cMatDe)     .Or. (SRA->Ra_MAT > cMatAte)     .Or. ;
		(SRA->RA_CC < cCcDe)       .Or. (SRA->Ra_CC > cCcAte)
		SRA->(dbSkip(1))
		Loop
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica Data Demissao         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSitFunc := SRA->RA_SITFOLH
	dDtPesqAf:= CTOD("01/" + Left(cMesAnoRef,2) + "/" + Right(cMesAnoRef,4),"DDMMYY")
	If cSitFunc == "D" .And. (!Empty(SRA->RA_DEMISSA) .And. MesAno(SRA->RA_DEMISSA) > MesAno(dDtPesqAf))
		cSitFunc := " "
	Endif	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste situacao e categoria dos funcionarios			     |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !( cSitFunc $ cSituacao ) .OR.  ! ( SRA->RA_CATFUNC $ cCateg )
		dbSkip()
		Loop
	Endif
	If cSitFunc $ "D" .And. Mesano(SRA->RA_DEMISSA) # Mesano(dDataRef)
		dbSkip()
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas				 |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 	If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
  		dbSkip()
    	Loop
  	EndIf

	If SRA->RA_Filial # cFilialAnt
		If ! Fp_CodFol(@aCodFol,Sra->Ra_Filial) .Or. ! fInfo(@aInfo,Sra->Ra_Filial)
			Exit
		Endif
		dbSelectArea("SRA")
		cFilialAnt := SRA->RA_FILIAL
	Endif

	dbSelectArea("SRC")
	dbSetOrder(1)
	If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT)
		While !Eof() .And. SRC->RC_FILIAL+SRC->RC_MAT == SRA->RA_FILIAL+SRA->RA_MAT
      	If (SRC->RC_PD == aCodFol[309,1]) .or. (SRC->RC_PD == aCodFol[356,1]) .Or.(SRC->RC_PD == aCodFol[357,1])
				If RC_MAT <> cMatAnt
					nFuncs++
					cMatAnt	:=	SRC->RC_MAT
				Endif
				nTotCMC	+=	SRC->RC_VALOR
			Endif	
    		If SRC->RC_PD == aCodFol[303,1]
				nTotCMC	+=	SRC->RC_VALOR
			Endif
			DbSkip()
		Enddo
	Endif
	If lAguinal
		dbSelectArea( "SRI" )
		dbSetOrder(1)
		If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT)
			While !Eof() .And. SRI->RI_FILIAL+SRI->RI_MAT == SRA->RA_FILIAL+SRA->RA_MAT
      		If SRI->RI_PD == aCodFol[359,1]
					nTotCMC	+=	SRI->RI_VALOR
				Endif	
 				DbSkip()
			Enddo
	   Endif
	Endif	
	DbSelectArea('SRA')
	dbSkip() 
EndDo
WCabec1 := STR0010+aInfo[3]+" "+cFilialAnt+" - "+aInfo[1]

If nTotCmc > 0
	If nTotCmc < (nDisseCot * nFuncs)
      cDet:=STR0012+Space(07)+StrZero(Month(dDataRef),2)+"/"+StrZero(Year(dDataRef),4)
		Impr(cDet,"C")                                                    //Data Referencia
		Impr(" ","C")
		Impr(" ","C")
      cDet:=STR0008+"  "+Transform(nFuncs,cPicVlr)								//Qt.Empl
		Impr(cDet,"C")
		Impr(" ","C")
		Impr(" ","C")
		cDet:=STR0011+"  "+Transform(nTotCmc,cPicVlr)                    //Aporte 8%
		Impr(cDet,"C")                                                     
		Impr(" ","C")
		Impr(" ","C")
		cDet:=STR0009+"  "+Transform(nDisseCot,cPicVlr)							//Valor C.Mutual
		Impr(cDet,"C")                                                     
		Impr(" ","C")
		Impr(" ","C")
		cDet:=STR0007+"  "+Transform((nDisseCot * nFuncs)-nTotCMC,cPicVlr) //C.C.Mutual
		Impr(cDet,"C")
		Impr(" ","C")
		Impr(" ","C")
		cDet:=STR0013+"  "+Padl(cCCCuota,14)										   //Centro de Custo
		Impr(cDet,"C")
   Endif
	Impr("","F")

Endif   
   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona arq. defaut do Siga caso Imp. Mov. Anteriores      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty( cAliasMov )
	fFimArqMov( cAliasMov , aOrdBag , cArqMov )
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SRC")
dbSetOrder(1)          // Retorno a ordem 1
dbSelectArea("SRI")
dbSetOrder(1)          // Retorno a ordem 1
dbSelectArea("SRA")
dbSetOrder(1)          // Retorno a ordem 1

Return

