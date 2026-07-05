/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "LOJR090.CH"
#INCLUDE "PROTHEUS.CH"

Static cNomArq 		:= "TRB"	//Nome da Tabela
Static oTabTemp		:= Nil		//Objeto tabela temporaria 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ LojR090	³ Autor ³ Raul Capeleti 		  ³ Data ³ 04.01.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Mapa Demostrativo de Valores Realizados e a Realizar		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_LojR090(void)															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nao tem																	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LojR090()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cDesc1 := STR0001  // Imprime o Demonstrativo dos valores a Realizar e dos valores Realiza-
LOCAL cDesc2 := STR0002  // dos de um determinado Mes, por Natureza
LOCAL cDesc3 := ""

PRIVATE nDecs := MsDecimais(1)

PRIVATE cString:="SE1"
PRIVATE tamanho:="M"
PRIVATE wnrel
PRIVATE titulo  := STR0003  // Valores Realizados do Mes
// Zebrado / Administracao
PRIVATE aReturn := { STR0004 , 1, STR0005, 1, 2, 1, "",1 }
PRIVATE nomeprog:="LOJR090"
PRIVATE nLastKey := 0
PRIVATE cPerg	 :="LJR090"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("LJR090",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros				 ³
//³ mv_par01	  //	Mes e Ano de Refer.				 ³
//³ mv_par02	  //	Da Natureza 						 ³
//³ mv_par03	  //	Ate' a Natureza                ³
//³ mv_par04	  //	Carteira 							 ³
//³ mv_par05	  //	Regime de Caixa ou Competencia ³
//³ mv_par06	  //	Original / Efetivo				 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "LOJR090"

// Codigo / Descricao
aOrd	:= {STR0006, STR0007}
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If  nLastKey = 27
	Return
Endif

RptStatus({|lEnd| U_LJR090Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ LjR090Imp³ Autor ³ Mario Angelo			  ³ Data ³ 08.05.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao Mapa Demostrativo Valores Realizados /a Realizar ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Sigaloja 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LJR090Imp(lEnd,wnrel,cString)
LOCAL i, Cbtxt
LOCAL cabec1 := Replicate(" ", 160 )
LOCAL cabec2 := Replicate(" ", 160 )
LOCAL cArqTrab := ""
LOCAL nOrdem :=0
LOCAL aCampos:={}
LOCAL aIndexKey := {}
PRIVATE nVlrTotal,nVlrReal,nAtot1,nAtot2,aValr:={}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Cbtxt 	:= ""
cbcont	:= 0
li 		:= 80
m_pag 	:= 1
// Valores Realizados do Mes :-
//  - Contas a Receber -
//  - Contas a Pagar -
//  - Ambas -
//  Bruto
//  Liquido
titulo  := STR0008 + mv_par01+If(mv_par04 == 1,STR0009,If(mv_par04 == 2,STR0010,STR0011))+If(mv_par06 == 1,STR0012,STR0013)

nOrdem := aReturn[8]

aCampos:={ {"DATA1" ,"D",8 ,0},;
			  {"CODIG" ,"C",10,0},;
			  {"DESCR" ,"C",30,0},; 
			  {"VALOR1","N",17,2},;
			  {"CARTEI","C", 2,0}}

If nOrdem = 2
	aIndexKey := {"DESCR+DATA1+CARTEI"}
Else
	aIndexKey := {"CODIG+DATA1+CARTEI"}
End

oTabTemp := LjCrTmpTbl(cNomArq, aCampos, aIndexKey)
dbSelectArea(cNomArq)
(cNomArq)->(dbGoTop())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Invoca as Funcoes p/ Ler reg.de Pagto ou Recbt³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par04 == 1
	LerReceber()
Elseif mv_par04 == 2
	LerPagar()
Elseif mv_par04 == 3
	LerReceber()
	LerPagar()
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao para ler os registros de Baixa³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LerBaixas()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera a matriz com os valores do relatorio	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cNomArq)
(cNomArq)->(dbGotop())

SetRegua((cNomArq)->(RecCount()))

nVlrTotal := 0
nVlrReal  := 0

nAtot1:=nAtot2:=0

If nOrdem == 2
	While !Eof()
		cDes1 := DESCR
		cDes	:= DESCR
		cCod	:= CODIG
		For i = 1 To 31
			nDia := Day( Data1 ) 		
			While Day( Data1 ) == nDia .and. DESCR == cDes .and. Day( Data1 ) == i .and. !Eof()
				
					 //Incrementa Regua
					 IncRegua()
					 
					 If CARTEI $ "P1-R3"
					nVlrTotal += VALOR1
				Else
					nVlrReal += VALOR1
				End
				dbSkip( )
			End
			Aadd( aValR, { CtoD( StrZero( i,2 ) + "/" + Substr(mv_par01,1,2) + "/" + Right(StrZero(Year(dDataBase),4),2),"ddmmyy"),;
					  nVlrTotal ,;
					  If((nVlrTotal - nVlrReal) > 0,(nVlrTotal - nVlrReal),0 ),;
					  nVlrReal	,;
					  If(  ((nVlrReal/nVlrTotal)*100) > 100, 100 ,((nVlrReal/nVlrTotal)*100)) } )
			nAtot1+=nVlrTotal
			nAtot2+=nVlrReal
			nVlrTotal := 0
			nVlrReal  := 0
		Next
		If li > 50
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
				@ li,00 PSay replicate("*",132)
		End 
		Imprime(aValR,nAtot1,nAtot2,cCod,cDes1)	//Funcao para a impressao
		nAtot1:=nAtot2:=0
		aValr := {}
	End		
Else
	While !Eof()
		cDes1 := DESCR
		cDes	:= DESCR
		cCod	:= CODIG
		For i = 1 To 31
			nDia := Day( Data1 ) 		
			While Day( Data1 ) == nDia .and. CODIG == cCod .and. Day( Data1 ) == i .and. !Eof()
					  //Incrementa Regua
					  IncRegua()
					  
				If CARTEI $ "P1-R3"
					nVlrTotal += VALOR1
				Else
					nVlrReal += VALOR1
				End

				dbSkip( )
			End
			Aadd( aValR, { CtoD( StrZero( i,2 ) + "/" + Substr(mv_par01,1,2) + "/" + Substr(mv_par01,4,4),"ddmmyy"),;
				  nVlrTotal ,;
				  If((nVlrTotal - nVlrReal) > 0,(nVlrTotal - nVlrReal),0 ),;
				  nVlrReal	,;
				  If(  ((nVlrReal/nVlrTotal)*100) > 100, 100 ,((nVlrReal/nVlrTotal)*100)) } )
			nAtot1+=nVlrTotal
			nAtot2+=nVlrReal
			nVlrTotal := 0
			nVlrReal  := 0
		Next
		If li > 50
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
				@ li,00 PSay replicate("*",132)
		End 
		Imprime(aValR,nAtot1,nAtot2,cCod,cDes1)	//Funcao para a impressao
		nAtot1:=nAtot2:=0
		aValr := {}
	End		
End

dbSelectArea(cNomArq)
(cNomArq)->(DbCloseArea())

//Elimina arquivos de trabalho
If oTabTemp <> NIL
	oTabTemp:Delete()
	oTabTemp := NIL
EndIf

dbSelectArea( "SE1" )
dbSetOrder( 1 )		//E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO

dbSelectArea( "SE2" )
dbSetOrder( 1 )		//E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA

dbSelectArea( "SE5" )
dbSetOrder( 1 )		//E5_FILIAL+DTOS(E5_DATA)+E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ

Set Device To Screen
Set Filter To

If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
Endif
MS_FLUSH()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³LerReceber³ Autor ³ Marcelo Kotaki   	    ³ Data ³ 14/02/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gravar no arquivo de trabalho os registros que atendam a	  ³±±
±±³			 ³condicao de selecao  do arquivo de Contas a Receber 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³LerReceber() 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum 													  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³SIGALOJA       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista  ³ Data/Bops/Ver ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo K.³14/02/05³710   ³-Revisao do fonte para compatibilizacao com ³±±
±±³          ³        ³      ³o KRMS. Motivo BOPS 	                      ³±±
±±³          ³        ³      ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LerReceber()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia leitura dos registros do Contas a Receber posicionando no primeiro registro	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectarea("SE1")
DbSetOrder(3)		//E1_FILIAL+E1_NATUREZ+E1_NOMCLI+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
DbSeek( xFilial("SE1") + mv_par02, .T. )

SetRegua(RecCount())

While !Eof() .AND. SE1->E1_FILIAL == xFilial("SE1")

	//Incrementa Regua
	IncRegua()
	
	If  (Month(E1_VENCREA) == Val(Substr(mv_par01,1,2))) .AND. ;
		(Year(E1_VENCREA) == Year(dDataBase))
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se as condicoes serao satisfeitas	  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (E1_NATUREZ < mv_par02) .OR. (E1_NATUREZ > mv_par03)
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona no registro da Natureza ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("SED")
		DbSetorder(1)		//ED_FILIAL+ED_CODIGO
		If DbSeek( xFilial("SED") + SE1->E1_NATUREZ )

			GravaTrab(	SE1->E1_NATUREZ,SE1->E1_VENCREA,;
						Round(xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA, 1,SE1->E1_EMISSAO,nDecs+1),nDecs),"R3",SED->ED_DESCRIC )
		Endif				
	Endif
	
	DbSelectArea("SE1")
	DbSkip()
End

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³LerPagar	³ Autor ³ Raul C. Capeleti 	  ³ Data ³ 05.12.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gravar no arquivo de trabalho os registros que atendam a	  ³±±
±±³			 ³condicao de selecao do arquivo de Contas a Pagar 			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³LerPagar()																  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum 																	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Lojr090.prg 															  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function LerPagar()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia leitura dos registros de Pagto 		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectarea("SE2")
dbSetOrder(2)		//E2_FILIAL+E2_NATUREZ+E2_NOMFOR+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona no primeiro registro	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSeek( xFilial("SE2") + mv_par02, .T. )

SetRegua(RecCount())

While !Eof() .And. xFilial("SE2") == SE2->E2_FILIAL
	
	// Incrementa Regua
	IncRegua()
	
	If  (Month(E2_VENCREA) == Val(Substr(mv_par01,1,2))) .and.	(Year(E2_VENCREA) == Year(dDataBase))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se as condicoes serao satisfeitas	  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If E2_NATUREZ < mv_par02 .or. E2_NATUREZ > mv_par03
			dbSkip( )
			Loop
		End
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona no registro da Natureza ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SED")
		dbSeek( xFilial("SED") + SE2->E2_NATUREZ )
		
		GravaTrab(SE2->E2_NATUREZ,SE2->E2_VENCREA,;
		Round(xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA, 1,SE2->E2_EMISSAO,nDecs+1),nDecs),;
		"P1",SED->ED_DESCRIC)
		
	End
	
	dbSelectArea("SE2")
	dbSkip()
	
End

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³LerBaixas ³ Autor ³ Raul C. Capeleti 	  ³ Data ³ 05.12.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gravar no arquivo de trabalho os registros que atendam a	  ³±±
±±³			 ³condicao de selecao do arquivo de baixas						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³LerBaixas()																  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum 																	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³Lojr090.prg																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function LerBaixas()
Local nRec := 0
LOCAL nVlrLiq,cNumero,cNature,dData,cParcela,cPrefixo,cTipo
LOCAL nSe5Valor, nMoeda
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia leitura dos registros de Pagto ou Recbt³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectarea("SE5")
dbSetOrder(4)		//E5_FILIAL+E5_NATUREZ+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+DTOS(E5_DTDIGIT)+E5_RECPAG+E5_CLIFOR+E5_LOJA

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona no primeiro registro	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSeek( xFilial("SE5") + mv_par02, .T. )
SetRegua(RecCount())

While !Eof( ) .and. E5_FILIAL == xFilial("SE5")
	
	// Incrementa Regua
	IncRegua()
	
	If Empty( E5_NATUREZ )
		dbSkip( )
		Loop
	End
	
	If (Month(E5_DATA) == Val(Substr(mv_par01,1,2))) .and.  (Year(E5_DATA) == Year(dDataBase))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se as condicoes serao satisfeitas	  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If E5_NATUREZ < mv_par02 .or. E5_NATUREZ > mv_par03
			dbSkip( )
			Loop
		End
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona no registro da Natureza ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SED")
		dbSeek( xFilial("SED") + SE5->E5_NATUREZ )
		dbSelectarea("SE5")
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Se Considera Contas a Receber.	  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (mv_par04==1 .or. mv_par04 == 3) .and. SE5->E5_RECPAG == "R"
			If mv_par05 == 1
				If mv_par06 == 2
					If E5_TIPODOC $ ("VL^BA/LJ")  .or. Empty( E5_NUMERO )
						If cPaisLoc != "BRA"
							SA6->( DbSetOrder(1))		//A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
							SA6->( DbSeek( xFilial("SA6") + SE5->E5_BANCO + SE5->E5_AGENCIA+ SE5->E5_CONTA ) )
							nMoeda	:= Max( SA6->A6_MOEDA, 1 )
							nSe5Valor:= Round(xMoeda(SE5->E5_VALOR,nMoeda,1,SE5->E5_DATA,nDecs+1),nDecs)
						Else
							nSe5Valor := E5_VALOR
						EndIf
						GravaTrab(SE5->E5_NATUREZ, SE5->E5_DATA, nSe5Valor, "R4", SED->ED_DESCRIC)
					End
				Else
					nVlrLiq:=0
					cNumero:=E5_NUMERO
					cNature:=E5_NATUREZ
					dData  :=E5_DATA
					cParcela:=E5_PARCELA
					cPrefixo:=E5_PREFIXO
					Do While E5_FILIAL==xFilial("SE5") .and. E5_NUMERO == cNumero .and. ! Eof()
						If cPaisLoc != "BRA"
							SA6->( DbSetOrder(1))		//A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
							SA6->( DbSeek( xFilial("SA6") + SE5->E5_BANCO + SE5->E5_AGENCIA+ SE5->E5_CONTA ) )
							nMoeda	:= Max( SA6->A6_MOEDA, 1 )
							nSe5Valor:= Round(xMoeda(SE5->E5_VALOR,nMoeda,1,SE5->E5_DATA,nDecs+1),nDecs)
						Else
							nSe5Valor := E5_VALOR
						EndIf
						
						If E5_TIPODOC $ "JRüMTüCMüJ2üM2üC2"
							nVlrLiq-=nSe5Valor
						Elseif E5_TIPODOC $ "VLüV2üDCüD2/LJ/BA"
							nVlrLiq+=nSe5Valor
						End
						nRec := RecNo( )
						dbSkip( )
					End
					GravaTrab(cNature, dData, nVlrLiq, "R4", SED->ED_DESCRIC)
					SE5 -> ( dbGoTo( nRec ) )
				End
			Else
				dbSelectArea("SE1")
				dbSetOrder(1)		//E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
				If dbSeek( xFilial("SE1") + SE5->E5_PREFIXO + SE5->E5_NUMERO + SE5->E5_PARCELA + SE5->E5_TIPO )
					
					dbSelectArea("SE5")
					If mv_par06 == 2
						If E5_TIPODOC $ ("VL/LJ/BA") .or. Empty( E5_NUMERO )
							If cPaisLoc != "BRA"
								SA6->( DbSetOrder(1))		//A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
								SA6->( DbSeek( xFilial("SA6") + SE5->E5_BANCO + SE5->E5_AGENCIA+ SE5->E5_CONTA ) )
								nMoeda	:= Max( SA6->A6_MOEDA, 1 )
								nSe5Valor:= Round(xMoeda(SE5->E5_VALOR,nMoeda,1,SE5->E5_DATA,nDecs+1),nDecs)
							Else
								nSe5Valor := E5_VALOR
							EndIf
							GravaTrab(SE5->E5_NATUREZ, SE1->E1_VENCREA, nSe5Valor, "R4", SED->ED_DESCRIC)
						End
					Else
						nVlrLiq:=0
						cNumero:=E5_NUMERO
						cNature:=E5_NATUREZ
						dData  :=E5_DATA
						cParcela:=E5_PARCELA
						cPrefixo:=E5_PREFIXO
						cTipo   :=E5_TIPO
						DO While E5_NUMERO == cNumero .and. E5_PARCELA==cParcela .and. E5_PREFIXO == cPrefixo .and. E5_TIPO == cTipo .and. ! Eof() .And. xFilial("SE5") == E5_FILIAL
							If cPaisLoc != "BRA"
								SA6->( DbSetOrder(1))		//A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
								SA6->( DbSeek( xFilial("SA6") + SE5->E5_BANCO + SE5->E5_AGENCIA+ SE5->E5_CONTA ) )
								nMoeda	:= Max( SA6->A6_MOEDA, 1 )
								nSe5Valor:= Round(xMoeda(SE5->E5_VALOR,nMoeda,1,SE5->E5_DATA,nDecs+1),nDecs)
							Else
								nSe5Valor := E5_VALOR
							EndIf
							If E5_TIPODOC $ "JRüMTüCM"
								nVlrLiq-=nSe5Valor
							Elseif E5_TIPODOC $ "VLüDC/LJ/BA"
								nVlrLiq+=nSe5Valor
							End
							nRec := RecNo( )
							dbSkip( )
						End
						GravaTrab(cNature, SE1->E1_VENCREA, nVlrLiq, "R4", SED->ED_DESCRIC)
						SE5 -> ( dbGoTo( nRec ) )
					End
				EndIf
			End
		End
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Se Considera Contas a Pagar.		  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par04 >= 2 .and. SE5->E5_RECPAG == "P"
			If mv_par05 == 1
				If mv_par06 == 2
					If E5_TIPODOC $ ("VL^BA/LJ") .or. Empty(E5_NUMERO)
						If cPaisLoc != "BRA"
							SA6->( DbSetOrder(1))		//A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
							SA6->( DbSeek( xFilial("SA6") + SE5->E5_BANCO + SE5->E5_AGENCIA+ SE5->E5_CONTA ) )
							nMoeda	:= Max( SA6->A6_MOEDA, 1 )
							nSe5Valor:= Round(xMoeda(SE5->E5_VALOR,nMoeda,1,SE5->E5_DATA,nDecs+1),nDecs)
						Else
							nSe5Valor := E5_VALOR
						EndIf
						GravaTrab(SE5->E5_NATUREZ, SE5->E5_DATA, nSe5Valor, "P2", SED->ED_DESCRIC)
					End
				Else
					nVlrLiq:=0
					cNumero:=E5_NUMERO
					cNature:=E5_NATUREZ
					dData  :=E5_DATA
					cParcela:=E5_PARCELA
					cPrefixo:=E5_PREFIXO
					Do While E5_NUMERO == cNumero .and. E5_PARCELA==cParcela .and. E5_PREFIXO == cPrefixo .and. ! Eof()
						If cPaisLoc != "BRA"
							SA6->( DbSetOrder(1))		//A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
							SA6->( DbSeek( xFilial("SA6") + SE5->E5_BANCO + SE5->E5_AGENCIA+ SE5->E5_CONTA ) )
							nMoeda	:= Max( SA6->A6_MOEDA, 1 )
							nSe5Valor:= Round(xMoeda(SE5->E5_VALOR,nMoeda,1,SE5->E5_DATA,nDecs+1),nDecs)
						Else
							nSe5Valor := E5_VALOR
						EndIf
						If E5_TIPODOC $ "JRüMTüCM"
							nVlrLiq-=nSe5Valor
						Elseif E5_TIPODOC $ "VLüDC/LJ/BA"
							nVlrLiq+=nSe5Valor
						End
						nRec := RecNo( )
						dbSkip( )
					End
					GravaTrab(cNature, dData, nVlrLiq, "P2", SED->ED_DESCRIC)
					SE5 -> ( dbGoTo( nRec ) )
				End
			Elseif mv_par05 == 2
				dbSelectArea( "SE2" )
				dbSetOrder(1)	//E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
				If dbSeek( xFilial("SE2") + SE5->E5_PREFIXO + SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR )
					dbSelectArea("SE5")
					If mv_par06 == 2
						If SE5->E5_TIPODOC $ ("VL^BA/LJ") .or. Empty(E5_NUMERO)
							If cPaisLoc != "BRA"
								SA6->( DbSetOrder(1))		//A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
								SA6->( DbSeek( xFilial("SA6") + SE5->E5_BANCO + SE5->E5_AGENCIA+ SE5->E5_CONTA ) )
								nMoeda	:= Max( SA6->A6_MOEDA, 1 )
								nSe5Valor:= Round(xMoeda(SE5->E5_VALOR,nMoeda,1,SE5->E5_DATA,nDecs+1),nDecs)
							Else
								nSe5Valor := E5_VALOR
							EndIf
							GravaTrab(SE5->E5_NATUREZ, SE2->E2_VENCREA, nSe5Valor, "P2", SED->ED_DESCRIC)
						End
					Else
						nVlrLiq:=0
						cNumero:=E5_NUMERO
						cNature:=E5_NATUREZ
						dData  :=E5_DATA
						cParcela:=E5_PARCELA
						cPrefixo:=E5_PREFIXO
						Do While E5_NUMERO == cNumero .and. E5_PARCELA==cParcela .and. E5_PREFIXO == cPrefixo .and. ! Eof()
							If cPaisLoc != "BRA"
								SA6->( DbSetOrder(1))		//A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
								SA6->( DbSeek( xFilial("SA6") + SE5->E5_BANCO + SE5->E5_AGENCIA+ SE5->E5_CONTA ) )
								nMoeda	:= Max( SA6->A6_MOEDA, 1 )
								nSe5Valor:= Round(xMoeda(SE5->E5_VALOR,nMoeda,1,SE5->E5_DATA,nDecs+1),nDecs)
							Else
								nSe5Valor := E5_VALOR
							EndIf
							If E5_TIPODOC $ "JRüMTüCMü"
								nVlrLiq-=nSe5Valor
							Elseif E5_TIPODOC $ "VLüDC/LJ/BA"
								nVlrLiq+=nSe5Valor
							End
							nRec := RecNo( )
							dbSkip( )
						End
						GravaTrab(cNature, dData, nVlrLiq, "P2", SED->ED_DESCRIC)
						SE5 -> ( dbGoTo( nRec ) )
					End
				EndIf
			End
		End
	End
	dbSelectArea("SE5")
	dbSkip( )
End

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³Gravatrab ³ Autor ³ Raul C. Capeleti 	  ³ Data ³ 05.12.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gravar no arquivo de trabalho os registros que atendam a	  ³±±
±±³			 ³condicao de selecao													  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³Gravatrab(Exp1,Exp2,Exp3,Exp4,Exp5)								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Codigo,Data,Valor,Carteira,Descricao 							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Lojr090.prg 															  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function Gravatrab(cCod1,cCod2,cCod3,cCod4,cCod5)

RecLock(cNomArq,.T.)

Replace CODIG	With cCod1
Replace DATA1	With cCod2
Replace VALOR1 With cCod3
Replace CARTEI With cCod4
Replace DESCR	With cCod5

MsUnlock()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³Imprime	³ Autor ³ Raul C. Capeleti 	  ³ Data ³ 05.12.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprimir o Array que contem os dados somados					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³Imprime(Array,nExp1,nExp2,cExp1,cExp2)							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Array,Acmulador1, Acumulador2,Codigo,Descricao				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Lojr090.prg 															  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function Imprime(aValr,nAtot1,nAtot2,cCod,cDesc)
Local nContador:=1,i

li+=2
@ li,005 PSay cCod+"-"+cDesc
li++
@ li,000 PSay "     +----------------+----------------+----------------+--------+    +-----------------+----------------+----------------+--------+"
li++
// DIA |  Valor Total   |    A Realizar  |   Realizado    |    %   |DIA |  Valor Total    |   A Realizar   |   Realizado    |   %    |
@ li,000 PSay STR0014
li++
@ li,000 PSay "+----+----------------+----------------+----------------+--------+----+-----------------+----------------+----------------+--------+"
li++

for i=1 to 15
	
	@ li,000 PSay "|"
	@ li,002 PSay StrZero(nContador,2)
	@ li,005 PSay "|"
	@ li,007 PSay aValr[nContador][2] Picture PesqPict( "SE5", "E5_VALOR", 14 )
	@ li,022 PSay "|"
	@ li,024 PSay aValr[nContador][3] Picture PesqPict( "SE5", "E5_VALOR", 14 )
	@ li,039 PSay "|"
	@ li,041 PSay aValr[nContador][4] Picture PesqPict( "SE5", "E5_VALOR", 14 )
	@ li,056 PSay "|"
	@ li,058 PSay aValr[nContador][5] Picture "@E 999.99" //porcentagem
	@ li,065 PSay "|"
	
	nContador+=16
	
	@ li,067 PSay StrZero(nContador,2)
	@ li,070 PSay "|"
	@ li,073 PSay aValr[nContador][2] Picture PesqPict( "SE5", "E5_VALOR", 14 )
	@ li,088 PSay "|"
	@ li,090 PSay aValr[nContador][3] Picture PesqPict( "SE5", "E5_VALOR", 14 )
	@ li,105 PSay "|"
	@ li,107 PSay aValr[nContador][4] Picture PesqPict( "SE5", "E5_VALOR", 14 )
	@ li,122 PSay "|"
	@ li,124 PSay aValr[nContador][5] Picture "@E 999.99" //porcentagem
	@ li,131 PSay "|"
	
	nContador-=15
	li++
	
Next

@ li,000 PSay "|"
@ li,002 PSay StrZero(nContador,2)
@ li,005 PSay "|"
@ li,007 PSay aValr[nContador][2] Picture PesqPict( "SE5", "E5_VALOR", 14 )
@ li,022 PSay "|"
@ li,024 PSay aValr[nContador][3] Picture PesqPict( "SE5", "E5_VALOR", 14 )
@ li,039 PSay "|"
@ li,041 PSay aValr[nContador][4] Picture PesqPict( "SE5", "E5_VALOR", 14 )
@ li,056 PSay "|"
@ li,058 PSay aValr[nContador][5] Picture "@E 999.99" //porcentagem
@ li,065 PSay "|"
@ li,070 PSay "|"
@ li,088 PSay "|"
@ li,105 PSay "|"
@ li,122 PSay "|"
@ li,131 PSay "|"
li++
@ li,000 PSay "+----+----------------+----------------+----------------+--------+----+-----------------+----------------+----------------+--------+"
li++
//|          - * * * * * *   T O T A L  * * * * * * -                   |
@ li,000 PSay STR0015
@ li,073 PSay nAtot1 		 	Picture PesqPict( "SE5", "E5_VALOR", 14 )
@ li,088 PSay "|"
@ li,090 PSay nAtot1-nAtot2	Picture PesqPict( "SE5", "E5_VALOR", 14 )
@ li,105 PSay "|"
@ li,107 PSay nAtot2 		 	Picture PesqPict( "SE5", "E5_VALOR", 14 )
@ li,122 PSay "|"
@ li,124 PSay If( ((nAtot2/nAtot1)*100) > 100 , 100,((nAtot2/nAtot1)*100) ) Picture "@Z 999.99"
@ li,131 PSay "|"
li++
@ li,000 PSay "+----------------------------------------------------------------------------------------------------------------------------------+"
li++
Return
