/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE  "TOTVS.CH"
#INCLUDE  "QDOR010.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QDOR010  ³ Autor ³ Leandro S. Sabino     ³ Data ³ 12/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio Lista de Treinamentos por Departamento           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs:      ³ (Versao Relatorio Personalizavel) 		                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAQDO	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function QDOR010()
Local oReport
           
If TRepInUse()
	Pergunte("QDR010",.F.) 
    oReport := ReportDef()
    oReport:PrintDialog()
Else
	Return U_QDOR010R3() //Executa versão anterior do fonte
EndIF    

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 12/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport                                             
Local oSection1 
Local oSection0
Local cFilFunc := xFilial("QAC")
Local cTitle   := OemToAnsi(STR0001)
	
If mv_par03 = 1 
	cTitle += " - "+OemToAnsi(STR0013) // "Realizados/Pendentes"
Endif

oReport   := TReport():New("QDOR010",cTitle,"QDR010",{|oReport| PrintReport(oReport)},OemToAnsi(STR0002)+OemToAnsi(STR0003)+OemToAnsi(STR0004))
// "LISTA DE TREINAMENTOS POR DEPARTAMENTO"
// "Este programa ir  imprimir uma rela‡„o de treinamentos  "
// "por departamento, separando-os por documentos e usu rios"
// "listando a data de inclus„o e baixa"

oSection0 := TRSection():New(oReport,OemToAnsi(STR0030),{"QD8"})//Documento

oSection1 := TRSection():New(oReport,OemToAnsi(STR0031),{"QD8"})//Treinando
TRCell():New(oSection1,"cTREIN"    ,"  " ,OemToAnsi(STR0023) ,,30,,{||Substr(QA_NUSR(QD8->QD8_FILMAT,QD8->QD8_MAT,.T.),1,30)})//"Treinando"
TRCell():New(oSection1,"cCARG0"    ,"  " ,OemToAnsi(STR0024) ,,20,,{||Substr(QA_NFUNC(QD8->QD8_CARGO,.T.,cFilFunc),1,20)})//"Funcao"
TRCell():New(oSection1,"cNUM"      ,"  " ,OemToAnsi(STR0025) ,,02,,{||QD8->QD8_NUMERO +"/"+ QD8->QD8_ANO})//"Numero/Ano"
TRCell():New(oSection1,"cDTSOL"    ,"  " ,OemToAnsi(STR0026) ,,08)//"Dt. Solicitacao"
TRCell():New(oSection1,"cDTREAl"   ,"  " ,OemToAnsi(STR0027) ,,08)//"Dt. Realizacao"
TRCell():New(oSection1,"cPARTIC"   ,"  " ,OemToAnsi(STR0028) ,,03,,{||IIf(QD8->QD8_SELECA == "S",OemToAnsi(STR0017),OemToAnsi(STR0018))})//"Participante"
TRCell():New(oSection1,"QD8_HISTOR","QD8",OemToAnsi(STR0029) ,,20,,{||QD8->QD8_HISTOR})//"Justificativa"
oSection0:SetEdit(.F.)

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 12/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAQIE                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PrintReport( oReport )
Local oSection0  := oReport:Section(1)
Local oSection1  := oReport:Section(2)
Local cCampos1 	:= " "
Local cCompara1	:= " "
Local cCampos2 	:= " "
Local cCompara2	:= " "
Local cFiltro  	:= " "
Local cTitulo   := ""
Local cCondQD8 	:= ".T."

DbSelectarea("QD8")
dbGoTop()

cFiltro:='QD8->QD8_FILIAL == "'+xFilial("QD8")+'" .And. '
cFiltro+='QD8->QD8_FILDEP >= "'+mv_par05+'" .And. QD8->QD8_FILDEP <= "'+mv_par06+'" .And. '
cFiltro+='QD8->QD8_DEPTO >= "'+mv_par01+'" .And. QD8->QD8_DEPTO <= "'+mv_par02+'"'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtro para treinamentos (Considera so baixados ou pendentes)    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par03 == 2 
	cFiltro+= '.And. QD8->QD8_BAIXA == "S"'	
ElseIf mv_par03 == 3
	cFiltro+= '.And. QD8->QD8_BAIXA <> "S"'	
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtro para treinandos (Considera so participantes ou ausente)   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par03 <> 3
	If mv_par04 == 2
	   cFiltro+=  ' .And. QD8->QD8_SELECA=="S"'
	   cCondQD8:= 'QD8->QD8_SELECA == "S"'	
	ElseIf mv_par04 == 3
	   cFiltro+= '.And. QD8->QD8_SELECA == "N"'
	   cCondQD8:= 'QD8->QD8_SELECA == "N"'	
	EndIf
EndIf

oSection1:SetFilter(cFiltro,"QD8_FILIAL+QD8_DEPTO+QD8_ANO+QD8_NUMERO+QD8_FILMAT+QD8_CARGO+QD8_MAT")

While !oReport:Cancel() .And. QD8->(!Eof())

	oSection0:Init()
	
	cCompara1:= QD8->QD8_FILDEP+QD8->QD8_DEPTO
	cCampos1 := "QD8->QD8_FILDEP+QD8->QD8_DEPTO"	
	
 	If &(cCondQD8)//Departamento
   		oReport:SkipLine(1) 
		oReport:ThinLine()
		oReport:PrintText(Upper(OemToAnsi(STR0011))+QA_NDEPT(QD8->QD8_DEPTO,.T.,QD8->QD8_FILDEP),oReport:Row(),025)//"Departamento: "
		oReport:SkipLine(1)	
		oReport:ThinLine() 
	EndIf	
  
	While QD8->(!Eof()) .And. cCompara1 == &(cCampos1)
		oSection1:Init()

		If mv_par03 == 3
			oSection1:Cell("cPARTIC"):Hide()
			oSection1:Cell("cPARTIC"):HideHeader()
			
			oSection1:Cell("QD8_HISTOR"):Hide()
			oSection1:Cell("QD8_HISTOR"):HideHeader()		
		EndIf
		
		cCompara2:= QD8->(QD8_FILDEP+QD8_DEPTO+QD8_ANO+QD8_NUMERO)
		cCampos2 := "QD8->(QD8_FILDEP+QD8_DEPTO+QD8_ANO+QD8_NUMERO)"

		If QDA->(DbSeek(xFilial("QD8")+QD8->QD8_ANO+QD8->QD8_NUMERO))
		   If &(cCondQD8)//Documento e Treinamento 
				oReport:SkipLine(1)	
				oReport:PrintText(Upper(OemToAnsi(STR0012))+AllTrim(QDA->QDA_DOCTO)+"/"+QDA->QDA_RV,oReport:Row(),025)//"Documento: "
				oReport:SkipLine(1)	
				oReport:PrintText(Upper(OemToAnsi(STR0014))+" "+If(QD8->QD8_BAIXA == "S",OemToAnsi(STR0015),OemToAnsi(STR0016)),oReport:Row(),025)//"Documento: ### // Realizado ### // Pendente "
				oReport:SkipLine(1)	
		   EndIf		
		EndIf   

		While QD8->(!Eof()) .And. cCompara2 == &(cCampos2)
	    	    	
	    	FilFunc:= If(FWModeAccess("QAC")=="E",QD8->QD8_FILMAT,Space(FWSizeFilial()))   // If(!Empty(xFilial("QAC")),QD8->QD8_FILMAT,"  ")
	      
	        If QDA->QDA_ANO+QDA->QDA_NUMERO == QD8->QD8_ANO+QD8->QD8_NUMERO
		      oSection1:Cell("cDTSOL"):SetValue(QDA->QDA_DTCAD)
			  oSection1:Cell("cDTREAl"):SetValue(QDA->QDA_DTFEC)
	        EndIf
	
			oSection1:PrintLine()
	  		QD8->(DbSkip())
	   EndDo
	   oSection1:Finish()
   EndDo   
   
EndDo       

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QDOR010R3³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 09/07/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio Lista de Treinamentos por Departamento           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR010                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Eduardo S.  ³26/03/02³ META ³ Otimizacao e Melhoria.                   ³±±
±±³Eduardo S   |13/12/02³ ---- ³ Incluido a pergunta 05 e 06 permitindo   ³±±
±±³            ³        ³      ³ filtrar por filial de departamento.      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QDOR010R3()

Local cTitulo   := OemToAnsi(STR0001)	// "LISTA DE TREINAMENTOS POR DEPARTAMENTO"
Local cDesc1    := OemToAnsi(STR0002) // "Este programa ir  imprimir uma rela‡„o de treinamentos  "
Local cDesc2    := OemToAnsi(STR0003) // "por departamento, separando-os por documentos e usu rios"
Local cDesc3    := OemToAnsi(STR0004) // "listando a data de inclus„o e baixa"
Local cString   := "QD8" 
Local wnrel     := "QDOR010"
Local Tamanho	 := "M" // Define o Tamanho do relatorio

Private cPerg   := "QDR010"
Private aReturn := {STR0005,1,STR0006, 1, 2, 1, "",1 } //"Zebrado" ### "Administra‡„o"
Private nLastKey:= 0
Private INCLUI  := .F.	// Colocada para utilizar as funcoes

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                          ³
//³ mv_par01	// De  Departamento                               ³
//³ mv_par02	// Ate Departamento                               ³
//³ mv_par03	// Treinamentos(Todos/Realizados/Pendentes)       ³
//³ mv_par04	// Treinandos(Todos/Participantes/Nao Participante³
//³ mv_par05	// De  Filial Treinando                           ³
//³ mv_par06	// Ate Filial Treinando                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

wnrel :=AllTrim(SetPrint(cString,wnrel,cPerg,ctitulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho))

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

RptStatus({|lEnd| QDOR010Imp(@lEnd,cTitulo,wnRel,tamanho)},cTitulo)

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QDOR010Imp³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 09/07/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Envia para funcao que faz a impressao do relatorio.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QDOR010Imp(ExpL1,ExpC1,ExpW1,ExpC2)                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QDOR010Imp(lEnd,ctitulo,wnRel,tamanho)

Local cCabec1  := " "
Local cCabec2  := " "
Local cbtxt    := Space(10)
Local nTipo		:= 0
Local cBcont   := 0
Local cCampos1 := " "
Local cCompara1:= " "
Local cCampos2 := " "
Local cCompara2:= " "
Local cIndex1  := " "
Local cFiltro  := " "
Local cKey     := " "
Local cCondQD8 := ".T."
Local cFilFunc := xFilial("QAC")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Indice Condicional nos arquivos utilizados ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cIndex1 := CriaTrab(Nil,.F.)
DbSelectarea("QD8")
cFiltro:='QD8->QD8_FILIAL == "'+xFilial("QD8")+'" .And. '
cFiltro+='QD8->QD8_FILDEP >= "'+mv_par05+'" .And. QD8->QD8_FILDEP <= "'+mv_par06+'" .And. '
cFiltro+='QD8->QD8_DEPTO >= "'+mv_par01+'" .And. QD8->QD8_DEPTO <= "'+mv_par02+'"'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtro para treinamentos (Considera so baixados ou pendentes)    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par03 == 2 
	cFiltro+= '.And. QD8->QD8_BAIXA == "S"'	
ElseIf mv_par03 == 3
	cFiltro+= '.And. QD8->QD8_BAIXA <> "S"'	
Else
	cTitulo+= " - "+OemToAnsi(STR0013) // "Realizados/Pendentes"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtro para treinandos (Considera so participantes ou ausente)   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par03 <> 3
	If mv_par04 == 2
	   cFiltro+=  ' .And. QD8->QD8_SELECA=="S"'
		cCondQD8:= 'QD8->QD8_SELECA == "S"'	
	ElseIf mv_par04 == 3
	   cFiltro+= '.And. QD8->QD8_SELECA == "N"'
		cCondQD8:= 'QD8->QD8_SELECA == "N"'	
	EndIf
EndIf

cKey	 :='QD8_FILIAL+QD8_DEPTO+QD8_ANO+QD8_NUMERO+QD8_FILMAT+QD8_CARGO+QD8_MAT'
IndRegua("QD8",cIndex1,cKey,,cFiltro,STR0007)	//"Selecionando Registros.."

If mv_par03 == 2 .Or. mv_par03 <> 3
   cCabec1:= OemToAnsi(STR0008) // "TREINANDO                       FUNCAO             NUMERO/ANO  DT.SOLICITACAO DT.REALIZACAO  PARTICIPANTE JUSTIFICATIVA"
   cCabec2:= OemToAnsi(STR0009)	// "                                                                                                                           "
ElseIf mv_par03 == 3
   cCabec1:= OemToAnsi(STR0019)	// "TREINANDO                       FUNCAO             NUMERO/ANO  DT.SOLICITACAO DT.REALIZACAO  "
   cCabec2:= OemToAnsi(STR0020)	// "                                                                                             "
EndIf	

//          1         2         3         4         5         6         7         8         9        10        11        12        13
// 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012

Li       := 80
m_pag    := 1

QD8->(DbSeek(xFilial("QD8")))
SetRegua(RecCount()) // Total de Elementos da Regua

While QD8->(!Eof())
	cCompara1:= QD8->QD8_FILDEP+QD8->QD8_DEPTO
	cCampos1 := "QD8->QD8_FILDEP+QD8->QD8_DEPTO"
	If lEnd
		Li++
		@ PROW()+1,001 PSAY OemToAnsi(STR0010)	//"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If Li > 58
		cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,nTipo)
	EndIf

	If &(cCondQD8)
	   @ Li,00 PSay Upper(OemToAnsi(STR0011))+QA_NDEPT(QD8->QD8_DEPTO,.T.,QD8->QD8_FILDEP) //"Departamento: "
      Li+=2
	EndIf	

	While QD8->(!Eof()) .And. cCompara1 == &(cCampos1)
		cCompara2:= QD8->(QD8_FILDEP+QD8_DEPTO+QD8_ANO+QD8_NUMERO)
		cCampos2 := "QD8->(QD8_FILDEP+QD8_DEPTO+QD8_ANO+QD8_NUMERO)"
		If lEnd
			Li++
			@ PROW()+1,001 PSAY OemToAnsi(STR0010)	//"CANCELADO PELO OPERADOR"
			Exit
		EndIf
		If Li > 58
			cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,nTipo)
		EndIf

		If QDA->(DbSeek(xFilial("QD8")+QD8->QD8_ANO+QD8->QD8_NUMERO))
		   If &(cCondQD8) 
			   @ Li,000 PSay Upper(OemToAnsi(STR0012))+AllTrim(QDA->QDA_DOCTO)+"/"+QDA->QDA_RV		//"Documento: "
			   @ Li,pCol()+1 PSay Upper(OemToAnsi(STR0014))+" "+If(QD8->QD8_BAIXA == "S",OemToAnsi(STR0015),OemToAnsi(STR0016)) //"Documento: ### // Realizado ### // Pendente "
				Li++
				@ Li,000 PSay __PrtFatLine()
		   EndIf		
			Li++
		EndIf

		While QD8->(!Eof()) .And. cCompara2 == &(cCampos2)
			IncRegua()
			If &(cCondQD8)
			   If lEnd
				   Li++
				   @ PROW()+1,001 PSAY OemToAnsi(STR0010) //"CANCELADO PELO OPERADOR"
				   Exit
			   EndIf
			   If Li > 58
				   cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,nTipo)
			   EndIf
	 
		      @ Li,000 PSay Substr(QA_NUSR(QD8->QD8_FILMAT,QD8->QD8_MAT,.T.),1,30)
			  cFilFunc:= If(FWModeAccess("QAC")=="E",QD8->QD8_FILMAT,Space(FWSizeFilial()))  //!Empty(xFilial("QAD")
		      @ Li,031 PSay Substr(QA_NFUNC(QD8->QD8_CARGO,.T.,cFilFunc),1,20)
		      @ Li,052 PSay QD8->QD8_NUMERO +"/"+ QD8->QD8_ANO

		      If QDA->QDA_ANO+QDA->QDA_NUMERO == QD8->QD8_ANO+QD8->QD8_NUMERO
			      @ Li,063 PSay QDA->QDA_DTCAD
			      @ Li,078 Psay QDA->QDA_DTFEC
		      EndIf

            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
            //³ Imprime o Historico de Justificativa Caso exista³
            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	         @ Li,pCol()+7  PSay If(QD8->QD8_SELECA == "S",OemToAnsi(STR0017),OemToAnsi(STR0018))
	         @ Li,pCol()+10 PSay QD8->QD8_HISTOR
			EndIf	
		   Li++
		   QD8->(DbSkip())
	   EndDo
	   Li++
   EndDo
	@ (Li-1),000 PSay __PrtThinLine()
   Li++
EndDo

If Li <> 80
	roda(cbcont,cbtxt,tamanho)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve as ordens originais do arquivo                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("QD8")
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