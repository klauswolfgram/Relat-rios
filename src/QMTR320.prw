/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "QMTR320.CH"
#include "REPORT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR320  ³ Autor ³ Cicero Cruz           ³ Data ³ 10.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de instrumentos disponiveis                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR320(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QMTR320()

Local oReport        
Private cAliasQN4  := "QN4"  
Private aInstru    := {}     

If TRepInUse()
	// Interface de impressao
	oReport := ReportDef()
 	oReport:PrintDialog()
Else
	U_QMTR320R3()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Cicero Cruz           ³ Data ³ 10.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ QMTR320                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport 
Local oSection1
Local aOrdem    := {}
Local cPerg		:="QMT320"

/* Criacao do objeto REPORT
DEFINE REPORT oReport NAME <Nome do relatorio> ;
					  TITLE <Titulo> 		   ;
					  PARAMETER <Pergunte>     ;
					  ACTION <Bloco de codigo que sera executado na confirmacao da impressao> ;
					  DESCRIPTION <Descricao>
*/
DEFINE REPORT oReport NAME "QMTR320" TITLE STR0005 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION STR0001+STR0002 // "Relatorio de Instrumentos Disponiveis por Filial" ### "Relatorio de Instrumentos Disponiveis por Filial"
	   
/*
Criacao do objeto secao utilizada pelo relatorio                               
DEFINE SECTION  <Nome> OF <Objeto TReport que a secao pertence>  ;
       TITLE  <Descricao da secao>                               ;
       TABLES <Tabelas a ser usadas>                             ;
       ORDERS <Array com as Ordens do relatorio>                 ;
       LOAD CELLS            									 ; // Carrega campos do SX3 como celulas
       TOTAL TEXT //Carrega ordens do Sindex
*/
DEFINE SECTION oSection1 OF oReport   TABLES "QN4" //ORDERS aOrdem
DEFINE SECTION oSection2 OF oReport                TITLE STR0018 TABLES "QN4"  // "LEGENDA DAS FILIAIS"            
DEFINE SECTION oSection3 OF oReport                TITLE STR0020 TABLES "QN4"  // "LEGENDA DOS DEPARTAMENTOS POR FILIAL" 

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


//|------------------	
//DADOS DO EMPRESTIMO
DEFINE CELL NAME "QN4_INSTR"   OF oSection1 ALIAS "QN4" SIZE 38  TITLE CRLF+"Instrumento"
DEFINE CELL NAME "QN4_REVINS"  OF oSection1 ALIAS "QN4" SIZE 5	 TITLE CRLF+"Rev"
DEFINE CELL NAME "QN4_FILINS"  OF oSection1 ALIAS "QN4" SIZE 5	 TITLE CRLF+"Fil"
DEFINE CELL NAME "QN4_DTASAI"  OF oSection1 ALIAS "QN4" SIZE  10 TITLE CRLF+"Data"			   	BLOCK { || " "+DTOC(&(cAliasQN4+"->QN4_DTASAI")) }
DEFINE CELL NAME "HORSAI"  	   OF oSection1             SIZE  10 TITLE ""/*______"*/+CRLF+STR0025                	BLOCK { || &(cAliasQN4+"->QN4_HORSAI")}
DEFINE CELL NAME "QN4_RESSAI"  OF oSection1 ALIAS "QN4" SIZE  18 TITLE CRLF+STR0038 
DEFINE CELL NAME "NOMEE"       OF oSection1             SIZE  21 TITLE STR0029+CRLF+STR0026 	 			  	BLOCK { || Substr(Posicione("QAA",1,&(cAliasQN4+"->QN4_FILRSA")+&(cAliasQN4+"->QN4_RESSAI"),"QAA_NOME"),1,20) }
DEFINE CELL NAME "QN4_FILRSA"  OF oSection1 ALIAS "QN4" SIZE   4 TITLE /*"____ "+*/CRLF+STR0023
DEFINE CELL NAME "QN4_DEPRSA"  OF oSection1 ALIAS "QN4" SIZE  18 TITLE /*"______________"+*/CRLF+STR0027 
    
//DADOS DO RECEBIMENTO
DEFINE CELL NAME "QN4_DTAENT"  OF oSection1 ALIAS "QN4" SIZE  12 	TITLE /*"____________"*/+CRLF+STR0024			BLOCK { || " "+DTOC(&(cAliasQN4+"->QN4_DTAENT"))}
DEFINE CELL NAME "HORENT"      OF oSection1             SIZE  10 	TITLE CRLF+STR0025 				BLOCK { || &(cAliasQN4+"->QN4_HORENT")}
DEFINE CELL NAME "QN4_RESENT"  OF oSection1 ALIAS "QN4" SIZE  15 	TITLE CRLF+STR0038 
DEFINE CELL NAME "NOMER"       OF oSection1             SIZE  21 	TITLE STR0031+CRLF+STR0026  				BLOCK { || Substr(Posicione("QAA",1,&(cAliasQN4+"->QN4_FILREN")+&(cAliasQN4+"->QN4_RESENT"),"QAA_NOME"),1,20) }
DEFINE CELL NAME "QN4_FILREN"  OF oSection1 ALIAS "QN4" SIZE   4 	TITLE /*"____"+*/CRLF+STR0023 
DEFINE CELL NAME "QN4_DEPREN"  OF oSection1 ALIAS "QN4" SIZE  20 	TITLE /*"______________"+*/CRLF+STR0027

//DADOS DA MOVIMENTACAO
//Verifica o tipo de Movimentacao
DEFINE CELL NAME "MOVIM"       OF oSection1             SIZE   25	 TITLE STR0032+CRLF+STR0033  	   			BLOCK { || Iif(&(cAliasQN4+"->QN4_TPMOV") == "1",Iif(&(cAliasQN4+"->QN4_FILINS") == &(cAliasQN4+"->QN4_FILREN"), STR0015, STR0010), STR0011)} //"Tipo"###"Movimentacao"###"Devolução"###"Emprestimo"###"Calibração"
//Verifica o tipo de Devolucao
DEFINE CELL NAME "DEVOL"       OF oSection1             	SIZE  55 TITLE STR0032+CRLF+STR0015 				BLOCK { || Iif(&(cAliasQN4+"->QN4_TPDEV") == "1", STR0012, STR0013)} //"Tipo"###"Devolucao"###"Devol. Obrigatoria"###"Devol. Não Obrigatoria"
DEFINE CELL NAME "FIL"  		OF oSection2             	SIZE  55 TITLE STR0034 // "FILIAL"
DEFINE CELL NAME "DESC"  		OF oSection2         	  	SIZE  55 TITLE STR0035 // "DESCRICAO" 
DEFINE CELL NAME "FIL"  		OF oSection3           		SIZE  55 TITLE STR0034 // "FILIAL"
DEFINE CELL NAME "DEPTO"  		OF oSection3          	  	SIZE  55 TITLE STR0036 // "DEPARTAMENTO"
DEFINE CELL NAME "DESC"  		OF oSection3          	  	SIZE  55 TITLE STR0035 // "DESCRICAO"

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³PrintRepor³ Autor ³ Cicero Cruz           ³ Data ³ 10.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao dos Textos	Reprogramacao R4	 				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QMTR320													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport( oReport )
Local oSection1 := oReport:Section(1)   
Local oSection2 := oReport:Section(2)
Local oSection3 := oReport:Section(3)  
Local nY := 0
Local cFiltro	:= " "
Local cPerg		:="QMT320"
Local cInstAnt  := ""
Local cTipo  	:= "" 
Local lMov      := .F.
Local cMemo 	:= ""  
Local nMCount   := 0
Local nLoop     := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿    ^
//³ Variaveis utilizadas para parametros                  ³
//³ mv_par01   : Filia De			                      ³
//³ mv_par02   : Filial Ate 		                      ³
//³ mv_par03   : Familia da Instrumento De                ³
//³ mv_par04   : Familia da Instrumento Ate               ³
//³ mv_par05   : Data De           					      ³
//³ mv_par06   : Data Ate       					      ³
//³ mv_par07   : Tipo de Movimentação	                  ³
//³ 			 1= Emprestimo  						  ³
//³ 			 2= Calibração							  ³
//³ 			 3= Todos								  ³
//³ mv_par08   : Imprime Justificativa (1=Sim/2=Nao)	  ³    
//³ mv_par09   : Imprime Legenda (1=Sim/2=Nao)	          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:BeginQuery()	

cAliasQN4 := GetNextAlias()
    
    cChave := "% "+SqlOrder("QN4_INSTR+QN4_REVINS+QN4_SEQUEN")+" %"
    
BeginSql Alias cAliasQN4
 

SELECT  * 
 		FROM    %table:QN4% QN4, 	
 			%table:QM2% QM2
	WHERE 	QN4.QN4_FILREN 	BETWEEN %Exp:mv_par01% 	AND %Exp:mv_par02% 	AND
			QN4.QN4_DTAENT 	BETWEEN %Exp:mv_par05% 	AND %Exp:mv_par06%	AND  
	      	QN4.QN4_INSTR  = QM2.QM2_INSTR                            	AND
	      	QN4.QN4_REVINS = QM2.QM2_REVINS                           	AND
	       //	QN4.QN4_FILINS = QM2.QM2_FILIAL 							AND
	     // 	QN4.QN4_FILREN <> QN4.QN4_FILRSA 							AND
	      	QN4.QN4_RESENT <> QN4.QN4_RESSAI 							AND
			QM2.QM2_TIPO 	BETWEEN %Exp:mv_par03% AND %Exp:mv_par04% 	AND  
	      	QN4.%notDel% 												AND 
	      	QM2.%notDel% 
	ORDER BY %Exp:cChave% 		

EndSql   
oSection1:EndQuery()	

oSection1:Init()

oSection1:Cell("QN4_DTASAI"):SetColSpace(-1)
oSection1:Cell("HORSAI"):SetColSpace(-1)
oSection1:Cell("QN4_RESSAI"):SetColSpace(-1)
oSection1:Cell("NOMEE"):SetColSpace(0)
oSection1:Cell("QN4_FILRSA"):SetColSpace(-1)

oSection1:Cell("QN4_DTAENT"):SetColSpace(-1)
oSection1:Cell("HORENT"):SetColSpace(-1)
oSection1:Cell("QN4_RESENT"):SetColSpace(-1)
oSection1:Cell("NOMER"):SetColSpace(0)
oSection1:Cell("QN4_FILREN"):SetColSpace(-1)

If Empty(cInstAnt)

	oSection1:Cell("QN4_INSTR"):SetValue(" ")
	oSection1:Cell("QN4_REVINS"):SetValue(" ")
	oSection1:Cell("QN4_FILINS"):SetValue(" ")
	
	oSection1:Cell("QN4_DTASAI"):SetValue(" ")
	oSection1:Cell("HORSAI"):SetValue(" ")
	oSection1:Cell("QN4_RESSAI"):SetValue(" ")
	oSection1:Cell("NOMEE"):SetValue(" ")
	oSection1:Cell("QN4_FILRSA"):SetValue(" ")
	oSection1:Cell("QN4_DEPRSA"):SetValue(" ")
	
	oSection1:Cell("QN4_DTAENT"):SetValue(" ")
	oSection1:Cell("HORENT"):SetValue(" ")
	oSection1:Cell("QN4_RESENT"):SetValue(" ")
	oSection1:Cell("NOMER"):SetValue("")
	oSection1:Cell("QN4_FILREN"):SetValue("")
	oSection1:Cell("QN4_DEPREN"):SetValue("") 
	
	oSection1:Cell("MOVIM"):SetValue("")
	oSection1:Cell("DEVOL"):SetValue("")

	oSection1:PrintLine() 
EndIf

While !(cAliasQN4)->(EOF())
	// Caso inclua na Embedded
 	If MV_PAR07 <> 3 .AND. &(cAliasQN4+"->QN4_TPMOV") != ALLTRIM(STR(MV_PAR07)) 
		(cAliasQN4)->(DbSkip())
		Loop
    EndIf          

	If 	&(cAliasQN4+"->QN4_FILREN") == &(cAliasQN4+"->QN4_FILRSA") .AND. &(cAliasQN4+"->QN4_RESENT") == &(cAliasQN4+"->QN4_RESSAI")
		(cAliasQN4)->(dbSkip())
		Loop 
	EndIf         
 	
	lMov:= .T.
						
	If Empty(cInstAnt)
	    oReport:PrintText(STR0037,oReport:Row(),oSection1:Cell("QN4_INSTR"):ColPos()) //"Instrumento: "
		oReport:PrintText(&(cAliasQN4+"->QN4_INSTR")+STR0009+&(cAliasQN4+"->QN4_REVINS"),oReport:Row(),oSection1:Cell("QN4_REVINS"):ColPos()) //" - Revisão : "
	    oReport:SkipLine()
	    cInstAnt := &(cAliasQN4+"->QN4_INSTR")
	Else
		If (cInstAnt != &(cAliasQN4+"->QN4_INSTR"))
		    oReport:SkipLine()
			oReport:PrintText(STR0037,oReport:Row(),oSection1:Cell("QN4_INSTR"):ColPos()) //"Instrumento: "
			oReport:PrintText(&(cAliasQN4+"->QN4_INSTR")+STR0009+&(cAliasQN4+"->QN4_REVINS"),oReport:Row(),oSection1:Cell("QN4_REVINS"):ColPos()) //" - Revisão : "
		    oReport:SkipLine()
			cInstAnt := &(cAliasQN4+"->QN4_INSTR")
		EndIf
	EndIf 
	  

	If !Empty(aInstru)
		If !(Ascan(aInstru, { |x| x[1] == &(cAliasQN4+"->QN4_FILREN") .AND. x[2] == &(cAliasQN4+"->QN4_DEPREN") }) > 0)
			Aadd(aInstru,{ &(cAliasQN4+"->QN4_FILREN"), &(cAliasQN4+"->QN4_DEPREN") })                
		EndIf
		If !(Ascan(aInstru, { |x| x[1] == &(cAliasQN4+"->QN4_FILRSA") .AND. x[2] == &(cAliasQN4+"->QN4_DEPRSA") }) > 0)
			Aadd(aInstru,{ &(cAliasQN4+"->QN4_FILRSA"), &(cAliasQN4+"->QN4_DEPRSA") })	
		EndIf
	Else
		Aadd(aInstru,{ &(cAliasQN4+"->QN4_FILREN"), &(cAliasQN4+"->QN4_DEPREN") })
		If !(Ascan(aInstru, { |x| x[1] == &(cAliasQN4+"->QN4_FILRSA") .AND. x[2] == &(cAliasQN4+"->QN4_DEPRSA") }) > 0)
			Aadd(aInstru,{ &(cAliasQN4+"->QN4_FILRSA"), &(cAliasQN4+"->QN4_DEPRSA") })	
		EndIf
	Endif

	oSection1:Cell("QN4_INSTR"):SetValue(&(cAliasQN4+"->QN4_INSTR"))
	oSection1:Cell("QN4_REVINS"):SetValue(&(cAliasQN4+"->QN4_REVINS"))
	oSection1:Cell("QN4_FILINS"):SetValue(&(cAliasQN4+"->QN4_FILINS"))

	oSection1:Cell("QN4_DTASAI"):SetValue(&(cAliasQN4+"->QN4_DTASAI"))
	oSection1:Cell("HORSAI"):SetValue(&(cAliasQN4+"->QN4_HORSAI"))
	oSection1:Cell("QN4_RESSAI"):SetValue(&(cAliasQN4+"->QN4_RESSAI"))
	oSection1:Cell("NOMEE"):SetValue(Substr(Posicione("QAA",1,&(cAliasQN4+"->QN4_FILRSA")+&(cAliasQN4+"->QN4_RESSAI"),"QAA_NOME"),1,20) )
	oSection1:Cell("QN4_FILRSA"):SetValue(&(cAliasQN4+"->QN4_FILRSA"))
	oSection1:Cell("QN4_DEPRSA"):SetValue(&(cAliasQN4+"->QN4_DEPRSA"))
	
	oSection1:Cell("QN4_DTAENT"):SetValue(&(cAliasQN4+"->QN4_DTAENT"))
	oSection1:Cell("HORENT"):SetValue(&(cAliasQN4+"->QN4_HORENT"))
	oSection1:Cell("QN4_RESENT"):SetValue(&(cAliasQN4+"->QN4_RESENT"))
	oSection1:Cell("NOMER"):SetValue(Substr(Posicione("QAA",1,&(cAliasQN4+"->QN4_FILREN")+&(cAliasQN4+"->QN4_RESENT"),"QAA_NOME"),1,20))
	oSection1:Cell("QN4_FILREN"):SetValue(&(cAliasQN4+"->QN4_FILREN"))
	oSection1:Cell("QN4_DEPREN"):SetValue(&(cAliasQN4+"->QN4_DEPREN")) 
	
	oSection1:Cell("MOVIM"):SetValue(Iif(&(cAliasQN4+"->QN4_TPMOV") == "1",Iif(&(cAliasQN4+"->QN4_FILINS") == &(cAliasQN4+"->QN4_FILREN"), STR0015, STR0010), STR0011))
	oSection1:Cell("DEVOL"):SetValue(Iif(&(cAliasQN4+"->QN4_TPDEV") == "1", STR0012, STR0013))

	If MV_PAR08 == 1 .and. !Empty(&(cAliasQN4+"->QN4_CODJUS"))
		oSection1:PrintLine()
		
		// Ainda nao existe um parametro no printtext para que eu indique onde vai a informacao "antes ou depois" da linha da secao 
		// entao so obrigado a usar este  recurso zero os valores e imprimo por cima. Caso seja criado tal parametro retirar este
		// trecho - Inicio
		
		oSection1:Cell("QN4_INSTR"):Hide()
		oSection1:Cell("QN4_REVINS"):Hide()
		oSection1:Cell("QN4_FILINS"):Hide()
	
		oSection1:Cell("QN4_DTASAI"):Hide()
		oSection1:Cell("HORSAI"):Hide()
		oSection1:Cell("QN4_RESSAI"):Hide()
		oSection1:Cell("NOMEE"):Hide()
		oSection1:Cell("QN4_FILRSA"):Hide()
		oSection1:Cell("QN4_DEPRSA"):Hide()
		
		oSection1:Cell("QN4_DTAENT"):Hide()
		oSection1:Cell("HORENT"):Hide()
		oSection1:Cell("QN4_RESENT"):Hide()
		oSection1:Cell("NOMER"):Hide()
		oSection1:Cell("QN4_FILREN"):Hide()
		oSection1:Cell("QN4_DEPREN"):Hide()
		
		oSection1:Cell("MOVIM"):Hide()
		oSection1:Cell("DEVOL"):Hide()		
		// - Fim		
		
		oReport:SkipLine()
		oReport:PrintText(STR0014,oReport:Row(),oSection1:Cell("QN4_INSTR"):ColPos()) //"Justificativa : "
		oReport:SkipLine()        

		cMemo	:= MSMM(&(cAliasQN4+"->QN4_CODJUS"))
		nMCount	:= MlCount( cMemo, 200 )
				
		If !Empty(nMCount)
			For nLoop := 1 To nMCount
				cLinha := MemoLine( cMemo, 200, nLoop )
				oReport:PrintText(MemoLine( cMemo, 200, nLoop ),oReport:Row(),oSection1:Cell("QN4_REVINS"):ColPos()/2) 
				oReport:SkipLine()
			Next nLoop 
			oReport:SkipLine(-1) // Compensar o excesso de espaços  gerados pelo componente quando corrigido o componente  dar um skipline  normal
		EndIf 
	EndIf

	oSection1:PrintLine()  

	oSection1:Cell("QN4_INSTR"):Show()
	oSection1:Cell("QN4_REVINS"):Show()
	oSection1:Cell("QN4_FILINS"):Show()

	oSection1:Cell("QN4_DTASAI"):Show()
	oSection1:Cell("HORSAI"):Show()
	oSection1:Cell("QN4_RESSAI"):Show()
	oSection1:Cell("NOMEE"):Show()
	oSection1:Cell("QN4_FILRSA"):Show()
	oSection1:Cell("QN4_DEPRSA"):Show()
	
	oSection1:Cell("QN4_DTAENT"):Show()
	oSection1:Cell("HORENT"):Show()
	oSection1:Cell("QN4_RESENT"):Show()
	oSection1:Cell("NOMER"):Show()
	oSection1:Cell("QN4_FILREN"):Show()
	oSection1:Cell("QN4_DEPREN"):Show()
	
	oSection1:Cell("MOVIM"):Show()
	oSection1:Cell("DEVOL"):Show()      
	
	(cAliasQN4)->(DbSkip())
EndDo
	
oSection1:Finish() 

If MV_PAR09 == 1 .AND. LEN(aInstru)>0
	oSection2:Init()  
	oReport:ThinLine() 
	// Totalizador geral estava  saindo depois da legenda
	oReport:SkipLine()
	oReport:PrintText(STR0018,oReport:Row(),oSection1:Cell("QN4_INSTR"):ColPos()) //"LEGENDA DAS FILIAIS"
	oReport:SkipLine()
	oSection2:PrintLine()

	aSort(aInstru,,,{|x,y| x[1] < y[1]}) 
	cInstAnt:= ""
	For nY := 1 to Len(aInstru)
		If cInstAnt != aInstru[nY,1]
			cInstAnt := aInstru[nY,1]
			oSection2:Cell("FIL"):SetValue(aInstru[nY,1])
			oSection2:Cell("DESC"):SetValue(QA_CHKFIL(aInstru[nY,1],,.T.))  
			oSection2:PrintLine()
		EndIf
	Next
	oSection2:Finish()    

	oSection3:Init()  
	oReport:SkipLine()
	oReport:PrintText(STR0020,oReport:Row(),oSection1:Cell("QN4_INSTR"):ColPos()) //"LEGENDA DOS DEPARTAMENTOS POR FILIAL" 
	oReport:SkipLine()           
	oSection3:PrintLine()
	aSort(aInstru,,,{|x,y| x[1] < y[1]}) 
	cInstAnt:= ""
	For nY := 1 to Len(aInstru)
		If cInstAnt != aInstru[nY,1]+aInstru[nY,2]
			cInstAnt := aInstru[nY,1]+aInstru[nY,2]
			oSection3:Cell("FIL"):SetValue(aInstru[nY,1])
			oSection3:Cell("DEPTO"):SetValue(aInstru[nY,2])  
			oSection3:Cell("DESC"):SetValue(Posicione("QAD",1,xFilial("QAD")+aInstru[nY,2],"QAD_DESC"))  
			oSection3:PrintLine()
		EndIf
	Next
	oSection3:Finish()
EndIf                      

If !lMov
	oReport:PrintText(STR0039,oReport:Row(),oSection1:Cell("NOMEE"):ColPos()) // "NAO HOUVE MOVIMENTACÃO PARA OS PARAMETROS ESPECIFICADOS"
	oReport:SkipLine()
	oSection1:PrintLine()
	oSection1:Finish()
EndIf

Return	

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR320R3³ Autor ³ Cleber Souza          ³ Data ³ 23/04/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relacao da movimentação dos Instrumentos                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR320R3(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cleber    ³      ³ Criacao do relatorio                                ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMTR320R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1        := STR0001 //"Relatorio da Movimentação dos Instrumentos" 
Local cDesc2        := STR0002 //" por Filial."
Local cDesc3        := ""
Local nLin          := 80
Local Cabec1        := Space(28)+STR0003 //"|---------------------------- Emprestimo ----------------------------|     |---------------------------- Recebimento ----------------------------| "
Local Cabec2        := STR0004 //"Instrumento        Rev  Fil  Data      Hora   Respons.    Nome                  Fil Departamento         Data      Hora   Repons.     Nome                  Fil Departamento     Tipo Moviment.  Tipo Devolução"
Local aOrd := {}

Private titulo      := STR0005 //"Relatorio de movimentação de instrumentos entre filiais"
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := "QMTR320" 
Private nTipo       := 18
Private aReturn     := { STR0016, 1, STR0017, 2, 2, 1, "", 1} //Zebrado # Administracao
Private nLastKey    := 0
Private cPerg       := "QMT320"
Private wnrel       := "QMTR320"  
Private cString     := "QN4"

dbSelectArea("QN4")
dbSetOrder(1)

pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                  ³
//³ mv_par01   : Filia De			                      ³
//³ mv_par02   : Filial Ate 		                      ³
//³ mv_par03   : Familia da Instrumento De                ³
//³ mv_par04   : Familia da Instrumento Ate               ³
//³ mv_par05   : Data De           					      ³
//³ mv_par06   : Data Ate       					      ³
//³ mv_par07   : Tipo de Movimentação	                  ³
//³ 			 1= Emprestimo  						  ³
//³ 			 2= Calibração							  ³
//³ 			 3= Todos								  ³
//³ mv_par08   : Imprime Justificativa (1=Sim/2=Nao)	  ³
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)  

TRB->(dbCloseArea())

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ Cleber Souza       º Data ³  23/04/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QMTR320			                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local cQuery    := ""   
Local aInstru   := {}  
Local lPrimVez  := .T. 
Local cCond     := "" 
Local cIndex    := ""
Local cChave    := "" 
Local cAlias    := ""
Local cMovim    := ""
Local cDevol    := ""
Local cMemo	    := ""
Local nMCount   := 0
Local nLoop     := 0
Local cLinha	:= "" 
Local cInstr    := "" 
Local aFilial   := {}
Local aDepto    := {}
Local nY        := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := Space(10)
cbcont   := 0
m_pag    := 1

If Empty(MV_PAR01) .or. !IsDigit(MV_PAR01)
	MV_PAR01 := "00"
Endif               

If Empty(MV_PAR02) .or. !IsDigit(MV_PAR02)
	MV_PAR02 := "zz"
Endif               

cAlias := "TRB"
cQuery := " SELECT * "
cQuery += " FROM "+RetSqlName("QN4")+" QN4, " + RetSqlName("QM2")+" QM2 "
cQuery += " WHERE "
cQuery += " QN4.QN4_FILREN >= '"+MV_PAR01+"' AND "
cQuery += " QN4.QN4_FILREN <= '"+MV_PAR02+"' AND "
cQuery += " QN4.QN4_INSTR  = QM2.QM2_INSTR  AND "
cQuery += " QN4.QN4_REVINS = QM2.QM2_REVINS AND "
 //	cQuery += " QN4_FILINS = QM2_FILIAL AND "
//	cQuery += " QN4.QN4_FILREN <> QN4.QN4_FILRSA AND "
cQuery += " QN4.QN4_RESENT <> QN4.QN4_RESSAI AND "
cQuery += " QM2.QM2_TIPO >= '"+MV_PAR03+"' AND "
cQuery += " QM2.QM2_TIPO <= '"+MV_PAR04+"' AND "
cQuery += " QN4.QN4_DTAENT >= '"+DTOS(MV_PAR05)+"' AND "
cQuery += " QN4.QN4_DTAENT <= '"+DTOS(MV_PAR06)+"' AND "
    
If MV_PAR07 <> 3     
	cQuery += "QN4.QN4_TPMOV = '"+ALLTRIM(STR(MV_PAR07))+"' AND "
    EndIf

cQuery += " QM2.D_E_L_E_T_= ' ' AND "
cQuery += " QN4.D_E_L_E_T_= ' ' "
cQuery += " ORDER BY " + SqlOrder("QN4_INSTR+QN4_REVINS+QN4_SEQUEN") 

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
TcSetField("TRB","QN4_DTASAI","D",8,0)
TcSetField("TRB","QN4_DTAENT","D",8,0)
	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(LastRec())

While &(cAlias+"->(!EOF())")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		@nLin,00 PSAY STR0007 // "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nLin > 55
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 6
	Endif   
     
 	If cInstr<>&(cAlias+"->QN4_INSTR")+&(cAlias+"->QN4_REVINS")
		If !lPrimVez
		  	@nLin,00 PSAY __PrtFatLine()		
		 	nLin ++
		 	@nLin,00 PSAY STR0008+ Alltrim(&(cAlias+"->QN4_INSTR"))+ STR0009 +&(cAlias+"->QN4_REVINS") //"Instrumento -----> " ### " - Revisão : "
		 	nLin += 2
			cInstr  := &(cAlias+"->QN4_INSTR")+&(cAlias+"->QN4_REVINS")
		Else
			lPrimVez := .f. 
			nLin += 3 
			@nLin,00 PSAY STR0008+ Alltrim(&(cAlias+"->QN4_INSTR"))+ STR0009 +&(cAlias+"->QN4_REVINS")//"Instrumento -----> " ### " - Revisão : "
			nLin += 2
			cInstr  := &(cAlias+"->QN4_INSTR")+&(cAlias+"->QN4_REVINS")
		EndIf
	EndIf
	*/ 
  
	//Verifica o tipo de Movimentação
	If &(cAlias+"->QN4_TPMOV") == "1"
		If &(cAlias+"->QN4_FILINS") == &(cAlias+"->QN4_FILREN")
			cMovim := STR0015 //"Devolução"
		Else
			cMovim := STR0010 //"Emprestimo"
		EndIf	
	Else
		cMovim := STR0011 //"Calibração"
	EndIF
	
	//Verifica o tipo de Devolução
	If &(cAlias+"->QN4_TPDEV") == "1"
		cDevol := STR0012 //"Devol. Obrigatoria"
	Else
		cDevol := STR0013 //"Devol. Não Obrigatoria"
	EndIF
	
    //DADOS DO INSTRUMENTO
	@nLin,00 PSAY &(cAlias+"->QN4_INSTR")
	@nLin,19 PSAY &(cAlias+"->QN4_REVINS")
	@nLin,24 PSAY &(cAlias+"->QN4_FILINS")
	
	//DADOS DO EMPRESTIMO
	@nLin,29 PSAY DTOC(&(cAlias+"->QN4_DTASAI"))
	@nLin,39 PSAY &(cAlias+"->QN4_HORSAI")
	@nLin,46 PSAY &(cAlias+"->QN4_RESSAI")
	@nLin,58 PSAY Substr(Posicione("QAA",1,&(cAlias+"->QN4_FILRSA")+&(cAlias+"->QN4_RESSAI"),"QAA_NOME"),1,20)
	@nLin,80 PSAY &(cAlias+"->QN4_FILRSA")
	@nLin,84 PSAY &(cAlias+"->QN4_DEPRSA")
    
	//DADOS DO RECEBIMENTO
	@nLin,105 PSAY DTOC(&(cAlias+"->QN4_DTAENT"))
	@nLin,115 PSAY &(cAlias+"->QN4_HORENT")
	@nLin,122 PSAY &(cAlias+"->QN4_RESENT")
	@nLin,134 PSAY Substr(Posicione("QAA",1,&(cAlias+"->QN4_FILREN")+&(cAlias+"->QN4_RESENT"),"QAA_NOME"),1,20)
	@nLin,156 PSAY &(cAlias+"->QN4_FILREN")
	@nLin,160 PSAY &(cAlias+"->QN4_DEPREN")
	
	//DADOS DA MOVIMENTACAO
	@nLin,177 PSAY cMovim
	@nLin,193 PSAY cDevol

	nLin++                 
	
	If MV_PAR08 == 1 .and. !Empty(&(cAlias+"->QN4_CODJUS"))
		nLin++
		If nLin > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 6
		Endif   
		@nLin,01 PSAY STR0014 //"Justificativa : " 
		cMemo	:= MSMM(&(cAlias+"->QN4_CODJUS"))
		nMCount	:= MlCount( cMemo, 200 )
				
		If !Empty(nMCount)
			For nLoop := 1 To nMCount
				cLinha := MemoLine( cMemo, 200, nLoop )
				@nLin,019 PSAY StrTran( cLinha, Chr(13)+Chr(10), "" )
				nLin++
				If nLin > 55
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 6
				Endif   
			Next nLoop 
		EndIf 
		nLin++
	EndIF		    
	
	If MV_PAR09 == 1 
	
		//Pesquisa as Filiais utilizados
		If aScan(aFilial,{|x|x[1]==&(cAlias+"->QN4_FILRSA")}) == 0
	   		AADD(aFilial,{&(cAlias+"->QN4_FILRSA")})
	   	EndIF	

		If aScan(aFilial,{|x|x[1]==&(cAlias+"->QN4_FILREN")}) == 0
	   		AADD(aFilial,{&(cAlias+"->QN4_FILREN")})
	   	EndIF	
        
		//Pesquisa os Departamentos utilizados
   		If aScan(aDepto,{|x|x[1]==&(cAlias+"->QN4_FILRSA")+&(cAlias+"->QN4_DEPRSA")}) == 0
	   		AADD(aDepto,{&(cAlias+"->QN4_FILRSA")+&(cAlias+"->QN4_DEPRSA")})
	   	EndIF	

   		If aScan(aDepto,{|x|x[1]==&(cAlias+"->QN4_FILREN")+&(cAlias+"->QN4_DEPREN")}) == 0
	   		AADD(aDepto,{&(cAlias+"->QN4_FILREN")+&(cAlias+"->QN4_DEPREN")})
	   	EndIF	

	EndIF
	
	&(cAlias+"->(dbSkip())")
EndDo


If MV_PAR09 == 1 .and. Len(aFilial)>0

	nLin ++
	@nLin,00 PSAY __PrtFatLine()		
	nLin ++ 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nLin > 55
		Cabec(Titulo,"","",NomeProg,Tamanho,nTipo)
		nLin := 6
	Endif                                  

	@nLin,001 PSAY STR0018 //"LEGENDA DAS FILIAIS"
	nLin +=2                                
	@nLin,001 PSAY STR0019 //"FILIAL     DESCRICAO"
	nLin ++
	 
	For nY:=1 to Len(aFilial)
		@nLin,001 PSAY aFilial[nY,1]
		@nLin,012 PSAY QA_CHKFIL(aFilial[nY,1],,.T.) 
		nLin ++  
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do cabecalho do relatorio. . .                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLin > 55
			Cabec(Titulo,"","",NomeProg,Tamanho,nTipo)
			nLin := 6
		Endif
   
    Next nY
   
	nLin +=2
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nLin > 55
		Cabec(Titulo,"","",NomeProg,Tamanho,nTipo)
		nLin := 6
	Endif          

	@nLin,001 PSAY STR0020//"LEGENDA DOS DEPARTAMENTOS POR FILIAL"
	nLin +=2 
	@nLin,001 PSAY STR0021//"FILIAL  DEPTO             DESCRICAO"
	nLin ++

	For nY:=1 to Len(aDepto)
		@nLin,001 PSAY Substr(aDepto[nY,1],1,2)
		@nLin,009 PSAY Substr(aDepto[nY,1],3,Len(Alltrim(aDepto[nY,1]))-2)
		@nLin,027 PSAY Posicione("QAD",1,aDepto[nY,1],"QAD_DESC") 
		nLin ++  
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do cabecalho do relatorio. . .                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLin > 55
			Cabec(Titulo,"","",NomeProg,Tamanho,nTipo)
			nLin := 6
		Endif
   
    Next nY

EndIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return      
