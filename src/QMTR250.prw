/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QMTR250.CH"


#DEFINE ETIQ_TIPO_PEQUENA 1
#DEFINE ETIQ_TIPO_GRANDE  2

#DEFINE DEPTO	 1
#DEFINE DATA    2
#DEFINE VALDATA 3
#DEFINE INSTR	 4

#DEFINE FORMATO_SEMANA 2

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ QMTR250	³ Autor ³ Antonio Aurelio       ³ Data ³ 14.12.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Etiqueta de Rastreabilidade            					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_QMTR250(cProg)                                			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGAQMT  												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ STR		 ³ Ultimo utilizado: 0011                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function QMTR250()

Local cAlias      := Alias()
Local nOldOrder   := IndexOrd()
Local nRecNo      := RecNo()
Local  cPerg      := "QMR250"
Local cTamanho    := "P"

Private wnrel    := "QMTR250"
Private cString  := "QM2"
Private cDesc1   := STR0001 //"SerÆo impressas as etiquetas para instrumentos. "
Private cDesc2   := STR0002 //" "
Private cDesc3   := ""
Private cTitulo  := STR0003  // "Etiqueta para instrumentos"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas pela fun‡„o SetDefault    ³
//³  e SetPrint                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private  aReturn  := {STR0004, 1,STR0005,  2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
Private  nLastKey := 0 
Private  nLimite  := 80

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros								³
//³ mv_par01				// Instrumento Inicial						³
//³ mv_par02				// Instrumento Final 						³
//³ mv_par03				// Periodo Inicial							³
//³ mv_par04				// Periodo Final							³
//³ mv_par05				// Departamento Inicial						³
//³ mv_par06				// Departamento Final						³
//³ mv_par07				// Orgao Calibrador Todos/Interno/Externo   ³
//³ mv_par08				// Org.Calib.Intr.Inicial					³
//³ mv_par09				// Org.Calib.Intr.Final						³
//³ mv_par10				// Org.Calib.Extr.Inicial					³
//³ mv_par11				// Org.Calib.Extr.Final						³
//³ mv_par12				// Familia Inicial                          ³
//³ mv_par13				// Familia Final							³
//³ mv_par14				// Fabricante Inicial						³
//³ mv_par15				// Fabricante Final							³
//³ mv_par16				// Status de								³
//³ mv_par17                // Status ate								³
//³ mv_par18				// Usu rio Inicial							³
//³ mv_par19				// Usu rio Final							³
//³ mv_par20				// Tipo de Etiqueta							³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT 						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,"",,cTamanho)
// ,"",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se apertou o botao cancela ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLastKey == 27
	Return
EndIf
	
SetDefault(aReturn,cString)

If nLastKey == 27
	Return .F.
EndIf

RptStatus({|| A250Imp() },cTitulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura o DBF anterior             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAlias)
dbSetOrder(nOldOrder)
dbGoto(nRecNo)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ A250Imp  ³ Autor ³ Antonio Aurelio       ³ Data ³ 04.05.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime as Etiquetas dos Produtos da Entrega               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±± 
±±³			 ³	wnRel - Usada na funcao OurSpool						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ QMTR250                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function A250Imp()

Local   nOrdQM2     := QM2->(IndexOrd())
Local   nOrdQM6     := QM6->(IndexOrd())
Local   nItem       := 0
Local   nCol        := 0
Local   cInstr      := ""
Local   cValData    := ""
Local   cData       := ""
Local   lImpPar     := .T.
Local   aInstr      := {}
Local   nIndex

Private cIndex		:= ""
Private nLin        := 80
Private	TRB_FILIAL
Private	TRB_INSTR	
Private	TRB_REVINS	
Private	TRB_VALDAF	
Private	TRB_DEPTO	
Private	TRB_TIPO	
Private	TRB_FABR	
Private	TRB_STATUS	
Private	TRB_RESP	
Private	TRB_USOINI	
lAbortPrint := .F.

QM2->(dbSetOrder(1)) // Instrumento + RevisÆo Invertida
QM6->(dbSetOrder(2)) // Instrumento + RevisÆo Invertida + Data Invertida

SetRegua(QM2->(RecCount()))

cChave := "QM2_FILIAL+QM2_INSTR+QM2_REVINV"
cQuery := "SELECT QM2_FILIAL,QM2_INSTR,QM2_REVINS,QM2_REVINV,QM2_VALDAF,"
cQuery += "QM2_DEPTO,QM2_RESP,QM2_TIPO,QM2_FABR,QM2_STATUS,QM2_USOINI "
cQuery += "FROM "+RetSqlName("QM2")+" QM2 "					
cQuery += "WHERE "
cQuery += "QM2.QM2_FILIAL = '"			+xFilial("QM2")+	"' AND "
cQuery += "QM2.QM2_INSTR  BetWeen '"	+ mv_par01 +		"' AND '" + mv_par02 +			"' AND " 
cQuery += "QM2.QM2_VALDAF BetWeen '"	+ Dtos(mv_par03)+	"' AND '" + DtoS(mv_par04) +	"' AND "
cQuery += "QM2.QM2_DEPTO BetWeen '"		+ mv_par05 +		"' AND '" + mv_par06 + 			"' AND " 
cQuery += "QM2.QM2_TIPO BetWeen '"		+ mv_par12 +		"' AND '" + mv_par13 + 			"' AND " 
cQuery += "QM2.QM2_FABR BetWeen '"		+ mv_par14 +		"' AND '" + mv_par15 + 			"' AND " 
cQuery += "QM2.QM2_STATUS BetWeen '"	+ mv_par16 +		"' AND '" + mv_par17 + 			"' AND " 
cQuery += "QM2.QM2_RESP BetWeen '"		+ mv_par18 +		"' AND '" + mv_par19 + 			"' AND " 
cQuery += "QM2.D_E_L_E_T_= ' ' "
cQuery += "ORDER BY " + SqlOrder(cChave)
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
TcSetField("TRB","QM2_VALDAF","D",8,0)
TcSetField("TRB","QM2_USOINI","D",8,0)
dbSelectArea( "TRB" )


While !Eof()
	
	cAlias		:= "TRB"
	TRB_FILIAL	:= TRB->QM2_FILIAL
	TRB_INSTR	:= TRB->QM2_INSTR
	TRB_REVINS	:= TRB->QM2_REVINS
	TRB_VALDAF	:= TRB->QM2_VALDAF
	TRB_DEPTO	:= TRB->QM2_DEPTO
	TRB_TIPO	:= TRB->QM2_TIPO
	TRB_FABR	:= TRB->QM2_FABR
	TRB_STATUS	:= TRB->QM2_STATUS
	TRB_RESP	:= TRB->QM2_RESP
	TRB_USOINI	:= TRB->QM2_USOINI

	IncRegua()
	
	If lAbortPrint
		If nLin <> 80
			nLin := nLin + 1
   	   @nLin,001 PSAY STR0007  //"CANCELADO PELO OPERADOR"
		EndIf
		Exit
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pula as revisoes anteriores do mesmo instrumento             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB_FILIAL+TRB_INSTR == cInstr
		dbSkip()
		Loop 
	EndIf
	cInstr := TRB_FILIAL+TRB_INSTR

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica se status do instrumento esta ativo                    ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !QMTXSTAT(TRB_STATUS)
		dbskip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno e externo                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 1 // Todos
		If !Calibrador(0,mv_par08,mv_par09,mv_par10,mv_par11,TRB_INSTR,TRB_REVINS)
			dbSkip()
			Loop
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. interno                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 2 // Interno
		If !Calibrador(1,mv_par08,mv_par09,,,TRB_INSTR,TRB_REVINS)
			dbSkip()
			Loop
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico O.C. externo                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par07 == 3 // Externo
		If !Calibrador(2,,,mv_par10,mv_par11,TRB_INSTR,TRB_REVINS)
			dbSkip()
			Loop
		EndIf
	EndIf

	
	QM6->(dbSeek(xFilial("QM6")+TRB_INSTR+TRB_REVINS))
	
	cValData := "  /  /  "
	cData		:= "  /  /  "	
	If QM6->(Found())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ A data de validade da calibra‡Æo tem que ser a mesma.           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If QM6->QM6_VALDAF == TRB_VALDAF
			cValData := IIf(mv_par21==FORMATO_SEMANA ,RetSem(QM6->QM6_VALDAF),;
																  DtoC(QM6->QM6_VALDAF) )
			cData		:= IIf(mv_par21==FORMATO_SEMANA ,RetSem(QM6->QM6_DATA),;
																	DtoC(QM6->QM6_DATA) )
		Else
			cValData := IIf(mv_par21==FORMATO_SEMANA, RetSem(TRB_VALDAF), ;
																	DtoC(TRB_VALDAF) )
			cData		:= IIf(mv_par21==FORMATO_SEMANA, RetSem(TRB_USOINI), ;
																	DtoC(TRB_VALDAF) )
		EndIf
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se nao ocorreu calibracao ‚ utilizado USOINI COMO DATA.         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cValData := IIf(mv_par21==FORMATO_SEMANA, RetSem(TRB_VALDAF), ;
															   DtoC(TRB_VALDAF) )
		cData		:= IIf(mv_par21==FORMATO_SEMANA, RetSem(TRB_USOINI), ;
															   DtoC(TRB_USOINI) )
	EndIf
	
	aAdd(aInstr,{TRB_DEPTO, cData, cValData , TRB_INSTR})
	
	dbSelectArea("TRB")   
	cAlias := "TRB"
	dbSkip()
	
	If Len(aInstr) == 2 .Or. &(cAlias)->(Eof())
	For nItem := 1  To Len(aInstr)
		
		If nLin > 55
			@00,00 PSAY AvalImp(nLimite)
			nLin := -1 // vai para zero...
			nCol := 00
		Else
			nCol := 00
		EndIf
			
		If mv_par20 == ETIQ_TIPO_PEQUENA
			nlin := nlin+1
			@nLin,nCol    PSAY Padr(aInstr[nItem,DEPTO],16)
            If Len(aInstr) > nItem  // ...For‡o a impressÆo da pr¢x. etiqueta...
				@nLin,nCol+36 PSAY Padr(aInstr[nItem+1,DEPTO],16)
            EndIf
			nCol := 0
		EndIf
		
		nlin := nlin+1
		@nLin,nCol    PSAY STR0010+" "+Padr(aInstr[nItem,DATA],16) // AFERIDO:
		
		If Len(aInstr) > nItem
			@nLin,nCol+36 PSAY STR0010+" "+Padr(aInstr[nItem+1,DATA],16)
		EndIf
		
		nlin := nlin+1
		@nLin,00 PSAY STR0011+" "+Padr(aInstr[nItem,VALDATA],16) // PROX.AF:
		
		If Len(aInstr)> nItem
			@nLin,36 PSAY STR0011+" "+Padr(aInstr[nItem+1,VALDATA],16)
		EndIf
		nlin := nlin+1
		@nLin,00 PSAY Padr(aInstr[nItem,INSTR],16)
		
		If Len(aInstr)>nItem
			@nLin,36 PSAY Padr(aInstr[nItem+1,INSTR],16)
		EndIf
		
		nlin := nlin+1
		@nLin,00 PSAY STR0012  // Ass.
		@nLin,36 PSAY STR0012
        nlin ++
		nItem:= nItem+1
	Next

	If mv_par20 == ETIQ_TIPO_GRANDE
		IIF(lImpPar,NIL,(nLin:=nlin+1))
	Else
		IIf(lImpPar,(nLin:=nlin+2),(nLin:=nlin+3))
	EndIf 
	lImpPar := !lImpPar

	aInstr := {}
	EndIf

EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso algum tenha ficado pendente...  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aInstr) == 1 
	
	If nLin > 55
		@00,00 PSAY AvalImp(nLimite)
		nLin := -1 // vai para zero...
		nCol := 00
	Else
		nCol := 00
	EndIf
			
	If mv_par20 == ETIQ_TIPO_PEQUENA
		nlin := nlin+1
		@nLin,nCol    PSAY Padr(aInstr[1,DEPTO],16)
	EndIf
	
	nlin := nlin+1
	@nLin,nCol    PSAY STR0010+" "+Padr(aInstr[1,DATA],16) // AFERIDO:
	
	nlin := nlin+1
	@nLin,00 PSAY STR0011+" "+Padr(aInstr[1,VALDATA],16) // PROX.AF:
	
	nlin := nlin+1
	@nLin,00 PSAY Padr(aInstr[1,INSTR],16)
	
	nlin := nlin+1
	@nLin,00 PSAY STR0012  // Ass.
EndIf

Set Device To Screen

dbSelectArea("TRB")
dbCloseArea()
dbSelectArea("QM2")
dbSetOrder(1)		

If aReturn[5] == 1
	Set Printer To
	If nLin <> 80
		Ourspool(wnrel)
	Else
		MsgStop(OemToAnsi(STR0041), cTitulo)  // "NÆo foram encontrados dados que atendam os crit‚rios pedidos"
	EndIf
EndIf

MS_FLUSH()

QM2->(dbSetOrder(nOrdQM2))
QM6->(dbSetOrder(nOrdQM6))

Return(.T.)
