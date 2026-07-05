/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR820.ch"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR820
Relatório dos EPI's necessários por função. O usuário pode selecionar
o código da função, obtendo como resultado a relação dos EPI's que devem
ser utilizados pelos funcionários que executam a função.  

@author Thiago Machado
@since 15/08/2000

@return Lógico Sempre verdadeiro
/*/
//---------------------------------------------------------------------
User Function MDTR820()

Local aNGBEGINPRM := NGBEGINPRM()
Local oReport
Local aArea := GetArea()
Local cOldFil := cFilAnt

Private cPerg   := ""
Private nSizeFil:= FwSizeFilial()
Private nSizeSRJ:= If((TAMSX3("RJ_FUNCAO")[1]) < 1,5,(TAMSX3("RJ_FUNCAO")[1]))
Private nSizeCod:= If((TAMSX3("B1_COD")[1]) < 1,2,(TAMSX3("B1_COD")[1]))
Private nTa1 	:= If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
Private nTa1L 	:= If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
Private nSizeTD := nTa1+nTa1L

Private cModoSRJ:= NGSX2MODO("SRJ")
Private cModoTNB:= NGSX2MODO("TNB")
Private lModoCom:= (cModoTNB == "C" .and. cModoSRJ == "C")
Private cAliasFil:= "SRJ"

If cModoSRJ == "E"
	cAliasFil := "SRJ"
Elseif cModoTNB == "E"
	cAliasFil := "TNB"
Else
	cAliasFil := "TNB"
Endif

cPerg    :="MDT820"
	
//PERGUNTAS PADRÃO						
// MDT820    ¦01      ¦De  Funcao ?		
// MDT820    ¦02      ¦Ate Funcao ?		
// MDT820    ¦03      ¦De Filial ?		
// MDT820    ¦04      ¦Ate Filial ?		

If TRepInUse()
	oReport := ReportDef()
	oReport:SetPortrait()
	oReport:PrintDialog()
Else
	U_MDTR820R3()
EndIf

RestArea(aArea)

//Devolve variaveis armazenadas (NGRIGHTCLICK)                        
NGRETURNPRM(aNGBEGINPRM)
cFilAnt := cOldFil
dbSelectArea("SM0")
dbSetOrder(1)
dbSeek(cEmpAnt+cFilAnt)

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define as seções impressas no relatório.  

@author Andre E. Perez Alvarez
@since 31/07/2006

@return oReport
/*/
//---------------------------------------------------------------------

Static Function ReportDef()

Static oReport
Static oSection0
Static oSection1
Static oSection2

Static oCell

//LAYOUT
/*        1         2         3         4         5         6         7         8         9       100       110       120       130
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
____________________________________________________________________________________________________________________________________

Epi's por Funcao
____________________________________________________________________________________________________________________________________

Função    Descrição
__________________________________________
xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

EPI      Descrição
______________________________________________________________________

123456   1234567890123456789012345678901234567890
123456   1234567890123456789012345678901234567890
123456   1234567890123456789012345678901234567890
123456   1234567890123456789012345678901234567890

*/

/*
Criação do componente de impressão                                      
                                                                        
TReport():New                                                           
ExpC1 : Nome do relatório                                               
ExpC2 : Título                                                          
ExpC3 : Pergunte                                                        
ExpB4 : Bloco de código que será executado na confirmação da impressão 
ExpC5 : Descrição
*/                                                     

oReport := TReport():New("MDTR820",OemToAnsi(STR0006),cPerg,{|oReport| ReportPrint()},;  //"Epi x Funcao"
STR0001+" "+STR0002+" "+STR0003)

Pergunte(oReport:uParam,.F.)

/*
Criação da seção utilizada pelo relatório                               
                                                                        
TRSection():New                                                         
ExpO1 : Objeto TReport que a seção pertence                             
ExpC2 : Descrição da seção                                              
ExpA3 : Array com as tabelas utilizadas pela seção. A primeira tabela   
        será considerada como principal para a seção.                   
ExpA4 : Array com as Ordens do relatório                                
ExpL5 : Carrega campos do SX3 como células                              
        Default : False                                                 
ExpL6 : Carrega ordens do Sindex                                        
        Default : False                                                 
                                                                        

Criação da células da seção do relatório                                
                                                                        
TRCell():New                                                            
ExpO1 : Objeto TSection que a seção pertence                            
ExpC2 : Nome da célula do relatório. O SX3 será consultado              
ExpC3 : Nome da tabela de referência da célula                          
ExpC4 : Titulo da célula                                                
        Default : X3Titulo()                                            
ExpC5 : Picture                                                         
        Default : X3_PICTURE                                            
ExpC6 : Tamanho                                                         
        Default : X3_TAMANHO                                            
ExpL7 : Informe se o tamanho está em pixel                              
        Default : False                                                 
ExpB8 : Bloco de código para impressão.                                 
        Default : ExpC2                                                 
*/

//Seção 0 - Filial
oSection0 := TRSection():New (oReport,STR0029, {"TNB"} )//"Filial"
oCell := TRCell():New(oSection0, "TNB_FILIAL"    , "TNB"  , "Filial", "@!", nSizeFil )
oCell := TRCell():New(oSection0, "NOMFIL"	, "TNB", STR0020, "@!", 40, /*lPixel*/, {|| cNomFil } ) //"Nome"

//Seção 1 - Função
oSection1 := TRSection():New (oReport,STR0009, {"TNB","SRJ"} ) //Função
oCell := TRCell():New(oSection1, "TNB_CODFUN"    , "TNB"  , STR0009, "@!", nSizeSRJ+5  )  //"Função"
oCell := TRCell():New(oSection1, "RJ_DESC"       , "SRJ"  , STR0010, "@!", 40        )  //"Descrição"

//Seção 2 - EPI
oSection2 := TRSection():New (oReport,STR0011, {"SB1"} )  //"EPI"
oCell := TRCell():New (oSection2, "CODIGO" , , STR0011, "@!", nSizeCod+5, , {||  cCodEpi}) //"EPI"
oCell := TRCell():New (oSection2, "B1_DESC", "SB1", STR0010, "@!", 40, , ) //"Nome do Exame"
If TNB->(FieldPos("TNB_OBRIGA")) > 0
	oCell := TRCell():New (oSection2, "TNB_OBRIGA", "TNB", STR0012, "@!", 03, /*lPixel*/, {|| If (TNB->TNB_OBRIGA=="S",STR0013,STR0014) } ) //"Obrigatório" ###"Sim"###"Nao"
Endif

Return oReport

//---------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o relatorio.

@author Andre E. Perez Alvarez
@since 31/07/2006

@return Lógico Sempre verdadeiro
/*/
//---------------------------------------------------------------------
Static Function ReportPrint()

Local cFuncao  := ""
Local cCliente := ""
Local aFiliais:= {}
Local aEpiFil := {}
Local i
Local j
Local nTemEpi
Local lPrintx   := .F.

Private cNomFil := ""
Private cCodEpi := ""

aFiliais := MDTRETFIL(cAliasFil, MV_PAR03, MV_PAR04)

oReport:SetMeter(Len(aFiliais))
For i:=1 to Len(aFiliais)
	oReport:IncMeter()
	//Correr TNB para ler os  EPI's por Função.                
	lFirst := .T.
	dbSelectArea("TNB")
	dbSetOrder(01)
	dbSeek(xFilial("TNB",aFiliais[i,1])+MV_PAR01,.T.)
	While !oReport:Cancel() .AND. !Eof() .AND. TNB->TNB_FILIAL == xFilial("TNB",aFiliais[i,1]) .AND. TNB->TNB_CODFUN <= MV_PAR02
		If lFirst .and. !lModoCom
			lFirst := .F.
			cNomFil := aFiliais[i,2]
			oSection0:Init()
			oSection0:PrintLine()
		Endif
		cFuncao := TNB->TNB_CODFUN
		//Posiciona na Função
		dbSelectArea("SRJ")
		dbSetOrder(1)
		dbSeek(xFilial("SRJ",aFiliais[i,1])+TNB->TNB_CODFUN)
		oSection1:Init()
		oSection1:PrintLine()
		oSection2:Init()
		While !oReport:Cancel() .AND. !Eof() .AND. TNB->TNB_FILIAL+TNB->TNB_CODFUN == xFilial("TNB",aFiliais[i,1])+cFuncao
				dbSelectArea("TN3")
				dbSetOrder(2)
				dbSeek(xFilial("TN3")+TNB->TNB_CODEPI)
				While TN3->(!Eof()) .and. TN3->TN3_CODEPI == TNB->TNB_CODEPI
					If TN3->TN3_GENERI == '2'
						dbSelectArea("TL0")
						dbSetOrder(1)
						dbSeek(xFilial("TL0")+TNB->TNB_CODEPI)
						While TL0->(!Eof()) .and. TL0->TL0_EPIGEN == TNB->TNB_CODEPI
							nTemEpi := aScan(aEpiFil,{|x| x == TL0->TL0_EPIFIL})
							If nTemEpi == 0
								aAdd(aEpiFil,TL0->TL0_EPIFIL)
							EndIf
							dbSelectArea("TL0")
							dbSkip()
						End
					Else
						nTemEpi := aScan(aEpiFil,{|x| x == TNB->TNB_CODEPI})
						If nTemEpi == 0
							aAdd(aEpiFil,TNB->TNB_CODEPI)
						EndIf
					EndIf
					dbSelectArea("TN3")
					TN3->(dbSkip())
				End
				For j := 1 to Len(aEpiFil)
					//Posiciona no EPI
					dbSelectArea("SB1")
					dbSetOrder(1)
					dbSeek(xFilial("SB1",aFiliais[i,1])+aEpiFil[j])
					cCodEpi := aEpiFil[j]
					oSection2:PrintLine()
					lPrintx := .T.
				Next j
				aEpiFil := {}

			dbSelectArea("TNB")
			dbSkip()
		End
		oSection2:Finish()
		oSection1:Finish()
		If !lModoCom .and. (Eof() .or. TNB->TNB_FILIAL != xFilial("TNB",aFiliais[i,1]))
			oSection0:Finish()
		Endif
	End
Next i


If !lPrintx
	MsgInfo(STR0024)	//"Não há nada para imprimir no relatório."
	Return .F.
Endif

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR820R3
Relatório dos EPI's necessários por função.

@author Thiago Machado
@since 15/08/2000

@return Nil
/*/
//---------------------------------------------------------------------
User Function MDTR820R3()

Local wnrel   := "MDTR820"
Local cDesc1  := STR0001 //"Relatório de apresentação dos EPI's   por função. Baseado nos     "
Local cDesc2  := STR0002 //"parâmetros o usuário poderá selecionar uma determinada função,    "
Local cDesc3  := STR0003 //"ou obter uma listagem detalhada de todos os EPI's por Função.     "
Local cString := "TNB"

Private nomeprog := "MDTR820"
Private tamanho  := "M"
Private aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private titulo   := STR0006 //"EPI x Funcao"
Private ntipo    := 0
Private nLastKey := 0
Private cabec1, cabec2
Private nMasc    := 0
Private nFemin   := 0
Private cCodfun  := space(nSizeSRJ)
Private cCid     := space(8)

pergunte(cPerg,.F.)


//Envia controle para a funcao SETPRINT                        
wnrel:="MDTR820"

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

#IFDEF WINDOWS
	RptStatus({|lEnd| R820Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
#ELSE
	R820Imp(.F.,wnRel,titulo,tamanho)
#ENDIF

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} R820Imp
Chamada do Relatório.

@author Thiago Machado
@since 15/08/2000

@return Nil
/*/
//---------------------------------------------------------------------
Static Function R820Imp(lEnd,wnRel,titulo,tamanho)

Local cRodaTxt := ""
Local nCntImpr := 0
Local lObrigat := .F.
Local cCliente := ""
Local cFunc    := ""
Local lPri     := .T.
Local aEpiFil  := {}
Local cCodFil  := ""
Local aFiliais := {}
Local i
                               
Private li    := 80 
Private m_pag := 1
Private aDBF  := {}
Private cTRB  := GetNextAlias(), oTempTRB
Private aVetInr := {}

nSizeCod := If((TAMSX3("B1_COD")[1]) < 1,2,(TAMSX3("B1_COD")[1]))

//Verifica se deve comprimir ou não                         
nTipo  := IIF(aReturn[4]==1,15,18)

If TNB->(FieldPos("TNB_OBRIGA")) > 0
	lObrigat := .T.
EndIf

//Monta os Cabecalhos                                         
cabec1 := STR0007 //"Função  Descrição                             "
If lObrigat
	cabec2 := STR0021  //"        EPI              Descrição                                 Obrigatório"
Else
	cabec2 := STR0022  //"        EPI              Descrição"
EndIf

/*
1         2         3         4         5         6         7         8
012345678901234567890123456789012345678901234567890123456789012345678901234567890
---------------------------------------------------------------------------------
Função  Descrição
EPI              Descrição                                 Obrigatório
---------------------------------------------------------------------------------
Filial: xx

xxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  Sim
*/

aDBF := {}
AADD(aDBF,{"FUNCAO","C",nSizeSRJ,0})
AADD(aDBF,{"EPI"   ,"C",nSizeCod,0})

If lObrigat
	AADD(aDBF,{"OBRIGA","C",3 ,0})
EndIf

AADD(aDBF,{"FILIAL"   ,"C",nSizeFil	,0})
AADD(aDBF,{"NOMFIL"   ,"C",40		,0})
AADD(aDBF,{"RJ_DESC"  ,"C",25		,0})
AADD(aDBF,{"B1_DESC"  ,"C",40		,0})

oTempTRB := FWTemporaryTable():New( cTRB, aDBF )
oTempTRB:AddIndex( "1", {"FILIAL","FUNCAO","EPI"} )
oTempTRB:Create()


aFiliais := MDTRETFIL(cAliasFil, MV_PAR03, MV_PAR04)

For i:=1 to Len(aFiliais)
	//Correr TNB para ler os  EPI's por Funcao.             	
	dbSelectArea("TNB")
	dbSetOrder(01)
	dbSeek(xFilial("TNB",aFiliais[i,1])+MV_PAR01,.T.)
	While !Eof() .And. TNB->TNB_FILIAL == xFilial("TNB",aFiliais[i,1]) .AND. TNB->TNB_CODFUN <= MV_PAR02
		//Posiciona na Funcao
		dbSelectArea("SRJ")
		dbSetOrder(1)
		dbSeek(xFilial("SRJ",aFiliais[i,1])+TNB->TNB_CODFUN)
		//Posiciona no EPI
		dbSelectArea("SB1")
		dbSetOrder(1)
		dbSeek(xFilial("SB1",aFiliais[i,1])+TNB->TNB_CODEPI)
			//Verifica NUMCAP para EPIs filhos
			dbSelectArea("TN3")
			dbSetOrder(2)
			dbSeek(xFilial("TN3",aFiliais[i,1])+TNB->TNB_CODEPI)
			While TN3->(!Eof()) .and. TN3->TN3_CODEPI == TNB->TNB_CODEPI
				If TN3->TN3_GENERI == '2'//Se não for genérico
					dbSelectArea("TL0")
					dbSetOrder(1)
					dbSeek(xFilial("TL0",aFiliais[i,1])+TN3->TN3_CODEPI)
					While TL0->(!Eof()) .and. TL0->TL0_EPIGEN == TN3->TN3_CODEPI
						nTemEpi := aScan(aEpiFil,{|x| x == TL0->TL0_EPIFIL})
						If nTemEpi == 0
							aAdd(aEpiFil,TL0->TL0_EPIFIL)
							dbSelectArea("SB1")
							dbSetOrder(1)
							dbSeek(xFilial("SB1",aFiliais[i,1])+TL0->TL0_EPIFIL)
							dbSelectArea(cTRB)
							RecLock(cTRB,.T.)
							(cTRB)->FILIAL := TNB->TNB_FILIAL
							(cTRB)->NOMFIL := aFiliais[i][2]
							(cTRB)->FUNCAO := TNB->TNB_CODFUN
							(cTRB)->EPI    := TL0->TL0_EPIFIL
							(cTRB)->RJ_DESC:= SRJ->RJ_DESC
							(cTRB)->B1_DESC:= SB1->B1_DESC
							If lObrigat
								(cTRB)->OBRIGA := If (TNB->TNB_OBRIGA=="S",STR0013,STR0014) //"Sim"###"Não"
							EndIf
							MsUnlock(cTRB)
						EndIf
						dbSelectArea("TL0")
						TL0->(dbSkip())
					End
				Else
					nTemEpi := aScan(aEpiFil,{|x| x == TNB->TNB_CODEPI})
					If nTemEpi == 0
						aAdd(aEpiFil,TNB->TNB_CODEPI)
						dbSelectArea(cTRB)
						RecLock(cTRB,.T.)
						(cTRB)->FILIAL := TNB->TNB_FILIAL
						(cTRB)->NOMFIL := aFiliais[i][2]
						(cTRB)->FUNCAO := TNB->TNB_CODFUN
						(cTRB)->EPI    := TNB->TNB_CODEPI
						(cTRB)->RJ_DESC:= SRJ->RJ_DESC
						(cTRB)->B1_DESC:= SB1->B1_DESC
						If lObrigat
							(cTRB)->OBRIGA := If (TNB->TNB_OBRIGA=="S",STR0013,STR0014) //"Sim"###"Não"
						EndIf
						MsUnlock(cTRB)
					EndIf
				EndIf
				dbSelectArea("TN3")
				TN3->(dbSkip())
			End

		dbSelectArea("TNB")
		dbSkip()
	End
Next i

cCodFil := ""
dbSelectArea(cTRB)
dbGoTop()
SetRegua((cTRB)->(RecCount()))
While !eof()
	IncProc()
	If lModoCom
		cCodFil := (cTRB)->FILIAL
		Somalinha()
	Else
		If cCodFil != (cTRB)->FILIAL
			If !Empty(cCodFil)
				Somalinha()
			Endif
			cCodFil := (cTRB)->FILIAL
			Somalinha()
			@Li,000 pSay STR0029+": "+AllTrim((cTRB)->FILIAL)+" - "+(cTRB)->NOMFIL//"Filial"
		Endif
	Endif
	cFunc := (cTRB)->FUNCAO
	Somalinha()
	Somalinha()
	@Li,000 PSAY Alltrim((cTRB)->FUNCAO)
	@Li,008 PSAY Alltrim((cTRB)->RJ_DESC)
	
	While ! eof() .and. (cTRB)->(FILIAL+FUNCAO) == cCodFil+cFUNC
		Somalinha()
		@Li,008 PSAY (cTRB)->EPI PICTURE "@!"
		@Li,046 PSAY (cTRB)->B1_DESC PICTURE "@!"
		If lObrigat
			@Li,085 PSAY (cTRB)->OBRIGA PICTURE "@!"
		EndIf
		dbSelectArea(cTRB)
		dbSkip()
		If !lModoCom .and. (Eof() .or. ((cTRB)->(FILIAL) != cCodFil .and. !Empty((cTRB)->FILIAL)))
			Somalinha()
			@Li,000 pSay __PrtThinLine()
		Endif
	End
End
If (cTRB)->(RecCount()) == 0
	MsgInfo(STR0024)//"Não há nada para imprimir no relatório."
	oTempTRB:Delete()
	dbSelectArea("TNB")
	dbSetOrder(01)
	Return .F.
EndIf


Roda(nCntImpr,cRodaTxt,Tamanho)

//Devolve a condição original do arquivo principal             
RetIndex("TNB")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
End
MS_FLUSH()

oTempTRB:Delete()

dbSelectArea("TNB")
dbSetOrder(01)

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa linha e controla o salto de página.

@author Thiago Machado
@since 15/08/2000

@return Nil
/*/
//---------------------------------------------------------------------
Static Function Somalinha()
Li++
If Li > 58
	Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
EndIf
Return
