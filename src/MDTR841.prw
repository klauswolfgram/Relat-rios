/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr841.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR840
Relatorio dos Planos de Acoes por Acidente.

@author Thiago Machado 
@since 15.08.01
@return Nil
/*/ 
//---------------------------------------------------------------------
User Function MDTR841()
//----------------------------------------------------------------
// Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  
//----------------------------------------------------------------
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//----------------------------------------------------------------
// Define Variaveis                                             
//----------------------------------------------------------------
LOCAL wnrel   := "MDTR841"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatorio do Plano de Acao por Acidente.                           "
LOCAL cDesc2  := STR0002 //"O Relatorio mostra as acoes definidas para eliminar ou minimizar os"
LOCAL cDesc3  := STR0003 //"acidentes existentes na empresa.                                   "
LOCAL cString := "TNT"

PRIVATE lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
PRIVATE nomeprog := "MDTR841"
PRIVATE tamanho  := "M"
PRIVATE aReturn  := {STR0004, 1,STR0005, 2, 2, 1, "",1 }   //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Plano de Acao por Acidente"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cPerg    := ""
PRIVATE cabec1, cabec2

SG90PLACAO()//Adequação do Plano de Ação.

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
cPerg    := If(!lSigaMdtPS,"MDT841    ","MDT841PS  ")

/*-------------------------------------
//PERGUNTAS PADRÃO						|
MDT841    ¦01      ¦De  Acidente ?		|
MDT841    ¦02      ¦Ate Acidente ?		|
MDT841    ¦03      ¦Acoes ?				|
|											|
//PRGUNTAS PRESTADOR DE SERVIÇO			|
		   01       De Cliente ?			|
		   02       Loja					|
		   03       Até Cliente ?		|
		   04       Loja					|
MDT841    ¦05      ¦De  Acidente ?		|
MDT841    ¦06      ¦Ate Acidente ?		|
MDT841    ¦07      ¦Acoes ?				|
---------------------------------------*/

//----------------------------------------------------------------
// Verifica as perguntas selecionadas                           
//----------------------------------------------------------------
pergunte(cPerg,.F.)

//----------------------------------------------------------------
// Envia controle para a funcao SETPRINT                        
//----------------------------------------------------------------
wnrel:="MDTR841"

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	//----------------------------------------------------------------
	// Devolve variaveis armazenadas (NGRIGHTCLICK)                          
	//----------------------------------------------------------------
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	//----------------------------------------------------------------
	// Devolve variaveis armazenadas (NGRIGHTCLICK)                          
	//----------------------------------------------------------------
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif


RptStatus({|lEnd| R841Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

//----------------------------------------------------------------
// Devolve variaveis armazenadas (NGRIGHTCLICK)                          
//----------------------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} R841Imp
Chama Relatório.

@param lEnd - Cancela a impressão.
@param wnRel - Programa utilizado.
@param titulo - Titulo do relatório.
@param tamanho - Tamanho do relatório.

@author Thiago Machado 
@since 15.08.01
@return Nil
/*/ 
//---------------------------------------------------------------------
Static Function R841Imp(lEnd,wnRel,titulo,tamanho)

//----------------------------------------------------------------
// Define Variaveis                                             
//----------------------------------------------------------------
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0       
LOCAL cCliente := "" 
LOCAL lPri := .T.
Local oTempTable

//----------------------------------------------------------------
// Variaveis para controle do cursor de progressao do relatorio 
//----------------------------------------------------------------
LOCAL nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

//----------------------------------------------------------------
// Variaveis locais exclusivas deste programa                   
//----------------------------------------------------------------

LOCAL lContinua        := .T.

//----------------------------------------------------------------
// Contadores de linha e pagina                                 
//----------------------------------------------------------------
PRIVATE li := 80 ,m_pag := 1

//----------------------------------------------------------------
// Verifica se deve comprimir ou nao                            
//----------------------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)

//----------------------------------------------------------------
// Monta os Cabecalhos                                          
//----------------------------------------------------------------

cabec1 := STR0007 //"Acidente    Descricao              Dt.Acid.    Hr.Acid.   Ind. Acid.            Vitima  Dias Afast.    Local"
cabec2 := STR0008 //"    Plano     Nome do Plano de Acao                    Dt.Implant Inic.Prev  Fim Prev   Inic.Real   Fim Real   Responsavel  "

/*
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04         <Plano de Acao por Risco>                                                                DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************
          1         2         3         4         5         6         7         8         9        10        11        12        13
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
Acidente    Descricao              Dt.Acid.    Hr.Acid.   Ind. Acid. Vitima  Dias Afast.    Local
    Plano     Nome do Plano de Acao                    Dt.Implant Inic.Prev  Fim Prev   Inic.Real   Fim Real   Responsavel          
xxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxx 99/99/999 99/99/999 99/99/9999 xxxxxxxx    xxxxx,xxx xxxxxx xxxxxxxxx  xxxx   xxxxxx  xxxxxx
    xxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/9999 99/99/9999 99/99/9999 99/99/9999  99/99/9999 xxxxxxxxxxxx
              O que.: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Onde..: .xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Porque: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Como..: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Quando: Inic.Previsto.: 99/99/9999      Real.:   99/99/9999
                      Fim  Previsto.: 99/99/9999      Real.:   99/99/9999
              Quanto: Valor Previsto: x.xxx.xxx,xx    Real.: x.xxx.xxx,xx
                      Qtde  Atual...:    xx.xxx,xx    Real.: x.xxx.xxx,xx   Meta.: xx.xxx,xx      Unid.Medida.: xxxxxx

    xxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/9999 99/99/9999 99/99/9999 99/99/9999  99/99/9999 xxxxxx - xxxxxxxxxxxxx
              O que.: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Onde..: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Porque: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Como..: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
              Quando: Inic.Previsto.: 99/99/9999      Real.:   99/99/9999
                      Fim  Previsto.: 99/99/9999      Real.:   99/99/9999
              Quanto: Valor Previsto: x.xxx.xxx,xx    Real.: x.xxx.xxx,xx
                      Qtde  Atual...:    xx.xxx,xx    Real.: x.xxx.xxx,xx   Meta.: xx.xxx,xx      Unid.Medida.: xxxxxx

===============================================================================================================================================

*/

If lSigaMdtps

	aDBF := {}
	AADD(aDBF,{ "CLIENT"  , "C" ,nTa1 , 0 }) 
	AADD(aDBF,{ "LOJA"    , "C" ,nTa1L, 0 }) 	
	AADD(aDBF,{ "NOMECLI" , "C" ,40, 0 })
	AADD(aDBF,{ "ACIDEN"  , "C" ,09, 0 })
	AADD(aDBF,{ "DESCRI"  , "C" ,20, 0 })
	AADD(aDBF,{ "DTACID"  , "D" ,08, 0 })
	AADD(aDBF,{ "HRACID"  , "C" ,05, 0 })
	AADD(aDBF,{ "INDACI"  , "C" ,20, 0 }) 
	AADD(aDBF,{ "VITIMA"  , "C" ,03, 0 }) 
	AADD(aDBF,{ "QTAFAS"  , "N" ,03, 0 }) 
	AADD(aDBF,{ "AMBIENTE", "C" ,15, 0 }) 
	AADD(aDBF,{ "PLANO"   , "C" ,08, 0 }) 
	AADD(aDBF,{ "NOMPLA"  , "C" ,40, 0 }) 
	AADD(aDBF,{ "DTIMPLA" , "D" ,08, 0 }) 
	AADD(aDBF,{ "INICPREV", "D" ,08, 0 }) 
	AADD(aDBF,{ "FIM"     , "D" ,08, 0 }) 
	AADD(aDBF,{ "INIREAL" , "D" ,08, 0 }) 
	AADD(aDBF,{ "FIMREAL" , "D" ,08, 0 }) 
	AADD(aDBF,{ "RESP"    , "C" ,12, 0 }) 
	
	oTempTable := FWTemporaryTable():New( "TRB", aDBF )
	oTempTable:AddIndex( "1", {"CLIENT","LOJA","ACIDEN","PLANO"} )
	oTempTable:Create()

	dbSelectArea("TNC")
	dbSetOrder(13)  //TNC_FILIAL+TNC_CLIENT+TNC_LOJA+TNC_ACIDEN
	dbSeek(xFilial("TNC")+MV_PAR01+MV_PAR02,.T.)
	
	SetRegua(LastRec())  
	
	//----------------------------------------------------------------
	// Correr TNT para ler o Plano de Acao por Acidente         
	//----------------------------------------------------------------
	
	While !Eof()                            .AND.;
	      TNC->TNC_FILIAL == xFilial('TNC') .AND.;
	      TNC->(TNC_CLIENT+TNC_LOJA) >= MV_PAR01+MV_PAR02 .AND. TNC->(TNC_CLIENT+TNC_LOJA) <= MV_PAR03+MV_PAR04

	      IncRegua()	      
	      
	      If TNC->TNC_ACIDEN < MV_PAR05 .OR. TNC->TNC_ACIDEN > MV_PAR06
	      		dbSelectArea("TNC")
	      		dbSkip()
	      		Loop
	      Endif
	      	
	      dbSelectArea("TNT")
	      dbSetOrder(1)  //TNT_FILIAL+TNT_CLIENT+TNT_LOJA+TNT_ACIDEN+TNT_MANDAT+TNT_CODPLA
	      IF dbSeek(xfilial("TNT")+TNC->TNC_CLIENT+TNC->TNC_LOJA+TNC->TNC_ACIDEN)
	           
	         DO WHILE !eof()                              .and.;
	                  xfilial("TNT")  == TNT->TNT_FILIAL .AND.;
	                  TNT->TNT_ACIDEN == TNC->TNC_ACIDEN .AND.;
	                  TNT->(TNT_CLIENT+TNT_LOJA) == TNC->TNC_CLIENT+TNC->TNC_LOJA
	         
	                  dbSelectArea( cAliasPA )
	                  dbSetOrder(nIndexPA)  //TNI_FILIAL+TNI_CLIENT+TNI_LOJA+TNI_CODPLA
	                  IF dbSeek(xfilial( cAliasPA )+TNC->TNC_CLIENT+TNC->TNC_LOJA+TNT->TNT_CODPLA)
	                     DO WHILE !eof()                              .and.;
	                              xfilial( cAliasPA )  == (cAliasPA)->&(aFieldPA[1]).AND.;
	                              (cAliasPA)->&(aFieldPA[2]) == TNT->TNT_CODPLA .AND.;
	                              (cAliasPA)->(&(cClientePA)+&(cLojaPA)) == TNC->TNC_CLIENT+TNC->TNC_LOJA
	                
	                              If !Empty((cAliasPA)->&(aFieldPA[8])) .AND. MV_PAR07 = 2
	                                 dbSelectArea( cAliasPA )
	                                 dbSKIP()
	                                 loop
	                              Endif 
	                              If Empty((cAliasPA)->&(aFieldPA[8])) .AND. MV_PAR07 = 3
	                                 dbSelectArea( cAliasPA )
	                                 dbSKIP()
	                                 loop
	                              Endif 
	   			            	  dbSelectArea("TRB")
	                              TRB->(DbAppend())
	                              TRB->CLIENT   := TNC->TNC_CLIENT
	                              TRB->LOJA     := TNC->TNC_LOJA
	                              TRB->NOMECLI  := NGSEEK("SA1",TNC->TNC_CLIENT+TNC->TNC_LOJA,1,"SA1->A1_NOME")
	                              TRB->ACIDEN   := TNC->TNC_ACIDEN 
	                              TRB->DESCRI   := SubStr(TNC->TNC_DESACI,1,20)
	                              TRB->DTACID   := TNC->TNC_DTACID
	                              TRB->HRACID   := TNC->TNC_HRACID   
	                              If TNC->TNC_INDACI = "1"
			                         TRB->INDACI   := STR0010 //"Acidente Tipico"
	                     	      ElseIf TNC->TNC_INDACI = "2"       
	                                     TRB->INDACI   := STR0011 //"Acidente de Trajeto"
	                              ElseIf TNC->TNC_INDACI = "3"       
	                                     TRB->INDACI   := STR0012 //"Doenca do Trabalho"
	                              ElseIf TNC->TNC_INDACI = "4"
	                                     TRB->INDACI   := STR0013 //"Incidente"
	                              EndIf                
	                              If TNC->TNC_VITIMA = "1"
		                             TRB->VITIMA   := STR0014 //"Sim"
	                              Else                               
	                                 TRB->VITIMA   := STR0015 //"Nao"
	                              EndIf   
	                              TRB->QTAFAS   := TNC->TNC_QTAFAS
	                              TRB->AMBIENTE := TNC->TNC_LOCAL 
	                              TRB->PLANO    := (cAliasPA)->&(aFieldPA[2])
	                              TRB->NOMPLA   := (cAliasPA)->&(aFieldPA[3])
	                              TRB->DTIMPLA  := (cAliasPA)->&(aFieldPA[4])
	                              TRB->INICPREV := (cAliasPA)->&(aFieldPA[6])
	                              TRB->FIM      := (cAliasPA)->&(aFieldPA[7])  
	                              TRB->INIREAL  := (cAliasPA)->&(aFieldPA[8])
	                              TRB->FIMREAL  := (cAliasPA)->&(aFieldPA[9])
	                              TRB->RESP     := (cAliasPA)->&(aFieldPA[11])
	    
	                              dbSelectArea( cAliasPA )
	                              dbSKIP()
	                     enddo
	                  endif
	                  dbSelectArea("TNT")
	                  dbSKIP()   
	         enddo    
	      endif
	      dbSelectArea("TNC")
	      dbSKIP()  
	End
	dbSelectArea("TRB")
	dbGOTOP()
	
	SomaLinha()
	SomaLinha()
	
	While !eof()
	/*        1         2         3         4         5         6         7         8         9        10        11        12        13
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	Acidente    Descricao              Dt.Acid.    Hr.Acid.   Ind. Acid.            Vitima  Dias Afast.    Local*/
	    
	      If cCliente <> TRB->CLIENT+TRB->LOJA
				If !lPri
					@Li,000 PSAY Replicate("-",132)
					SomaLinha()
				Endif          
				lPri := .F.				
				cCliente := TRB->CLIENT+TRB->LOJA
				@Li,000 PSAY STR0029 + TRB->CLIENT + "-" + TRB->LOJA + " - " + TRB->NOMECLI PICTURE "@!" //"Cliente/Loja: "            
	      Endif
	      
	      cAciden := TRB->ACIDEN
	      Somalinha()  
	      Somalinha()
	      @Li,000 PSAY TRB->ACIDEN 
	      @Li,012 PSAY SubStr(TRB->DESCRI,1,20) 
	      @Li,035 PSAY TRB->DTACID   PICTURE "99/99/99" 
	      @Li,047 PSAY TRB->HRACID   PICTURE "99:99"
	      @Li,058 PSAY TRB->INDACI   PICTURE "@!"
	      @Li,080 PSAY TRB->VITIMA   PICTURE "@!"
	      @Li,088 PSAY TRB->QTAFAS   PICTURE "@E 99999"
	      @Li,103 PSAY TRB->AMBIENTE PICTURE "@!"  
	    
	      Do while ! eof() .and. TRB->ACIDEN == cAciden .and. TRB->CLIENT+TRB->LOJA == cCliente
	               Somalinha()                            
	               @Li,004 PSAY TRB->PLANO    PICTURE "@!"
	               @Li,014 PSAY TRB->NOMPLA   PICTURE "@!"
	               @Li,055 PSAY TRB->DTIMPLA  PICTURE "99/99/99"
	               @Li,066 PSAY TRB->INICPREV PICTURE "99/99/99"
	               @Li,077 PSAY TRB->FIM      PICTURE "99/99/99"
	               @Li,088 PSAY TRB->INIREAL  PICTURE "99/99/99"
	               @Li,100 PSAY TRB->FIMREAL  PICTURE "99/99/99"
	               @Li,111 PSAY TRB->RESP     PICTURE "@!"
	               dbSelectArea( cAliasPA )
	               dbSetOrder(nIndexPA)  //TNI_FILIAL+TNI_CLIENT+TNI_LOJA+TNI_CODPLA
	               IF dbSEEK(xfilial( cAliasPA )+cCliente+TRB->PLANO)
	                  somalinha()
	                  @Li,014 PSAY STR0016 + (cAliasPA)->&(aFieldPA[10])PICTURE "@!" //"O que.: "
	                  somalinha()
	                  @Li,014 PSAY STR0017 + (cAliasPA)->&(aFieldPA[12])PICTURE "@!"  //"Onde..: "
	                  somalinha()
	                  @Li,014 PSAY STR0018 + (cAliasPA)->&(aFieldPA[13])PICTURE "@!"  //"Porque: "
	                  somalinha()
	                  @Li,014 PSAY STR0019 + (cAliasPA)->&(aFieldPA[14])PICTURE "@!"  //"Como..: "
	                  somalinha()
	                  @Li,014 PSAY STR0020 + dtoc((cAliasPA)->&(aFieldPA[6]))   //"Quando: Inic.Previsto..: "
	                  @Li,054 PSAY STR0021 + dtoc((cAliasPA)->&(aFieldPA[8]))   //"Real.: "
	                  somalinha()
	                  @Li,022 PSAY STR0022 + dtoc((cAliasPA)->&(aFieldPA[7]))   //"Fim Previsto...: "
	                  @Li,054 PSAY STR0021 + dtoc((cAliasPA)->&(aFieldPA[9]))   //"Real.: "
	                  somalinha()
	                  @Li,014 PSAY STR0023 //"Quanto: Valor Previsto.: "
	                  @LI,039 PSAY (cAliasPA)->&(aFieldPA[15])
	                  @Li,054 PSAY STR0021 //"Real.: "
	                  @LI,061 PSAY (cAliasPA)->&(aFieldPA[16])
	                  somalinha()
	                  @Li,022 PSAY STR0024 //"Qtde Atual.....:"
	                  @Li,039 PSAY (cAliasPA)->&(aFieldPA[17])
	                  @Li,054 PSAY STR0021 //"Real.: "
	                  @Li,061 PSAY (cAliasPA)->&(aFieldPA[19])
	                  @Li,076 PSAY STR0025 //"Meta.: "
	                  @Li,084 PSAY (cAliasPA)->&(aFieldPA[18])
	               ENDIF
	               somalinha()
	               somalinha()
	               dbSelectArea("TRB")
	               dbSKIP()
	      enddo   
	Enddo
    
Else

	aDBF := {}                 
	AADD(aDBF,{ "ACIDEN"  , "C" ,09, 0 }) 
	AADD(aDBF,{ "DESCRI"  , "C" ,20, 0 }) 
	AADD(aDBF,{ "DTACID"  , "D" ,08, 0 }) 
	AADD(aDBF,{ "HRACID"  , "C" ,05, 0 }) 
	AADD(aDBF,{ "INDACI"  , "C" ,20, 0 }) 
	AADD(aDBF,{ "VITIMA"  , "C" ,03, 0 }) 
	AADD(aDBF,{ "QTAFAS"  , "N" ,03, 0 }) 
	AADD(aDBF,{ "AMBIENTE", "C" ,15, 0 }) 
	AADD(aDBF,{ "PLANO"   , "C" ,08, 0 }) 
	AADD(aDBF,{ "NOMPLA"  , "C" ,40, 0 }) 
	AADD(aDBF,{ "DTIMPLA" , "D" ,08, 0 }) 
	AADD(aDBF,{ "INICPREV", "D" ,08, 0 }) 
	AADD(aDBF,{ "FIM"     , "D" ,08, 0 }) 
	AADD(aDBF,{ "INIREAL" , "D" ,08, 0 }) 
	AADD(aDBF,{ "FIMREAL" , "D" ,08, 0 }) 
	AADD(aDBF,{ "RESP"    , "C" ,12, 0 })    
	
	oTempTable := FWTemporaryTable():New( "TRB", aDBF )
	oTempTable:AddIndex( "1", {"ACIDEN","PLANO"} )
	oTempTable:Create()

	dbSelectArea("TNC")
	dbSetOrder(01)
	dbSeek(xFilial("TNC")+MV_PAR01,.T.)
	
	SetRegua(LastRec())  
	
	//----------------------------------------------------------------
	// Correr TNT para ler o Plano de Acao por Acidente         
	//----------------------------------------------------------------
	
	While !Eof()                         .AND.;
	      TNC->TNC_FILIAL == xFilial('TNC') .AND.;
	      TNC->TNC_ACIDEN <= MV_PAR02
	      
	      If lEnd
	          @ PROW()+1,001 PSay STR0009 //"CANCELADO PELO OPERADOR"
	          Exit
	      EndIf
	
	      IncRegua()
	      dbSelectArea("TNT")
	      dbSetOrder(1)
	      IF dbSeek(xfilial("TNT")+TNC->TNC_ACIDEN)
	           
	         DO WHILE !eof()                              .and.;
	                  xfilial("TNT")  == TNT->TNT_FILIAL .AND.;
	                  TNT->TNT_ACIDEN == TNC->TNC_ACIDEN
	         
	                  dbSelectArea( cAliasPA )
	                  dbSetOrder( nIndexPA )
	                  IF dbSeek(xfilial( cAliasPA )+TNT->TNT_CODPLA)
	                     DO WHILE !eof()                              .and.;
	                              xfilial( cAliasPA )  == (cAliasPA)->&(aFieldPA[1]).AND.;
	                              (cAliasPA)->&(aFieldPA[2]) == TNT->TNT_CODPLA
	                
	                              If !Empty((cAliasPA)->&(aFieldPA[8])) .AND. MV_PAR03 = 2
	                                 dbSelectArea( cAliasPA )
	                                 dbSKIP()
	                                 loop
	                              Endif 
	                              If Empty((cAliasPA)->&(aFieldPA[8])) .AND. MV_PAR03 = 3
	                                 dbSelectArea( cAliasPA )
	                                 dbSKIP()
	                                 loop
	                              Endif 
	   			            	  dbSelectArea("TRB")
	                              TRB->(DbAppend())
	                              TRB->ACIDEN   := TNC->TNC_ACIDEN 
	                              TRB->DESCRI   := SubStr(TNC->TNC_DESACI,1,20)
	                              TRB->DTACID   := TNC->TNC_DTACID
	                              TRB->HRACID   := TNC->TNC_HRACID   
	                              If TNC->TNC_INDACI = "1"
			                         TRB->INDACI   := STR0010 //"Acidente Tipico"
	                     	      ElseIf TNC->TNC_INDACI = "2"       
	                                     TRB->INDACI   := STR0011 //"Acidente de Trajeto"
	                              ElseIf TNC->TNC_INDACI = "3"       
	                                     TRB->INDACI   := STR0012 //"Doenca do Trabalho"
	                              ElseIf TNC->TNC_INDACI = "4"
	                                     TRB->INDACI   := STR0013 //"Incidente"
	                              EndIf                
	                              If TNC->TNC_VITIMA = "1"
		                             TRB->VITIMA   := STR0014 //"Sim"
	                              Else                               
	                                 TRB->VITIMA   := STR0015 //"Nao"
	                              EndIf   
	                              TRB->QTAFAS   := TNC->TNC_QTAFAS
	                              TRB->AMBIENTE := TNC->TNC_LOCAL 
	                              TRB->PLANO    := (cAliasPA)->&(aFieldPA[2])
	                              TRB->NOMPLA   := (cAliasPA)->&(aFieldPA[3])
	                              TRB->DTIMPLA  := (cAliasPA)->&(aFieldPA[4])
	                              TRB->INICPREV := (cAliasPA)->&(aFieldPA[6])
	                              TRB->FIM      := (cAliasPA)->&(aFieldPA[7])  
	                              TRB->INIREAL  := (cAliasPA)->&(aFieldPA[8])
	                              TRB->FIMREAL  := (cAliasPA)->&(aFieldPA[9])
	                              TRB->RESP     := (cAliasPA)->&(aFieldPA[11])
	    
	                              dbSelectArea( cAliasPA )
	                              dbSKIP()
	                     enddo
	                  endif
	                  dbSelectArea("TNT")
	                  dbSKIP()   
	         enddo    
	      endif
	      dbSelectArea("TNC")
	      dbSKIP()  
	End
	dbSelectArea("TRB")
	dbGOTOP()
	
	While !eof()
	/*        1         2         3         4         5         6         7         8         9        10        11        12        13
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	Acidente    Descricao              Dt.Acid.    Hr.Acid.   Ind. Acid.            Vitima  Dias Afast.    Local*/
	    
	      cAciden := TRB->ACIDEN
	      Somalinha()  
	      Somalinha()
	      @Li,000 PSAY TRB->ACIDEN 
	      @Li,012 PSAY SubStr(TRB->DESCRI,1,20) 
	      @Li,035 PSAY TRB->DTACID   PICTURE "99/99/99" 
	      @Li,047 PSAY TRB->HRACID   PICTURE "99:99"
	      @Li,058 PSAY TRB->INDACI   PICTURE "@!"
	      @Li,080 PSAY TRB->VITIMA   PICTURE "@!"
	      @Li,088 PSAY TRB->QTAFAS   PICTURE "@E 99999"
	      @Li,103 PSAY TRB->AMBIENTE PICTURE "@!"  
	    
	      Do while ! eof() .and. TRB->ACIDEN == cAciden
	               Somalinha()                            
	               @Li,004 PSAY TRB->PLANO    PICTURE "@!"
	               @Li,014 PSAY TRB->NOMPLA   PICTURE "@!"
	               @Li,055 PSAY TRB->DTIMPLA  PICTURE "99/99/99"
	               @Li,066 PSAY TRB->INICPREV PICTURE "99/99/99"
	               @Li,077 PSAY TRB->FIM      PICTURE "99/99/99"
	               @Li,088 PSAY TRB->INIREAL  PICTURE "99/99/99"
	               @Li,100 PSAY TRB->FIMREAL  PICTURE "99/99/99"
	               @Li,111 PSAY TRB->RESP     PICTURE "@!"
	               dbSelectArea( cAliasPA )
	               dbSetOrder( nIndexPA )
	               IF dbSEEK(xfilial( cAliasPA )+TRB->PLANO)
	                  somalinha()
	                  @Li,014 PSAY STR0016 + (cAliasPA)->&(aFieldPA[10]) PICTURE "@!" //"O que.: "
	                  somalinha()
	                  @Li,014 PSAY STR0017 + (cAliasPA)->&(aFieldPA[12]) PICTURE "@!" //"Onde..: "
	                  somalinha()
	                  @Li,014 PSAY STR0018 + (cAliasPA)->&(aFieldPA[13]) PICTURE "@!"  //"Porque: "
	                  somalinha()
	                  @Li,014 PSAY STR0019 + (cAliasPA)->&(aFieldPA[14]) PICTURE "@!"  //"Como..: "
	                  somalinha()
	                  @Li,014 PSAY STR0020 + dtoc((cAliasPA)->&(aFieldPA[6])) //"Quando: Inic.Previsto..: "
	                  @Li,054 PSAY STR0021 + dtoc((cAliasPA)->&(aFieldPA[8])) //"Real.: "
	                  somalinha()
	                  @Li,022 PSAY STR0022 + dtoc((cAliasPA)->&(aFieldPA[7])) //"Fim Previsto...: "
	                  @Li,054 PSAY STR0021 + dtoc((cAliasPA)->&(aFieldPA[9])) //"Real.: "
	                  somalinha()
	                  @Li,014 PSAY STR0023 //"Quanto: Valor Previsto.: "
	                  @LI,039 PSAY (cAliasPA)->&(aFieldPA[15])
	                  @Li,054 PSAY STR0021 //"Real.: "
	                  @LI,061 PSAY (cAliasPA)->&(aFieldPA[16])
	                  somalinha()
	                  @Li,022 PSAY STR0024 //"Qtde Atual.....:"
	                  @Li,039 PSAY (cAliasPA)->&(aFieldPA[17])
	                  @Li,054 PSAY STR0021 //"Real.: "
	                  @Li,061 PSAY (cAliasPA)->&(aFieldPA[19])
	                  @Li,076 PSAY STR0025 //"Meta.: "
	                  @Li,084 PSAY (cAliasPA)->&(aFieldPA[18])
	               ENDIF
	               somalinha()
	               somalinha()
	               dbSelectArea("TRB")
	               dbSKIP()
	      enddo   
	Enddo

Endif


Roda(nCntImpr,cRodaTxt,Tamanho)
//----------------------------------------------------------------
// Devolve a condicao original do arquivo principal             
//----------------------------------------------------------------
RetIndex("TN0")
Set Filter To
Set device to Screen

If aReturn[5] = 1
   Set Printer To
   dbCommitAll()
   If TRB->(RecCount()) == 0
      	msgStop(STR0030)  //"Não há dados para exibir."
		oTempTable:Delete()
       	Return .F.
   Endif   
   OurSpool(wnrel)
Endif             

MS_FLUSH()
oTempTable:Delete()
dbSelectArea("TN0")
dbSetOrder(01)
Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina    

@author Thiago Machado 
@since 15.08.01
@return
/*/ 
//---------------------------------------------------------------------
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
        If Li > 9
	        Li := Li - 1        
        Endif
    EndIf
Return