/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR620.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR620
Relatorio de Acidentes por tipo de acidentes 
 
@author Liber de Esteban
@since 20/06/2005
@return nill
/*/
//---------------------------------------------------------------------
User Function MDTR620()   
//---------------------------------------------------------------------  
//- Define Variaveis                                                  -
//---------------------------------------------------------------------
LOCAL wnrel   := "MDTR620"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatorio de acidentes por tipo de acidentes."
LOCAL cDesc2  := STR0002 //"Atrav‚s dos parametros o usu rio poder  selecionar o periodo,"
LOCAL cDesc3  := STR0003 //"C.Custo entre outras op‡äes dispon¡eis para um melhor aproveitamento."
LOCAL cString := "TNC"
Local nTamCTT := TAMSX3("CTT_CUSTO")[1]
LOCAL aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

PRIVATE nomeprog := "MDTR620"
PRIVATE tamanho  := "G"
PRIVATE aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Acidentes por Tipo"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cPerg    := "MDT620"
PRIVATE cabec1, cabec2
PRIVATE nSizeSI3 := 9
Private lSigaMdtPS := SuperGetMv("MV_MDTPS",.F.,"N") == "S"
 
//---------------------------------------------------------------------
//- Verifica as perguntas selecionadas                                - 
//---------------------------------------------------------------------
pergunte(cPerg,.F.)
//---------------------------------------------------------------------
//| Variaveis utilizadas para parametros                              |        
//| mv_par01             // De  Tipo Acidente                    		| 
//| mv_par02             // Ate Tipo Acidente                    		|
//| mv_par03             // De  Acidente                         		| 
//| mv_par04             // Ate Acidente                         		|
//| mv_par05             // De  Dt. Acidente                     		|
//| mv_par06             // Ate Dt. Acidente                     		|
//| mv_par07             // De  Centro de Custo                  		|
//| mv_par08             // Ate Centro de Custo                  		|
//---------------------------------------------------------------------
//---------------------------------------------------------------------
//- Envia controle para a funcao SETPRINT                             -
//---------------------------------------------------------------------
wnrel:="MDTR620"

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

NGRETURNPRM(aNGBEGINPRM)

#IFDEF WINDOWS
    RptStatus({|lEnd| R620Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
#ELSE
    R620Imp(.F.,wnRel,titulo,tamanho)
#ENDIF
Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} R620Imp
Chamada do Relat¢rio  

@param lEnd - Cancela a operação.
@param wnRel - Programa utilizado.  
@param titulo - Titulo do relatório. 
@param tamanho - Tamanho utilizado para o relatório.
 
@author Liber de Esteban
@since 20/06/2005
@return nill
/*/
//---------------------------------------------------------------------
Static Function R620Imp(lEnd,wnRel,titulo,tamanho)

//---------------------------------------------------------------------
//- Define Variaveis                                                  -
//---------------------------------------------------------------------
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0
LOCAL LinhaCorrente
Local cCliente := ""
Local oTempTable
//---------------------------------------------------------------------
//³ Variaveis para controle do cursor de progressao do relatorio ³
//---------------------------------------------------------------------
LOCAL nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

//---------------------------------------------------------------------
//- Variaveis locais exclusivas deste programa                        -
//---------------------------------------------------------------------

LOCAL cChave           := SPACE(16)
LOCAL lContinua        := .T.
//---------------------------------------------------------------------
//- Variaveis tipo Private padrao de todos os relatorios              -
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//- Contadores de linha e pagina                                      -
//---------------------------------------------------------------------
PRIVATE li := 80 ,m_pag := 1

//---------------------------------------------------------------------
//- Verifica se deve comprimir ou nao                                 -
//---------------------------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)
      
//---------------------------------------------------------------------  
//- Monta os Cabecalhos                                               -
//---------------------------------------------------------------------
cabec1 := STR0007+If(lSigaMdtPs,Space(10)+STR0015+Space(4)+STR0016,"") //"    Acid.   Dt.Acid.   Mat.    Nome Funcionario                Dt.Alta     Centro Custo   Funcao         Obj.  Dt.CAT      Afasta."
cabec2 := STR0008 //"        Descricao detalhada do acidente"
   
/*
          1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
=======================================================================================================================================
    Acid.   Dt.Acid.   Mat.    Nome Funcionario                Dt.Alta     Centro Custo   Funcao         Obj.  Dt.CAT      Afasta.
        Descricao detalhada do acidente
=======================================================================================================================================
Tipo de Acidente: XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

    xxxxxx  xx/xx/xxxx xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx/xx/xxxx  xxxxxxxxxxxxx  xxxxxxxxxxxxxx xxx   xx/xx/xxxx  xxx Dias  
	    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

    xxxxxx  xx/xx/xxxx xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx/xx/xxxx  xxxxxxxxxxxxx  xxxxxx  xxx  xx/xx/xxxx  xxx Dias  
	    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        
                                                                                    Total de dias afastados............:  xxxxxxxxxx


Tipo de Acidente: XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

    xxxxxx  xx/xx/xxxx xxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx/xx/xxxx  xxxxxxxxxxxxx  xxxxxx  xxx  xx/xx/xxxx  xxx Dias  
	    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    	
                                                                                    Total de dias afastados............:  xxxxxxxxxx

                                                                                    Total geral de dias afastados......:  xxxxxxxxxx
*/

aDBF := {}
AADD(aDBF,{"TPACID"  ,"C",03,0})  
AADD(aDBF,{"ACIDENTE","C",06,0})  
AADD(aDBF,{"DATACID" ,"D",08,0})  
AADD(aDBF,{"FICHA"   ,"C",09,0}) 
If lSigaMdtPs
	AADD(aDBF,{"CLIENT" ,"C",TAMSX3("A1_COD")[1] ,0})  
	AADD(aDBF,{"LOJA"   ,"C",TAMSX3("A1_LOJA")[1],0}) 
EndIf
oTempTable := FWTemporaryTable():New( "TRB620", aDBF )
If lSigaMdtPs
	oTempTable:AddIndex( "1", {"TPACID","CLIENT","LOJA","ACIDENTE","DATACID"} )
Else
	oTempTable:AddIndex( "1", {"TPACID","ACIDENTE","DATACID"} )
EndIf
oTempTable:Create()

aDBF := {}

//---------------------------------------------------------------------
//- Correr TNC para ler os acidentes                                  -
//---------------------------------------------------------------------
      
dbSelectArea("TNC")
dbSetOrder(03)
dbSeek(xFilial("TNC") + MV_PAR01,.T.)
   
SetRegua(LastRec())

While lContinua .And.!Eof()                     .AND.;
      TNC->TNC_FILIAL == xFilial('TNC')         .AND.;
      TNC->TNC_TIPACI <= MV_PAR02

	#IFNDEF WINDOWS
		If LastKey() = 286    //ALT_A
			lEnd := .t.
		End
	#ENDIF
	If lEnd
		@ PROW()+1,001 PSay STR0009 //"CANCELADO PELO OPERADOR"
		Exit
	EndIf

	IncRegua()                                                   
	
    if TNC->TNC_ACIDEN < MV_PAR03 .OR. TNC->TNC_ACIDEN > MV_PAR04   
		dbSelectARea("TNC")
		dbSKIP()
		loop
    endif

    if TNC->TNC_DTACID < MV_PAR05 .OR. TNC->TNC_DTACID > MV_PAR06
		dbSelectARea("TNC")
		dbSKIP()
		loop
    endif

	if TNC->TNC_CC < MV_PAR07 .OR. TNC->TNC_CC > MV_PAR08
		dbSelectARea("TNC")
		dbSKIP()
		loop
	endif

    dbSelectArea("TRB620")
    TRB620->(DbAppend())
    TRB620->TPACID   := TNC->TNC_TIPACI
    TRB620->ACIDENTE := TNC->TNC_ACIDEN
    TRB620->DATACID  := TNC->TNC_DTACID
    TRB620->FICHA    := TNC->TNC_NUMFIC
    If lSigaMdtPs
    	TRB620->CLIENT  := TNC->TNC_CLIENT
    	TRB620->LOJA    := TNC->TNC_LOJA
    Endif
    dbSelectArea("TNC")
    dbSKIP()
END
            
dbSelectARea("TRB620")
dbGOTOP()  
cTipo := " "
nTotaltp := 0
nTotalgr := 0
lFirst := .t.

While !eof()
    Somalinha()
    If TRB620->TPACID != cTipo .or. lFirst
    	lFirst := .f.
    	cTipo := TRB620->TPACID
	    dbSelectArea("TNG")
	    dbSetOrder(01)
	    dbSeek(xFilial("TNG")+TRB620->TPACID)
	    @Li,000 PSAY STR0010 + TRB620->TPACID + " - " + Alltrim(TNG->TNG_DESTIP) //"Tipo de Acidente: "
	    Somalinha()
	    Somalinha()
	EndIf
    @Li,004 PSAY TRB620->ACIDENTE
    @Li,012 PSAY TRB620->DATACID
    dbSelectArea("TM0")
    dbSetOrder(01)
    dbSeek(xFilial("TM0")+TRB620->FICHA)
    @Li,023 PSAY TM0->TM0_MAT
	@Li,033 PSAY Substr(TM0->TM0_NOMFIC,1,28)
	
    dbSelectArea("TNC")
    dbSetOrder(If(lSigaMdtPs,13,1))
    dbSEEK(xfilial("TNC")+If(lSigaMdtPs,TRB620->CLIENT+TRB620->LOJA,"")+TRB620->ACIDENTE)
    
    If FieldPos("TNC_DTALTA") > 0
    	@Li,063 PSAY TNC->TNC_DTALTA PICTURE "99/99/99"
    Endif
    @Li,075 PSAY TNC->TNC_CC  
    @Li,100 PSAY TNC->TNC_CODFUN    
    
	@Li,115 PSAY TNC->TNC_CODOBJ PICTURE "999"
	@Li,121 PSAY TNC->TNC_DTEMIS PICTURE "99/99/99"

	If TNC->TNC_AFASTA == '2' .and. (Empty(TNC->TNC_QTAFAS) .or. TNC->TNC_QTAFAS == 0)
		@Li,133 PSAY STR0011 //"Nao Houve"
	Else
		@Li,133 PSAY STRZERO(TNC->TNC_QTAFAS,3) + STR0012 //" Dias"
		nTotaltp += TNC->TNC_QTAFAS	
	EndIf
	
	If lSigaMdtPs .AND. cCliente <> TRB620->CLIENT+TRB620->LOJA
		@Li,150 PSAY TRB620->CLIENT 
		@Li,162 PSAY TRB620->LOJA
		cCliente :=  TRB620->CLIENT+TRB620->LOJA
	EndIf	   
	
	If Empty(TNC->TNC_DETALH)
		Somalinha()
		@Li,008 PSAY TNC->TNC_DESACI PICTURE "@!"
	Else
		LihasMemo := MLCOUNT(TNC->TNC_DETALH,200)
		lPRIN := .T.
		For LinhaCorrente := 1 to LihasMemo
			If !empty((MemoLine(TNC->TNC_DETALH,200,LinhaCorrente)))
				Somalinha()
				@Li,008 PSAY (MemoLine(TNC->TNC_DETALH,200,LinhaCorrente))
	        Endif
		Next LinhaCorrente                		
	EndIf
	Somalinha()
    
    dbSelectArea("TRB620")
    dbSKIP()
    If TRB620->TPACID != cTipo
	    Somalinha()
	    @Li,085 PSAY STR0013 //"Total de dias afastados............: "
	    @Li,123 PSAY nTotaltp
	    Somalinha()
	    nTotalgr += nTotaltp
	    nTotaltp := 0
	EndIf
	
Enddo

somalinha()
somalinha()
@Li,085 PSAY STR0014 //"Total geral de dias afastados......: "
@Li,123 PSAY nTotalgr

//---------------------------------------------------------------------
//- Devolve a condicao original do arquivo principal                  -
//---------------------------------------------------------------------
RetIndex("TNC")

Set Filter To

Set device to Screen

If aReturn[5] = 1
        Set Printer To
        dbCommitAll()
        OurSpool(wnrel)
Endif
//SET CENTURY ON
MS_FLUSH()         

dbSelectArea("TRB620")
use
dbSelectArea("TNC")
dbSetOrder(01)

Return NIL    

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina     

@author Inacio Luiz Kolling 
@since 01/06/1997
@return 
/*/
//---------------------------------------------------------------------
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf
Return