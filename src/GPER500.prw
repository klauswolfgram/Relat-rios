/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GPER500.CH"
#INCLUDE "Report.ch" 
#INCLUDE "Protheus.ch"
#IFDEF TOP
	#INCLUDE "TOPCONN.CH"
#ENDIF

/*

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao      ³ GPER500  ³ Autor  ³ Equipe RH              ³ Data ³ 30/10/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao   ³ Relacao de Movimentacoes de Funcionarios  (TURN-OVER)        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso         ³ Generico                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ FNC      ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±    
±±³Raquel Hager|12/04/13³   M12RH01³Remocao de funcoes e tratamentos para     ³±±
±±³        	   ³        ³    RQ3005³impresso do relatorio em formato R3.      ³±± 
±±³Cícero Alves|22/07/15³ 	Incluido filtro por categorias				      ³±±
±±³        	   ³        ³      												  ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER500() 
Local	oReport   
Local	aArea	:= GetArea()
Local   bAction

Private aEmpresa	:= {} 			//-- Array com  as filiais da Empresa 
Private cPerg		:= "GPR500" 
Private cTitulo		:= OemToAnsi(STR0001)
Private	cAliasSRA	:= "SRA"
Private lRelNew		:= .T.
	
//Verifica as perguntas selecionadas       
Pergunte(cPerg,.F.) 

bAction:={|| cMesAnoI  := mv_par05,cMesAnoF  := mv_par06,;
    		IF(; 
							(  ;
									( 	Empty(stod(right(cMesAnoI,4)+left(cMesAnoI,2)+"01")) .or. ;
					        		    Empty(stod(right(cMesAnoF,4)+left(cMesAnoF,2)+"01"))		;
					        	    ) .OR. ;
							   		( stod(right(cMesAnoI,4)+left(cMesAnoI,2)+"01") > 	stod(right(cMesAnoF,4)+left(cMesAnoF,2)+"01") );
					  		 ) ,;
							(Aviso(STR0015,STR0016,{"OK"},,STR0017), .F.),; //"Atencao"#"Periodo inicial maior que o periodo final ou periodo informado invalido"#"Periodo Invalido")
                  			( PrintReport(oReport)));
          }                    
oReport := ReportDef()
oReport:PrintDialog(bAction)

RestArea( aArea )

Return    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡ao    ³ ReportDef³ Autor ³ Andreia dos Santos ³ Data ³25/08/2006   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Desenvolvimento do relatorio.                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER500                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()   
Local oReport 
Local oSection1 
Local cDesc		:=	STR0001 +". "+  OemToAnsi(STR0013) //"Rela‡„o de Movimenta‡”es Funcionarios (Turn-Over)""Esta rotina faz a impressão das quantidade de movimentacao de funcionarios dentro da empresa, ou seja,  a quantidade de funcionarios demitidos, admitidos e transferidos."
Local aOrd     	:=	{"C.Custo"}

	//-- Inicio definicao do Relatorio
	DEFINE REPORT oReport NAME "GPER500" TITLE OemToAnsi(STR0006) PARAMETER "GPR500" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION cDesc 
	
	      //-- Section de Informacoes
			DEFINE SECTION oSection1 OF oReport ORDERS aOrd TITLE oemToAnsi(STR0012) PAGE BREAK		//-- "Movimentacao de funcionarios"
			
				oSection1:SetHeaderPage(.T.)
				oSection1:SetPageBreak(.T.)
				
				DEFINE CELL NAME "CCUSTO" 		OF oSection1 ALIAS "   " TITLE STR0018 SIZE 45 PIXEL //C.CUSTO
				DEFINE CELL NAME "MESANO" 		OF oSection1 ALIAS "   " TITLE STR0019 SIZE 20 PIXEL //"MES/ANO"
				DEFINE CELL NAME "INICIO" 		OF oSection1 ALIAS "   " TITLE STR0020 PICTURE "@E 999999" SIZE 07 PIXEL //"INICIO"
				DEFINE CELL NAME "ADMISSAO" 	OF oSection1 ALIAS "   " TITLE STR0021 PICTURE "@E 999999" SIZE 07 PIXEL //"ADMISSAO"
				DEFINE CELL NAME "TRANSFENT" 	OF oSection1 ALIAS "   " TITLE STR0022 PICTURE "@E 999999" SIZE 07 PIXEL //"ENT.TRANSF."
				DEFINE CELL NAME "TRANSFSAI" 	OF oSection1 ALIAS "   " TITLE STR0023 PICTURE "@E 999999" SIZE 07 PIXEL //"SAI.TRANSF."
				DEFINE CELL NAME "DEMISSAO" 	OF oSection1 ALIAS "   " TITLE STR0024 PICTURE "@E 999999" SIZE 07 PIXEL //"DEMISSAO"
				DEFINE CELL NAME "FIM" 			OF oSection1 ALIAS "   " TITLE STR0025 PICTURE "@E 999999" SIZE 07 PIXEL //"FIM     "

Return oReport
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport ³ Autor ³ RH- Andreia S.        ³ Data ³ 25/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao do relatorio.		                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ GPER500                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)
// Objeto
Local oSection1 	:= oReport:Section(1)  
Local oBreakCC 
Local aArea			:= SRA->( GetArea() )	// Ponteiros atuais do arquivo SRA
Local _aTurnAux		:= {} 
Local cFiltro		:= "" 
Local aJaContou		:= {}											//-- Armazena funcionario que ja foi contado : "01"-Transferencia / "02"-Admissao
Local cAcessaSRA  	:= &("{ || " + ChkRH("GPER500","SRA","2") + "}")
Local cFilSRE 		:= ""
// Variaveis de controle 
Local nX 			:= 0 
Local nW
Local nAnoMes		:= 0 
Local nTransf		:= 0 
Local lAdmitiu		:= .F. 
Local nInicio		:= 0 
Local cFilialAtu	:= "" 
Local cDet			:= ""
Local cCCAtu		:= ""
Local nTransFil		:= 0
// Define Variaveis Privates (Programa)                         
Private aInfo   	:= {}
Private aTurnOver  	:= {}
Private aTurnOveF  	:= {}
Private lImpressao 	:= .F. 
Private lContou		:= .F. 
Private lTransfAll	:= .F. 			// Carregou aTransfAll  
Private aAnoMes		:= {} 
Private nCont		:= 0 
Private aLog		:= {}			// Log de controle interno- indica a localizacao inicial do func. - Filial/ CC / Mat 
Private aLogTitle 	:= {}
	
	
	// Adiciona as filiais que serao processadas 								
	fAdEmpresa(2, @aEmpresa)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ O B S E R V A C A O !!!!!!         						             	³
	 	//³ Nao e possivel fazer o filtro (R4). E necessario utilizar o filtro da   ³
	 	//³ filial/CC somente na hora de montar o array  de    movimentacao pois  	³
	 	//³ o funcionario pode estar em  uma determinada filial/CC (situacao atual )³ 
	 	//³ e solicitar o relatorio de meses anteriores. Ex. func. na filial 01 (si-³
	 	//³ tuacao no mes 10, eh transferido no mes 12 para a filial 05 ( situacao  ³
	 	//³ atual).Se usuario solicitar movimentacao do mes 10  da filial 01, a movi³
	 	//³ mentacao deste funcionario nao iria aparecer                        	³ 	
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cFilDe    := mv_par01
		cFilAte   := mv_par02
		cCcDe     := mv_par03
		cCcAte    := mv_par04
		cMesAnoI  := mv_par05
		cMesAnoF  := mv_par06
		cCategorias := mv_par07
	            
		//Faz filtro no arquivo...                                                 
		cAliasSRA:= "SRA"
	
		dbSelectArea( "SRE" )
		dbSetOrder( 1 )
			
		dbSelectArea( "SRA" )
		dbSetOrder( 2 )
		(cAliasSRA)->( dbgotop() )					//-- Tenho que varrer todo o SRA independente da Filial e CC escolhido no parametro. 
		cInicio := "SRA->RA_FILIAL + SRA->RA_CC"
		cFim    := cFilAte + cCcAte
			
		cTitulo  := If(AllTrim(oReport:Title()) == AllTrim(cTitulo), cTitulo, oReport:Title())
		oReport:SetTitle(cTitulo)
		
		// Incrementa o Array aTurnOver/aAnoMes Com o Intervalo de Datas
		fR500Add("1")
	
		cFilialAnt 	:= Replicate("!", FWGETTAMFILIAL)
		cCcAnt     	:= "!!"
		
		oSection1:INIT(.F.)
		
		oReport:SetMeter((cAliasSRA)->( RecCount()) ) 
	
		While !(cAliasSRA)->( Eof() )
	
	    	oReport:IncMeter()
		    
			If oReport:Cancel()
				@Prow()+1,0 PSAY cCancel 
				Exit
			EndIf	
			
			If !((cAliasSRA)->RA_CATFUNC $ cCategorias)
				(cAliasSRA)->( dbSkip() )
				Loop
			EndIf
		
			If (cAliasSRA)->RA_FILIAL # cFilialAnt 
				If !fInfo(@aInfo,(cAliasSRA)->RA_FILIAL)
					Exit
				EndIf
				cFilialAnt 	:= (cAliasSRA)->RA_FILIAL
			EndIf
		
			If !Empty((cAliasSRA)->RA_DEMISSA ) .And. MesAno((cAliasSRA)->RA_DEMISSA) <  SubStr(cMesAnoI,3,4) + SubStr(cMesAnoI,1,2) 
				(cAliasSRA)->( dbSkip() )
				Loop
			EndIf 
		
			// Consiste controle de acessos e filiais validas               
			If !((cAliasSRA)->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
				(cAliasSRA)->( dbSkip() )
				Loop
			EndIf 
	
			cCcAnt 		:= (cAliasSRA)->RA_CC
			nReg 		:= (cAliasSRA)->( Recno() ) 
			aTransfAll 	:= {}
			lContou		:= .F. 
			lTransfAll	:= .F. 
			For nAnoMes:= 1 to Len( aAnoMes )
				// Apurar quantidade inicial do C.Custo                                    
				If nAnoMes == 1 	//-- Somente preciso apurar onde o funcionario estava no primeiro periodo
					If  MesAno((cAliasSRA)->RA_ADMISSA) <  aAnoMes[1] .And. ( Empty((cAliasSRA)->RA_DEMISSA) .Or. ; 
				        (MesAno((cAliasSRA)->RA_DEMISSA) >= aAnoMes[1] ) ) 
	        	
						// Carrega o array aTransfAll - TODAS as transferencias do funcionario     
						dbSelectArea( "SRE" )
						fTransfAll( @aTransfAll,,,.T.) 			
	
						// Se nao houve transferencias, entao deve-se contar o func. de acordo com  a    
						// Emp/Filial/CC atual                                                           				
						If Len(aTransfAll) <= 0 .And. (cAliasSRA)->(&cInicio) <= (cAliasSRA)->( cFim )	
							If fR500Acum( (cFilialAnt + AllTrim(cCcAnt) + aAnoMes[1]+cEmpAnt) , cFilialAnt, cCcAnt, 4) 
								ncont ++ 
								aAdd( aLog , cFilialAnt +SPACE(1)+ cCcAnt+SPACE(1) + (cAliasSRA)->RA_MAT+SPACE(1)+ strzero(ncont,4) +SPACE(1)+ " +"  )
							EndIf		
						Else 
							For nX := 1 to Len(aTransfAll)
								// Se houve transferencias, deve-se verificar onde o func. estava no inicio do   
	  							// periodo desejado                                                              
								If aTransfAll[nX,12] < aAnoMes[1] 
									If  ( nX = 1 .And. nX = Len(aTransfAll) ) .Or.  ( nX = Len(aTransfAll)) 
										If fR500Acum( (aTransfAll[nX,10]+alltrim(aTransfAll[nX,06]) + aAnoMes[1] + aTransfAll[nX,04] ) , aTransfAll[nX,10], aTransfAll[nX,06], 4 , aTransfAll[nX,04]) 
											ncont ++ 
											aAdd( aLog , aTransfAll[nX,10]+SPACE(1)+aTransfAll[nX,06]+SPACE(1)+sra->ra_mat+SPACE(1)+strzero(ncont,4)+SPACE(1)+" +" )
										EndIf	
									EndIf
								Else
								    //-- Tenho q garantir que nao vou contar  o funcionario Mais de uma vez quando estiver processando mais de uma filial. 
									// Verifica se não existe Transferência de Filial anterior à Transferência que está sendo avaliada (Centro de Custo/Departamento/Processo)
									// Caso existir, esse funcionário não deve ser contado na coluna Início pois ele será contabilizado por entrada por transferência de filial
									// Quando a impressão é de somente 1 mês/ano, este deve ser usado para validar o período da transferência pois o
									// for principal trabalha somente com o primeiro mês/ano
									nTransFil	:= aScan(aTransfAll, {|x| x[7] < aTransfAll[nX,7] .And. If(Len(aAnoMes) > 1, .T. , x[12] == aAnoMes[nAnoMes] .And. x[10] + x[11] == (cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_MAT ) .And. x[8] + x[9] != (cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_MAT})
									If  (nX = 1 .Or. !lContou) .And. nTransFil == 0  .And. aTransfAll[nX,8] + aTransfAll[nX,9] ==  (cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_MAT 
										If fR500Acum( (aTransfAll[nX,08] +Alltrim(aTransfAll[nX,03]) + aAnoMes[1]+ aTransfAll[nX,01] ) , aTransfAll[nX,8], aTransfAll[nX,03], 4, aTransfAll[nX,01] ) 
											ncont ++
											aAdd( aLog , aTransfAll[nX,08]+SPACE(1)+aTransfAll[nX,03]+SPACE(1)+(cAliasSRA)->ra_mat +SPACE(1)+strzero(ncont,4)+SPACE(1)+ " +"  ) 
										EndIf
									ElseIf aTransfAll[nX,8] != (cAliasSRA)->RA_FILIAL .And. aTransfAll[nX,9] != (cAliasSRA)->RA_MAT
										lContou := .T.
									EndIf 
								EndIf					
							Next nX 
						EndIf	
						lTransfAll	:= .T. 
					EndIf
		 		EndIf 
				#IFDEF TOP	
					DbSelectArea("SRA")
					dbSetOrder(2)
				#ENDIF
		
				// Se nao existe nenhum funcionario no inicio do CC                         
				If !lTransfAll
					dbSelectArea( "SRE" )
					aTransfAll := {}
					fTransfAll( @aTransfAll,,,.T.) 
					lTransfAll	:= .T. 
				EndIf                    
				
				// Apurar a movimentacao do funcionario dentro do periodo                  
				If  Len(aTransfAll) > 0
					// Movtimentacao de transferencias                                         		
					lAdmitiu	:= .F.
					For nTransf := 1 to Len(aTransfAll) 
						If aAnoMes[nAnoMes] == aTransfAll[nTransf,12]  .And. ; 
							(nPos:= Ascan(aJaContou, {|X| X[1] == "01"+aTransfAll[nTransf,1]+aTransfAll[nTransf,2]+aTransfAll[nTransf,3]+ dtos(aTransfAll[nTransf,7])  } ) )<= 0  //-- Empresa De+ Filial De + Matricula De + data 	
							// Apurar Saidas por Transferencia               
							fR500Acum( (aTransfAll[nTransf,08] + Alltrim(aTransfAll[nTransf,03] )+ aAnoMes[nAnoMes] + aTransfAll[nTransf,01] ) , aTransfAll[nTransf,08] , aTransfAll[nTransf,03], 7,aTransfAll[nTransf,01]) 						
							// Apurar Entradas por Transferencia             
							fR500Acum( (aTransfAll[nTransf,10] + Alltrim( aTransfAll[nTransf,06] ) + aAnoMes[nAnoMes]+ aTransfAll[nTransf,04]) , aTransfAll[nTransf,10] , aTransfAll[nTransf,06], 6 ,  aTransfAll[nTransf,04]) 
							// Como ja computou entrada e saida, nao devo con
							// tar novamente qdo estiver processando mais de 
							// uma  filial                                   	
							Aadd(aJaContou, {"01"+aTransfAll[nTransf,1]+aTransfAll[nTransf,2]+aTransfAll[nTransf,3]+ dtos(aTransfAll[nTransf,7] )} ) 
						EndIf         
						
						// Apurar Admissao qdo tem transferencias        
						// Casos onde ha transf. no mesmo mes da admissao 
						
					    If  (nTransf == 1) .And. ( aTransfAll[1,12] >= aAnoMes[nAnoMes] ) .And. aTransfAll[nTransf,08] ==  (cAliasSRA)->RA_FILIAL 
		
							If ( MesAno((cAliasSRA)->RA_ADMISSA) == aAnoMes[nAnoMes] ) .And. !(lAdmitiu) .and. ;
								(nPos:= Ascan(aJaContou, {|X| X[1] == "02"+aTransfAll[nTransf,1]+aTransfAll[nTransf,2]+aTransfAll[nTransf,3]+ DtoS(aTransfAll[nTransf,7])  } ) )<= 0  //-- Empresa De+ Filial De + Matricula De 
								If fR500Acum( (aTransfAll[nTransf,08] + Alltrim( aTransfAll[nTransf,03] ) + aAnoMes[nAnoMes] + aTransfAll[nTransf,01] ) , aTransfAll[nTransf,08] , aTransfAll[nTransf,03], 5, aTransfAll[nTransf,01] ) 
									Aadd(aJaContou, {"02"+aTransfAll[nTransf,1]+aTransfAll[nTransf,2]+aTransfAll[nTransf,3]+ dtos(aTransfAll[nTransf,7] )} ) 
									lAdmitiu	:= .T. 	
								EndIf	
							Endif
						EndIf						
					Next nTransf
				ElseIf (cAliasSRA)->(&cInicio) <= (cAliasSRA)->( cFim )	
					// Admissoes do periodo                                                    
					If MesAno((cAliasSRA)->RA_ADMISSA) = aAnoMes[nAnoMes]
						fR500Acum( (cFilialAnt + AllTrim((cAliasSRA)->RA_CC ) + aAnoMes[nAnoMes]+ cEmpAnt ) , cFilialAnt , (cAliasSRA)->RA_CC, 5 ) 
					EndIf
				EndIf		

				// Demissoes do periodo                                                    
				If MesAno((cAliasSRA)->RA_DEMISSA) = aAnoMes[nAnoMes] .and. !((cAliasSRA)->RA_AFASFGT $ "5*N") .and. !((cAliasSRA)->RA_RESCRAI $ "30/31") .And. (cAliasSRA)->(&cInicio) <= (cAliasSRA)->( cFim )	
					fR500Acum( (cFilialAnt + Alltrim((cAliasSRA)->RA_CC) + aAnoMes[nAnoMes]+ cEmpAnt ) , cFilialAnt , (cAliasSRA)->RA_CC, 8  ) 
				EndIf 
			Next nAnoMes       
			#IFDEF TOP	 
				DbSelectArea("SRA")
				dbSetOrder(2) 
			#ENDIF	
			(cAliasSRA)->( DBSKIP() )
		Enddo

		// Impressao do Relatorio                                       
		If Len(aTurnOver)> 0 
			// Filtra impressao somente das movimentacoes da empresa corrente 
			aEval( aTurnOver , { |x,y| If(aTurnOver[Y,10] = cEmpAnt , aAdd( _aTurnAux , aClone( aTurnOver[y] ) ) , NIL ) } )
		
			aTurnOver:= aClone(_aTurnAux)
		
			aSort( ATurnOver,,, {|x,y| x[10]+x[1]+x[2]+x[3] < y[10]+y[1]+y[2]+y[3]} )
		
			cFilialAtu := aTurnOver[1,1] 
		Endif 	
	
		For Nx := 1 To Len( aTurnOver )
	
			If aTurnOver[Nx,1] # cFilialAtu 
				fSumFilial( cFilialAtu )
	
				oReport:Thinline()
	
			   	For Nw := 1 To Len( aTurnOveF )
			        If Nw ==1
						oSection1:Cell("CCUSTO"):SetValue( STR0014 + " " + cFilialAtu )  //-- TOTAL DA FILIAL 
			        Else
						oSection1:Cell("CCUSTO"):SetValue()
			        EndIf
			
					If !fInfo(@aInfo,aTurnOveF[Nw,01])
						Exit
					EndIf
		
					If nTData == 8
						cDet := SubStr(aTurnOveF[Nw,3],5,2) + " / " + SubStr(aTurnOveF[Nw,3],3,2) 
					Else
						cDet := SubStr(aTurnOveF[Nw,3],5,2) + "/" + SubStr(aTurnOveF[Nw,3],1,4)  
					EndIf 
					
					oSection1:Cell("MESANO"):SetValue(cDet)
					oSection1:Cell("INICIO"):SetValue(aTurnOveF[Nw,4])
					oSection1:Cell("ADMISSAO"):SetValue(aTurnOveF[Nw,5])
					oSection1:Cell("TRANSFENT"):SetValue(aTurnOveF[Nw,6])
					oSection1:Cell("TRANSFSAI"):SetValue(aTurnOveF[Nw,7])
					oSection1:Cell("DEMISSAO"):SetValue(aTurnOveF[Nw,8])
					cDet := ( aTurnOveF[Nw,4] + aTurnOveF[Nw,5] + aTurnOveF[Nw,6] ) - ( aTurnOveF[Nw,7] + aTurnOveF[Nw,8] )
					oSection1:Cell("FIM"):SetValue(cDet)
			
					oSection1:PrintLine()	
				
					// Limpa o conteudo da celula
					oSection1:Cell("MESANO"):SetValue()
					oSection1:Cell("INICIO"):SetValue()
					oSection1:Cell("ADMISSAO"):SetValue()
					oSection1:Cell("TRANSFENT"):SetValue()
					oSection1:Cell("TRANSFSAI"):SetValue()
					oSection1:Cell("DEMISSAO"):SetValue()
					oSection1:Cell("FIM"):SetValue()
				
				Next nW 
	
				aTurnOveF	:= {}
	
				cFilialAtu 	:= aTurnOver[Nx,1]
				cCCAtu		:= ""
				oSection1:Finish()	
				oSection1:INIT(.F.)
			EndIf 
	
			If  !( aTurnOver[Nx,2] == cCCAtu )
				cDet := aTurnOver[Nx,1] + "-"+ aTurnOver[Nx,2] + " - " + SUBSTR(DescCc(aTurnOver[Nx,2],aTurnOver[Nx,1])+SPACE(25),1,25) 
				nInicio := aTurnOver[Nx,4]
				oSection1:Cell("CCUSTO"):SetValue(cDet)
				oReport:Thinline()
			Else
				oSection1:Cell("CCUSTO"):SetValue()
			EndIf     
	
			If nTData == 8
				cDet := SubStr(aTurnOver[Nx,3],5,2) + " / " + SubStr(aTurnOver[Nx,3],3,2) 
			Else
				cDet := SubStr(aTurnOver[Nx,3],5,2) + "/" + SubStr(aTurnOver[Nx,3],1,4) 
			EndIf      
			
			oSection1:Cell("MESANO"):SetValue(cDet)
	
			aTurnOver[Nx,4] := nInicio
			oSection1:Cell("INICIO"):SetValue(aTurnOver[Nx,4])
			oSection1:Cell("ADMISSAO"):SetValue(aTurnOver[Nx,5])
			oSection1:Cell("TRANSFENT"):SetValue(aTurnOver[Nx,6])
			oSection1:Cell("TRANSFSAI"):SetValue(aTurnOver[Nx,7])
			oSection1:Cell("DEMISSAO"):SetValue(aTurnOver[Nx,8])
		
			cDet := ( aTurnOver[Nx,4] + aTurnOver[Nx,5] + aTurnOver[Nx,6] ) - ( aTurnOver[Nx,7] + aTurnOver[Nx,8] ) 
			oSection1:Cell("FIM"):SetValue(cDet)
	
			oSection1:PrintLine()	        
		
			// Limpa o conteudo da celula
			oSection1:Cell("MESANO"):SetValue()
			oSection1:Cell("INICIO"):SetValue()
			oSection1:Cell("ADMISSAO"):SetValue()
			oSection1:Cell("TRANSFENT"):SetValue()
			oSection1:Cell("TRANSFSAI"):SetValue()
			oSection1:Cell("DEMISSAO"):SetValue()
			oSection1:Cell("FIM"):SetValue()
		
			nInicio := ( aTurnOver[Nx,4] + aTurnOver[Nx,5] + aTurnOver[Nx,6] ) - ( aTurnOver[Nx,7] + aTurnOver[Nx,8] )
			cCCAtu	:= aTurnOver[Nx,2]
		Next Nx
	
		// Impressao da ultima filial                                   
		If Len( aTurnOver ) > 0
			fSumFilial( cFilialAtu )
			
			oReport:Thinline()
			For Nw := 1 To Len( aTurnOveF )
		        If Nw ==1
					oSection1:Cell("CCUSTO"):SetValue( STR0014 + " " + cFilialAtu)
		        Else
					oSection1:Cell("CCUSTO"):SetValue()
		        EndIf           
		        
				If !fInfo(@aInfo,aTurnOveF[Nw,01])
					Exit
				EndIf
		
				If nTData == 8
					cDet := SubStr(aTurnOveF[Nw,3],5,2) + " / " + SubStr(aTurnOveF[Nw,3],3,2) 
				Else
					cDet := SubStr(aTurnOveF[Nw,3],5,2) + "/" + SubStr(aTurnOveF[Nw,3],1,4) 
				EndIf   
				
				oSection1:Cell("MESANO"):SetValue(cDet)
				oSection1:Cell("INICIO"):SetValue(aTurnOveF[Nw,4])
				oSection1:Cell("ADMISSAO"):SetValue(aTurnOveF[Nw,5])
				oSection1:Cell("TRANSFENT"):SetValue(aTurnOveF[Nw,6])
				oSection1:Cell("TRANSFSAI"):SetValue(aTurnOveF[Nw,7])
				oSection1:Cell("DEMISSAO"):SetValue(aTurnOveF[Nw,8])
				cDet := ( aTurnOveF[Nw,4] + aTurnOveF[Nw,5] + aTurnOveF[Nw,6] ) - ( aTurnOveF[Nw,7] + aTurnOveF[Nw,8] ) 
				oSection1:Cell("FIM"):SetValue(cDet)
		
				oSection1:PrintLine()	
			
				// Limpa o conteudo da celula
				oSection1:Cell("MESANO"):SetValue()
				oSection1:Cell("INICIO"):SetValue()
				oSection1:Cell("ADMISSAO"):SetValue()
				oSection1:Cell("TRANSFENT"):SetValue()
				oSection1:Cell("TRANSFSAI"):SetValue()
				oSection1:Cell("DEMISSAO"):SetValue()
				oSection1:Cell("FIM"):SetValue()
			
			Next nW 
		EndIf
		
		aTurnOveF	:= {}
		oSection1:Finish()	
	
	RestArea(aArea) 
     
Return        

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ fR500Add ³Autor  ³ Equipe RH          ³ Data ³  11/25/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER500                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fR500Add(cTipo, cFilAtu , cCC, cEmpresa)
Local cAnoMesI  := SubStr(cMesAnoI,3,4) + SubStr(cMesAnoI,1,2)
Local cAnoMesF  := SubStr(cMesAnoF,3,4) + SubStr(cMesAnoF,1,2)
Local nMes 		:= 0 
Local nAno		:= 0 

DEFAULT  	cFilAtu	:= SRA->RA_FILIAL
DEFAULT 	cCC		:= SRA->RA_CC
DEFAULT		cEmpresa:= cEmpant
	
	While Val( cAnoMesI ) <= Val( cAnoMesF ) 
		If cTipo ="1"
			Aadd(aAnoMes    , cAnoMesI )
		ElseIf cTipo = "2"
			Aadd(aTurnOver  ,{cFilAtu, cCC , cAnoMesI , 0 , 0 , 0 , 0 , 0 , 0 , cEmpresa } )
		Else
			Aadd(aTurnOveF  ,{cFilAtu, ""  , cAnoMesI , 0 , 0 , 0 , 0 , 0 , 0 , cEmpresa } )
		EndIf	
		
		nMes := Val(Subs(cAnoMesI,5,2)) + 1
		nAno := Val(Subs(cAnoMesI,1,4)) 
		
		If nMes > 12
			cAnoMesI := StrZero(nAno + 1,4) + "01"
		Else
			cAnoMesI := StrZero(nAno,4) + StrZero(nMes,2)
		EndIf 
		
	EndDo

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ fSumFilial ³Autor  ³ Equipe RH        ³ Data ³  11/28/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Incrementa array aTurnOver/aAnoMes com intervalo de Datas. º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER500                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static function fSumFilial(cFilAtu)
Local nX		:= 0                  
Local nPos		:= 0 
Local aTurnAux	:= {}
	
	// Incrementa o Array aTurnOver/aAnoMes Com o Intervalo de Datas
	fR500Add("3",cFilAtu)
	
	aEval( aTurnOver , { |x,y| IF(aTurnOver[Y,1] == cFilAtu, aAdd( aTurnAux , aClone( aTurnOver[y] ) ) , NIL ) } )
	
	For Nx:= 1  to Len(aTurnAux)
		// Posiciona no CEI/CNPJ (Centro de Custo ) que esta sendo processado		
		If ( nPos := ascan(aTurnOvef, {|z| z[3] == aTurnAux[nX,3]  } )    ) > 0 			//-- Ano/Mes 
			aTurnOveF[nPos,4]	+=  aTurnAux[nX,4]
			aTurnOveF[nPos,5]	+=  aTurnAux[nX,5]
			aTurnOveF[nPos,6]	+=  aTurnAux[nX,6]
			aTurnOveF[nPos,7]	+=  aTurnAux[nX,7]
			aTurnOveF[nPos,8]	+=  aTurnAux[nX,8]	
		EndIf 
	Next nX 

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ fR500ACum ³Autor  ³ Equipe RH         ³ Data ³  12/02/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Incrementa array aTurnOver se Filial/CC pertem a empresa.  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ GPER500                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fR500ACum(cChave, cFilialAtu,cCcusto, nTipo , cEmpresa) 
Local nPos 		:= 0 
Local nEmpAtu	:= 0 
	
	/*
	nTipo 04= Qtde Inicial 
	      05= Admissao 
	      06= Entrada p/transferencias
	      07= Saida p/transferencias
	      08= Demissoes 
	*/
	
	If fChkParam(cFilialAtu, cCcusto )
		// Verifica se Filial /CC pertencem  a empresa atual                 		
		If ( nEmpAtu  := (Ascan( aEmpresa, { |x| Alltrim(x[2]+ X[3]) == AllTrim(cFilialAtu+cCcusto)  } ) > 0) .Or. ;
				        ((nTipo == 7 .Or. nTipo == 4 .Or. nTipo == 5 .Or. nTipo == 6) .And. Ascan( aEmpresa, { |x| Alltrim(x[2]) == Alltrim(cFilialAtu)  } ) > 0 ))
			// Incrementa o Array aTurnOver/aAnoMes Com o Intervalo de Datas
		
			If ( nPos 	:= Ascan( aTurnOver, {|x| x[1]+ x[2]+ x[3]+ x[10] == cChave   } )   ) > 0  	//-- C.C. + Periodo + Empresa 
				aTurnOver[nPos,01]		:= cFilialAtu
				aTurnOver[nPos,02]		:= alltrim(cCcusto )
				aTurnOver[nPos,nTipo]	+= 1  
			Else
				// Incrementa o Array aTurnOver/aAnoMes Com o Intervalo de Datas
				fR500Add("2", cFilialAtu, alltrim(cCcusto ), cEmpresa )
				If ( nPos 	:= Ascan( aTurnOver, {|x| x[1]+ x[2]+ x[3]+ x[10] == cChave } )   ) > 0  	//-- C.C. + Periodo  
					aTurnOver[nPos,01]		:= cFilialAtu
					aTurnOver[nPos,02]		:= Alltrim(cCcusto )
					aTurnOver[nPos,nTipo]	+= 1
				EndIf 
			EndIf 
			lImpressao	:= .T. 
		EndIf 	
	EndIf   
	
	lContou 	:= .T. 

Return( lContou )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GPER500   ³ Autor ³ Equipe RH          ³ Data ³  12/02/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Garante a impressao somente das filiais e C.C. indicadas   º±±
±±º          ³ nos parametros.                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fChkParam(cFilAtu, cCcAtu )                                              
Return ( cFilAtu $ fValidFil() .And.  cFilAtu >= cFilDe .And. cFilAtu <= cFilAte .And. Alltrim(cCcAtu) >= Alltrim(cCcDe)  .And. Alltrim(cCcAtu) <= Alltrim( cCcAte ) )
