/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR755.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 3 //Versao do fonte
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR755
Relatorio da Agenda Medica

@author Rafael Diogo Richter
@since 20/08/2003
@return .T.
/*/
//---------------------------------------------------------------------      
User Function MDTR755()

//Guarda conteudo e declara variaveis padroes
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)	

Local oReport 
Local aArea := GetArea()
PRIVATE cPerg := "MDT755"

/*-------------------|
//PERGUNTAS PADRÃO	|
| Usuario ?			|
| Periodo De ?		|
| Periodo Ate ?		|
| Considerar ?		|
| Imprimir ?			|
---------------------|*/

If !MDTRESTRI("MDTR755")  
	Return .F.
Endif

If TRepInUse()
   	//-- Interface de impressao
  	oReport := ReportDef()
	oReport:SetLandScape()
	oReport:DisableOrientation()
	oReport:PrintDialog()
Else
   U_MDTR755R3()
EndIf          

RestArea(aArea)

//Retorna conteudo de variaveis padroes
NGRETURNPRM(aNGBEGINPRM) 
Return .T.
//---------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define as secoes impressas no relatorio  

@author Andre E. Perez Alvarez
@since 31/07/06
@return .T.
/*/
//---------------------------------------------------------------------  
Static Function ReportDef()

Static oReport
Static oSection1
Static oSection2
Static oCell

//LAYOUT: mv_par05 == 1
/*        1         2         3         4         5         6         7         8         9       100       110       120       130 
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
____________________________________________________________________________________________________________________________________
                                                       
                                                       Relatorio da Agenda Medica       
____________________________________________________________________________________________________________________________________

Usuario
______________________________
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


Ficha        Nome                             Dt. Consulta   Hr. Consulta   Exame                       Motivo
____________________________________________________________________________________________________________________
xxxxxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx       xx:xx          xxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx
		Observacao: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx       xx:xx          xxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx
xxxxxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx       xx:xx          xxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx
xxxxxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx       xx:xx          xxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx

*/ 

//LAYOUT: mv_par05 == 2
/*        1         2         3         4         5         6         7         8         9       100       110       120       130 
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
____________________________________________________________________________________________________________________________________
                                                       
                                                       Relatorio da Agenda Medica       
____________________________________________________________________________________________________________________________________

Usuario
______________________________
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


Matricula    Nome                             Dt. Consulta   Hr. Consulta   Exame                       Motivo
____________________________________________________________________________________________________________________
xxxxxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx       xx:xx          xxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx
		Observacao: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx       xx:xx          xxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx
xxxxxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx       xx:xx          xxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx
xxxxxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx       xx:xx          xxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx

*/

//LAYOUT: mv_par05 == 3
/*        1         2         3         4         5         6         7         8         9       100       110       120       130 
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
____________________________________________________________________________________________________________________________________
                                                       
                                                       Relatorio da Agenda Medica       
____________________________________________________________________________________________________________________________________

Usuario
______________________________
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


Ficha     Matr.  Nome                             Dt. Consulta   Hr. Consulta   Exame                       Motivo
_____________________________________________________________________________________________________________________________________
xxxxxxxxx xxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx       xx:xx          xxxxxxxxxxxxxxxxxxxxxxxxxx  1234567890123456789012345
		Observacao: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx       xx:xx          xxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx
xxxxxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx       xx:xx          xxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx
xxxxxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx       xx:xx          xxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxx

*/  

//------------------------------------------------------------------------
// Criacao do componente de impressao                                      
//                                                                        
// TReport():New                                                           
// ExpC1 : Nome do relatorio                                               
// ExpC2 : Titulo                                                          
// ExpC3 : Pergunte                                                        
// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  
// ExpC5 : Descricao                                                       
//                                                                        
//------------------------------------------------------------------------
oReport := TReport():New("MDTR755",OemToAnsi(STR0004),"MDT755",{|oReport| ReportPrint()},;  //"Relatório da Agenda Médica"
           STR0001)

//------------------------------------------------------------------------
// Variaveis utilizadas para parametros                         
// mv_par01             // Usuario                              
// mv_par02             // Periodo De                           
// mv_par03             // Periodo Ate                                    
// mv_par04             // Considerar                           
//                           1 - Todos                          
//                           2 - Atendidos                      
//                           3 - Nao atendidos                  
// mv_par05             // Imprimir:                            
//                           1 - Ficha Medica                   
//                           2 - Matricula                      
//                           3 - Ambos                          
//------------------------------------------------------------------------

Pergunte(oReport:uParam,.F.)

//------------------------------------------------------------------------
// Criacao da secao utilizada pelo relatorio                               
//                                                                        
// TRSection():New                                                         
// ExpO1 : Objeto TReport que a secao pertence                             
// ExpC2 : Descricao da seçao                                              
// ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   
//        sera considerada como principal para a seção.                   
// ExpA4 : Array com as Ordens do relatório                                
// ExpL5 : Carrega campos do SX3 como celulas                              
//        Default : False                                                 
// ExpL6 : Carrega ordens do Sindex                                        
//        Default : False                                                 
//                                                                        
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// Criacao da celulas da secao do relatorio                                
//                                                                        
// TRCell():New                                                            
// ExpO1 : Objeto TSection que a secao pertence                            
// ExpC2 : Nome da celula do relatório. O SX3 será consultado              
// ExpC3 : Nome da tabela de referencia da celula                          
// ExpC4 : Titulo da celula                                                
//        Default : X3Titulo()                                            
// ExpC5 : Picture                                                         
//        Default : X3_PICTURE                                            
// ExpC6 : Tamanho                                                         
//        Default : X3_TAMANHO                                            
// ExpL7 : Informe se o tamanho esta em pixel                              
//         Default : False                                                 
// ExpB8 : Bloco de código para impressao.                                 
//        Default : ExpC2                                                 
//                                                                        
//------------------------------------------------------------------------

//********************* Secao 1 - Usuario
oSection1 := TRSection():New (oReport,"Usuários SESMT", {"TMJ","TMK"} ) 
oCell := TRCell():New(oSection1, "TMK_NOMUSU", "TMK" , STR0015, "@!", 40  )  //"Usuario"     
TRPosition():New (oSection1, "TMK", 1, {|| xFilial("TMK") + TMJ->TMJ_CODUSU} )      
       
Return oReport
//---------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o relatorio.  

@author Andre E. Perez Alvarez
@since 31/07/06
@return .T.
/*/
//---------------------------------------------------------------------  
Static Function ReportPrint()

//********************* Secao 2 - Ficha Medica / Nome / Data Consulta ....

oSection2 := TRSection():New (oReport,"Consultas", {"TMJ","TM0","TM4","TMS"} )

//Ajusta o cabecalho de acordo com o parametro 5
If mv_par05 == 1
	oCell := TRCell():New (oSection2, "TMJ_NUMFIC", "TMJ", STR0016, "@!"      , 15, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Ficha Medica"
ElseIf mv_par05 == 2
	oCell := TRCell():New (oSection2, "TMJ_MAT", "TMJ", STR0025, "@!"      , 06, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Matrícula"
ElseIf mv_par05 == 3
	oCell := TRCell():New (oSection2, "TMJ_NUMFIC", "TMJ", STR0016, "@!"      , 15, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Ficha Medica"	
	oCell := TRCell():New (oSection2, "TMJ_MAT"   , "TMJ", STR0029, "@!"      , 06, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Matr."
Endif

oCell := TRCell():New (oSection2, "TM0_NOMFIC", "TM0", STR0017, "@!"      , 40, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Nome"
oCell := TRCell():New (oSection2, "TMJ_DTCONS", "TMJ", STR0018, "99/99/9999", 14, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Dt. Consulta"
oCell := TRCell():New (oSection2, "TMJ_HRCONS", "TMJ", STR0019, "99:99"   , 05, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Hr. Consulta"
oCell := TRCell():New (oSection2, "TM4_NOMEXA", "TM4", STR0020, "@!"      , 40, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Exame"
oCell := TRCell():New (oSection2, "TMS_NOMOTI", "TMS", STR0021, "@!"      , 25, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Motivo"
oCel  := TRCell():New (oSection2, "TMJ_OBSCON", "TMJ", STR0022, "@!"      , 44, /*lPixel*/, /*{|| code-block de impressao }*/            ) //"Observação"
If mv_par04 == 1
	oCel  := TRCell():New (oSection2, Space(15), "TMJ", STR0030, "@!"   , 15, /*lPixel*/, {|| If(!empty(TMJ->TMJ_DTATEN),"Sim            ","Não            ") }            ) //"Realizado?"
EndIf
TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + TMJ->TMJ_NUMFIC } )      
TRPosition():New (oSection2, "TM4", 1, {|| xFilial("TM4") + TMJ->TMJ_EXAME  } )      
TRPosition():New (oSection2, "TMS", 1, {|| xFilial("TMS") + TMJ->TMJ_MOTIVO } )  

//*******************
	
dbSelectArea("TMJ")
dbSetOrder(01)
dbSeek ( xFilial("TMJ") + mv_par01 + DTOS(mv_par02), .T. )
oReport:SetMeter( LastRec() ) 

oSection1:Init()
oSection1:PrintLine()
oSection2:Init()
While !oReport:Cancel()	  				  .AND.;
	  !Eof() 	                          .AND.; 
	  TMJ->TMJ_FILIAL == xFilial("TMJ")	  .AND.; 
	  TMJ->TMJ_CODUSU == mv_par01		  .AND.; 
	  TMJ->TMJ_DTCONS <= mv_par03

    oSection1:IncMeter() 
    
    If ( mv_par04 == 2 ) .AND. empty(TMJ->TMJ_DTATEN)
    	DbSkip()
    	Loop
    Endif
    If ( mv_par04 == 3 ) .AND. !empty(TMJ->TMJ_DTATEN)
    	DbSkip()
    	Loop
    Endif
	
	oSection2:PrintLine()
    
	DbSelectArea("TMJ")
	DbSkip()
End
oSection2:Finish()
oSection1:Finish()

Return .T.   
 
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR755R3
Relatorio da Agenda Medica (realese 3)

@author Rafael Diogo Richter
@since 20/08/2003
@return .T.
/*/
//---------------------------------------------------------------------  
User Function MDTR755R3()
//---------------------------------------------------------------
// Define Variaveis                                             
//---------------------------------------------------------------
LOCAL wnrel   := "MDTR755"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Exibe os Dados Conforme as Informacoes da Agenda Medica"
LOCAL cDesc2  := " "
LOCAL cDesc3  := " "
LOCAL cString := "TMJ"


PRIVATE nomeprog := "MDTR755"
PRIVATE tamanho  := "G"
PRIVATE aReturn  := { STR0002, 1,STR0003, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0004 //"Relatório da Agenda Médica"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0

PRIVATE cabec1
Private cabec2 := ""


//---------------------------------------------------------------
// Variaveis utilizadas para parametros                         
// mv_par01             // Usuario                              
// mv_par02             // Periodo De                           
// mv_par03             // Periodo Ate                                    
// mv_par04             // Considerar                           
//                           1 - Todos                          
//                           2 - Atendidos                      
//                           3 - Nao atendidos                  
// mv_par05             // Imprimir:                            
//                           1 - Ficha Medica                   
//                           2 - Matricula                      
//                           3 - Ambos                          
//---------------------------------------------------------------

//---------------------------------------------------------------
// Verifica as perguntas selecionadas                           
//---------------------------------------------------------------
pergunte(cPerg,.F.)
//---------------------------------------------------------------
// Envia controle para a funcao SETPRINT                        
//---------------------------------------------------------------
wnrel:="MDTR755"

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
 	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

RptStatus({|lEnd| R755Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return Nil       
//---------------------------------------------------------------------
/*/{Protheus.doc} R755Imp
Chama Relatório.

@param lEnd - Cancela a impressão
@param wnRel - Programa utilizado.
@param titulo - Titulo do relatório.
@param tamanho - Tamanho do relatório. 

@author Rafael Diogo Richter
@since 20/08/2003
@return .T.
/*/
//---------------------------------------------------------------------  
Static Function R755Imp(lEnd,wnRel,titulo,tamanho)

//---------------------------------------------------------------
// Define Variaveis                                             
//---------------------------------------------------------------
Local cRodaTxt := ""
Local nCntImpr := 0
Local aColunas := { 013, 046, 061, 076, 104, 130, 178 }

//---------------------------------------------------------------
// Contadores de linha e pagina                                 
//---------------------------------------------------------------
PRIVATE li := 80 ,m_pag := 1

//---------------------------------------------------------------
// Verifica se deve comprimir ou nao                            
//---------------------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)

//---------------------------------------------------------------
// Monta os Cabecalhos                                          
//---------------------------------------------------------------

If mv_par05 == 1 .And. mv_par04 <> 1
	cabec1 := STR0031 //"Ficha        Nome                             Dt. Consulta   Hr. Consulta   Exame                       Motivo                    Observação"	
ElseIf mv_par05 == 1 .And. mv_par04 == 1
	cabec1 := STR0012 //"Ficha        Nome                             Dt. Consulta   Hr. Consulta   Exame                       Motivo                    Observação"
ElseIf mv_par05 == 2 .And. mv_par04 <> 1
	cabec1 := STR0032 //"Matrícula    Nome                             Dt. Consulta   Hr. Consulta   Exame                       Motivo                    Observação"	
ElseIf mv_par05 == 2  .And. mv_par04 == 1
	cabec1 := STR0027 //"Matrícula    Nome                             Dt. Consulta   Hr. Consulta   Exame                       Motivo                    Observação"
ElseIf mv_par05 == 3 .And. mv_par04 <> 1
	cabec1 := STR0033		//"Ficha     Matr.  Nome                             Dt. Consulta   Hr. Consulta   Exame                       Motivo                    Observação"	
	aColunas := { 017, 050, 065, 080, 108, 134}
ElseIf mv_par05 == 3 .And. mv_par04 == 1
	cabec1 := STR0028 //"Ficha     Matr.  Nome                             Dt. Consulta   Hr. Consulta   Exame                       Motivo                    Observação"
	aColunas := { 017, 050, 065, 080, 108, 134, 182 }
Endif



/*              mv_par05 == 1
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************

          1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(Padrao)                           						Relatorio da Agenda Medica										              
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Ficha        Nome                             Dt. Consulta   Hr. Consulta   Exame                       Motivo
     Observacao
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

XXXXXXXXXX   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   XXXXXXXX       XXXXX          XXXXXXXXXXXXXXXXXXXXXXXXX   XXXXXXXXXXXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


Total de Funcionarios.: 999
*/

/*              mv_par02 == 2
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************

          1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(Padrao)                           						Relatorio da Agenda Medica										              
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Matricula    Nome                             Dt. Consulta   Hr. Consulta   Exame                       Motivo
     Observacao
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

XXXXXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   XXXXXXXX       XXXXX          XXXXXXXXXXXXXXXXXXXXXXXXX   XXXXXXXXXXXXXXXXXXXXXXXXX
     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


Total de Funcionarios.: 999
*/                           

/*              mv_par02 == 3
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************

          1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(Padrao)                           						Relatorio da Agenda Medica										              
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Ficha     Matr.  Nome                             Dt. Consulta   Hr. Consulta   Exame                       Motivo
     Observacao
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

XXXXXXXXX XXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   XXXXXXXX       XXXXX          XXXXXXXXXXXXXXXXXXXXXXXXX   1234567890123456789012345
     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


Total de Funcionarios.: 999
*/ 

DbSelectArea("TMK")
DbSetOrder(1)
DbSeek(xFilial("TMK")+mv_par01)
lFirst := .T.

dbSelectArea("TMJ")
dbSetOrder(01)  //TMJ_FILIAL + TMJ_CODUSU + DTOS(TMJ_DTCONS) + TMJ_HRCONS
dbSeek( xFilial( "TMJ" ) + mv_par01 + DTOS(mv_par02), .T. )

SetRegua(LastRec())

WHILE !eof() .and. xFilial("TMJ") == TMJ->TMJ_FILIAL .and. TMJ->TMJ_CODUSU == mv_par01 .and. TMJ->TMJ_DTCONS <= mv_par03

    INCREGUA() 
    
    IF mv_par04 == 2 .and. empty(TMJ->TMJ_DTATEN)
    	DbSkip()
    	Loop
    ENDIF
    IF mv_par04 == 3 .and. !empty(TMJ->TMJ_DTATEN)
    	DbSkip()
    	Loop
    ENDIF
    
	If lFirst 
		somalinha()
		@ Li,000 PSay STR0014 + SubStr(TMK->TMK_NOMUSU,1,40)  //"Usuário:  "
		somalinha()
		somalinha() 
		somalinha() 
		lFirst := .F.
	Endif	    

	If mv_par05 == 1
		@ Li,000 PSay TMJ->TMJ_NUMFIC
	ElseIf mv_par05 == 2
		@ Li,000 PSay TMJ->TMJ_MAT
	Else
		@ Li,000 PSay TMJ->TMJ_NUMFIC
		@ Li,010 PSay TMJ->TMJ_MAT
	Endif  

	DbSelectArea("TM0")
	DbSetOrder(1)
	DbSeek(xFilial("TM0")+TMJ->TMJ_NUMFIC)
	@ Li,aColunas[1] PSay SubSTR(TM0->TM0_NOMFIC,1,30)
	@ Li,aColunas[2] PSay TMJ->TMJ_DTCONS
	@ Li,aColunas[3] PSay TMJ->TMJ_HRCONS

	DbSelectArea("TM4")
	DbSetOrder(1)
	DbSeek(xFilial("TM4")+TMJ->TMJ_EXAME)
	@ Li,aColunas[4] PSay SubSTR(TM4->TM4_NOMEXA,1,25)
    
    
	DbSelectArea("TMS")
	DbSetOrder(1)
	DbSeek(xFilial("TMS")+TMJ->TMJ_MOTIVO)
	@ Li,aColunas[5] PSay SubSTR(TMS->TMS_NOMOTI,1,25)	

	@ Li,aColunas[6] PSay SubSTR(TMJ->TMJ_OBSCON,1,40)
	If mv_par04 == 1
		@ Li,aColunas[7] PSay If(!empty(TMJ->TMJ_DTATEN),"Sim","Não")
	EndIf		
	
	somalinha()
	
	dbSelectArea("TMJ")
	dbSkip()
End  

Roda(nCntImpr,cRodaTxt,Tamanho)

RetIndex("TMJ")
Set Filter To
Set device to Screen

If aReturn[5] = 1
	Set Printer To
 	dbCommitAll()
  	OurSpool(wnrel)
Endif  

//SET CENTURY ON
MS_FLUSH()

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina 

@author Rafael Diogo Richter
@since 20/08/2003
@return .T.
/*/
//---------------------------------------------------------------------  
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf
Return