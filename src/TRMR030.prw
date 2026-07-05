/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TRMR030.CH"
#INCLUDE "REPORT.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TRMR030  ³ Autor ³ Eduardo Ju            ³ Data ³ 03/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Planejado x Realizado                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TRMR020                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cecilia Car.³31/07/14³TPZWAO³AIncluido o fonte da 11 para a 12 e efetu-³±±
±±³            ³        ³      ³ada a limpeza.                            ³±±
±±³Oswaldo L.  ³03/04/17³DRHPONTP-9   ³Projeto cTree                      ³±±
±±³Renan Borges³02/08/17³DRHPONTP-1196³Ajuste para que o sistema imprime  ³±±
±±³            ³        ³             ³corretamente  os dados tanto no mo-³±±
±±³            ³        ³             ³do Personalizável quanto no tradici³±±
±±³            ³        ³             ³onal.                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TRMR030()

Local oReport
Local aArea := GetArea()

Private nQuantos 	:= 0
Private nMvPlan  	:= GetMV("MV_CUSTCUR") // Somar o custo do curso na 1-Dt Inicio Curso0 2-Dt Fim do curso 3-Ratear pelos dias
Private aMeses	  	:= {}
Private cQual	  	:= ""
Private cTitAux	:= ""
Private cAno		:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TRX030",.F.)
oReport := ReportDef()
oReport:PrintDialog()	

RestArea( aArea )

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef() ³ Autor ³ Eduardo Ju          ³ Data ³ 30.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Definicao do Componente de Impressao do Relatorio           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local oSection1
Local oSection2 //Ora por Valores, Ora por Horas
Local oSection3	//Horas
Local aOrdem    := {}    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:=TReport():New("TRMR030",STR0011,"TRX030",{|oReport| PrintReport(oReport)},STR0052)	//"Planejado x Realizado"#"Será impresso de acordo com os parametros solicitados pelo usuario"
oReport:SetLandscape()	//Imprimir Somente Paisagem
oReport:SetTotalInLine(.F.) //Totaliza em linha

Pergunte("TRX030",.F.)

Aadd( aOrdem, STR0004)	// "Curso"
Aadd( aOrdem, STR0005)	// "Centro de Custo"
Aadd( aOrdem, STR0006)	// "Grupo+Depto"
Aadd( aOrdem, STR0007) 	// "Cargo"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
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
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Primeira Secao:³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
oSection1 := TRSection():New(oReport,STR0011,{"RA4"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oSection1:SetTotalInLine(.F.)  
oSection1:SetHeaderBreak(.T.) 

TRCell():New(oSection1,"RA4_CURSO","RA4",STR0004,,,,{|| cCurso })				//Codigo do Curso    
TRCell():New(oSection1,"RA1_DESC","RA1",,,,,{|| Posicione("RA1",1,xFilial("RA1")+cCurso,"RA1_DESC") }) //Descricao do Curso
TRCell():New(oSection1,"CTT_CUSTO","CTT",STR0005,,,,{|| cCC })					//Codigo do Centro de Custo    
TRCell():New(oSection1,"CTT_DESC01","CTT",,,,,{|| Posicione("CTT",1,xFilial("CTT")+cCC,"CTT_DESC01") }) //Descricao do Centro de Custo      
TRCell():New(oSection1,"Q0_GRUPO","SQ0",STR0014,,,,{|| Substr(cGrupo,1,2) })	//Codigo do Grupo
TRCell():New(oSection1,"Q0_DESCRIC","SQ0",,,,,{|| Posicione("SQ0",1,xFilial("SQ0")+Substr(cGrupo,1,2),"Q0_DESCRIC") }) //Descricao do Grupo
TRCell():New(oSection1,"QB_DEPTO"," ",STR0015,,,,{|| Substr(cGrupo,3,3) })		//Codigo do Depto    
TRCell():New(oSection1,"QB_DESCRIC","SQB",,,,,{|| Posicione("SQB",1,xFilial("SQB")+Substr(cGrupo,3,3),"QB_DESCRIC") }) //Descricao do Depto
TRCell():New(oSection1,"Q3_CARGO","SQ3",STR0007,,,,{|| cCargo }) 				//Codigo do Cargo    
TRCell():New(oSection1,"Q3_DESCSUM","SQ3",,,,,{|| Posicione("SQ3",1,xFilial("SQ3")+cCargo,"Q3_DESCSUM") }) //Descricao do Cargo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿                            
//³ Criacao da Segunda Secao: ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1,STR0001,,/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)
oSection2:SetTotalInLine(.F.)  
oSection2:SetHeaderBreak(.T.)
oSection2:AutoSize()
                
TRCell():New(oSection2,"CURSOS"	,"   ","",,9)	//PLANEJADO OU REALIZADO 
TRCell():New(oSection2,"JANEIRO"	,"   ",	STR0040	,"99999999",8)
TRCell():New(oSection2,"FUNCJAN"	,"   ",	STR0036	,"9999",4)
TRCell():New(oSection2,"FEVEREIRO"	,"   ", STR0041	,"99999999",8)       
TRCell():New(oSection2,"FUNCFEV"	,"   ",	STR0036	,"9999",4)
TRCell():New(oSection2,"MARCO"		,"   ", STR0042	,"99999999",8)
TRCell():New(oSection2,"FUNCMAR"	,"   ",	STR0036	,"9999",4)
TRCell():New(oSection2,"ABRIL"		,"   ", STR0043	,"99999999",8)
TRCell():New(oSection2,"FUNCABR"	,"   ",	STR0036	,"9999",4)
TRCell():New(oSection2,"MAIO"		,"   ", STR0044	,"99999999",8)  
TRCell():New(oSection2,"FUNCMAI"	,"   ",	STR0036	,"9999",4)
TRCell():New(oSection2,"JUNHO"		,"   ", STR0045	,"99999999",8)
TRCell():New(oSection2,"FUNCJUN"	,"   ",	STR0036	,"9999",4)
TRCell():New(oSection2,"JULHO"		,"   ", STR0046	,"99999999",8) 
TRCell():New(oSection2,"FUNCJUL"	,"   ",	STR0036	,"9999",4)
TRCell():New(oSection2,"AGOSTO"		,"   ", STR0047	,"99999999",8)
TRCell():New(oSection2,"FUNCAGO"	,"   ",	STR0036	,"9999",4)
TRCell():New(oSection2,"SETEMBRO"	,"   ", STR0048	,"99999999",8)
TRCell():New(oSection2,"FUNCSET"	,"   ",	STR0036	,"9999",4)
TRCell():New(oSection2,"OUTUBRO"	,"   ", STR0049	,"99999999",8) 
TRCell():New(oSection2,"FUNCOUT"	,"   ",	STR0036	,"9999",4)
TRCell():New(oSection2,"NOVEMBRO"	,"   ", STR0050	,"99999999",8)
TRCell():New(oSection2,"FUNCNOV"	,"   ",	STR0036	,"9999",4)
TRCell():New(oSection2,"DEZEMBRO"	,"   ", STR0051	,"99999999",8)
TRCell():New(oSection2,"FUNCDEZ"	,"   ",	STR0036	,"9999",4)
TRCell():New(oSection2,"TOTAL"		,"   ", STR0038	,"99999999",8)
TRCell():New(oSection2,"FUNC"		,"   ",	STR0036	,"9999",4)

oSection2:Cell("JANEIRO"):SetHeaderAlign("RIGHT")
oSection2:Cell("FEVEREIRO"):SetHeaderAlign("RIGHT")
oSection2:Cell("MARCO"):SetHeaderAlign("RIGHT")
oSection2:Cell("ABRIL"):SetHeaderAlign("RIGHT")
oSection2:Cell("MAIO"):SetHeaderAlign("RIGHT")
oSection2:Cell("JUNHO"):SetHeaderAlign("RIGHT")
oSection2:Cell("JULHO"):SetHeaderAlign("RIGHT")
oSection2:Cell("AGOSTO"):SetHeaderAlign("RIGHT")
oSection2:Cell("SETEMBRO"):SetHeaderAlign("RIGHT")
oSection2:Cell("OUTUBRO"):SetHeaderAlign("RIGHT")
oSection2:Cell("NOVEMBRO"):SetHeaderAlign("RIGHT")
oSection2:Cell("DEZEMBRO"):SetHeaderAlign("RIGHT")
oSection2:Cell("TOTAL"):SetHeaderAlign("RIGHT")


Return oReport

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef() ³ Autor ³ Eduardo Ju          ³ Data ³ 04.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do Relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)

Local cOrder:= ""
Local aLstIndices := {}
Local aLista := {} 
Local aFields 	:= {}
Local cFiltro	:= ""
Local cIndCond	:= ""
Local cFor		:= ""
Local cCodPlan  := ""
Local cFil		:= "" 
Local cAuxFil	:= ""
Local cAcessaRA1:= &("{ || " + ChkRH(FunName(),"RA1","2") + "}")
Local cAcessaRA4:= &("{ || " + ChkRH(FunName(),"RA4","2") + "}")
Local lReal		:= .F.
Local cCargo	:= ""

Private aVlReal
Private aHrReal
Private aNrReal
Private aVlPlan
Private aHrPlan
Private aNrPlan

Private nOrdem 	:=	oReport:Section(1):GetOrder()
Private oTmpTRA 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ MV_PAR01        //  Filial  De                               ³
//³ MV_PAR02        //  Filial  Ate                              ³
//³ MV_PAR03        //  Planejamento De                          ³
//³ MV_PAR04        //  Planejamento Ate                         ³
//³ MV_PAR05        //  Periodo De                               ³
//³ MV_PAR06        //  Periodo Ate                              ³
//³ MV_PAR07        //  Curso De                                 ³
//³ MV_PAR08        //  Curso Ate                                ³
//³ MV_PAR09        //  Cargo De                                 ³
//³ MV_PAR10        //  Cargo Ate                                ³
//³ MV_PAR11        //  Grupo De                                 ³
//³ MV_PAR12        //  Grupo Ate                                ³
//³ MV_PAR13        //  Departamento De                          ³
//³ MV_PAR14        //  Departamento Ate                         ³
//³ MV_PAR15        //  Centro de Custo De                       ³
//³ MV_PAR16        //  Centro de Custo Ate                      ³
//³ MV_PAR17        //  Imprimir por Horas Valor Ambos           ³
//³ MV_PAR18        //  Rateia planejamento Sim/Nao              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Valida os periodos do parametro
If 	MV_PAR05 > MV_PAR06 .Or.;
	(MV_PAR06 - MV_PAR05) > 365
	Help("",1,"Tr030Data")	// Verifique as datas do periodo
	Return .F.
EndIf                  

// Monta as strings do cabecalho
U_Tr30MesesRP()

aVlReal := Array(nQuantos)
aHrReal := Array(nQuantos)
aNrReal := Array(nQuantos)
aVlPlan := Array(nQuantos)
aHrPlan := Array(nQuantos)
aNrPlan := Array(nQuantos)

U_FZeraRP(oReport)

// Variaveis do relatorio
lRet := .T.                                              

// Cria arquivo que sera armazenado os dados dos cursos
AADD(aFields,{"TR_FILIAL", "C", FWGETTAMFILIAL,          0                        } )
AADD(aFields,{"TR_CC"     ,"C", TamSx3("RA_CC")[1],      TamSx3("RA_CC")[2]       } )
AADD(aFields,{"TR_CURSO"  ,"C", TamSx3("RA4_CURSO")[1],  TamSx3("RA4_CURSO")[2]   } )
AADD(aFields,{"TR_DTINI"  ,"D", TamSx3("RA4_DATAIN")[1], TamSx3("RA4_DATAIN")[2]  } )
AADD(aFields,{"TR_DTFIM"  ,"D", TamSx3("RA4_DATAFI")[1], TamSx3("RA4_DATAFI")[2]  } )
AADD(aFields,{"TR_GRUPO"  ,"C", TamSx3("Q3_GRUPO")[1],   TamSx3("Q3_GRUPO")[2]    } )
AADD(aFields,{"TR_DEPTO"  ,"C", TamSx3("Q3_DEPTO")[1],   TamSx3("Q3_DEPTO")[2]    } )
AADD(aFields,{"TR_CARGO"  ,"C", TamSx3("Q3_CARGO")[1],   TamSx3("Q3_CARGO")[2]    } )
AADD(aFields,{"TR_VALOR"  ,"N", TamSx3("RA4_VALOR")[1],  TamSx3("RA4_VALOR")[2]   } )
AADD(aFields,{"TR_HORAS"  ,"N", TamSx3("RA4_HORAS")[1],  TamSx3("RA4_HORAS")[2]   } )
 
If nOrdem == 1 		// Planejamento
	aLista := {"TR_CURSO"}
ElseIf nOrdem == 2	// Centro de Custo
	aLista := {"TR_FILIAL","TR_CC","TR_CURSO"}
ElseIf nOrdem == 3	// Grupo + Departamento	
	aLista := {"TR_FILIAL","TR_GRUPO","TR_DEPTO","TR_CURSO"}
ElseIf nOrdem == 4	// Cargo
	aLista := {"TR_FILIAL","TR_CARGO","TR_CURSO"}
EndIf

AAdd( aLstIndices, aLista)

oTmpTRA := RhCriaTrab("TRA", aFields, aLstIndices)
dbselectarea("TRA")
dbGoTop()

dbSelectArea("RA1")
dbSetOrder(1)
cFil := xFilial("RA1", MV_PAR01)
dbSeek(cFil+MV_PAR07,.T.)

While !Eof() .And. RA1->RA1_FILIAL <= MV_PAR02 .And. RA1->RA1_CURSO <= MV_PAR08

  	If !Eval(cAcessaRA1)
		dbSkip()  
		Loop
	EndIf
	
	//Verifica os cursos realizados
    dbSelectArea("RA4")
    IndRegua( "RA4", "05", "RA4->RA4_CURSO+dtos(RA4->RA4_DATAIN)+RA4_FILIAL",,, "")                                                
    lReal := .F.
    dbSeek(RA1->RA1_CURSO+dTos(MV_PAR05)+xFilial("RA4",MV_PAR01),.T.)
    While !Eof() .And. RA1->RA1_CURSO == RA4->RA4_CURSO .And. RA4->RA4_FILIAL <= MV_PAR02 

    	If (RA4->RA4_DATAIN < MV_PAR05) .Or. (RA4->RA4_DATAIN > MV_PAR06)
        	dbSkip()
        	Loop
     	Endif
     	
    	If !Eval(cAcessaRA4)
			dbSkip()  
			Loop
		EndIf    	        
		
		If !Empty(oReport:Section(1):GetAdvplExp()) .AND. !&(oReport:Section(1):GetAdvplExp())
			dbSkip()
			Loop
		EndIF

		// Verifica o funcionario
		dbSelectArea("SRA")
		dbSetOrder(1)                                     
		cFil := xFilial("SRA", RA4->RA4_FILIAL)
		If dbSeek(cFil+RA4->RA4_MAT)
			If 	(SRA->RA_CC < MV_PAR15) .Or.;
				(SRA->RA_CC > MV_PAR16)  //.Or.;
			   	 //SRA->RA_SITFOLH == "D"
			   	 
				 dbSelectArea("RA4")
				 dbSkip()
				 Loop
			EndIf
	
			cCargo := fGetCargo(SRA->RA_MAT,SRA->RA_FILIAL)			
			
			If cCargo < MV_PAR09 .Or. cCargo > MV_PAR10
				 
				dbSelectArea("RA4")
				dbSkip()
				Loop
			EndIf
				
			dbSelectArea( "SQ3" )
			dbSetOrder(1)
			cFil := xFilial("SQ3", SRA->RA_FILIAL)
			If dbSeek(cFil + cCargo + SRA->RA_CC) .Or. dbSeek(cFil + cCargo)
				If	SQ3->Q3_GRUPO < MV_PAR11 .Or.;
					SQ3->Q3_GRUPO > MV_PAR12 .Or.;
					SQ3->Q3_DEPTO < MV_PAR13 .Or.;
					SQ3->Q3_DEPTO > MV_PAR14
				
					dbSelectArea("RA4")
					dbSkip()
					Loop
				EndIf
			EndIf
					
	 		RecLock("TRA",.T.)
				Replace TRA->TR_FILIAL		With SRA->RA_FILIAL
				Replace TRA->TR_CC			With SRA->RA_CC
				Replace TRA->TR_CURSO		With RA4->RA4_CURSO
				Replace TRA->TR_GRUPO		With SQ3->Q3_GRUPO
				Replace TRA->TR_DEPTO		With SQ3->Q3_DEPTO
				Replace TRA->TR_CARGO		With SQ3->Q3_CARGO
				Replace TRA->TR_VALOR		With RA4->RA4_VALOR
				Replace TRA->TR_HORAS		With RA4->RA4_HORAS 
				Replace TRA->TR_DTINI		With RA4->RA4_DATAIN
				Replace TRA->TR_DTFIM		With RA4->RA4_DATAFI
	 			MsUnlock()
	 			lReal := .T.
		Endif
	
		dbSelectArea("RA4")
    	dbSkip()
	EndDo
		                             
	// Verifica se existe Planejamento qdo. nao tiver Realizado.
	If !lReal
    	U_Tr030PlanRP()
 	EndIf
	
	dbSelectArea("RA1")
	dbSetOrder(1)
    dbSkip()
EndDo
         
U_Tr030Print(oReport)

Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ Tr030Print ³ Autor ³ Eduardo Ju          ³ Data ³ 04.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Funcao que imprime os dados do planejamento x realizado    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Tr030Print()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRMR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/   
User Function Tr030Print(oReport)

Local lRet 	:= .T.
Local nVx	:= 0
Local Det	:= ""
       
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oBreak

Private cCurso	:= ""
Private cCC		:= ""
Private cGrupo 	:= ""
Private cCargo	:= ""
Private nVezes	:= 0
Private nCont	:= 0

// Define se sera impresso horas, valor ou ambos                   
If MV_PAR17 == 3  
	nVezes := 2
Else
	nVezes := 1
EndIf		                   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Troca do Titulo do Relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
cAno := STR(Year(MV_PAR05))
If !(AllTrim(oReport:Title())==AllTrim(STR0011))
	cTitle	:= oReport:Title() + " em " + IIF(MV_PAR17 == 2,"Horas","Valor") + " - Ano: " + Alltrim(cAno)
	cTitAux	:= oReport:Title()
Else
	cTitle := STR0011 + " em " + IIF(MV_PAR17 == 2,"Horas","Valor") + " - Ano: " + Alltrim(cAno)
	cTitAux	:= STR0011
Endif
oReport:SetTitle(cTitle) 

//-- Quebrar pagina por tipo de dados (Hora ou Valor)
DEFINE BREAK oBreak 	OF oReport WHEN {|| cQual } TITLE STR0001
oBreak:SetPageBreak(.T.)                
oBreak:OnBreak({|| oReport:SetTitle(cTitAux + " em Horas - Ano: " + Alltrim(cAno)) })

For nVx:= 1 To nVezes
             
	If nVezes == 1
		cQual := IIF(MV_PAR17 ==1,"V","H")
	Else
		cQual := IIF(nVx==1,"V","H")
	EndIf
                              
	dbSelectArea("TRA")
	dbGotop()
		
	oReport:SetMeter(RecCount())
	                                  
	While !Eof()
	
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
                       
		If lRet
			lRet:= .F.
			If nOrdem == 1
				oSection1:Cell("CTT_CUSTO"):Disable()
				oSection1:Cell("CTT_DESC01"):Disable()
				oSection1:Cell("Q0_GRUPO"):Disable()
				oSection1:Cell("Q0_DESCRIC"):Disable()
				oSection1:Cell("QB_DEPTO"):Disable()
				oSection1:Cell("QB_DESCRIC"):Disable()
				oSection1:Cell("Q3_CARGO"):Disable()
				oSection1:Cell("Q3_DESCSUM"):Disable() 
			ElseIf nOrdem == 2
				cCC	  := TRA->TR_CC	
				TRPosition():New(oSection1,"CTT",1,{|| RhFilial("CTT", TRA->TR_FILIAL) + cCC})   		
				oSection1:Cell("Q0_GRUPO"):Disable()
				oSection1:Cell("Q0_DESCRIC"):Disable()
				oSection1:Cell("QB_DEPTO"):Disable()
				oSection1:Cell("QB_DESCRIC"):Disable()
				oSection1:Cell("Q3_CARGO"):Disable()
				oSection1:Cell("Q3_DESCSUM"):Disable()				
			ElseIf nOrdem == 3			
				cGrupo:= TRA->TR_GRUPO+TRA->TR_DEPTO 
   			TRPosition():New(oSection1,"SQ0",1,{|| RhFilial("SQ0", TRA->TR_FILIAL) + Substr(cGrupo,1,2)}) 
				TRPosition():New(oSection1,"SQB",1,{|| RhFilial("SQB", TRA->TR_FILIAL) + Substr(cGrupo,3,3)})  
				oSection1:Cell("CTT_CUSTO"):Disable()
				oSection1:Cell("CTT_DESC01"):Disable()
				oSection1:Cell("Q3_CARGO"):Disable()
				oSection1:Cell("Q3_DESCSUM"):Disable()
			ElseIf nOrdem == 4
				cCargo:= TRA->TR_CARGO 
				TRPosition():New(oSection1,"SQ3",1,{|| RhFilial("SQ3", TRA->TR_FILIAL) + cCargo}) 
				oSection1:Cell("CTT_CUSTO"):Disable()
				oSection1:Cell("CTT_DESC01"):Disable()
				oSection1:Cell("Q0_GRUPO"):Disable()
				oSection1:Cell("Q0_DESCRIC"):Disable()
				oSection1:Cell("QB_DEPTO"):Disable()
				oSection1:Cell("QB_DESCRIC"):Disable()
			EndIf	
			cCurso := TRA->TR_CURSO          
		EndIf   
		
		TRPosition():New(oSection1,"RA1",1,{|| RhFilial("RA1", TRA->TR_FILIAL) + cCurso}) 	
							
		If nOrdem == 1				// Curso		
		   	If cCurso # TRA->TR_CURSO
		   		
		   		oSection1:Init()
		   		oSection1:Printline()
		   		oSection1:Finish()
		   		
				U_Tr030RPVerPlan(oSection2)
				cCurso  := TRA->TR_CURSO 
			EndIf	
			U_Tr030Sum(oReport)
		ElseIf nOrdem == 2 		// Centro de Custo
			If cCC # TRA->TR_CC .Or. cCurso # TRA->TR_CURSO  
			   
			 	oSection1:Init()
		   		oSection1:Printline()
		   		oSection1:Finish()
			               
				U_Tr030RPVerPlan(oSection2)
				If cCC # TRA->TR_CC
					cCC := TRA->TR_CC         
				EndIf
				cCurso := TRA->TR_CURSO
			EndIf	
			U_Tr030Sum(oReport)
		ElseIf nOrdem == 3		// Grupo+Depto
			If cGrupo # TRA->TR_GRUPO+TRA->TR_DEPTO .Or. cCurso # TRA->TR_CURSO
			 
				oSection1:Init()
		   		oSection1:Printline()
		   		oSection1:Finish()
			
				U_Tr030RPVerPlan(oSection2)
				If cGrupo # TRA->TR_GRUPO+TRA->TR_DEPTO   
					cGrupo	:= TRA->TR_GRUPO+TRA->TR_DEPTO
				EndIf	
				cCurso  := TRA->TR_CURSO 				
			EndIf	
			U_Tr030Sum(oReport)
		ElseIf nOrdem == 4		// Cargo
			If cCargo # TRA->TR_CARGO .Or. cCurso # TRA->TR_CURSO
			
				oSection1:Init()
		   		oSection1:Printline()
		   		oSection1:Finish()
			
				U_Tr030RPVerPlan(oSection2)
				If cCargo # TRA->TR_CARGO
					cCargo	:= TRA->TR_CARGO				
				EndIf
				cCurso  := TRA->TR_CURSO 
			EndIf	
			U_Tr030Sum(oReport)
		EndIf

		dbSelectArea("TRA")
		dbSkip()
	EndDo
	
	If !lRet
		oSection1:Init()
  		oSection1:Printline()
 		oSection1:Finish()
		U_Tr030RPVerPlan(oSection2)
		lRet := .T.
	EndIf	    

Next nVx	      


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("TRA")
dbCloseArea()

If oTmpTRA <> Nil
	oTmpTRA:Delete()
	Freeobj(oTmpTRA)
EndIf 

oReport:Section(1):Finish()            	//Fecha Section1

Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TR30IMPRE  ³ Autor ³ Cristina Ogura      ³ Data ³ 10.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime as linhas de detalhes do relatorios                ³±± 
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TR30IMPRE                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRMR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/    
Static Function TR30IMPRE(aTotais,oSection)

Local nx		:= 0
Local nTotal	:= 0
Local nTotFunc	:= 0     

dbSelectArea("RA1")
dbSetOrder(1)
cFil := xFilial("RA1")
dbSeek(cFil+cCurso)



If aScan(aMeses, { |x| x == 1 }) == 0
	oSection:Cell("JANEIRO"):Disable()
	oSection:Cell("FUNCJAN"):Disable()
Endif

If aScan(aMeses, { |x| x == 2 }) == 0
	oSection:Cell("FEVEREIRO"):Disable()
	oSection:Cell("FUNCFEV"):Disable()
Endif

If aScan(aMeses, { |x| x == 3 }) == 0
	oSection:Cell("MARCO"):Disable()
	oSection:Cell("FUNCMAR"):Disable()
Endif

If aScan(aMeses, { |x| x == 4 }) == 0
	oSection:Cell("ABRIL"):Disable()
	oSection:Cell("FUNCABR"):Disable()
Endif

If aScan(aMeses, { |x| x == 5 }) == 0
	oSection:Cell("MAIO"):Disable()
	oSection:Cell("FUNCMAI"):Disable()
Endif

If aScan(aMeses, { |x| x == 6 }) == 0
	oSection:Cell("JUNHO"):Disable()
	oSection:Cell("FUNCJUN"):Disable()
Endif

If aScan(aMeses, { |x| x == 7 }) == 0
	oSection:Cell("JULHO"):Disable()
	oSection:Cell("FUNCJUL"):Disable()
Endif

If aScan(aMeses, { |x| x == 8 }) == 0
	oSection:Cell("AGOSTO"):Disable()
	oSection:Cell("FUNCAGO"):Disable()
Endif

If aScan(aMeses, { |x| x == 9 }) == 0
	oSection:Cell("SETEMBRO"):Disable()
	oSection:Cell("FUNCSET"):Disable()
Endif

If aScan(aMeses, { |x| x == 10 }) == 0
	oSection:Cell("OUTUBRO"):Disable()
	oSection:Cell("FUNCOUT"):Disable()
Endif

If aScan(aMeses, { |x| x == 11 }) == 0
	oSection:Cell("NOVEMBRO"):Disable()
	oSection:Cell("FUNCNOV"):Disable()
Endif

If aScan(aMeses, { |x| x == 12 }) == 0
	oSection:Cell("DEZEMBRO"):Disable()
	oSection:Cell("FUNCDEZ"):Disable()
Endif



If cQual == "V"                           
	    
	oSection:Init()	//Secao 2    

	oSection:Cell("CURSOS"):SetValue(STR0037)	//PLANEJADO 
	For nx:=1 To nQuantos
		If nx == nQuantos
			If nTotal+aVlPlan[nx] < aTotais[1]
				aVlPlan[nx] += aTotais[1] - (nTotal+aVlPlan[nx])
			EndIf
			If nTotFunc+aNrPlan[nx] < aTotais[3]
				aNrPlan[nx] += aTotais[3] - (nTotFunc+aNrPlan[nx])
			EndIf
		EndIf 
		
		nTotal   := nTotal   + aVlPlan[nx]		
		nTotFunc := nTotFunc + aNrPlan[nx]

		Do Case
			Case aMeses[nx] == 1 
				oSection:Cell("JANEIRO"):SetValue(aVlPlan[nx])
				oSection:Cell("FUNCJAN"):SetValue(aNrPlan[nx])
			Case aMeses[nx] == 2   
		   		oSection:Cell("FEVEREIRO"):SetValue(aVlPlan[nx])
				oSection:Cell("FUNCFEV"):SetValue(aNrPlan[nx])
			Case aMeses[nx] == 3 
				oSection:Cell("MARCO"):SetValue(aVlPlan[nx])
				oSection:Cell("FUNCMAR"):SetValue(aNrPlan[nx])
			Case aMeses[nx] == 4  
				oSection:Cell("ABRIL"):SetValue(aVlPlan[nx])
				oSection:Cell("FUNCABR"):SetValue(aNrPlan[nx])
			Case aMeses[nx] == 5   
				oSection:Cell("MAIO"):SetValue(aVlPlan[nx])
				oSection:Cell("FUNCMAI"):SetValue(aNrPlan[nx])	
			Case aMeses[nx] == 6   
				oSection:Cell("JUNHO"):SetValue(aVlPlan[nx])
				oSection:Cell("FUNCJUN"):SetValue(aNrPlan[nx])
			Case aMeses[nx] == 7   
				oSection:Cell("JULHO"):SetValue(aVlPlan[nx])
				oSection:Cell("FUNCJUL"):SetValue(aNrPlan[nx]) 
			Case aMeses[nx] == 8
				oSection:Cell("AGOSTO"):SetValue(aVlPlan[nx])
				oSection:Cell("FUNCAGO"):SetValue(aNrPlan[nx]) 	
			Case aMeses[nx] == 9                                                            
				oSection:Cell("SETEMBRO"):SetValue(aVlPlan[nx])
				oSection:Cell("FUNCSET"):SetValue(aNrPlan[nx]) 
			Case aMeses[nx] == 10 
				oSection:Cell("OUTUBRO"):SetValue(aVlPlan[nx])
				oSection:Cell("FUNCOUT"):SetValue(aNrPlan[nx]) 
			Case aMeses[nx] == 11    
				oSection:Cell("NOVEMBRO"):SetValue(aVlPlan[nx])
				oSection:Cell("FUNCNOV"):SetValue(aNrPlan[nx]) 
			Case aMeses[nx] == 12    
				oSection:Cell("DEZEMBRO"):SetValue(aVlPlan[nx])
				oSection:Cell("FUNCDEZ"):SetValue(aNrPlan[nx])		
		End Case
	
	Next nx
	
	oSection:Cell("TOTAL"):SetValue(nTotal)
	oSection:Cell("FUNC"):SetValue(nTotFunc) 
	
	oSection:PrintLine()	//Secao 2
	                                         
	// Imprime a linha dos dados do realizado
	nTotal :=0
	nTotFunc :=0
	
	//oSection:Init()	//Secao 2
	
	oSection:Cell("CURSOS"):SetValue(STR0039)//REALIZADO
	
	For nx:=1 To nQuantos
	
		nTotal   := nTotal   + aVlReal[nx]    
		nTotFunc := nTotFunc + aNrReal[nx]
		Do Case
			Case aMeses[nx] == 1 
				oSection:Cell("JANEIRO"):SetValue(aVlReal[nx])
				oSection:Cell("FUNCJAN"):SetValue(aNrReal[nx])
			Case aMeses[nx] == 2   
		   		oSection:Cell("FEVEREIRO"):SetValue(aVlReal[nx])
				oSection:Cell("FUNCFEV"):SetValue(aNrReal[nx])
			Case aMeses[nx] == 3 
				oSection:Cell("MARCO"):SetValue(aVlReal[nx])
				oSection:Cell("FUNCMAR"):SetValue(aNrReal[nx])
			Case aMeses[nx] == 4  
				oSection:Cell("ABRIL"):SetValue(aVlReal[nx])
				oSection:Cell("FUNCABR"):SetValue(aNrReal[nx])
			Case aMeses[nx] == 5   
				oSection:Cell("MAIO"):SetValue(aVlReal[nx])
				oSection:Cell("FUNCMAI"):SetValue(aNrReal[nx])	
			Case aMeses[nx] == 6   
				oSection:Cell("JUNHO"):SetValue(aVlReal[nx])
				oSection:Cell("FUNCJUN"):SetValue(aNrReal[nx])
			Case aMeses[nx] == 7   
				oSection:Cell("JULHO"):SetValue(aVlReal[nx])
				oSection:Cell("FUNCJUL"):SetValue(aNrReal[nx]) 
			Case aMeses[nx] == 8
				oSection:Cell("AGOSTO"):SetValue(aVlReal[nx])
				oSection:Cell("FUNCAGO"):SetValue(aNrReal[nx]) 	
			Case aMeses[nx] == 9                                                            
				oSection:Cell("SETEMBRO"):SetValue(aVlReal[nx])
				oSection:Cell("FUNCSET"):SetValue(aNrReal[nx]) 
			Case aMeses[nx] == 10 
				oSection:Cell("OUTUBRO"):SetValue(aVlReal[nx])
				oSection:Cell("FUNCOUT"):SetValue(aNrReal[nx]) 
			Case aMeses[nx] == 11    
				oSection:Cell("NOVEMBRO"):SetValue(aVlReal[nx])
				oSection:Cell("FUNCNOV"):SetValue(aNrReal[nx]) 
			Case aMeses[nx] == 12    
				oSection:Cell("DEZEMBRO"):SetValue(aVlReal[nx])
				oSection:Cell("FUNCDEZ"):SetValue(aNrReal[nx])		
		End Case           		          
		
	Next nx

	oSection:Cell("TOTAL"):SetValue(nTotal)
	oSection:Cell("FUNC"):SetValue(nTotFunc)		

	oSection:Printline()	//Secao 2
Else      

	oSection:Init()	//Secao 2
	
	oSection:Cell("CURSOS"):SetValue(STR0037)//PLANEJADO
	
	For nx:=1 To nQuantos
		If nx == nQuantos
			If nTotal+aHrPlan[nx] < aTotais[2]
				aHrPlan[nx] += aTotais[2] - (nTotal+aHrPlan[nx])
			EndIf
			If nTotFunc+aNrPlan[nx] < aTotais[3]
				aNrPlan[nx] += aTotais[3] - (nTotFunc+aNrPlan[nx])
			EndIf
		EndIf
		
		nTotal   := nTotal   + aHrPlan[nx]
		nTotFunc := nTotFunc + aNrPlan[nx]
		
		Do Case
			Case aMeses[nx] == 1 
				oSection:Cell("JANEIRO"):SetValue(aHrPlan[nx])
				oSection:Cell("FUNCJAN"):SetValue(aNrPlan[nx])
			Case aMeses[nx] == 2   
		   		oSection:Cell("FEVEREIRO"):SetValue(aHrPlan[nx])
				oSection:Cell("FUNCFEV"):SetValue(aNrPlan[nx])
			Case aMeses[nx] == 3 
				oSection:Cell("MARCO"):SetValue(aHrPlan[nx])
				oSection:Cell("FUNCMAR"):SetValue(aNrPlan[nx])
			Case aMeses[nx] == 4  
				oSection:Cell("ABRIL"):SetValue(aHrPlan[nx])
				oSection:Cell("FUNCABR"):SetValue(aNrPlan[nx])
			Case aMeses[nx] == 5   
				oSection:Cell("MAIO"):SetValue(aHrPlan[nx])
				oSection:Cell("FUNCMAI"):SetValue(aNrPlan[nx])	
			Case aMeses[nx] == 6   
				oSection:Cell("JUNHO"):SetValue(aHrPlan[nx])
				oSection:Cell("FUNCJUN"):SetValue(aNrPlan[nx])
			Case aMeses[nx] == 7   
				oSection:Cell("JULHO"):SetValue(aHrPlan[nx])
				oSection:Cell("FUNCJUL"):SetValue(aNrPlan[nx]) 
			Case aMeses[nx] == 8
				oSection:Cell("AGOSTO"):SetValue(aHrPlan[nx])
				oSection:Cell("FUNCAGO"):SetValue(aNrPlan[nx]) 	
			Case aMeses[nx] == 9                                                            
				oSection:Cell("SETEMBRO"):SetValue(aHrPlan[nx])
				oSection:Cell("FUNCSET"):SetValue(aNrPlan[nx]) 
			Case aMeses[nx] == 10 
				oSection:Cell("OUTUBRO"):SetValue(aHrPlan[nx])
				oSection:Cell("FUNCOUT"):SetValue(aNrPlan[nx]) 
			Case aMeses[nx] == 11    
				oSection:Cell("NOVEMBRO"):SetValue(aHrPlan[nx])
				oSection:Cell("FUNCNOV"):SetValue(aNrPlan[nx]) 
			Case aMeses[nx] == 12    
				oSection:Cell("DEZEMBRO"):SetValue(aHrPlan[nx])
				oSection:Cell("FUNCDEZ"):SetValue(aNrPlan[nx])		
		End Case
				
	Next nx      
	
	oSection:Cell("TOTAL"):SetValue(nTotal)
	oSection:Cell("FUNC"):SetValue(nTotFunc)
	
    oSection:Printline()	//Secao 2
                                         
	// Imprime a linha dos dados do realizado
	nTotal  := 0
	nTotFunc:= 0

	//oSection:Init()	//Secao 2
	
	oSection:Cell("CURSOS"):SetValue(STR0039)//REALIZADO
	
	For nx:=1 To nQuantos

		nTotal   := nTotal   + aHrReal[nx]
		nTotFunc := nTotFunc + aNrReal[nx]
		
		Do Case
			Case aMeses[nx] == 1 
				oSection:Cell("JANEIRO"):SetValue(aHrReal[nx])
				oSection:Cell("FUNCJAN"):SetValue(aNrReal[nx])
			Case aMeses[nx] == 2   
		   		oSection:Cell("FEVEREIRO"):SetValue(aHrReal[nx])
				oSection:Cell("FUNCFEV"):SetValue(aNrReal[nx])
			Case aMeses[nx] == 3 
				oSection:Cell("MARCO"):SetValue(aHrReal[nx])
				oSection:Cell("FUNCMAR"):SetValue(aNrReal[nx])
			Case aMeses[nx] == 4  
				oSection:Cell("ABRIL"):SetValue(aHrReal[nx])
				oSection:Cell("FUNCABR"):SetValue(aNrReal[nx])
			Case aMeses[nx] == 5   
				oSection:Cell("MAIO"):SetValue(aHrReal[nx])
				oSection:Cell("FUNCMAI"):SetValue(aNrReal[nx])	
			Case aMeses[nx] == 6   
				oSection:Cell("JUNHO"):SetValue(aHrReal[nx])
				oSection:Cell("FUNCJUN"):SetValue(aNrReal[nx])
			Case aMeses[nx] == 7   
				oSection:Cell("JULHO"):SetValue(aHrReal[nx])
				oSection:Cell("FUNCJUL"):SetValue(aNrReal[nx]) 
			Case aMeses[nx] == 8
				oSection:Cell("AGOSTO"):SetValue(aHrReal[nx])
				oSection:Cell("FUNCAGO"):SetValue(aNrReal[nx]) 	
			Case aMeses[nx] == 9                                                            
				oSection:Cell("SETEMBRO"):SetValue(aHrReal[nx])
				oSection:Cell("FUNCSET"):SetValue(aNrReal[nx]) 
			Case aMeses[nx] == 10 
				oSection:Cell("OUTUBRO"):SetValue(aHrReal[nx])
				oSection:Cell("FUNCOUT"):SetValue(aNrReal[nx]) 
			Case aMeses[nx] == 11    
				oSection:Cell("NOVEMBRO"):SetValue(aHrReal[nx])
				oSection:Cell("FUNCNOV"):SetValue(aNrReal[nx]) 
			Case aMeses[nx] == 12    
				oSection:Cell("DEZEMBRO"):SetValue(aHrReal[nx])
				oSection:Cell("FUNCDEZ"):SetValue(aNrReal[nx])		
		End Case
		
	Next nx                  
	
	oSection:Cell("TOTAL"):SetValue(nTotal)
	oSection:Cell("FUNC"):SetValue(nTotFunc)
	
	oSection:Printline()	//Secao 2

EndIf              
   
oSection:Finish()	//Fecha Section2

Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FZeraRP	  ³ Autor ³ Cristina Ogura      ³ Data ³ 10.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Zera as variaveis do relatorio                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FZeraRP()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRMR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FZeraRP(oReport)

AFill(aVlReal,0)
AFill(aHrReal,0)
AFill(aNrReal,0)
AFill(aVlPlan,0)
AFill(aHrPlan,0)
AFill(aNrPlan,0)

Return Nil			

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³U_Tr030Sum () ³ Autor ³ Eduardo Ju          ³ Data ³ 04.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Soma os valores de curso,horas e nr funcionario             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_Tr030Sum(oReport)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRMR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Tr030Sum(oReport)

Local nMes := 0
Local nPos := 0

//Ler o getmv
//1- INICIO
//2- FIM
//3- RATEADO
// Se considerado o valor do custo do treinamento conforme definido no MV_PLANEJ
// Se for:  1- Sera considerado todo o custo do treinamento no inicio do curso.
// 			2- Sera considerado todo o custo do treinamento no fim do curso.
//			3- Sera dividido entre o mes inicial e mes final

If nMvPlan = 1			// Inicio
	nMes := Month(TRA->TR_DTINI)
ElseIf nMvPlan = 2		// Fim
	// Verifico se a data final do curso esta dentro do periodo selecionado
	If TRA->TR_DTFIM <= MV_PAR05
		nMes := Month(TRA->TR_DTFIM)
	EndIf	
ElseIf nMvPlan = 3		// Rateado	
	U_Tr30RateioRP(TRA->TR_DTINI,TRA->TR_DTFIM,TRA->TR_VALOR,TRA->TR_HORAS,1,"R")
EndIf   

nPos := Ascan(aMeses,nMes)

If nMvPlan # 3
	If nMes > 0 .And. nPos > 0
		aVlReal[nPos] += TRA->TR_VALOR
		aHrReal[nPos] += TRA->TR_HORAS
		If TRA->TR_VALOR > 0 .Or. TRA->TR_HORAS > 0
			aNrReal[nPos] += 1	
		EndIf
	EndIf
EndIf										

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Tr030VerPlan³ Autor ³ Cristina Ogura      ³ Data ³ 10.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Verifica os val. custo, horas e nr func planej para curso   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Tr030VerPlan                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³TRMR030                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Tr030RPVerPlan(oSection)

Local aSaveArea := GetArea()
Local nMes		:= 0 
Local aTotais[3]

aFill(aTotais,0)
                  
dbSelectArea("RA8")
dbSetOrder(2)
If dbSeek(xFilial("RA8")+cCurso)
	While !Eof() .and. xFilial("RA8")+cCurso == RA8->RA8_FILIAL+RA8->RA8_CURSO
	
		// Ordem 2 - Centro de custo  
		// Ordem 3 - Grupo+Depto
		// Ordem 4 - Cargo
		If (nOrdem == 2 .And. cCC    # RA8->RA8_CC) .Or.;
		   (nOrdem == 3 .And. cGrupo # RA8->RA8_GRUPO+RA8->RA8_DEPTO) .Or.;
		   (nOrdem == 4 .And. cCargo # RA8->RA8_CARGO)
		   dbSkip()
		   Loop
		EndIf		    	

		// Verifica periodos
		If 	RA8->RA8_DATADE < MV_PAR05 .Or. ;
			RA8->RA8_DATADE > MV_PAR06        
			dbSkip()
			Loop
		EndIf	
					            
		// Planejamento 
		If RA8->RA8_PLANEJ < MV_PAR03 .Or.;
		   RA8->RA8_PLANEJ > MV_PAR04
		   dbSkip()
		   Loop
		EndIf		   
		 
		// Centro de Custo			
		If RA8->RA8_CC < MV_PAR15 .Or.;
		   RA8->RA8_CC > MV_PAR16
		   dbSkip()
		   Loop
		EndIf        
		
		// Grupo+Departamento
		If RA8->RA8_GRUPO+RA8->RA8_DEPTO < MV_PAR11+MV_PAR13 .Or.;
		   RA8->RA8_GRUPO+RA8->RA8_DEPTO > MV_PAR12+MV_PAR14
		   dbSkip()
		   Loop
		EndIf                
		
		// Rateia planejamento 1-Sim 2-Nao
		If MV_PAR18 == 1 	 
			U_Tr30RateioRP(RA8->RA8_DATADE,RA8->RA8_DATAAT,RA8->RA8_VALOR,RA8->RA8_HORAS,RA8->RA8_NFUNC,"P")
		Else            
			// Coloca os custos no final do mes em que foi planejado
			nMes := Month(RA8->RA8_DATAAT)
			nPos := Ascan(aMeses,nMes)
			If nPos > 0
			    aVlPlan[nPos] += RA8->RA8_VALOR
				aNrPlan[nPos] += RA8->RA8_NFUNC
				aHrPlan[nPos] += RA8->RA8_HORAS
			EndIf	
		EndIf	
		
		aTotais[1] := aTotais[1] + RA8->RA8_VALOR
		aTotais[2] := aTotais[2] + RA8->RA8_HORAS
		aTotais[3] := aTotais[3] + RA8->RA8_NFUNC		
				    
		dbSelectArea("RA8")
		dbSetOrder(2)				                            
		dbSkip()		
	EndDo
EndIf

RestArea(aSaveArea)

TR30IMPRE(aTotais, oSection)

U_FZeraRP(oSection)      

Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ Tr30MesesRP³ Autor ³ Eduardo Ju          ³ Data ³ 05.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Meses                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Tr30MesesRP()                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRMR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Tr30MesesRP()

Local nMes		:= 0
Local nAno		:= 0
Local nMuda		:= 0
Local nx		:= 0                     
                   
nMes := Month(MV_PAR05)
nAno := Year(MV_PAR05)

If Year(MV_PAR05) == Year(MV_PAR06)
	nQuantos := Month(MV_PAR06) - Month(MV_PAR05)
	nMuda    := 0
Else            
	nMuda    := (12 - Month(MV_PAR05))+ 2
	nQuantos := (12 - Month(MV_PAR05))+ Month(MV_PAR06)	
EndIf

nQuantos:= nQuantos + 1
//"CURSO			                JAN/2000 FUNC| FEV/2000 FUNC| MAR/2000 FUNC| ABR/2000 FUNC| MAI/2000 FUNC| JUN/2000 FUNC| JUL/2000 FUNC| AGO/2000 FUNC| SET/2000 FUNC| OUT/2000 FUNC| NOV/2000 FUNC| DEZ/2000 FUNC!      TOTAL   FUNC"		
//"123451234567890123456789012345678123456789012345                                                                                                                                                                               

For nx := 1 To nQuantos 
	If nx # 1
		nMes:= nMes + 1
	EndIf
	If nMuda == nx
		nAno := Year(MV_PAR06)
		nMes := 1
	EndIf		
	Aadd(aMeses,nMes)
Next nx          

Return .T.
        
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ Tr30RateioRP³ Autor ³ Cristina Ogura     ³ Data ³ 04.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Calcula o rateio de valores e horas                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Tr30RateioRP()                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TRMR030                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Tr30RateioRP(dInicio,dFim,nValor,nHoras,nFunc,cTipo)

Local nDias		:= 0
Local nVezes	:= 0
Local nAno		:= 0
Local nVlDias	:= 0
Local nHrDias	:= 0
Local nNrDias	:= 0
Local dMonta
Local cString	:= ""  
Local nCValor	:= 0
Local nCHoras	:= 0
Local nCFunc	:= 0			// Valores Calculados
Local nTValor	:= 0
Local nTHoras	:= 0
Local nTFunc	:= 0			// Totais dos valores dos meses
Local nDif 		:= 0
Local nx		:= 0

// Sao verificadas todas as possibilidades:
// Datas iguais : 15/02/99 a 15/02/99
// MMAAAA iguais: 15/02/99 a 25/02/99
// AAAA iguais  : 15/02/99 a 20/03/99
// AAAA diferen.: 21/09/99 a 03/02/99

nDias := dFim - dInicio + 1 

If nDias == 0
	nDias := 1
EndIf
	
nVlDias := Round(nValor / nDias,2)
nHrDias := Round(nHoras / nDias,2)
nNrDias := Round(nFunc  / nDias,2)

nMes    := Month(dInicio)                
nAno    := Year(dInicio)

If Year(dInicio) == Year(dFim)
	nVezes := Month(dFim) - Month(dInicio) + 1
Else                          
    nVezes := (12 - Month(dInicio)) + Month(dFim)
EndIf			
		
For nx := 1 To nVezes
	If nVezes == 1
		If dInicio == dFim
			nDias := 1
		ElseIf Year(dInicio) == Year(dFim) .And.;
			   Month(dInicio)== Month(dFim)
			nDias := Day(dFim)
		Else	   	
			nDias := Day(dInicio)
		EndIf
	Else	
		If nx== nVezes
			nDias := Day(dFim)	
		Else
			// Montar a data para verificar o ultimo dia do mes 
			cString:= "'01/"+StrZero(nMes,2)+"/"+Substr(Str(nAno,4),3,2)+"'"
			dMonta 	:= CtoD(cString)
			nDias 	:= f_ultdia(dMonta)			
			If nx == 1
				nDias := nDias - Day(dInicio) + 1
			EndIf				
		EndIf            
	EndIf

	nCValor := Round(nVlDias * nDias,2)
	nCHoras := Round(nHrDias * nDias,2)
	nCFunc  := Round(nNrDias * nDias,2)
	        
	nPos   := Ascan(aMeses,nMes)

	If nPos > 0	
		// Somando para obter o total do curso
		nTValor := nTValor + nCValor
		nTHoras := nTHoras + nCHoras
		nTFunc  := nTFunc  + nCFunc
		
		// Acerto dos totais 
		If nx== nVezes                   
			nDif := Round(Abs(nValor - nTValor),0)			
			If nTValor < nValor
				nCValor := nCValor + nDif
			ElseIf nTValor > nValor
				nCValor := nCValor - nDif
			EndIf					 
			nDif := Round(Abs(nHoras - nTHoras),0)		
			If nTHoras < nHoras
				nCHoras := nCHoras + nDif
			ElseIf nTHoras > nHoras
				nCHoras := nCHoras - nDif
			EndIf	                     
			nDif := Round(Abs(nFunc - nTFunc),0)
			If nTFunc < nFunc
				nCFunc := nCFunc + nDif
			ElseIf nTfunc > nFunc                   
				nCFunc := nCFunc - nDif
			EndIf	
		EndIf

		If cTipo == "P"
			aVlPlan[nPos] += Round(nCValor,0)
			aHrPlan[nPos] += Round(nCHoras,0)
			aNrPlan[nPos] += Round(nCFunc,0)
		Else
			aVlReal[nPos] += Round(nCValor,0)
			aHrReal[nPos] += Round(nCHoras,0)
			aNrReal[nPos] += Round(nCFunc,0)
		EndIf
	EndIf
			
	nMes := nMes + 1
	
	If nMes == 13
		nMes := 1
		nAno := Year(dFim)
	EndIf
			
Next nx

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Tr030PlanRP ³ Autor ³ Emerson Grassi Rocha³ Data ³ 25/02/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Cria registro em branco no Real qdo tiver Planej. s/ Real.  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³Tr030PlanRP                                          	      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³TRMR030                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Tr030PlanRP()  

Local aSaveArea := GetArea()
                  
dbSelectArea("RA8")
dbSetOrder(2)
If dbSeek(xFilial("RA8")+RA1->RA1_CURSO)
	While !Eof() .and. xFilial("RA8")+RA1->RA1_CURSO == RA8->RA8_FILIAL+RA8->RA8_CURSO
	
		// Verifica periodos
		If 	RA8->RA8_DATADE < MV_PAR05 .Or. ;
			RA8->RA8_DATADE > MV_PAR06        
			dbSkip()
			Loop
		EndIf	
					            
		// Planejamento 
		If RA8->RA8_PLANEJ < MV_PAR03 .Or.;
		   RA8->RA8_PLANEJ > MV_PAR04
		   dbSkip()
		   Loop
		EndIf		   
		 
		// Centro de Custo			
		If RA8->RA8_CC < MV_PAR15 .Or.;
		   RA8->RA8_CC > MV_PAR16
		   dbSkip()
		   Loop
		EndIf        
		
		// Grupo+Departamento
		If RA8->RA8_GRUPO+RA8->RA8_DEPTO < MV_PAR11+MV_PAR13 .Or.;
		   RA8->RA8_GRUPO+RA8->RA8_DEPTO > MV_PAR12+MV_PAR14
		   dbSkip()
		   Loop
		EndIf                
         
		// Registro de Realizado zerado para buscar Planejado
 		RecLock("TRA",.T.)
			Replace TRA->TR_FILIAL		With RA8->RA8_FILIAL
			Replace TRA->TR_CC			With ""
			Replace TRA->TR_CURSO		With RA1->RA1_CURSO
			Replace TRA->TR_GRUPO		With ""
			Replace TRA->TR_DEPTO		With ""
			Replace TRA->TR_CARGO		With ""
			Replace TRA->TR_VALOR		With 0
			Replace TRA->TR_HORAS		With 0
			Replace TRA->TR_DTINI		With RA8->RA8_DATADE
			Replace TRA->TR_DTFIM		With RA8->RA8_DATAAT
		MsUnlock()         
		
		dbSelectArea("RA8")		
		dbSkip()		
	EndDo
EndIf

RestArea(aSaveArea)

Return Nil
