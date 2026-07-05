/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MATR845.CH"
#Include "FIVEWIN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR845  ³ Autor ³ Gilson Nascimento     ³ Data ³ 07.12.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Carga Acumulativa Analitica                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR845(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Edson   M.  ³19/01/98³XXXXXX³ Inclusao do Campo C2_SLDOP.              ³±±
±±³Edson   M.  ³02/02/98³XXXXXX³ Subst. do Campo C2_SLDOP p/ Funcao.      ³±±
±±³Rodrigo Sart³23/04/98³XXXXXX³ Inclusao de decimal no calculo do %      ³±±
±±³Fernando J. ³07/02/99³META  ³Imprimir OP's Firmes, Previstas ou Ambas. ³±±
±±³Cesar       ³31/03/99³XXXXXX³Manutencao na SetPrint()                  ³±±
±±³Erike Yuri  ³19/07/05³083178³Reescrever rel. usando a tabela SHH(MP811)³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
User Function Matr845()
Local titulo 	:= STR0001	//"Carga Acumulativa - Analitica"
Local cString	:= "SHH"
Local wnrel		:="MATR845"
Local cDesc1 	:= STR0002	//"Este programa ira imprimir Carga Acumulativa Analitica."
Local cDesc2 	:= STR0003	//"Os valores referentes a horas est„o convertidos conforme"
Local cDesc3 	:= STR0004	//"o parƒmetro MV_TPHR, (C)entesimais ou (N)ormais."
Local tamanho	:= "M"
Private aReturn  := {STR0005,1,STR0006, 2, 2, 1, "",1 }	//"Zebrado"###"Administracao"
Private cPerg    :="MTR845"
Private nLastKey := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("MTR845",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        	// Ordem de Producao Inicial                ³
//³ mv_par02        	// Ordem de Producao Final                  ³
//³ mv_par03        	// Centro de Trabalho Inicial               ³
//³ mv_par04        	// Centro de Trabalho Final                 ³
//³ mv_par05         // Impr. OP's Firmes, Previstas ou Ambas    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ChkFile("SHH",.F.)
	Help(" ",1,"SH8EmUso") //BY ERIKE VERIFICAR O HELP CORRETO PARA SHH
	Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey = 27
	dbSelectArea("SHH")
	Set Filter To
	dbCloseArea()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Retira o SHH da variavel cFopened ref. a abertura no MNU     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ClosFile("SHH")
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	dbSelectArea("SHH")
	Set Filter To
	dbCloseArea()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Retira o SHH da variavel cFopened ref. a abertura no MNU     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ClosFile("SHH")
	Return
Endif

RptStatus({|lEnd| R845Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R845Imp  ³ Autor ³ Waldemiro L. Lustosa  ³ Data ³ 13.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR845			                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R845Imp(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cbTxt, cCTrab
Local CbCont,cabec1,cabec2
Local nomeprog  := "MATR845"
Local cTipoHora := GetMV("MV_TPHR")
Local cIndSHH 	:= CriaTrab(NIL,.F.)
Local cCondSHH	:= ""
Local cOper		:= ""
Local cOPAnt	:= ""
Local nHH_USO 	:= 0
Local lPrintRpe := .F.
Private li := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
m_pag    := 1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cabec1 := ""
cabec2 := ""

dbSelectArea("SHH")
dbSetOrder(1)
cKeySHH 	:= "HH_FILIAL+HH_CTRAB+HH_OP+HH_OPER"
cCondSHH 	:= 'HH_FILIAL == "'+xFilial("SHH")+'"' 
cCondSHH	+= ' .And. HH_OP >= "'+mv_par01+'"'
cCondSHH	+= ' .And. HH_OP <= "'+mv_par02+'"'
cCondSHH	+= ' .And. HH_CTRAB >= "'+mv_par03+'"'
cCondSHH	+= ' .And. HH_CTRAB <= "'+mv_par04+'"'
IndRegua("SHH",cIndSHH,cKeySHH,,cCondSHH,STR0007) //"Selecionando Registros..."
SHH->(DbGoTop())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica qual ordem foi selecionada                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo += ""
cabec1 := STR0008  
cabec2 := STR0009  
// "ORDEM         ALO CODIGO          DESCRICAO        QUANTIDADE   OPERACAO HRS."
// "PRODUCAO      CM  PRODUTO         PRODUTO                                UTILIZ."	 
//            1         2         3         4         5         6         7         8
//  012345678901234567890123456789012345678901234567890123456789012345678901234567890 
SetRegua(LastRec())

While SHH->(!Eof())
	
	IF lEnd
		@ Prow()+1,001 PSay STR0010	//"CANCELADO PELO OPERADOR"
		Exit
	EndIF

	// Posiciona arquivo de Centro de Trabalho
	lPrintRpe := .T.
	dbSelectArea("SHB")
	dbSetOrder(1)
	dbSeek(cFilial+SHH->HH_CTRAB)
	
	dbSelectArea("SHH")
	
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
	li++
	@ li,00 PSay STR0011+SHH->HH_CTRAB+"-"+Subs(SHB->HB_NOME,1,25)	//"Centro de Trabalho: "
	@ li,58 PSay STR0012	//"Hr.Utiliz.: "
	TransHora("SHB->HB_USO",cTipoHora,70)
	li++
	@ li,00 PSay STR0013	//"Hr.Uteis          : "
	TransHora("SHB->HB_UTEIS",cTipoHora,20)
	@ li,58 PSay STR0014+Transform(((SHB->HB_USO/SHB->HB_UTEIS)*100),"@E 999.99")+" %"	//"Utilizacao: "
	li+=2
	
	cCTrab := SHH->HH_CTRAB
	
	While SHH->(!Eof() .And. HH_CTRAB == cCTrab)

		IncRegua()

		// Posiciona arquivo de Ordens de Producao
		dbSelectArea("SC2")
		dbSetOrder(1)
		dbSeek(cFilial+SHH->HH_OP)
		
		//-- Valida se a OP deve ser Impressa ou n„o
		If !MtrAValOP(mv_par05, 'SC2')
			SHH->(dbSkip())
			Loop
		EndIf
		
     	IF mv_par06 == 2
	    	IF !empty(dtos(SC2->C2_DATRF))  
               SHH->(dbSkip())
     	       LOOP
         	EndIf
        EndIf
		
		// Posiciona arquivo de produtos
		dbSelectArea("SB1")
		dbSetOrder(1)
		dbSeek(cFilial+SC2->C2_PRODUTO)
		
		// Posiciona arquivo de Centro de Trabalho
		dbSelectArea("SHB")
		dbSetOrder(1)
		dbSeek(cFilial+SHH->HH_CTRAB)	
		IF li > 60
			Li := 0
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
			li++
			@ li,00 PSay STR0011+SHH->HH_CTRAB+"-"+Subs(SHB->HB_NOME,1,25)	//"Centro de Trabalho: "
			@ li,58 PSay STR0012	//"Hr.Utiliz.: "
			TransHora("SHB->HB_USO",cTipoHora,70)
			li++
			@ li,00 PSay STR0013	//"Hr.Uteis          : "
			TransHora("SHB->HB_UTEIS",cTipoHora,20)
			@ li,58 PSay STR0014+Transform(((SHB->HB_USO/SHB->HB_UTEIS)*100),"@E 999.99")+" %"	//"Utilizacao: "
			li+=2
		EndIF
		//Inicia variavel de aglutinacao                         
		cOPAnt := SHH->HH_OP
		cOper  := SHH->HH_OPER
		nHH_USO:= 0                	                                  
		dbSelectArea("SHH")
		SHH->(DbSetOrder())
		While SHH->(!Eof() .AND. HH_CTRAB+HH_OP+HH_OPER==cCTrab+cOPAnt+cOper) 
	    	nHH_USO += SHH->HH_USO
			SHH->(DbSkip())		
		EndDo
		//Volta para o registro anterior 
		SHH->(DbSkip(-1))
		// "ORDEM         ALO CODIGO          DESCRICAO        QUANTIDADE   OPERACAO HRS."
		// "PRODUCAO      CM  PRODUTO         PRODUTO                                UTILIZ."	 
        //            1         2         3         4         5         6         7         8
        //  012345678901234567890123456789012345678901234567890123456789012345678901234567890 
        //  123456 12 123 123 123456789012345 123456789012345 123456789012     123  123456789
		@ li,00 PSay Subs(SHH->HH_OP,1,6)+" "+Subs(SHH->HH_OP,7,2)+" "+Subs(SHH->HH_OP,9,3)
		// Pesquisa se OP + Operacao foi alocada
		SH8->(DbsetOrder(1))
		If SH8->(DbSeek(xFilial("SH8")+SC2->C2_NUM+SC2->C2_ITEM+SC2->C2_SEQUEN+SC2->C2_ITEMGRD+SHH->HH_OPER))
			@ li,14 PSay OemToAnsi(STR0015) 
		Else
			@ li,14 PSay OemToAnsi(STR0016) 
		EndIf
		@ li,18 PSay SC2->C2_PRODUTO
		@ li,54 PSay Subs(SB1->B1_DESC,1,15)
		@ li,70 PSay (aSC2Sld()) Picture PesqPictQt("C2_QUANT",12)
		@ li,87 PSay SHH->HH_OPER
		If cTipoHora=="C"
			@ li,92 PSay nHH_USO Picture PesqPictQT("HH_USO",9)
		Else                       
			@ li,92 PSay FloatToHora(nHH_USO) 
		EndIf
		li++
		// Retorna ao arquivo Principal.
		SHH->(dbSkip())
	EndDo
EndDO

If (li < 60) .And. lPrintRpe
	roda(cbcont,cbtxt,tamanho)
Endif

dbSelectArea("SHH")
RetIndex("SHH")
Ferase(cIndSHH+OrdBagExt())

dbCloseArea()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retira o SHH da variavel cFopened ref. a abertura no MNU     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ClosFile("SHH")
dbSelectArea("SC2")

If aReturn[5] = 1
	Set Printer TO
	dbCommitall()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return NIL
