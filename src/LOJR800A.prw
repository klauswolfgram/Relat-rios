/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "LOJR800A.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

Static oTempTable := Nil	//Objeto tabela temporaria
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LOJR800a  º Autor ³ Julio Cesar        ºData  ³  27-06-02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de movimentacoes por Lay-Away.                   º±±
±±º          ³ (Localizacoes)                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function LOJR800A()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracion de Variables                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1   		:= OemToAnsi(STR0001) // "Este programa tem como objetivo imprimir relatorio "
Local cDesc2   		:= OemToAnsi(STR0002) // "de acordo com os parametros informados pelo usuario."
Local cDesc3   		:= OemToAnsi(STR0003) // "Relatorio de Movimentacoes por Lay-Away"
Local Cabec1   		:= ""
Local Cabec2   		:= ""
Local titulo   		:= OemToAnsi(STR0003) // "Relatorio de Movimentacoes por Lay-Away"
Local nLin     		:= 80
Local lR5	   		:= GetRpoRelease("R5") // Indica se o release e 11.5 

Private aOrd        := {OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0008)}  // "Cliente","Data de Emissao","Data de Entrega","Data de Movimentacao"
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 132
Private tamanho     := "M"
Private nomeprog    := "LOJR800A"
Private nTipo       := 15
Private aReturn     := { OemToAnsi(STR0009), 1, OemToAnsi(STR0010), 1, 2, 1, "", 1}   // "A Rayas","Administracao"
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "LOJR800A"
Private cString     := "SLO"
Private cPerg       := "LJ800A"
  
If cPaisLoc == "MEX" .AND. lR5 .AND. FindFunction("Lojr800N")
  U_Lojr800N()
Else

	If !Pergunte("LJ800A",.T.)
		Return 
	EndIf
	           
	If Empty(MV_PAR07) .OR. Empty(MV_PAR08)
		MsgStop(OemToAnsi(STR0021)+OemToAnsi(STR0022))   // "Preencha os parametros ","De Emissao e Ate Emissao "
		Return
	Endif	     
	                        
	If Empty(MV_PAR09) .OR. Empty(MV_PAR10)
		MsgStop(OemToAnsi(STR0021)+OemToAnsi(STR0023))   // "Preencha os parametros ","De Entrega e Ate Entrega "
		Return
	Endif	  
	
	If Empty(MV_PAR11) .OR. Empty(MV_PAR12)
		MsgStop(OemToAnsi(STR0021)+OemToAnsi(STR0024))   // "Preencha os parametros ","De Movimentacao e Ate Movimentacao "
		Return
	Endif	  
	   
	//Define o cabecalho conforme a selecao do tipo de relatorio: Analitico/Sintetico
	If MV_PAR18 == 2 
		//         10        20        30        40        50        60        70        80        90        100       110       120       130
		//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
		//LAY-AWAY  CLIENTE                                   EMISSAO    ENTREGA    ULT. MOV    STATUS    VALOR              SALDO
		//XXXXXX    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999 99/99/9999 99/99/9999  XXXXXXX   99999999999999.99  99999999999999.99
	
		Cabec1 := OemToAnsi(STR0011)  // "LAY-AWAY  CLIENTE                                   EMISSAO    ENTREGA    ULT. MOV    STATUS             VALOR              SALDO"
	Else
		//         10        20        30        40        50        60        70        80        90        100       110       120       130
		//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
		//LAY-AWAY  CLIENTE                                   EMISSAO    ENTREGA    ULT. MOV    STATUS    VALOR              SALDO
		//XXXXXX    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999 99/99/9999 99/99/9999  XXXXXXX   99999999999999.99  99999999999999.99
		//SERIE  DOCUMENTO    PARCELA  MOVIMENTO                                 VALOR
		//XXX    XXXXXXXXXXX  XX       99/99/9999                                99999999999999.99
		Cabec1 := OemToAnsi(STR0011) //  "LAY-AWAY  CLIENTE                                   EMISSAO    ENTREGA    ULT. MOV    STATUS             VALOR              SALDO"
		Cabec2 := OemToAnsi(STR0012) //  "SERIE  DOCUMENTO    PARCELA  MOVIMENTO                                 VALOR"
	EndIF
	
	dbSelectArea("SLO")
	dbSetOrder(1)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta la interfase estandar con el usuario...                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.F.,Tamanho,,.T.)
	
	If nLastKey == 27
		Return
	Endif
	
	SetDefault(aReturn,cString)
	
	If nLastKey == 27
	   Return
	Endif
	
	nTipo := If(aReturn[4]==1,15,18)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procesamiento. RPTSTATUS monta ventana con la regla de procesamiento. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
EndIf

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncion   ³RUNREPORT º Autor ³ Julio Cesar        º Data ³  27-06-02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Funcao auxiliar chamada pela funcao U_LOJR800a(). A funcao   º±±
±±º          ³ RUNREPORT monta a tela com a regua de procesamento.        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
                       
Local aDadosLay := {{}}
Local lContinua := .T.
Local cTotal    := ""
Local nOrdem    := aReturn[8]                                                               
Local nColuna   := 0
Local nSubValor := 0,nTotValor := 0
Local nSubSaldo := 0,nTotSaldo := 0 
Local nC        := 0,nI:=0,nX:=0
Local uControle       
Local cArqTrab1 
#IFDEF TOP
Local cQuery,aStru,nJ
#ENDIF

Private cNumLay := ""
Private aPict   := {}  
Private cSLO
Private cStatus := ""

//Armazena as pictures no array para futuro uso...
AAdd(aPict,PesqPict("SLO","LO_NUMLAY"))
AAdd(aPict,PesqPict("SLO","LO_CLIENTE"))
AAdd(aPict,PesqPict("SLO","LO_EMISSAO"))
AAdd(aPict,PesqPict("SLO","LO_DTENT")) 
AAdd(aPict,PesqPict("SLO","LO_TOTAL")) 
AAdd(aPict,PesqPict("SE5","E5_VALOR"))
// Obs : Se o campo de status estiver marcando aberto (LO_STATUS == "1"), mas
// se a data de entrega (LO_ENT) for menor que a data do sistema, o relatorio 
// vai tratar esse Lay-Away como status vencido - Esse status nao e gravado no
// campo LO_STATUS 

// Armazena o Status do parametro na variavel para facilitar visualizacao 
If MV_PAR13 == 1
	cStatus := "1"       // Aberto  
ElseIf MV_PAR13 == 2
	cStatus := "2"       // Encerrado
ElseIf MV_PAR13 == 3
	cStatus := "4"       // Anulado  
ElseIf MV_PAR13 == 4     
	cStatus := "5"       // Todos 
Endif			

SA1->(dbSetOrder(1))
SA1->(dbSeek(xFilial("SA1")+MV_PAR05,.T.))

dbSelectArea(cString)  

#IFDEF TOP
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Query para SQL                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	        
	cArqTrab1  := CriaTrab( "" , .F. )        
	cSLO   := "SLOTMP"
	aStru  := dbStruct()
	cQuery := "SELECT * FROM " + RetSqlName("SLO") + " SLO "
	cQuery += "WHERE SLO.LO_FILIAL >= '"+mv_par01+"' AND "
	cQuery += "SLO.LO_FILIAL <= '"+mv_par02+"' AND "
	cQuery += "SLO.LO_NUMLAY >= '"+mv_par03+"' AND "
	cQuery += "SLO.LO_NUMLAY <= '"+mv_par04+"' AND "
	cQuery += "SLO.LO_CLIENTE >= '"+mv_par05+"' AND " 
	cQuery += "SLO.LO_CLIENTE <= '"+mv_par06+"' AND " 
	cQuery += "SLO.LO_EMISSAO BETWEEN '"+DtoS(mv_par07)+"' AND '"+DtoS(mv_par08)+ "' AND "
	cQuery += "SLO.LO_DTENT BETWEEN '"+DtoS(mv_par09)+"' AND '"+DtoS(mv_par10)+ "' AND "
	If cStatus <> "5"
		cQuery += "SLO.LO_STATUS = '"+cStatus+"' AND "
	Endif	
	cQuery += "SLO.D_E_L_E_T_ <> '*' "
	cQuery += " ORDER BY SLO.LO_FILIAL,SLO.LO_CLIENTE,SLO.LO_NUMLAY,SLO.LO_LOJA" 
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),'SLOTRB', .F., .T.)},OemToAnsi(STR0026)) //"Selecionando registros"
	For nj := 1 to Len(aStru)
		If aStru[nj,2] != 'C'
			TCSetField('SLOTRB', aStru[nj,1], aStru[nj,2],aStru[nj,3],aStru[nj,4])
		EndIf	
	Next nj
	
	U_Lj800aTmp(aStru, cSLO, "SLOTRB")
	IndRegua(cSLO,cArqTrab1,"LO_FILIAL+LO_NUMLAY+LO_CLIENTE+LO_LOJA",,".T.",STR0026)		//"Selecionando Registros..."
	                 
	DbSelectArea(cSLO)
	While !(cSLO)->(EOF())
		If MV_PAR13 == 4
			cStatus := (cSLO)->LO_STATUS
		Endif
		cNumLay := (cSLO)->LO_NUMLAY
		Lj800Dados((cSLO)->LO_FILIAL,@aDadosLay,@lContinua,"SLOTMP")
	End   
#ELSE	  
	dbSetOrder(2)
	dbSeek(MV_PAR01+SA1->A1_COD+SA1->A1_LOJA+MV_PAR03,.T.)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ SETREGUA -> Indica cuantos registros seran procesados para la regla ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetRegua(RecCount())
	While (SLO->LO_FILIAL  <= MV_PAR02) .And. (SLO->LO_NUMLAY <= MV_PAR04) .And.;
	      (SLO->LO_CLIENTE <= MV_PAR06) .And. lContinua .And. !Eof()
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Comprobar la anulacion por el usuario...                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbortPrint
	   		@nLin,00 PSAY OemToAnsi(STR0013)  // "*** CANCELADO PELO OPERADOR ***"
		   	Exit
		Endif
	
		//Valida o range da Dta. de Emissao
		If Dtos(SLO->LO_EMISSAO) < Dtos(MV_PAR07) .Or. Dtos(SLO->LO_EMISSAO) > Dtos(MV_PAR08)
			dbSkip()
			Loop
		Endif
		
		//Valida o range da Dta. de Entrega
		If Dtos(SLO->LO_DTENT) < Dtos(MV_PAR09) .Or. Dtos(SLO->LO_DTENT) > Dtos(MV_PAR10)
			dbSkip()
			Loop
		Endif	                          
	               
	    If MV_PAR13 == 4
			cStatus := SLO->LO_STATUS
		Endif	
	    
	    //Verifica se o Status esta igual ao informado pelo usuario...          
		If (cStatus <> "5") .And. (cStatus <> SLO->LO_STATUS)
			dbSkip()
			Loop
		EndIF
	
		//Executa a funcao que retorna os dados financeiros
		cNumLay := SLO->LO_NUMLAY
	    Lj800Dados(SLO->LO_FILIAL,@aDadosLay,@lContinua,"SLO")
	    DbSelectArea("SLO")
	End
#ENDIF

//Ordena o array conforme a ordem selecionada pelo usuario...                                                     
If nOrdem == 1
	For nI := 1 To Len(aDadosLay)
		aSort(aDadosLay[nI],,,{|x,y| x[2] + x[1] < y[2] + y[1]})
	Next nI          
	cTotal := OemToAnsi(STR0014) // "TOTAL DO CLIENTE "
	nColuna:= 3
ElseIf nOrdem == 2
	For nI := 1 To Len(aDadosLay)
		aSort(aDadosLay[nI],,,{|x,y| DTOS(x[4]) + x[1] < DTOS(y[4]) + y[1]})
	Next nI          
	cTotal := OemToAnsi(STR0015) // "TOTAL DA DATA DE EMISSAO "
	nColuna:= 4
ElseIf nOrdem == 3
	For nI := 1 To Len(aDadosLay)
		aSort(aDadosLay[nI],,,{|x,y| DTOS(x[5]) + x[1] < DTOS(y[5]) + y[1]})
	Next nI		                         
	cTotal := OemToAnsi(STR0016) // "TOTAL DA DATA DE ENTREGA "
	nColuna:= 5
ElseIf nOrdem == 4
	For nI := 1 To Len(aDadosLay)
		aSort(aDadosLay[nI],,,{|x,y| DTOS(x[6]) + x[1] < DTOS(y[6]) + y[1]})
	Next nI		                         
	cTotal := OemToAnsi(STR0017) // "TOTAL DA DATA DE MOVIMENTO "
	nColuna:= 6
EndIf			

For nI := 1 To Len(aDadosLay)
	For nC := 1 To Len(aDadosLay[nI])
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Comprobar la anulacion por el usuario...                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbortPrint
			@nLin,00 PSAY OemToAnsi(STR0013) // "*** CANCELADO PELO OPERADOR ***"
   			Exit
		Endif

		//Chama funcao de impressao dos Totais/SubTotais
		ImpTot(@nLin,uControle,@nSubValor,@nSubSaldo,nTotValor,nTotSaldo,;
		       aDadosLay[nI][nC][nColuna],cTotal,Cabec1,Cabec2,Titulo,.F.,.F.)
		
		If MV_PAR18 == 1
			nLin+=1  
		Endif	
		@ nLin,00  PSAY aDadosLay[nI][nC][01] Picture aPict[01] //Numero do Lay-Away
		@ nLin,10  PSAY aDadosLay[nI][nC][03] Picture aPict[02] //Nome do Cliente
		@ nLin,52  PSAY aDadosLay[nI][nC][04] Picture aPict[03] //Data de Emissao
		@ nLin,63  PSAY aDadosLay[nI][nC][05] Picture aPict[04] //Data de Entrega
		@ nLin,74  PSAY aDadosLay[nI][nC][06] Picture aPict[04] //Ultima Movimentacao
		@ nLin,86  PSAY aDadosLay[nI][nC][07]                    //Status
		@ nLin,95  PSAY aDadosLay[nI][nC][08] Picture aPict[05] //Valor do Lay-Away
		@ nLin,114 PSAY aDadosLay[nI][nC][09] Picture aPict[05] //Saldo do Lay-Away
		                
		//Impressao Analitica dos Dados   
		If MV_PAR18 == 1
			For nX := 1 To Len(aDadosLay[nI][nC][10]) 
				nLin++  
				@ nLin,00 PSAY aDadosLay[nI][nC][10][nX][01] //Prefixo        
				@ nLin,07 PSAY aDadosLay[nI][nC][10][nX][02] //Numero do Titulo
				@ nLin,20 PSAY aDadosLay[nI][nC][10][nX][03] //Parcela 
				@ nLin,29 PSAY aDadosLay[nI][nC][10][nX][04] Picture aPict[04] //Movimento
				@ nLin,59 PSAY aDadosLay[nI][nC][10][nX][05] Picture aPict[06] //Valor
			Next nX
		EndIf
				
		nLin++  // Avanza la línea de impresión
		nSubValor += aDadosLay[nI][nC][08]
		nSubSaldo += aDadosLay[nI][nC][09]
		nTotValor += aDadosLay[nI][nC][08]
		nTotSaldo += aDadosLay[nI][nC][09]		
		uControle := aDadosLay[nI][nC][nColuna]
	Next nC               
	If Len(aDadosLay[nI]) == 0 
		MsgStop(OemToAnsi(STR0025))  // "Nao existem registros para esse relatorio - Verifique os parametros "
		Exit
	Endif	
	//Chama funcao de impressao dos Totais/SubTotais
	ImpTot(@nLin,uControle,@nSubValor,@nSubSaldo,nTotValor,nTotSaldo,;
	       aDadosLay[nI][nC-1][nColuna],cTotal,Cabec1,Cabec2,Titulo,.T.,.F.)
Next nI                                                              
//Imprime o Total Geral
ImpTot(@nLin,,,,nTotValor,nTotSaldo,,cTotal,Cabec1,Cabec2,Titulo,,.T.)

If Select("SLOTMP") <> 0
   (cSLO)->(DbCloseArea())
	If( ValType(oTempTable) == "O")
	  oTempTable:Delete()
	  FreeObj(oTempTable)
	  oTempTable := Nil
	EndIf
EndIf	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza la ejecucion del informe...                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Si imprime en disco, llama al gerente de impresion...               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return Nil

//************************

Static Function Lj800Dados(cFilAtu,aDadosLay,lContinua,cAlias)
Local nX
Local aTesInf  := {}
Local nValPg   := a800TotPg()
Local nValor   := 0 
Local nSaldo   := 0 
Local cChaveLP := ""
Local cChaveE5 := ""
Local cData    := ""
Local dDtaEmis := (cAlias)->LO_EMISSAO
Local dDtaEnt  := (cAlias)->LO_DTENT 
Local aDadosFin:= {}
Local nVlrImpos:= 0  
                                                           
//Pesquisa o nome do Cliente...
SA1->(dbSetOrder(1))
SA1->(dbSeek(xFilial("SA1")+(cAlias)->LO_CLIENTE+(cAlias)->LO_LOJA))
                                
//Verifica o valor total do Lay-Away e o Saldo que resta a pagar pelo mesmo...
dbSelectArea((cAlias))
While !Eof() .and. ((cAlias)->LO_FILIAL+(cAlias)->LO_NUMLAY == cFilAtu+cNumLay)
    nValor += (cAlias)->LO_TOTAL 
	aTesInf  := TesImpInf((cAlias)->LO_TES)
	nVlrImpos:= 0
	If Len(aTesInf) > 0
		For nX := 1 to Len(aTesInf)
	    	If aTesInf[nX][3] == "1"    
				#IFDEF TOP	
					nVlrImpos += &("SLOTMP->LO_VALIMP"+Substr(aTesInf[nX][2],10,1))
				#ELSE	
	      	    	nVlrImpos += &("SLO->LO_VALIMP"+Substr(aTesInf[nX][2],10,1))
	      		#ENDIF
			EndIf
		Next nX   
	EndIf
	nValor += nVlrImpos
	dbSkip()
	If Eof()
		lContinua := .F.
	EndIf
End
nSaldo := (nValor-nValPg)

//Verifica se o Valor esta dentro do Range informado pelo usuario...     
If (nValor < MV_PAR14) .Or. (nValor > MV_PAR15)
	Return
EndIf                                                               
                                                                         
//Verifica se o Saldo esta dentro do Range informado pelo usuario...     
If (nSaldo < MV_PAR16) .Or. (nSaldo > MV_PAR17)
	Return
EndIf
   

//Verifica se o tamanho limite do array ja foi atingido...
If Len(aDadosLay[Len(aDadosLay)]) == 4096 
	AAdd(aDadosLay,{}) 
EndIf
AAdd(aDadosLay[Len(aDadosLay)],{cNumLay,SA1->A1_COD,SA1->A1_NOME,;
                                 dDtaEmis,dDtaEnt,dDataBase,cStatus,0,0,{}})

dbSelectArea("SLP")    
dbSetOrder(1)
If dbSeek(cFilAtu+cNumLay+"2")
	While !Eof() .and. (SLP->LP_FILIAL+SLP->LP_NUMLAY+"2" == cFilAtu+cNumLay+"2")
       	cChaveLP := xFilial("SE5")+"RA"+SLP->LP_PREFIXO+SLP->LP_NUME1+SLP->LP_PARCELA+"RA "
		SE5->(dbSetOrder(2))
		If SE5->(dbSeek(cChaveLP))
			cChaveE5 := xFilial("SE5")+SE5->E5_TIPODOC+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO
			While SE5->(!Eof()) .And. (cChaveE5 == cChaveLP)
				//Verifica se o tamanho limite do array ja foi atingido...
		    	AAdd(aDadosFin,{SE5->E5_PREFIXO,SE5->E5_NUMERO,SE5->E5_PARCELA,SE5->E5_DATA,SE5->E5_VALOR})				
				If Dtos(SE5->E5_DATA) > cData
					cData := Dtos(SE5->E5_DATA)
				EndIf
				SE5->(dbSkip())
				cChaveE5 := xFilial("SE5")+SE5->E5_TIPODOC+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO
			End
		EndIf
		dbSkip()	
   	End 
Endif    	
     
aDadosLay[Len(aDadosLay)][Len(aDadosLay[Len(aDadosLay)])][06] := Stod(cData) 
If cStatus == "1" .And. aDadosLay[Len(aDadosLay)][Len(aDadosLay[Len(aDadosLay)])][05] >= dDataBase          
	aDadosLay[Len(aDadosLay)][Len(aDadosLay[Len(aDadosLay)])][07] := OemToAnsi(STR0018)  // "Aberto"
Else
	aDadosLay[Len(aDadosLay)][Len(aDadosLay[Len(aDadosLay)])][07] := OemToAnsi(STR0028) //  "Vencido"
Endif	
If cStatus == "2"
	aDadosLay[Len(aDadosLay)][Len(aDadosLay[Len(aDadosLay)])][07] := OemToAnsi(STR0019) //  "Encerrado"
ElseIf cStatus == "4"
	aDadosLay[Len(aDadosLay)][Len(aDadosLay[Len(aDadosLay)])][07] := OemToAnsi(STR0027) //  "Anulado"
Endif
aDadosLay[Len(aDadosLay)][Len(aDadosLay[Len(aDadosLay)])][08] := nValor 
If cStatus == "4"
	nSaldo := 0	  
	aDadosLay[Len(aDadosLay)][Len(aDadosLay[Len(aDadosLay)])][09] := nSaldo 
Else
	aDadosLay[Len(aDadosLay)][Len(aDadosLay[Len(aDadosLay)])][09] := nSaldo 
Endif	
aDadosLay[Len(aDadosLay)][Len(aDadosLay[Len(aDadosLay)])][10] := aDadosFin

Return

//***        

Static Function ImpTot(nLin,uControle,nSubValor,nSubSaldo,nTotValor,nTotSaldo,;
                       uAux,cTotal,Cabec1,Cabec2,Titulo,lUltimo,lTotGer)
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impresion del encabezamiento del informe. . .                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLin > 55 // Salto de Página. En este caso el impreso tiene 55 líneas...
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
    nLin := 8
Endif
		                                                               
If !lTotGer		
		If ((uControle <> uAux) .And. (uControle <> Nil)) .Or. lUltimo
			nLin++
			@ nLin,000         	PSAY cTotal                      //Descricao do SubTotal
			@ nLin,Len(cTotal)	PSAY uControle                   //Qual SubTotal esta sendo impresso
			@ nLin,095        	PSAY nSubValor Picture aPict[05] //SubTotal do Valor
			@ nLin,114			PSAY nSubSaldo Picture aPict[05] //SubTotal do Saldo
					
			nSubValor := 0
			nSubSaldo := 0
			nLin      := nLin+2
		EndIf
Else
	@ nLin,000 PSAY OemToAnsi(STR0020)  // "TOTAL GERAL => "
	@ nLin,095 PSAY nTotValor Picture aPict[05] //Total do Valor
	@ nLin,114 PSAY nTotSaldo Picture aPict[05] //Total do Saldo
EndIF

Return Nil
                  
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Lj800aTmp  ³ Autor ³ William Martinez Yong ³ Data ³ 08/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cria temporario a partir da consulta corrente (TOP)          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³U_LOJR800A (TOPCONNECT)                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Lj800aTmp(aStruTmp, cAliasTmp, cAlias)
	Local nI, nF
	nF := (cAlias)->(Fcount())
    oTempTable := LjCrTmpTbl(cAliasTmp, aStruTmp)
	(cAlias)->(DbGoTop())
	While ! (cAlias)->(Eof())
        (cAliasTmp)->(DbAppend())
		For nI := 1 To Len(aStruTmp)
            (cAliasTmp)->(FieldPut(nI ,;
				(cAlias)->(FieldGet( ;
				(cAlias)->(FieldPos( ;
                (cAliasTmp)->( FieldName( ni ))))))))
		Next
		(cAlias)->(DbSkip())
	End
	(cAlias)->(dbCloseArea())
    DbSelectArea(cAliasTmp)
Return Nil	


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Lojr800N    º Autor ³Vendas CRM          º Data ³  11/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Relatorio de movimentacoes por Lay-Away para o Mexico         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function Lojr800N()
	Local cPerg  := "LJ800A"
	Local cAlias := ""
	Local oSLO                //Objeto para armazenar a secao pai
	Local oSLP                //OBJETO PARA ARMAZENAR A SECAO FILHA
	
	Private cNumLay := "" 
	
   	#IFDEF TOP
	   	cAlias    := GetNextAlias()
	   	cAliasSLP := cAlias
   	#ELSE
		cAlias := "SLO"
		cAliasSLP := "SLP"
   	#ENDIF
   
	Pergunte(cPerg, .F.)
	
	//Relatório
	DEFINE REPORT oReport NAME "Lojr800N" TITLE STR0003 + STR0004 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport, cPerg, cAlias)} //"Relatorio de Movimentacoes por Lay-Away"
	oReport:SetLandscape() //Escolher o padrão de Impressao como Paisagem 
	 
	 //sessao 1
	 DEFINE SECTION oSLO OF oReport TITLE STR0029 TABLES "SLO" BREAK HEADER //"Processo de Vendas"
      
      //Celulas secao 1
      If SLO->(FieldPos("LO_CODCON")) > 0
      	DEFINE CELL NAME "LO_CODCON"	    OF oSLO ALIAS "SLO"
      EndIf	 
      DEFINE CELL NAME "LO_NUMLAY"	    OF oSLO TITLE STR0030 		SIZE 30 BLOCK {|| (cAlias) ->LO_NUMLAY } 	//"Cod. Manejo de Apartados"			
      DEFINE CELL NAME "LO_CLIENTE"	    OF oSLO ALIAS "SLO"         SIZE 30 BLOCK {|| POSICIONE("SA1",1,XFILIAL("SA1") +(cAlias)->LO_CLIENTE + (cAlias)->LO_LOJA,"A1_NOME")}
      DEFINE CELL NAME "LO_EMISSAO"	    OF oSLO ALIAS "SLO"         		
      DEFINE CELL NAME "LO_STATUS"	    OF oSLO ALIAS "SLO"
      DEFINE CELL NAME "Total"	    	OF oSLO TITLE STR0039		SIZE 20 BLOCK {|| U_Lj800TotA(.T.,(cAlias)->LO_NUMLAY) } //"Total"
      DEFINE CELL NAME "Saldo"	    	OF oSLO TITLE STR0033     	BLOCK {|| ((cAlias)->LO_VALPAG - U_Lj800TotA(.T.,(cAlias)->LO_NUMLAY)) }  //"Saldo"
      
  	//Sessao Neta/Entidade
	   DEFINE SECTION oSLP OF oSLO TITLE STR0029 TABLE "SLP" BREAK HEADER LEFT MARGIN 10 //"Informes de movimentacao de manejo de apartados		
	  		
		//Celulas secao Neta/Entidade	        
  	   	DEFINE CELL NAME "LP_PREFIXO"		OF oSLP ALIAS "SLP" 
   	   	DEFINE CELL NAME "LP_NUME1"			OF oSLP ALIAS "SLP"
   	  	DEFINE CELL NAME "LP_PARCELA"		OF oSLP ALIAS "SLP"
   	  	DEFINE CELL NAME "LP_TIPOE1"		OF oSLP ALIAS "SLP"
   	  	DEFINE CELL NAME "LP_NUME1"			OF oSLP ALIAS "SLP" 	  
      	DEFINE CELL NAME "Valor_DOC"		OF oSLP TITLE STR0040  BLOCK {|| POSICIONE("SE1",1,XFILIAL("SE1") + (cAliasSLP)->LP_PREFIXO+PADR((cAliasSLP)->LP_NUME1,TAMSX3("LP_NUME1")[1])+ (cAliasSLP)->LP_PARCELA + (cAliasSLP)->LP_TIPOE1,"E1_VALOR")} //"Valor Doc"
     
	//Quebra
	DEFINE BREAK oBreak OF oSLO WHEN oSLO:Cell("LO_CLIENTE")
	
	//Totalizador
	DEFINE FUNCTION FROM oSLO:Cell("Total") OF oSLO FUNCTION SUM TITLE STR0036 NO END SECTION BREAK oBreak  //"Total do cliente"		
	DEFINE FUNCTION FROM oSLO:Cell("Saldo")    OF oSLO FUNCTION SUM TITLE STR0037 NO END SECTION BREAK oBreak  //"Saldo Total"
		
	oReport:PrintDialog()

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReportºAutor  ³Vendas CRM         º Data ³  07/01/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Selecao dos itens a serem impressos                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³FATRXX                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport, cPerg, cAlias)

	Local oSection1 	:= oReport:Section(1)				// Objeto secao 1 do relatorio
	Local oSection2 	:= oSection1:Section(1)				// Objeto secao 2 do relatorio 
	Local cFiltro	    := ""      							// String contendo o filtro de busca a ser utilizado com DBF
	Local cSQL          := ""                               // String contendo a expressão utilizada na query  
	Local bMenos
	Local bMais
		   
#IFDEF TOP
	
	MakeSqlExp(cPerg)
	
	
	If !Empty(MV_PAR01)//De Sucusal
	   	cSQL += "AND LO_FILIAL >= '" + MV_PAR01 + "' "
	EndIf

	If !Empty(MV_PAR02)//A Sucursal
		cSQL += "AND LO_FILIAL <= '" + MV_PAR02 + "' "
	EndIf
	
	If !Empty(MV_PAR03) //De Manejo(Lay-Away)
	   	cSQL += "AND LO_NUMLAY >= '" + MV_PAR03 + "' "
	EndIf
    
    If !Empty(MV_PAR04) //A Manejo(Lay-Away)
	   	cSQL += "AND LO_NUMLAY <= '" + MV_PAR04 + "' "
	EndIf
    
    If !Empty(MV_PAR05) //De Cliente
	   	cSQL += "AND LO_CLIENTE >= '" + MV_PAR05 + "' "
	EndIf
    
    If !Empty(MV_PAR06) //A Cliente
	   	cSQL += "AND LO_CLIENTE <= '" + MV_PAR06 + "' "
	EndIf
    
    If !Empty(MV_PAR07) //De Emision
	   	cSQL += "AND LO_EMISSAO BETWEEN '" + DtoS(mv_par07) + "' "
	EndIf
	
	If !Empty(MV_PAR08) //A Emision
	   	cSQL += "AND '" +DtoS(mv_par08)+ "' "
	EndIf
	
	If !Empty(MV_PAR09) //De Entrega
	   	cSQL += "AND LO_DTENT BETWEEN '"+DtoS(mv_par09)+"' "
	EndIf
	
	If !Empty(MV_PAR10) //A Entrega
	   	cSQL += "AND '" + DtoS(mv_par10) + "' "
	EndIf
	
	If MV_PAR11 == 1  //Estatus
		cSQL += "AND LO_STATUS = '1' " // Aberto 
	ElseIf MV_PAR11 == 2
		cSQL += "AND LO_STATUS = '2' "// Encerrado
	ElseIf MV_PAR11 == 3
		cSQL += "AND LO_STATUS = '4' "  // Anulado
	Endif
		
	If MV_PAR12 > 0 //De Valor
		cSQL += "AND LO_TOTAL >= '" + Str(MV_PAR11) + "' "
	EndIf
    
    If MV_PAR13 > 0 //A Valor
	   cSQL += "AND LO_TOTAL <= '" + Str(MV_PAR12) + "' "
	EndIf
		
	If MV_PAR14 == 2 //Sintetico
		oSection2:Hide()
		oSection2:SetHeaderSection(.F.)
	EndIf  	
	
	cSQL := "%"+cSQL+"%" 
		
		BEGIN REPORT QUERY oSection1
			BeginSql Alias cAlias
				SELECT SLO.*,SLP.* FROM %Table:SLO% SLO
						JOIN %Table:SLP% SLP ON (LO_NUMLAY = LP_NUMLAY AND LP_TPAMAR=(SELECT MAX(SLP2.LP_TPAMAR) FROM %Table:SLP% AS SLP2 WHERE SLP2.LP_NUMLAY=SLP.LP_NUMLAY))
				WHERE LO_NUMLAY = LP_NUMLAY  
				%Exp:cSQL%
				ORDER BY LO_FILIAL,LO_CLIENTE,LO_NUMLAY,LO_LOJA
			EndSql
		
		END REPORT QUERY oSection1  
	    	    
	    oSection2:SetParentQuery()	
	   	oSection2:SetParentFilter({|cLay| (cAlias)->LP_NUMLAY == cLay},{|| (cAlias)->LO_NUMLAY })
	   	oSection1:Print()
 	
#ELSE

 MakeAdvplExpr(cPerg)
	
   dbSelectArea("SLO")
   dbSetOrder(1)
    
    cFiltro :=  "SLO->LO_CLIENTE >= '" + MV_PAR05 + "' .AND. SLO->LO_CLIENTE <= '" + MV_PAR06 + "'"
    
    If MV_PAR11 == 1
		bMais    := { || SLO->LO_STATUS = "1" } 
	ElseIf MV_PAR11 == 2
		bMais    := { || SLO->LO_STATUS = "2" } 
	ElseIf MV_PAR11 == 3
		bMais    := { || SLO->LO_STATUS = "4" }
	ElseIf MV_PAR11 == 4
		bMais    := { || .T. }		 	                                
	EndIf 
    
    If MV_PAR14 == 2 //Sintetico
    	bMenos    := { || .F. }
    EndIf
    
    SET DELETED OFF
     
   oSection1:SetFilter(cFiltro)
   oSection1:SetLineCondition({|| SLO->LO_FILIAL >= MV_PAR01 .And. SLO->LO_FILIAL <= MV_PAR02 .And. Eval( bMais ) .And. SLO->LO_NUMLAY >= MV_PAR03 .And. SLO->LO_NUMLAY <= MV_PAR04 .And. SLO->LO_CLIENTE >= MV_PAR05 .And. SLO->LO_CLIENTE <= MV_PAR06 .And. SLO->LO_EMISSAO >= MV_PAR07 .AND. SLO->LO_EMISSAO <= MV_PAR08 .And. SLO->LO_DTENT >= MV_PAR09 .And. SLO->LO_DTENT <= MV_PAR10 }) 	
   oSection2:SetRelation({|| xFilial("SLP") + SLO->LO_NUMLAY + "2" }, "SLP", 1, .T.)
   oSection2:SetParentFilter({|cLay| SLP->LP_NUMLAY == cLay},{|| SLO->LO_NUMLAY })
   If MV_PAR14 == 1
   	oSection2:SetLineCondition({|| SLO->LO_FILIAL >= MV_PAR01 .And. SLO->LO_FILIAL <= MV_PAR02 .And. Eval( bMais ) .And. SLO->LO_NUMLAY >= MV_PAR03 .And. SLO->LO_NUMLAY <= MV_PAR04 .And. SLO->LO_CLIENTE >= MV_PAR05 .And. SLO->LO_CLIENTE <= MV_PAR06 .And. SLO->LO_EMISSAO >= MV_PAR07 .AND. SLO->LO_EMISSAO <= MV_PAR08 .And. SLO->LO_DTENT >= MV_PAR09 .And. SLO->LO_DTENT <= MV_PAR10 })
   	oSection1:Print()
   Else 
   	oSection2:SetLineCondition({|| Eval( bMenos ) })
   	oSection1:Print()
   EndIf 
   
   SET DELETED ON
   
#ENDIF

Return Nil

  
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Lj800TotA ºAutor  ³Vendas CRM          º Data ³  11/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Totaliza o valor do lay-away                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJR800A                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Lj800TotA(lGravado,cNumLay)

Local nValor	:= 0
Local nX        := 0
Local aArea 	:= {}
Local aAreaSLO 	:= {}
Local aTesInf 	:= {}

aArea:= GetArea()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
//³	Roda o arquivo SLO para totalizar o valor do Lay-Away	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

If lGravado
	dbSelectArea("SLO")
	aAreaSLO:=GetArea()      
	dbSetOrder(1)
	dbSeek(xFilial("SLO")+cNumLay)
	While !Eof() .AND. SLO->LO_FILIAL+SLO->LO_NUMLAY == xFilial("SLO")+cNumLay
		nValor:= nValor + SLO->LO_TOTAL + SLO->LO_FRETE + SLO->LO_DESPESA - SLO->LO_VALDESC
		// Soma os impostos do item
		aTesInf  := TesImpInf(SLO->LO_TES)
		For nX := 1 to Len(aTesInf)
		   If aTesInf[nX][3] == "1"  //Verifica se o imposto incide no valor do layaway
		      nValor := nValor + &("SLO->LO_"+Substr(aTesInf[nX][2],4,7))
		   EndIf
		Next nX		
		dbSkip()
	End
	RestArea(aAreaSLO)
Else
	// Utiliza o total existente no rodape
	nValor := MaFisRet(,"NF_TOTAL")
EndIf


RestArea(aArea)
Return nValor  
