/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR430.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 2 //Versao do fonte
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR430   
Relatorio das Consultas classificadas por motivo.          
O usuario pode selecionar o motivo da consulta, obtendo    
a relacao das consultas realizadas em um determinado       
periodo pelo motivo selecionado, tambem podera selecionar o 
medico atendente, relacionando as consultas marcadas para o
medico informado, durante o periodo informado.     

@author Heverson Vitoreti   
@since 18/07/2006  
@return Nil   
/*/
//---------------------------------------------------------------------
User Function MDTR430()
//------------------------------------------------------------
//  Armazena variaveis p/ devolucao (NGRIGHTCLICK) 		     -
//------------------------------------------------------------
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

Local oReport
Local aArea := GetArea()

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

Private cPerg := If(!lSigaMdtPS,"MDT430    ","MDT430PS  ")
Private oTempTRB

If !MDTRESTRI(cPrograma)
	//------------------------------------------------------------
	//  Devolve variaveis armazenadas (NGRIGHTCLICK) 			 -
	//------------------------------------------------------------
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/*--------------------------------------
// PERGUNTAS PADRÃO						|
|  01  De  Motivo ?             		|
|  02  Ate Motivo ?             		|
|  03  De  Medico ?             		|
|  04  Ate Medico ?             		|
|  05  De  Data Diagnost. ?     		|
|  06  Ate Data Diagnost. ?     		|
|  07  Considerar ?             		|
| 											|
//PERGUNTAS PRESTADOR DE SERVIÇO		|
|  01  De  Cliente ?         			|
|  02  Loja                  			|
|  03  Até Cliente ?         			|
|  04  Loja                  			|
|  05  De  Motivo ?          			|
|  06  Ate Motivo ?          			|
|  07  De  Medico ?          			|
|  08  Ate Medico ?          			|
|  09  De  Data Diagnost. ?  			|
|  10  Ate Data Diagnost. ?  			|
|  11  Considerar ?          			|
---------------------------------------*/

If TRepInUse()   
   //-- Interface de impressao
   oReport := ReportDef()
   oReport:SetPortrait()
   oReport:PrintDialog()
Else	 
	U_MDTR430R3()
EndIf
RestArea(aArea)  

//------------------------------------------------------------
//  Devolve variaveis armazenadas (NGRIGHTCLICK)             -
//------------------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} ReportDef   
Define as secoes impressas no relatorio    

@author Heverson Vitoreti
@since 18/07/2006
@return oReport
/*/
//---------------------------------------------------------------------
Static Function ReportDef() 
Local oReport 
Local oSection0
Local oSection1
Local oSection2
Local oSection3
Local oCell
Local oCell2
Local oCell3
Local oFunction1

oReport := TReport():New("MDTR430",OemToAnsi(STR0006),cPerg,{|oReport| ReportPrint(oReport)},STR0001+" "+STR0002+" "+STR0003)

Pergunte(oReport:uParam,.F.)

If lSigaMdtps
	//********************* Secao 0 - Cliente
	oSection0 := TRSection():New (oReport, STR0018, {"TRB","SA1"} ) //"Cliente"
	oCell := TRCell():New(oSection0, "TRB->CLIENT", "TRB" , STR0018, "@!", 20  )  //"Cliente"
	oCell := TRCell():New(oSection0, "TRB->LOJA"   , "TRB" , STR0012, "@!", 20  ) //"Loja"
	oCell := TRCell():New(oSection0, "SA1->A1_NOME", "SA1" , STR0019, "@!", 40  )    //"Nome"
	TRPosition():New (oSection0, "SA1", 1, {|| xFilial("SA1") + TRB->CLIENT + TRB->LOJA } )
Endif

oSection1 := TRSection():New(oReport,"Motivo",{"TRB","TMS"})
oCell := TRCell():New(oSection1,"TRB->MOTIVO","TRB",STR0020,"@!",20)  //"Motivo"
oCell := TRCell():New(oSection1,"TMS_NOMOTI" ,"TMS",STR0021,"@!",40) //"Descrição do Motivo"
TRPosition():New(oSection1,"TMS",1,{|| xFilial("TMS") + TRB->MOTIVO})

oSection2 := TRSection():New(oReport,"Consultas",{"TRB","TM0"})
oCell2 := TRCell():New(oSection2,"TRB->MEDICO"	,"TRB",STR0022,"@!"      ,20,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Médico"
oCell2 := TRCell():New(oSection2,"TRB->DTCONS" 	,"TRB",STR0023,"99/99/9999",20,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Data"
oCell2 := TRCell():New(oSection2,"TRB->HORACO" 	,"TRB",STR0024,"99:99"   ,20,/*lPixel*/,/*{|| code-block de impressao }*/)   //"Hora"
oCell2 := TRCell():New(oSection2,"TM0_NOMFIC" 	,"TM0",STR0025,"@!"      ,50,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Paciente"
oCell2 := TRCell():New(oSection2,"TRB->DTATEN" 	,"TRB",STR0026,"99/99/9999",08,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Dt Atend"
TRPosition():New(oSection2,"TM0",1,{|| xFilial("TM0") + TRB->MATRIC})

oSection3 := TRSection():New(oReport,STR0027,{"TRB","TM0"})  //"Totais"
oCell3 := TRCell():New(oSection3,"   "		 ,"   ",STR0028,"@!",41,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Total de Consultas"
oCell3 := TRCell():New(oSection3,"TMS_NOMOTI","TMS",STR0029,"@!",40,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Motivo"
oCell3 := TRCell():New(oSection3,"QUANT"	 ,"   ",STR0030,"@E 999,999" ,7,/*lPixel*/,{|| nMOTIVO })  //"Quantidade"
TRPosition():New(oSection3,"TMS",1,{|| xFilial("TMS") + cMotivo })
oSection3:Cell("QUANT"):SetHeaderAlign("RIGHT")

oFunction1 := TRFunction():New(oSection2:Cell("TM0_NOMFIC"),/*cName*/,"COUNT",/*oBreak*/,/*cTitle*/,"@!",;//Totalizador de uma quebra para a contagem
			  /*uFormula*/,.T.,.F.,/*lEndPage*/,/*oParent*/,/*bCondition*/,/*lDisable*/,{|| .F. })        //de relatorios personalizados com filtros TReport

Return oReport

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR430   
Relatorio das Consultas classificadas por motivo.         
O usuario pode selecionar o motivo da consulta, obtendo     
a relacao das consultas realizadas em um determinado       
periodo pelo motivo selecionado, tambem podera selecionar o
medico atendente, relacionando as consultas marcadas para o 
medico informado, durante o periodo informado.    

@author Marcio Costa 
@since 12/01/2000
@return Nil
/*/
//---------------------------------------------------------------------
User Function MDTR430R3()
//------------------------------------------------------------
//  Define Variaveis                                         -
//------------------------------------------------------------
LOCAL wnrel   := "MDTR430"
LOCAL cDesc1  := STR0001 //"Relatorio das Consultas Marcadas classificadas por motivo. Baseado nas"
LOCAL cDesc2  := STR0002 //"agendas dos medicos atendentes. Atraves dos parametros podera ser     "
LOCAL cDesc3  := STR0003 //"selecionado Motivo, Medico e Periodo desejado.,                       "
LOCAL cString := "TMJ"

PRIVATE nomeprog := "MDTR430"
PRIVATE tamanho  := "M"  
PRIVATE aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006   //"Atendimento X Motivo"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2

/* Perguntas
+-------------------------------+
| 01  De  Motivo ?              |
| 02  Ate Motivo ?              |
| 03  De  Medico ?              |
| 04  Ate Medico ?              |
| 05  De  Data Diagnost. ?      |
| 06  Ate Data Diagnost. ?      |
| 07  Considerar ?              |
+-------------------------------+

If lSigaMdtps
	
	 Perguntas
	+---------------------------+
	| 01  De  Cliente ?         |
	| 02  Loja                  |
	| 03  Até Cliente ?         |
	| 04  Loja                  |
	| 05  De  Motivo ?          |
	| 06  Ate Motivo ?          |
	| 07  De  Medico ?          |
	| 08  Ate Medico ?          |
	| 09  De  Data Diagnost. ?  |
	| 10  Ate Data Diagnost. ?  |
	| 11  Considerar ?          |
	+---------------------------+
Endif*/

pergunte(cPerg,.F.)

//------------------------------------------------------------
//  Envia controle para a funcao SETPRINT                    -
//------------------------------------------------------------
wnrel:="MDTR430"

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

RptStatus({|lEnd| U_R430Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} R430Imp   
Chama Relatório 

@author Inacio Luiz Kolling
@since 14/04/2000

@param lEnd		- Variavel que informa o inicio da impressão
@param wnRel		- Contem o nome do fonte
@param titulo		- Contem o titulo do relatorio 
@param tamanho		- Informa o tamanho do relaório

@return Nil
/*/
//---------------------------------------------------------------------
User Function R430Imp(lEnd,wnRel,titulo,tamanho)

//------------------------------------------------------------
//  Define Variaveis                                         -
//------------------------------------------------------------
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0

//------------------------------------------------------------------
//  Variaveis para controle do cursor de progressao do relatorio   -
//------------------------------------------------------------------
LOCAL nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

//------------------------------------------------------------
//  Contadores de linha e pagina                             -
//------------------------------------------------------------
PRIVATE li := 80 ,m_pag := 1
Private aVetinr := {}

//------------------------------------------------------------
//  Verifica se deve comprimir ou nao                        -
//------------------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)

//------------------------------------------------------------
//  Monta os Cabecalhos                                      -
//------------------------------------------------------------

cabec1 := STR0007 //"Motivo Descricao do Motivo"
cabec2 := STR0008 //"     Medico      Data     Hora  Paciente                                Dt Atend"

/*
********************************************************************************
*<empresa>                                                    Folha..: xxxxx   *
*SIGA /<nome .04         <Relatorio de Questionario Medico>   DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                            Emissao: dd/mm/aa*
********************************************************************************
             1         2         3         4         5         6         7
01234567890123456789012345678901234567890123456789012345678901234567890123456789
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Motivo     Descricao do Motivo
       Medico     Data     Hora Paciente                                Dt Atend
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
     xxxxxxxxxxx 99/99/99 99:99 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/99
                 99/99/99 99:99 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/99
                 99/99/99 99:99 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/99

Total Consultas do Motivo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.: 999.999

xx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
     xxxxxxxxxxx 99/99/99 99:99 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/99
                 99/99/99 99:99 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/99
                 99/99/99 99:99 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/99

Total Consultas do Motivo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.: 999.999
*/

Processa({|lEND| MDTR430TMJ(@lEnd)},STR0039) //"Processando Arquivo..."

If lSigaMdtps

	dbSelectArea("TRB")
	dbGOTOP()
	While ! eof()

		cCliente := TRB->CLIENT+TRB->LOJA
		Somalinha()
		@ Li,000 Psay STR0040 + TRB->CLIENT + "-" + TRB->LOJA + " - " + NGSEEK("SA1",TRB->CLIENT+TRB->LOJA,1,"SA1->A1_NOME")   //"Cliente/Loja: "
		SomaLinha()

		While !eof() .and. cCliente == TRB->CLIENT+TRB->LOJA

			cMOTIVO := TRB->MOTIVO
			nMOTIVO := 0
	
			Somalinha()
			@Li,000 PSAY cMOTIVO PICTURE "@!"
	
			dbSelectArea("TMS")
			dbSetOrder(01)
			dbSeek(xFilial("TMS")+cMOTIVO)
	
			@Li,005 PSAY TMS->TMS_NOMOTI
			Somalinha()
	
			dbSelectArea("TRB")
			While ! eof() .and. TRB->MOTIVO == cMOTIVO .and. cCliente == TRB->CLIENT+TRB->LOJA
	
				cMEDICO := TRB->MEDICO
	
				Somalinha()
				@Li,If(Len(Alltrim(TRB->MEDICO)) <= 11,3,2) PSAY TRB->MEDICO  PICTURE "@!"
				While ! eof() .and. TRB->MOTIVO == cMOTIVO .and. TRB->MEDICO == cMEDICO .and. cCliente == TRB->CLIENT+TRB->LOJA
	
					nMOTIVO := nMOTIVO + 1
		
					@Li,015 PSAY TRB->DTCONS  PICTURE "99/99/9999"
					@Li,030 PSAY TRB->HORACO  PICTURE "99:99"
					dbSelectArea("TM0")
					dbSetOrder(01)
					dbSeek(xFilial("TM0")+TRB->MATRIC)
		
					@Li,050 PSAY Substr(TM0->TM0_NOMFIC,1,40)
					@Li,0101 PSAY TRB->DTATEN PICTURE '99/99/9999'
		
					Somalinha()
		
					dbSelectArea("TRB")
					dbskip()
	
				Enddo
	
			Enddo
			
			If nMOTIVO > 0
				SomaLinha()
				@Li,000 PSAY STR0010 + Alltrim(TMS->TMS_NOMOTI)+"  "+Str(nMOTIVO,6) //"Total Consultas do Motivo "
				SomaLinha()
			Endif						

		End
		@ Li,000 PSAY __PrtThinLine()

	Enddo

Else

	dbSelectArea("TRB")
	dbGOTOP()
	While ! eof()
	
	      cMOTIVO := TRB->MOTIVO
	      nMOTIVO := 0
	      
	      Somalinha()
	      @Li,000 PSAY cMOTIVO PICTURE "@!"
	
	      dbSelectArea("TMS")
	      dbSetOrder(01)
	      dbSeek(xFilial("TMS")+cMOTIVO)
	
	      @Li,015 PSAY TMS->TMS_NOMOTI
	      Somalinha()
	      
	      dbSelectArea("TRB")
	      While ! eof() .and. TRB->MOTIVO == cMOTIVO
	
	            cMEDICO := TRB->MEDICO
	
	            Somalinha()
	            @Li,If(Len(Alltrim(TRB->MEDICO)) <= 11,3,2) PSAY TRB->MEDICO  PICTURE "@!"
	            While ! eof() .and. TRB->MOTIVO == cMOTIVO ;
	                           .and. TRB->MEDICO == cMEDICO
	
	                  nMOTIVO := nMOTIVO + 1
	
	                  @Li,015 PSAY TRB->DTCONS  PICTURE "99/99/9999"
	                  @Li,030 PSAY TRB->HORACO  PICTURE "99:99"
	                  dbSelectArea("TM0")
	                  dbSetOrder(01)
	                  dbSeek(xFilial("TM0")+TRB->MATRIC)
	
	                  @Li,050  PSAY Substr(TM0->TM0_NOMFIC,1,40)
	                  @Li,0101 PSAY TRB->DTATEN PICTURE '99/99/9999'
	
	                  Somalinha()
	
	                  dbSelectArea("TRB")
	                  dbskip()
	
	            Enddo
	
	      Enddo
	
	      If nMOTIVO > 0
	         SomaLinha()
	         @Li,000 PSAY STR0010 + Alltrim(TMS->TMS_NOMOTI)+"  "+Str(nMOTIVO,6) //"Total Consultas do Motivo "
	         SomaLinha()
	      Endif
	
	Enddo

Endif

If TRB->(RecCount()) == 0
	MsgInfo(STR0031)  //"Não há nada para imprimir no relatório."
	oTempTRB:Delete()
	Return .f.
Endif

Roda(nCntImpr,cRodaTxt,Tamanho)

//------------------------------------------------------------
//  Devolve a condicao original do arquivo principal         -
//------------------------------------------------------------
RetIndex("TMT")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()

oTempTRB:Delete()
dbSelectArea("TMJ")
dbSetOrder(01)

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint   
Chama relatório

@author Rafael Diogo Richter
@since 04/08/2006

@param oReport		- Objeto que contem as seções do relatório

@return Nil
/*/
//---------------------------------------------------------------------
Static Function ReportPrint(oReport)

Local oSection0 
Local oSection1 
Local oSection2 
Local oSection3 
Local nx := 1 

Private cMotivo
Private aVetinr := {}

Processa({|lEND| MDTR430TMJ(@lEnd)},STR0039) //"Processando Arquivo..."

If lSigaMdtps

	oSection0 := oReport:Section(1)
	oSection1 := oReport:Section(2)
	oSection2 := oReport:Section(3)
	oSection3 := oReport:Section(4)	
	
	dbSelectArea("TRB")
	dbGOTOP()
	oReport:SetMeter(RecCount())
	While ! eof()
	
		cCliente := TRB->CLIENT+TRB->LOJA
		oSection0:Init()
		oSection0:PrintLine()
		
		While !eof() .and. cCliente == TRB->CLIENT+TRB->LOJA
		
			cMOTIVO := TRB->MOTIVO		
			nMOTIVO := 0
		
			oSection1:Init()
			oSection1:PrintLine()
			oSection2:Init()
		
			dbSelectArea("TRB")
			While ! eof() .and. TRB->MOTIVO == cMOTIVO .and. cCliente == TRB->CLIENT+TRB->LOJA
		
				cMEDICO := TRB->MEDICO
		
				While ! eof() .and. TRB->MOTIVO == cMOTIVO .and. TRB->MEDICO == cMEDICO .and. cCliente == TRB->CLIENT+TRB->LOJA
		
					nMOTIVO := nMOTIVO + 1
		
					oSection2:PrintLine()
					oSection2:Cell("TRB->MEDICO"):Hide()
		
					dbSelectArea("TRB")
					dbskip()
					oReport:IncMeter()
				Enddo
				oSection2:Cell("TRB->MEDICO"):Show()
			Enddo
		
			If nMOTIVO > 0
				nMOTIVO := oReport:aFunction[nx]:uSection //uSection - Total acumulado por secao.
				oSection3:Init()
				oSection3:PrintLine()
				oSection3:Finish()
			Endif
			oSection1:Finish()
			oSection2:Finish()		
		
		End
		oSection0:Finish()
		
	Enddo

Else

	oSection1 := oReport:Section(1)
	oSection2 := oReport:Section(2)
	oSection3 := oReport:Section(3)	
	
	dbSelectArea("TRB")
	dbGOTOP()
	oReport:SetMeter(RecCount())
	While ! eof()
	
		cMOTIVO := TRB->MOTIVO		
		nMOTIVO := 0
	
		oSection1:Init()
		oSection1:PrintLine()
		oSection2:Init()
	
		dbSelectArea("TRB")
		While ! eof() .and. TRB->MOTIVO == cMOTIVO
	
			cMEDICO := TRB->MEDICO
	
			While ! eof() .and. TRB->MOTIVO == cMOTIVO ;
				   .and. TRB->MEDICO == cMEDICO
	
				nMOTIVO := nMOTIVO + 1
	
				oSection2:PrintLine()
				oSection2:Cell("TRB->MEDICO"):Hide()
	
				dbSelectArea("TRB")
				dbskip()
				oReport:IncMeter()
			Enddo
			oSection2:Cell("TRB->MEDICO"):Show()
		Enddo
	
		If nMOTIVO > 0
			nMOTIVO := oReport:aFunction[nx]:uSection //uSection - Total acumulado por secao.
			oSection3:Init()
			oSection3:PrintLine()
			oSection3:Finish()
		Endif
		oSection1:Finish()
		oSection2:Finish()
	Enddo

Endif

If TRB->(RecCount()) == 0
	MsgInfo(STR0031)  //"Não há nada para imprimir no relatório."
	oTempTRB:Delete()
	Return .f.
Endif

oTempTRB:Delete()

Return .T.
//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha   
Incrementa Linha e Controla Salto de Pagina  

@author Inacio Luiz Kolling
@since 14/04/2000

@return Nil
/*/
//---------------------------------------------------------------------
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
//        Li := Li - 1
    EndIf
Return

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR430TMJ   
Processa o arquivo de roteiro

@author Rafael Diogo Richter
@since 03/08/2006

@param lEnd	- Veriavel lógica que informa o inicio ou cancelamento do processo

@return Nil
/*/
//---------------------------------------------------------------------
Static Function MDTR430TMJ(lEnd)

LOCAL lContinua := .T.
Private aVetinr := {}

If lSigaMdtps

	aDBF := {}
	AADD(aDBF,{"MOTIVO","C",02,0}) 
	AADD(aDBF,{"MEDICO","C",12,0}) 
	AADD(aDBF,{"DTCONS","D",08,0}) 
	AADD(aDBF,{"HORACO","C",05,0}) 
	AADD(aDBF,{"MATRIC","C",09,0})
	AADD(aDBF,{"DTATEN","D",08,0})
	AADD(aDBF,{"CLIENT","C",nTa1,0})
	AADD(aDBF,{"LOJA"  ,"C",nTa1L,0})
	
	//Cria TRB
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"CLIENT","LOJA","MOTIVO","MEDICO"} )
	oTempTRB:Create()
	
	dbSelectArea("TMJ")
	dbSetOrder(04)    //TMJ_FILIAL+TMJ_MOTIVO
	dbSeek(xFilial("TMJ")+MV_PAR05,.T.)
	ProcRegua(LastRec())
	
	//------------------------------------------------------------
	//  Correr TMT para ler os  Diagnosticos                     -
	//------------------------------------------------------------
	
	While !Eof()                                   .AND.;
	      TMJ->TMJ_FILIAL == xFIlial('TMJ')        .AND.;
	      TMJ->TMJ_MOTIVO <= MV_PAR06
		
	      IncProc()
	      
	      If Empty(TMJ->TMJ_MOTIVO)
	         dbSelectArea("TMJ")
	         dbSKIP()
	         loop	      	  		      
	      Endif
	      
	      dbSelectArea("TM0")
	      dbSetOrder(1)
	      If dbSeek(xFilial("TM0")+TMJ->TMJ_NUMFIC)
			 If TM0->TM0_CLIENT+TM0->TM0_LOJA < mv_par01+mv_par02 .or. TM0->TM0_CLIENT+TM0->TM0_LOJA > mv_par03+mv_par04
		         dbSelectArea("TMJ")
		         dbSKIP()
		         loop	      	  			 
			 Endif
	      Else
	         dbSelectArea("TMJ")
	         dbSKIP()
	         loop	      	  	      
	      Endif	      
	
	      If TMJ->TMJ_CODUSU < MV_PAR07 .OR. TMJ->TMJ_CODUSU > MV_PAR08
	         dbSelectArea("TMJ")
	         dbSKIP()
	         loop
	      Endif
	
	      If TMJ->TMJ_DTCONS < MV_PAR09 .OR. TMJ->TMJ_DTCONS > MV_PAR10
	         dbSelectArea("TMJ")
	         dbSKIP()
	         loop
	      Endif
	      
	      If MV_PAR11 = 2 
	         If Empty(TMJ->TMJ_DTATEN)
	            dbSelectArea("TMJ")
	            dbSKIP()
	            loop 
	         EndIf   
	      ElseIf MV_PAR11 = 3   
	         If !Empty(TMJ->TMJ_DTATEN)
	            dbSelectArea("TMJ")
	            dbSKIP()
	            loop 
	         EndIf 
	      EndIf
	         
	      dbSelectArea("TRB")
	      TRB->(DbAppend())
	      TRB->MOTIVO := TMJ->TMJ_MOTIVO
	      TRB->MEDICO := TMJ->TMJ_CODUSU
	      TRB->DTCONS := TMJ->TMJ_DTCONS
	      TRB->HORACO := TMJ->TMJ_HRCONS
	      TRB->MATRIC := TMJ->TMJ_NUMFIC
	      TRB->DTATEN := TMJ->TMJ_DTATEN
	      TRB->CLIENT := TM0->TM0_CLIENT
	      TRB->LOJA   := TM0->TM0_LOJA
	
	      dbSelectArea("TMJ")
	      dbSKIP()
	End

Else

	aDBF := {}
	AADD(aDBF,{"MOTIVO","C",02,0}) 
	AADD(aDBF,{"MEDICO","C",12,0}) 
	AADD(aDBF,{"DTCONS","D",08,0}) 
	AADD(aDBF,{"HORACO","C",05,0}) 
	AADD(aDBF,{"MATRIC","C",09,0})
	AADD(aDBF,{"DTATEN","D",08,0})
	
	//Cria TRB
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"MOTIVO","MEDICO"} )
	oTempTRB:Create()	
	
	dbSelectArea("TMJ")
	dbSetOrder(04)
	dbSeek(xFilial("TMJ")+MV_PAR01,.T.)
	ProcRegua(LastRec())
	
	//------------------------------------------------------------
	//  Correr TMT para ler os  Diagnosticos                     -
	//------------------------------------------------------------
	
	While lContinua                                .And.;
	      !Eof()                                   .AND.;
	      TMJ->TMJ_FILIAL == xFIlial('TMJ')        .AND.;
	      TMJ->TMJ_MOTIVO <= MV_PAR02
	                                                                                            
	
	      If lEnd
	          @ PROW()+1,001 PSay STR0009 //"CANCELADO PELO OPERADOR"
	          Exit
	      EndIf
	
	      IncProc()
	
	      If TMJ->TMJ_CODUSU < MV_PAR03 .OR. TMJ->TMJ_CODUSU > MV_PAR04
	         dbSelectArea("TMJ")
	         dbSKIP()
	         loop
	      Endif
	
	      If TMJ->TMJ_DTCONS < MV_PAR05 .OR. TMJ->TMJ_DTCONS > MV_PAR06
	         dbSelectArea("TMJ")
	         dbSKIP()
	         loop
	      Endif
	      
	      If MV_PAR07 = 2 
	         If Empty(TMJ->TMJ_DTATEN)
	            dbSelectArea("TMJ")
	            dbSKIP()
	            loop 
	         EndIf   
	      ElseIf MV_PAR07 = 3   
	         If !Empty(TMJ->TMJ_DTATEN)
	            dbSelectArea("TMJ")
	            dbSKIP()
	            loop 
	         EndIf 
	      EndIf
	         
	      dbSelectArea("TRB")
	      TRB->(DbAppend())
	      TRB->MOTIVO := TMJ->TMJ_MOTIVO
	      TRB->MEDICO := TMJ->TMJ_CODUSU
	      TRB->DTCONS := TMJ->TMJ_DTCONS
	      TRB->HORACO := TMJ->TMJ_HRCONS
	      TRB->MATRIC := TMJ->TMJ_NUMFIC
	      TRB->DTATEN := TMJ->TMJ_DTATEN
	
	      dbSelectArea("TMJ")
	      dbSKIP()
	End

Endif

Return .T.