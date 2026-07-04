/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "LOJR190.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo	 ³ LOJR190	³ Autor ³ Hanna Caroline        ³ Data ³ 23.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Relacao de cheques devolvidos 							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ LOJR190      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Protheus - Relatorio Personalizavel						  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LOJR190()
Local oReport				// Objeto para geracao do relatorio
Local aArea := GetArea()	// Salva a area                                

If !FindFunction("TRepInUse") .OR. !TRepInUse()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa versao anterior do fonte³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	U_LOJR190R3()
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros						 ³
	//³ mv_par01			  // Do Cliente							 ³
	//³ mv_par02			  // Ate o Cliente						 ³ 
	//³ mv_par03			  // Do Banco							 ³
	//³ mv_par04			  // Ate o Banco						 ³ 
	//³ mv_par05			  // Do Titulo 							 ³ 
	//³ mv_par06			  // Ate o Titulo 						 ³ 
	//³ mv_par07			  // Da Alinea1							 ³ 
	//³ mv_par08			  // Ate Alinea1						 ³
	//³ mv_par09			  // Da Dt. Alinea1						 ³
	//³ mv_par10			  // Ate a Dt. Alinea1					 ³
	//³ mv_par11			  // Da Alinea2							 ³
	//³ mv_par12			  // Ate Alinea2						 ³
	//³ mv_par13			  // Da Dt. Alinea2						 ³
	//³ mv_par14			  // Ate a Dt. Alinea2					 ³
	//³ mv_par15			  // Da Dt. Reapresent. 				 ³
	//³ mv_par16			  // Ate Dt. Reapresent.				 ³ 
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte("LJR190",.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := Ljr190RptDef()
	oReport:PrintDialog()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Restaura a area³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea( aArea )
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo	 ³ LOJR190R3³ Autor ³ Adriano Sacomani 	  ³ Data ³ 08.10.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Relacao de cheques devolvidos 									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_LOJR190(void)															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LOJR190R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis 														  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cabec1,cabec2,wnrel
LOCAL titulo := STR0002 //"Cheques Devolvidos"
LOCAL cDesc1 := STR0001 //"Este programa tem a fun‡„o de emitir a relacao dos cheques devolvidos."
LOCAL cDesc2 := ""
LOCAL cDesc3 := ""
LOCAL cString:= "SEF"

PRIVATE tamanho:= "G"
PRIVATE aReturn := {STR0004, 1,STR0005, 2, 2, 1, "",1 }  // "Zebrado" "Administracao"
PRIVATE nomeprog:="LOJR190"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg	 :="LJR190"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas 								  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("LJR190",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros								  ³
//³ mv_par01			  // Do Cliente									  ³
//³ mv_par02			  // Ate o Cliente								  ³ 
//³ mv_par03			  // Do Banco										  ³
//³ mv_par04			  // Ate o Banco									  ³ 
//³ mv_par05			  // Do Titulo 									  ³ 
//³ mv_par06			  // Ate o Titulo 								  ³ 
//³ mv_par07			  // Da Alinea1									  ³ 
//³ mv_par08			  // Ate Alinea1									  ³
//³ mv_par09			  // Da Dt. Alinea1								  ³
//³ mv_par10			  // Ate a Dt. Alinea1							  ³
//³ mv_par11			  // Da Alinea2									  ³
//³ mv_par12			  // Ate Alinea2									  ³
//³ mv_par13			  // Da Dt. Alinea2								  ³
//³ mv_par14			  // Ate a Dt. Alinea2							  ³
//³ mv_par15			  // Da Dt. Reapresent. 						  ³
//³ mv_par16			  // Ate Dt. Reapresent.						  ³ 
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o Cabecalho de acordo com o tipo de emissao 			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Cabec1 := STR0003 //" Banco     Agencia     Conta    Nro.Cheque  Titulo\Parcela   Cliente\Loja                               Telefone      Alinea1    Data    Reapresentado   Alinea2    Data    Historico"
Cabec2 := " "
wnrel  :="LOJR190"            
	
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho,"",.F.)

If nLastKey==27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString,.F.)

If nLastKey==27
	Set Filter to
	Return
Endif

RptStatus({|lEnd| C001Imp(@lEnd,wnRel,cString)},Titulo)

Return 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ C001		³ Autor ³ Adriano Sacomani 	  ³ Data ³ 08.10.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio - Cheques Devolvidos 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ LOJR190																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function C001Imp(lEnd,WnRel,cString)

STATIC aTamSXG //Recebe tamanho do Codigo do Cliente do SXG

LOCAL CbTxt
LOCAL CbCont,cabec1,cabec2
LOCAL titulo := STR0002 //"Cheques Devolvidos"
Local cCliente :=""
Local nTotal	:=0
Local nAux:=0
Local cChave

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o Cabecalho de acordo com o tipo de emissao 			  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Cabec1 := STR0006 //" Banco   Agencia  Conta       Nro.Cheque      Titulo\Parcela   Cliente\Loja                               Telefone       Alinea1    Data      Reapresentado   Alinea2      Data            Valor        Historico"
Cabec2 := " "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt 	:= SPACE(10)
cbcont	:= 0
Li 		:= 80
m_pag 	:= 1


dbSelectArea("SEF")
SetRegua(RecCount()) 	// Total de Elementos da regua

cFiltro := SEF->(dbFilter())

If !Empty(Alltrim(cFiltro))
  Set Filter To &cFiltro
  DbGoTop()
Endif

dbSelectArea("SEF")
Set Softseek On
dbSeek(xFilial("SEF")+(mv_par03),.T.) //Banco
Set Softseek off
	
While (!Eof()) .and. ((SEF->EF_Filial+SEF->EF_BANCO >= xFilial("SEF")+mv_par03) .and. (SEF->EF_Filial+SEF->EF_BANCO <= xFilial("SEF")+mv_par04))                   
	IncRegua()				
	cCliente :=""

	// Verifica se houve devolucao. A Alinea 1 preenchida configura a devolucao
	If EMPTY(SEF->EF_ALINEA1)
		dbSkip()
		Loop
	Endif
			
	If lEnd
		@Prow()+1,001 Psay STR0007 //"CANCELADO PELO OPERADOR"
		Exit
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verificando titulo													 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SEF->EF_TITULO < MV_PAR05 .or. SEF->EF_TITULO > MV_PAR06
		dbSkip()
		Loop
	Endif 	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verificando Alinea1 												 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SEF->EF_ALINEA1 < MV_PAR07 .or. SEF->EF_ALINEA1 > MV_PAR08
		dbSkip()
		Loop
	Endif 	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verificando DATA Alinea1											 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SEF->EF_DTALIN1 < MV_PAR09 .or. SEF->EF_DTALIN1 > MV_PAR10
		dbSkip()
		Loop
	Endif 	


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verificando Alinea2 												 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SEF->EF_ALINEA2 < MV_PAR11 .or. SEF->EF_ALINEA2 > MV_PAR12
		dbSkip()
		Loop
	Endif 	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verificando DATA Alinea2											 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SEF->EF_DTALIN2 <> Ctod("  /  /  ") .and. ( SEF->EF_DTALIN2 < MV_PAR13 .or. SEF->EF_DTALIN2 > MV_PAR14)
		dbSkip()
		Loop
	Endif 	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verificando DATA Reapresentacao 								 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SEF->EF_DTREPRE <> Ctod("  /  /  ") .AND. (SEF->EF_DTREPRE < MV_PAR15 .or. SEF->EF_DTREPRE > MV_PAR16)
		dbSkip()
		Loop
	Endif 	

	//Buscando a Cliente
	dbSelectArea("SF2")
	dbSetOrder(1)
	If dbSeek(xFilial("SF2")+SEF->EF_TITULO+SEF->EF_SERIE)
		IF SF2->F2_CLIENTE < MV_PAR01 .OR. SF2->F2_CLIENTE > MV_PAR02
			  dbSelectArea("SEF")
			  dbSkip()
			  Loop
		Endif
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA)
	Else
		//Busca quando cheque via Financeiro
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+SEF->EF_CLIENTE+SEF->EF_LOJACLI)
		If SA1->A1_COD < mv_par01 .or. SA1->A1_COD > mv_par02
		  dbSelectArea("SEF")
		  dbSkip()
		  Loop
		Endif		
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Checa tamanho do Codigo do Cliente no SXG e Monta  linha ³
	//³ de detalhe 															 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	aTamSXG:=TamSxg("001") // Pesquisa Tamanho do Codigo do Cliente no SXG

	cCliente:= A1_COD+"-"+A1_LOJA+" "+Left(A1_NOME,16+(aTamSXG[4]-aTamSXG[1]))
	
	dbSelectArea("SEF")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do Cabecalho.											 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Li > 55
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
	EndIf

	@ Li,001 PSay SEF->EF_BANCO	 Picture  "999"
	@ Li,009 PSay SEF->EF_AGENCIA Picture  "@!"
	@ Li,018 PSay SEF->EF_CONTA	 Picture  "@!" 
	@ Li,030 PSay SEF->EF_NUM 	 Picture  "@!"
	@ Li,048 PSay SEF->EF_TITULO+"-"+SEF->EF_PARCELA     Picture "@!"
	@ Li,063 PSay cCliente	Picture "@!"
	@ Li,106 Psay SEF->EF_TEL 												  
	@ Li,123 PSay SEF->EF_ALINEA1  Picture "!!"                     
	@ Li,130 PSay SEF->EF_DTALIN1											  
	@ Li,143 PSay SEF->EF_DTREPRE											  
	@ Li,160 PSay SEF->EF_ALINEA2  Picture "!!"                      
	@ Li,168 PSay SEF->EF_DTALIN2												
	@ Li,182 PSay SEF->EF_VALOR	  Picture tm ( SEF->EF_VALOR, 14 )	
	@ Li,200 PSay Substr(SEF->EF_HISTD,1,20) 	Picture "@!"         
	nTotal+=SEF->EF_VALOR
	li++
	naux:=0
	cChave := SEF->(EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM)
	While SEF->(!Eof()) 							.And.;
					SEF->EF_FILIAL == xFilial("SEF")	.And.;
					SEF->(EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM) == cChave
		dbSkip()
	End	
End

If nTotal == 0 
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
	@ li, 001 Psay OemtoAnsi(STR0008) //"N„o ha informa‡oes para este relatorio"
	li++
Else
	li+=2
	@ li,001 Psay STR0009  //"TOTAL DE CHEQUES DEVOLVIDOS ....:"
	@ li,037 Psay nTotal Picture PesqPict("SEF","EF_VALOR",14)
	li++
Endif 

roda(cbcont,cbtxt,tamanho)
dbSelectArea("SEF")
Set Filter To

Set Device To Screen
If aReturn[5] = 1
  Set Printer TO 
  dbcommitAll()
  ourspool(wnrel)
EndIf

MS_FLUSH()

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ljr190RptDefºAutor  ³Hanna             º Data ³  23/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no re- º±±
±±º          ³latorio                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJR190                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Ljr190RptDef()
Local oReport												// Objeto do relatorio
Local oSection1												// Objeto da secao 1
Local oSection2												// Objeto da secao 2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Gera a tela com os dados para a confirmação da geracao do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//"Este programa tem a fun‡„o de emitir a relacao dos cheques devolvidos."
oReport := TReport():New("LOJR190",STR0002,"LJR190",{|oReport| Ljr190PrtRpt( oReport )}, STR0001 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal utlizado eh o SEF e o complementar o SA1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport,STR0010,{ "SEF","SA1" } )	//"Cliente"

TRCell():New(oSection1,"EF_CLIENTE"	,"SEF" )
TRCell():New(oSection1,"A1_LOJA"	,"SA1" )
TRCell():New(oSection1,"A1_NOME"	,"SA1" )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao2 (que sera filha da secao1) ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1,STR0011,"SEF")				//"Itens Cheques Devolvidos"
oSection2:SetTotalText("")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oSection2,"EF_BANCO"	,"SEF" )
TRCell():New(oSection2,"EF_AGENCIA"	,"SEF" )
TRCell():New(oSection2,"EF_CONTA"	,"SEF" )  
TRCell():New(oSection2,"EF_NUM"		,"SEF" )
TRCell():New(oSection2,"EF_TITULO"	,"SEF" )
TRCell():New(oSection2,"EF_PARCELA"	,"SEF" )
TRCell():New(oSection2,"EF_TEL"		,"SEF" )
TRCell():New(oSection2,"EF_ALINEA1"	,"SEF" )
TRCell():New(oSection2,"EF_DTALIN1"	,"SEF" )
TRCell():New(oSection2,"EF_DTREPRE"	,"SEF" )
TRCell():New(oSection2,"EF_ALINEA2"	,"SEF" )
TRCell():New(oSection2,"EF_DTALIN2"	,"SEF" )
TRCell():New(oSection2,"EF_VALOR"	,"SEF" )
TRCell():New(oSection2,"EF_HISTD"	,"SEF",,,10 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Soma o valor total³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRFunction():New(oSection2:Cell("EF_VALOR"),NIL,"SUM",,STR0009 )	// "TOTAL DE CHEQUES DEVOLVIDOS ....:"

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Ljr190PrtRptºAutor  ³Hanna               º Data ³  23/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJR010                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Ljr190PrtRpt( oReport )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)				// Define que a secao 2 serah filha da secao 1
Local cAlias1	:= GetNextAlias()					// Pega o proximo Alias Disponivel
Local cFiltro	:= ""								// Variavel utilizada para o filtro

#IFDEF TOP
	DbSelectArea("SEF")
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("LJR190")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//BEGIN REPORT QUERY oSection1 
	oSection1:BeginQuery()	     

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query utilizada para filtrar todos os dados necessarios ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	EF_CLIENTE,	A1_LOJA,	A1_NOME,
				EF_BANCO,	EF_AGENCIA,	EF_CONTA,	EF_NUM,		EF_TITULO,
				EF_PARCELA,	EF_TEL,		EF_ALINEA1,	EF_DTALIN1,	EF_DTREPRE,
				EF_ALINEA2,	EF_DTALIN2,	EF_VALOR,	EF_HISTD

		FROM %table:SEF% SEF
		LEFT JOIN %table:SA1% SA1 ON 
				SEF.EF_CLIENTE = SA1.A1_COD  AND 
				SEF.EF_LOJACLI = SA1.A1_LOJA AND
				SA1.%notDel%
		WHERE	EF_FILIAL	=	%xfilial:SEF%			AND
				EF_CLIENTE	>=	%exp:mv_par01%			AND
				EF_CLIENTE	<=	%exp:mv_par02%			AND
				EF_BANCO	>=	%exp:mv_par03%			AND
				EF_BANCO	<=	%exp:mv_par04%			AND
				EF_NUMNOTA	>= 	%exp:mv_par05%			AND
				EF_NUMNOTA	<= 	%exp:mv_par06%			AND
				EF_ALINEA1	>=	%exp:mv_par07%			AND
				EF_ALINEA1	<=	%exp:mv_par08%			AND
				EF_ALINEA2	>=	%exp:mv_par11%			AND
				EF_ALINEA2	<=	%exp:mv_par12%			AND
				EF_ALINEA1	<>	' '						AND
				EF_DTALIN1	>=	%exp:DTOS(mv_par09)%	AND
				EF_DTALIN1	<=	%exp:DTOS(mv_par10)%	AND
			((	EF_DTREPRE	=	' '				)		OR
				EF_DTREPRE	>=	%exp:DTOS(mv_par15)%	AND
				EF_DTREPRE	<=	%exp:DTOS(mv_par16)%)	AND
			((	EF_DTALIN2	>=	%exp:DTOS(mv_par13)%	AND
				EF_DTALIN2	<=	%exp:DTOS(mv_par14)%)	OR
				EF_DTALIN2	=	' '	)					AND
				SEF.%notDel%							
		ORDER BY %Order:SEF%
	EndSql

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿                
	//³Indica o fim da query, caso utilize range, deve-se informar como parametro ³
	//³{MV_?,MV_?} para que seja incluido no select automaticamente               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 	//END REPORT QUERY oSection1 //PARAM mv_par01,mv_par02 
	oSection1:EndQuery(/*Array com os parametros do tipo Range*/)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Baseada na query da secao1, utiliza filtro para saber quando deve sair do laco de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection2:SetParentQuery()
	oSection2:SetParentFilter( { | cParam | (cAlias1)->EF_CLIENTE == cParam},{|| (cAlias1)->EF_CLIENTE } )

#ELSE
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("LJR190")

	DbSelectArea("SEF")
	DbSetOrder(1)

	cFiltro := "EF_FILIAL = '" + xFilial("SEF") + "'"
	cFiltro += " .AND. EF_CLIENTE >= '" + MV_PAR01 + "' .AND. EF_CLIENTE   <= '" + MV_PAR02 + "'"
	cFiltro += " .AND. EF_BANCO   >= '" + MV_PAR03 + "' .AND. EF_BANCO   <= '" + MV_PAR04 + "'"
	cFiltro += " .AND. EF_ALINEA1 >= '" + MV_PAR07 + "' .AND. EF_ALINEA1 <= '" + MV_PAR08 + "'"
	cFiltro += " .AND. EF_ALINEA2 >= '" + MV_PAR11 + "' .AND. EF_ALINEA2 <= '" + MV_PAR12 + "'"
	cFiltro += " .AND. DTOS(EF_DTALIN1) >= '" + DTOS(MV_PAR09) + "' .AND. DTOS(EF_DTALIN1) <= '" + DTOS(MV_PAR10) + "'"
	cFiltro += " .AND. ( ( DTOS(EF_DTALIN2) >= '" + DTOS(MV_PAR13) + "' .AND. DTOS(EF_DTALIN2) <= '" + DTOS(MV_PAR14) + "')"
	cFiltro += " .OR. Empty( DTOS( EF_DTALIN2 ) ) ) "
	cFiltro += " .AND. DTOS(EF_DTREPRE) >= '" + DTOS(MV_PAR15) + "' .AND. DTOS(EF_DTREPRE) <= '" + DTOS(MV_PAR16) + "'"
	cFiltro += " .AND. !Empty( EF_ALINEA1 ) .AND. EF_NUMNOTA >= '" + MV_PAR05 + "' .AND. EF_NUMNOTA <= '" + MV_PAR06 + "'"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Efetua o filtro de acordo com a expressao, gera o indice temporario de acordo com o informado ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro, "EF_FILIAL+EF_CLIENTE+EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM" )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Efetua a condicao do codeblock dentro do filtro jah efetuado³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRPosition(oSection1,"SF2",1,{|| xFilial( "SF2" ) + SEF->EF_NUMNOTA + SEF->EF_SERIE})
	oSection1:SetLineCondition( {|| !SF2->(EOF() ) } )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa a secao2, com o mesmo filtro da secao1.                                   ³
	//³A condicao no codeblock, informa que o laco da secao sera enqt o cliente for igual³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection2:SetParentFilter( { | cParam | SEF->EF_CLIENTE == cParam},{|| SEF->EF_CLIENTE } )
#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Print()
Return
