/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "LOJR800B.CH"
#INCLUDE "FIVEWIN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

Static oTempTable	:= Nil	//Objeto tabela temporaria

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LOJR800B  º Autor ³ William Martinez Yong º Data ³  22-07-02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de produtos por Lay-Away.                           º±±
±±º          ³ (Localizacoes)                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5 IDE                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function LOJR800b()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracion de Variables                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1   := OemToAnsi(STR0001) // "Este programa tem como objetivo imprimir relatorio "
Local cDesc2   := OemToAnsi(STR0002) // "de acordo com os parametros informados pelo usuario."
Local cDesc3   := OemToAnsi(STR0003) // "Relatorio de Produtos por Lay-Away"
Local Cabec1   := ""
Local Cabec2   := ""
Local titulo   := OemToAnsi(STR0003) // "Relatorio de Produtos por Lay-Away"
Local nLin     := 80
Local lR5	   := GetRpoRelease("R5")// Indica se o release e 11.5 

Private aOrd        := {OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007)}  // "Cliente","Data de Emissao","Data de Entrega"
Private lAbortPrint := .F.
Private tamanho     := "M"
Private nomeprog    := "LOJR800B"
Private nTipo       := 15
Private aReturn     := { OemToAnsi(STR0009), 1, OemToAnsi(STR0010), 1, 2, 1, "", 1}   // "A Rayas","Administracao"
Private nLastKey    := 0
Private wnrel       := "LOJR800B"
Private m_pag       := 01
Private cString     := "SLO"   
Private cPerg       := "LJ800B"
  
If cPaisLoc == "MEX" .AND. lR5 .AND. FindFunction("Lojr800")
  U_Lojr800()
Else

	If !Pergunte("LJ800B",.T.)
		Return 
	EndIf
	           
	If Empty(MV_PAR10) .OR. Empty(MV_PAR11)
		MsgStop(OemToAnsi(STR0021)+OemToAnsi(STR0022))   // "Preencha os parametros ","De Emissao e Ate Emissao "
		Return
	Endif	     
	                        
	If Empty(MV_PAR12) .OR. Empty(MV_PAR13)
		MsgStop(OemToAnsi(STR0021)+OemToAnsi(STR0023))   // "Preencha os parametros ","De Entrega e Ate Entrega "
		Return
	Endif	  
	
	// Define o cabecalho   
	//         10        20        30        40        50        60        70        80        90        100       110       120       130
	//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
		//LAY-AWAY  CLIENTE                                   EMISSAO    ENTREGA    STATUS    VALOR              SALDO
		//XXXXXX    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999 99/99/9999 XXXXXXX   99999999999999.99  99999999999999.99
	//SERIE  DOCUMENTO    PARCELA  MOVIMENTO                                 VALOR
	//XXX    XXXXXXXXXXX  XX       99/99/9999                                99999999999999.99
	Cabec1 := OemToAnsi(STR0011) //  "LAY-AWAY  CLIENTE                                   EMISION    ENTREGA    ESTATUS            VALOR                 SALDO"
	Cabec2 := OemToAnsi(STR0012) //  "PRODUCTO         DESCRIPCION                              CANTIDAD        $UNIT                $TOTAL"
	
	dbSelectArea("SLO")
	dbSetOrder(1)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta la interface estandar con el usuario...                       ³
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
±±ºFuncion   ³RUNREPORT º Autor ³ William M. Yong    º Data ³  22-07-02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Funcao auxiliar chamada pela funcao U_LOJR800b(). A funcao   º±±
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
Local nTotQuant := 0
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
AAdd(aPict,PesqPict("SLO","LO_QUANT")) 
AAdd(aPict,PesqPict("SLO","LO_VUNIT")) 
AAdd(aPict,PesqPict("SLO","LO_PRODUTO")) 
AAdd(aPict,PesqPict("SB1","B1_DESC")) 

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
SA1->(dbSeek(xFilial("SA1")+MV_PAR07,.T.))

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
	cQuery += "SLO.LO_PRODUTO >= '"+mv_par05+"' AND "
	cQuery += "SLO.LO_PRODUTO <= '"+mv_par06+"' AND "
	cQuery += "SLO.LO_CLIENTE >= '"+mv_par07+"' AND " 
	cQuery += "SLO.LO_CLIENTE <= '"+mv_par08+"' AND " 
	cQuery += "SLO.LO_EMISSAO BETWEEN '"+DtoS(mv_par09)+"' AND '"+DtoS(mv_par10)+ "' AND "
	cQuery += "SLO.LO_DTENT BETWEEN '"+DtoS(mv_par11)+"' AND '"+DtoS(mv_par12)+ "' AND "
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
	
	U_Lj800bTmp(aStru, cSLO, "SLOTRB")
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
	      (SLO->LO_CLIENTE <= MV_PAR08) .And. lContinua .And. !Eof()
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Comprobar la anulacion por el usuario...                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbortPrint
	   		@nLin,00 PSAY OemToAnsi(STR0013)  // "*** CANCELADO PELO OPERADOR ***"
		   	Exit
		Endif
	   
		//Valida o range da Dta. de Emissao
		If Dtos(SLO->LO_EMISSAO) < Dtos(MV_PAR09) .Or. Dtos(SLO->LO_EMISSAO) > Dtos(MV_PAR10)
			dbSkip()
			Loop
		Endif
		
		//Valida o range da Dta. de Entrega
		If Dtos(SLO->LO_DTENT) < Dtos(MV_PAR11) .Or. Dtos(SLO->LO_DTENT) > Dtos(MV_PAR12)
			dbSkip()
			Loop
		Endif	 
		
		If !(SLO->LO_NUMLAY >= MV_PAR03 .AND. SLO->LO_NUMLAY <= MV_PAR04)
			dbSkip()
			Loop
		Endif
		
		If !(SLO->LO_CLIENTE >= MV_PAR07 .AND. SLO->LO_CLIENTE <= MV_PAR08)
			dbSkip()
			Loop
		Endif
		                   
		If !(SLO->LO_PRODUTO >= MV_PAR05 .AND. SLO->LO_PRODUTO <= MV_PAR06)
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
		EndIf       
		
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
		       aDadosLay[nI][nC][nColuna],cTotal,Cabec1,Cabec2,Titulo,.F.,.F.,nTotQuant)
		
		nLin+=1  
		
		@ nLin,00  PSAY aDadosLay[nI][nC][01] Picture aPict[01] //Numero do Lay-Away
		@ nLin,10  PSAY aDadosLay[nI][nC][03] Picture aPict[02] //Nome do Cliente
		@ nLin,52  PSAY aDadosLay[nI][nC][04] Picture aPict[03] //Data de Emissao
		@ nLin,63  PSAY aDadosLay[nI][nC][05] Picture aPict[04] //Data de Entrega   
		@ nLin,74  PSAY aDadosLay[nI][nC][07]                    //Status
		@ nLin,84  PSAY aDadosLay[nI][nC][08] Picture aPict[05] //Valor do Lay-Away
		@ nLin,110 PSAY aDadosLay[nI][nC][09] Picture aPict[05] //Saldo do Lay-Away
		       
		For nX:=1  To Len(aDadosLay[nI][nC][10])
			nLin++         
			@ nLin,00 PSAY aDadosLay[nI][nC][10][nX][02] Picture aPict[08] //Codigo do Produto       
			@ nLin,17 PSAY aDadosLay[nI][nC][10][nX][03] Picture aPict[09] //Descricao do Produto
			@ nLin,49 PSAY aDadosLay[nI][nC][10][nX][04] Picture aPict[06] //Quantidade 
			@ nLin,75 PSAY aDadosLay[nI][nC][10][nX][05] Picture aPict[07] //Vlr. Unitario
			@ nLin,96 PSAY aDadosLay[nI][nC][10][nX][06] Picture aPict[05] //Vlr. Total 
			nTotQuant += aDadosLay[nI][nC][10][nX][04]
		Next nX
			
		nLin++  // Avanza la linea de impresion
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
	       aDadosLay[nI][nC-1][nColuna],cTotal,Cabec1,Cabec2,Titulo,.T.,.F.,nTotQuant)
Next nI                                                              
//Imprime o Total Geral
ImpTot(@nLin,,,,nTotValor,nTotSaldo,,cTotal,Cabec1,Cabec2,Titulo,,.T.,nTotQuant)

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

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Lj800Dadosº Autor ³ William M. Yong    ºFecha ³  22/07/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Alimenta o array aDadosLay com tudo o que deve ser impressoº±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Lj800Dados(cFilAtu,aDadosLay,lContinua,cAlias)
Local nValPg     := a800TotPg()
Local nValor     := 0 
Local nSaldo     := 0 
Local cData      := ""
Local dDtaEmis   := (cAlias)->LO_EMISSAO
Local dDtaEnt    := (cAlias)->LO_DTENT 
Local aDadosProd := {}
Local aProdTmp   := {} 
Local cDesc      := ""
#IFDEF TOP	
Local nVlrLay    := U_Lj800bVlr()
#ELSE
Local nX
#ENDIF

//Pesquisa o nome do Cliente...
SA1->(dbSetOrder(1))
SA1->(dbSeek(xFilial("SA1")+(cAlias)->LO_CLIENTE+(cAlias)->LO_LOJA))
                           
//Verifica o valor total do Lay-Away e o Saldo que resta a pagar pelo mesmo...
dbSelectArea((cAlias)) 
dbSetOrder(1)
dbSeek(xFilial("SLO")+cNumLay)
While !Eof() .and. ((cAlias)->LO_FILIAL+(cAlias)->LO_NUMLAY == cFilAtu+cNumLay)
	//Pesquisa a descricao do produto
	SB1->(dbSetOrder(1))
	If SB1->(dbSeek(xFilial("SB1")+(cAlias)->LO_PRODUTO))
		cDesc := SB1->B1_DESC
	Else
		cDesc := OemToAnsi(STR0029)  // "Descricao nao encontrada"                 
	Endif        
	If (cAlias)->LO_PRODUTO >= MV_PAR05 .AND. (cAlias)->LO_PRODUTO <= MV_PAR06	
		AAdd(aProdTmp,{(cAlias)->LO_NUMLAY,(cAlias)->LO_PRODUTO,cDesc,(cAlias)->LO_QUANT,(cAlias)->LO_VUNIT,(cAlias)->LO_TOTAL})				 
	Endif 
	#IFDEF TOP	
		nValor := nVlrLay    
    #ELSE
    	nValor += (cAlias)->LO_TOTAL 
		aTesInf  := TesImpInf((cAlias)->LO_TES)
		nVlrImpos:= 0
		If Len(aTesInf) > 0
			For nX := 1 to Len(aTesInf)
	    		If aTesInf[nX][3] == "1"    
	      	    	nVlrImpos += &("SLO->LO_VALIMP"+Substr(aTesInf[nX][2],10,1))
				EndIf
			Next nX   
		EndIf
		nValor += nVlrImpos 
	#ENDIF	
	(cAlias)->(dbSkip())
	If (cAlias)->(Eof())
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

aDadosProd := aClone(aProdTmp)

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
aDadosLay[Len(aDadosLay)][Len(aDadosLay[Len(aDadosLay)])][10] := aDadosProd

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ImpTot   º Autor ³ William M. Yong    ºFecha ³  22/07/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Imprime totais                                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ImpTot(nLin,uControle,nSubValor,nSubSaldo,nTotValor,nTotSaldo,;
                       uAux,cTotal,Cabec1,Cabec2,Titulo,lUltimo,lTotGer,nTotQuant)
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impresion del encabezamiento del informe. . .                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLin > 55 // Salto de Pagina. En este caso el impreso tiene 55 lineas...
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
    nLin := 8
Endif
		                                                               
If !lTotGer		
		If ((uControle <> uAux) .And. (uControle <> Nil)) .Or. lUltimo
			nLin++
			@ nLin,000         	PSAY cTotal                      //Descricao do SubTotal
			@ nLin,Len(cTotal)	PSAY uControle                   //Qual SubTotal esta sendo impresso
			@ nLin,084        	PSAY nSubValor Picture aPict[05] //SubTotal do Valor
			@ nLin,110		    PSAY nSubSaldo Picture aPict[05] //SubTotal do Saldo
					
			nSubValor := 0
			nSubSaldo := 0
			nLin      := nLin+2
		EndIf
Else
	@ nLin,000    PSAY OemToAnsi(STR0020)  // "TOTAL GERAL => "   
	@ nLin,049  PSAY nTotQuant Picture aPict[06] //Total da Quantidade
	@ nLin,084    PSAY nTotValor Picture aPict[05] //Total do Valor
	@ nLin,110   PSAY nTotSaldo Picture aPict[05] //Total do Saldo
EndIF

Return Nil
                  
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Lj800bTmp  ³ Autor ³ William Martinez Yong ³ Data ³ 08/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cria temporario a partir da consulta corrente (TOP)          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³U_LOJR800B (TOPCONNECT)                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function Lj800bTmp(aStruTmp, cAliasTmp, cAlias)
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

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Lj800bVlr  ³ Autor ³ William Martinez Yong ³ Data ³ 26/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Calcula o valor do lay-away em abiente TopConnect            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³U_LOJR800B (TOPCONNECT)                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function Lj800bVlr()

Local aTesInf    := {}
Local nX         := 0
Local nValor     := 0

dbSelectArea("SLO") 
dbSetOrder(1)
dbSeek(xFilial("SLO")+cNumLay)
While !Eof() .and. (SLO->LO_FILIAL+SLO->LO_NUMLAY == xFilial("SLO")+cNumLay)
	nValor += SLO->LO_TOTAL 
	aTesInf  := TesImpInf(SLO->LO_TES)
	nVlrImpos:= 0
	If Len(aTesInf) > 0
		For nX := 1 to Len(aTesInf)
	    	If aTesInf[nX][3] == "1"    	
	      		nVlrImpos += &("SLO->LO_VALIMP"+Substr(aTesInf[nX][2],10,1))
			EndIf
		Next nX   
	EndIf
	nValor += nVlrImpos
	dbSkip()
End
   
Return(nValor)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Lojr800     º Autor ³Vendas CRM          º Data ³  11/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³  Relatorio de produtos por Lay-Away.                         º±±
±±º          ³ (Localizacoes)                      							º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function Lojr800()
	Local cPerg  := "LJ800B"
	Local cAlias := ""
	Local oSLO                //Objeto para armazenar a secao pai
	Local oSB1                //OBJETO PARA ARMAZENAR A SECAO FILHA
	
	Private cNumLay := "" 
	
	#IFDEF TOP
	   	cAlias    := GetNextAlias()
	   	cAliasSB1 := cAlias
   	#ELSE
		cAlias := "SLO"
		cAliasSB1 := "SB1"
   	#ENDIF
   
	Pergunte(cPerg, .F.)
	
	//Relatório
	DEFINE REPORT oReport NAME "Lojr800" TITLE STR0003 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport, cPerg, cAlias)} //"Relatorio de Produtos por Lay-Away"
	oReport:SetLandscape() //Escolher o padrão de Impressao como Paisagem 

	 //sessao 1
	 DEFINE SECTION oSLO OF oReport TITLE STR0030 TABLES "SLO" BREAK HEADER //"Informe de Movimentos por Manejo de Apartados"
      
      //Celulas secao 1
      If SLO->(FieldPos("LO_CODCON")) > 0
      	DEFINE CELL NAME "LO_CODCON"	    OF oSLO ALIAS "SLO"
      EndIf	 
      DEFINE CELL NAME "LO_NUMLAY"	    OF oSLO TITLE STR0031 		SIZE 30 BLOCK {|| (cAlias) ->LO_NUMLAY } 				
      DEFINE CELL NAME "LO_CLIENTE"	    OF oSLO ALIAS "SLO"         SIZE 30 BLOCK {|| POSICIONE("SA1",1,XFILIAL("SA1") +(cAlias)->LO_CLIENTE + (cAlias)->LO_LOJA,"A1_NOME")}
      DEFINE CELL NAME "LO_EMISSAO"	    OF oSLO ALIAS "SLO"
      DEFINE CELL NAME "LO_DTENT"	    OF oSLO ALIAS "SLO"          		
      DEFINE CELL NAME "LO_STATUS"	    OF oSLO ALIAS "SLO"
      DEFINE CELL NAME "Total"	    	OF oSLO TITLE STR0032		SIZE 20 BLOCK {|| U_Lj800TotC(.T.,(cAlias)->LO_NUMLAY) }
      DEFINE CELL NAME "Saldo"	    	OF oSLO TITLE STR0033     			BLOCK {|| ((cAlias)->LO_VALPAG - U_Lj800TotC(.T.,(cAlias)->LO_NUMLAY)) }
      
  	//Sessao Neta/Entidade
	  #IFDEF TOP
	   	DEFINE SECTION oSB1 OF oSLO TITLE STR0034 TABLE "SB1" BREAK HEADER LEFT MARGIN 10 //"Movimentação de Manejo de Apartados"	
	  #ELSE
	   	DEFINE SECTION oSB1 OF oSLO TITLE STR0034 TABLE "SLO" BREAK HEADER LEFT MARGIN 10 //"Movimentação de Manejo de Apartados"	
	  #ENDIF		
		//Celulas secao Neta/Entidade	        
  		DEFINE CELL NAME "Produto"			OF oSB1 TITLE STR0035    SIZE 20 BLOCK {|| POSICIONE("SB1",1,XFILIAL("SB1") + (cAlias)->LO_PRODUTO,"B1_COD")}
  		DEFINE CELL NAME "Descricao"		OF oSB1 TITLE STR0036  	 SIZE 30 BLOCK {|| POSICIONE("SB1",1,XFILIAL("SB1") + (cAlias)->LO_PRODUTO,"B1_DESC")}
   		DEFINE CELL NAME "LO_QUANT"			OF oSB1 ALIAS "SLO"
   		DEFINE CELL NAME "LO_UNIT"			OF oSB1 ALIAS "SLO"	  
     	DEFINE CELL NAME "LO_TOTAL"			OF oSB1 ALIAS "SLO" 
     
	//Quebra
	DEFINE BREAK oBreak  OF oSLO WHEN oSLO:Cell("LO_CLIENTE")
	DEFINE BREAK oBreak2 OF oSB1 WHEN oSB1:Cell("Produto")
	
	//Totalizador
	DEFINE FUNCTION FROM oSLO:Cell("Total") 	OF oSLO FUNCTION SUM TITLE STR0037 NO END SECTION BREAK oBreak  //"Total do cliente"		
	DEFINE FUNCTION FROM oSLO:Cell("Saldo")    	OF oSLO FUNCTION SUM TITLE STR0038 NO END SECTION BREAK oBreak  //"Saldo Total"
	DEFINE FUNCTION FROM oSB1:Cell("LO_QUANT")  OF oSB1 FUNCTION SUM TITLE STR0039 NO END SECTION BREAK oBreak  //"Quantidade Total"
 
		
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
	   	cSQL += "LO_FILIAL >= '" + MV_PAR01 + "' AND "
	EndIf

	If !Empty(MV_PAR02)//A Sucursal
		cSQL += "LO_FILIAL <= '" + MV_PAR02 + "' AND "
	EndIf
	
	If !Empty(MV_PAR03) //De Manejo(Lay-Away)
	   	cSQL += "LO_NUMLAY >= '" + MV_PAR03 + "' AND "
	EndIf
    
    If !Empty(MV_PAR04) //A Manejo(Lay-Away)
	   	cSQL += "LO_NUMLAY <= '" + MV_PAR04 + "' AND "
	EndIf
    
    If !Empty(MV_PAR05) //De Cliente
	   	cSQL += "LO_PRODUTO >= '" + MV_PAR05 + "' AND "
	EndIf
    
    If !Empty(MV_PAR06) //A Cliente
	   	cSQL += "LO_PRODUTO <= '" + MV_PAR06 + "' AND "
	EndIf
    
    If !Empty(MV_PAR07) //De Cliente
	   	cSQL += "LO_CLIENTE >= '" + MV_PAR07 + "' AND "
	EndIf
    
    If !Empty(MV_PAR08) //A Cliente
	   	cSQL += "LO_CLIENTE <= '" + MV_PAR08 + "' AND "
	EndIf
    
    
    If !Empty(MV_PAR09) //De Emision
	   	cSQL += "LO_EMISSAO BETWEEN '" + DtoS(mv_par09) + "' AND"
	EndIf
	
	If !Empty(MV_PAR10) //A Emision
	   	cSQL += "'" +DtoS(mv_par10)+ "' AND "
	EndIf
	
	If !Empty(MV_PAR11) //De Entrega
	   	cSQL += "LO_DTENT BETWEEN '"+DtoS(mv_par11)+"' AND "
	EndIf
	
	If !Empty(MV_PAR12) //A Entrega
	   	cSQL += "'" + DtoS(mv_par12) + "' "
	EndIf
	
	If MV_PAR13 == 1  //Estatus
		cSQL += "AND LO_STATUS = '1' " // Aberto 
	ElseIf MV_PAR13 == 2
		cSQL += "AND LO_STATUS = '2' "// Encerrado
	ElseIf MV_PAR13 == 3
		cSQL += "AND LO_STATUS = '4' "  // Anulado
	Endif
	
	If MV_PAR14 > 0 //De Valor
	   	cSQL += "AND LO_TOTAL >= '" + Str(MV_PAR14) + "' "
	EndIf
    
    If MV_PAR15 > 0 //A Valor
	   	cSQL += "AND LO_TOTAL <= '" + Str(MV_PAR15) + "' "
	EndIf
	
	
	cSQL := "%"+cSQL+"%" 
		
		BEGIN REPORT QUERY oSection1
			BeginSql Alias cAlias
				SELECT * FROM %Table:SLO% SLO
				WHERE  
				%Exp:cSQL%
				ORDER BY LO_FILIAL,LO_CLIENTE,LO_NUMLAY,LO_LOJA
			EndSql
		
		END REPORT QUERY oSection1  
	    	    
	    oSection2:SetParentQuery()	
	    oSection2:SetParentFilter({|cLay| (cAlias)->LO_NUMLAY == cLay},{|| (cAlias)->LO_NUMLAY })
	   	oSection1:Print()
 	
#ELSE

 MakeAdvplExpr(cPerg)
	
   dbSelectArea("SLO")
   dbSetOrder(1)
    
    cFiltro :=  "SLO->LO_CLIENTE >= '" + MV_PAR07 + "' .AND. SLO->LO_CLIENTE <= '" + MV_PAR08 + "'"
    cFiltro +=  ".AND. SLO->LO_PRODUTO >= '" + MV_PAR05 + "' .AND. SLO->LO_PRODUTO <= '" + MV_PAR06 + "'"
    
    If MV_PAR13 == 1
		bMais    := { || SLO->LO_STATUS = "1" } 
	ElseIf MV_PAR13 == 2
		bMais    := { || SLO->LO_STATUS = "2" } 
	ElseIf MV_PAR13 == 3
		bMais    := { || SLO->LO_STATUS = "4" }
	ElseIf MV_PAR13 == 4
		bMais    := { || .T. }		 	                                
	EndIf 

    
    SET DELETED OFF
     
   oSection1:SetFilter(cFiltro)
   oSection1:SetLineCondition({|| SLO->LO_FILIAL >= MV_PAR01 .And. SLO->LO_FILIAL <= MV_PAR02 .And. Eval( bMais ) .And. SLO->LO_NUMLAY >= MV_PAR03 .And. SLO->LO_NUMLAY <= MV_PAR04 .And. SLO->LO_PRODUTO >= MV_PAR05 .And. SLO->LO_PRODUTO <= MV_PAR06 .And. SLO->LO_CLIENTE >= MV_PAR07 .AND. SLO->LO_CLIENTE <= MV_PAR08 .And. SLO->LO_EMISSAO >= MV_PAR09 .And. SLO->LO_EMISSAO <= MV_PAR10 .AND. SLO->LO_DTENT >= MV_PAR11 .And. SLO->LO_DTENT <= MV_PAR12 .AND. SLO->LO_TOTAL >= MV_PAR14 .AND. SLO->LO_TOTAL <= MV_PAR15 }) 	
   oSection2:SetRelation({|| xFilial("SLO") + SLO->LO_CLIENTE + SLO->LO_LOJA + SLO->LO_NUMLAY }, "SLO", 2, .T.)
   oSection2:SetParentFilter({|cLay| SLO->LO_NUMLAY == cLay},{|| SLO->LO_NUMLAY })
   oSection2:SetLineCondition({|| Eval( bMais ) })
   oSection1:Print()

   
   SET DELETED ON
   
#ENDIF

Return Nil

  
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Lj800TotC ºAutor  ³Vendas CRM          º Data ³  11/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Totaliza o valor do lay-away                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJR800A                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Lj800TotC(lGravado,cNumLay)

Local nValor	:= 0
Local nX
Local aArea 	:= {}
Local aAreaSLO 	:= {}
Local aTesInf 	:= {}

aArea:= GetArea()

If lGravado
	// Roda o arquivo SLO para totalizar o valor do Lay-Away
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