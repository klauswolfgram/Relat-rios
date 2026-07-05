/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR040.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "PROTHEUS.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTMKR040   บAutor  ณMonael P. Ribeiro   บ Data ณ  10/10/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio de Historico de cobranca                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP8                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบArmando   ณ Revisao da estrutura do relatorio e da logica e implementa-บฑฑ
ฑฑบ          ณ cao das querys para TOP.                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function TMKR040()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local wnrel		:= "TMKR040"  	 	// Nome do Arquivo utilizado no Spool
Local Titulo	:= STR0014			//"Relatorio dos Cobradores"
Local cDesc1	:= STR0015			//"Este progama tem por fim emitir um historico das  "
Local cDesc2	:= STR0016			//"cobran็as por grupo de operadores."
Local cDesc3	:= STR0017			//"conforme os parametros previamente definidos"
Local nomeprog	:= "TMKR040.PRW"		// nome do programa
Local cString	:= "SU0"					// Alias utilizado na Filtragem
Local lDic		:= .F. 					// Habilita/Desabilita Dicionario
Local lComp		:= .F. 					// Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro	:= .T. 					// Habilita/Desabilita o Filtro

Private Tamanho := "G" 					// P/M/G
Private Limite  := 220 					// 80/132/220
Private aReturn := {"Zebrado",;		// [1] Reservado para Formulario	//
					1,;						// [2] Reservado para Nง de Vias
					STR0018,;		// [3] Destinatario					//dministra็ใo
					2,;						// [4] Formato => 1-Comprimido 2-Normal
					2,;	    				// [5] Midia   => 1-Disco 2-Impressora
					1,;						// [6] Porta ou Arquivo 1-LPT1... 4-COM1...
					"",;						// [7] Expressao do Filtro
					1 } 						// [8] Ordem a ser selecionada
												// [9]..[10]..[n] Campos a Processar (se houver)
Private m_pag   := 1  				 	// Contador de Paginas
Private nLastKey:= 0  				 	// Controla o cancelamento da SetPrint e SetDefault
Private cPerg   := "TMK040"  		 	// Pergunta do Relatorio
Private aOrdem  := {}  				 	// Ordem do Relatorio

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica as perguntas selecionadas                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Pergunte(cPerg,.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                          ณ
//ณ Mv_Par01           // A partir de                             ณ
//ณ Mv_Par02           // Ate o Dia                               ณ
//ณ Mv_Par03           // Do Grupo                                ณ
//ณ Mv_Par04           // Ate o Grupo                             ณ
//ณ Mv_Par05           // Da Filial                               ณ
//ณ Mv_Par06           // Ate a Filial                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)

If (nLastKey == 27)
	DbSelectArea(cString)
	DbSetOrder(1)
	DbClearFilter()
	Return
Endif

SetDefault(aReturn,cString)

If (nLastKey == 27)
	DbSelectArea(cString)
	DbSetOrder(1)
	DbClearFilter()
	Return
Endif

RptStatus({|lEnd| TK040Imp(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)

Return(.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณ TK040IMP ณ Autor ณ Viviane Fernandes     ณ Data ณ 20/03/03 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Processamento do relatorio                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ AP8                                                        |ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParamemtroณ lEnd     = controle do cancelamento do rel. pelo usuario   ณฑฑ
ฑฑณ          ณ wnRel    = nome do relatorio                               ณฑฑ
ฑฑณ          ณ cString  = alias para o filtro                             ณฑฑ
ฑฑณ          ณ nomeprog = nome do programa                                ณฑฑ
ฑฑณ          ณ titulo   = titulo do relatorio                             ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function TK040Imp(lEnd,wnRel,cString,nomeprog,Titulo)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para Impressao Do Cabecalho e Rodape    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local nLi		:= 0			      // Linha a ser impressa
Local nMax		:= 58			      // Maximo de linhas suportada pelo relatorio
Local cbCont	:= 0			      // Numero de Registros Processados
Local cbText	:= SPACE(10)   	// Mensagem do Rodape
Local cCabec1	:= STR0008 			// Label dos itens
Local cCabec2	:= STR0009 			// Label dos itens

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDeclaracao de variaveis especificas para este relatorioณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local aFilial		:= {}
Local aOperador		:= {}
Local nIni			:= 0
Local nFim			:= 0
Local aRegras		:= {}
Local nPos			:= 0
Local aResult		:= {}
Local nQtdIni  		:= 0
Local nVlrIni		:= 0
Local nQtdEnv		:= 0
Local nVlrEnv		:= 0
Local nQtdRecup		:= 0
Local nVlrRecup		:= 0
Local nQtdNReal		:= 0
Local nVlrNReal		:= 0
Local nQtdCancel	:= 0
Local nVlrCAncel	:= 0
Local cGrupo      	:= ""
Local nFilial     	:= 0
Local nTQtdIni		:= 0
Local nTVlrIni		:= 0 
Local nTQtdEnv		:= 0
Local nTVlrEnv		:= 0
Local nTQtdRecup	:= 0
Local nTVlrRecup	:= 0
Local nTQtdNReal	:= 0
Local nTVlrNReal	:= 0
Local nTQtdCancel	:= 0
Local nTVlrCAncel	:= 0                
Local nI			:= 0 

// Filiais validas
DbSelectArea("SM0")
DBGotop()
While !Eof()
	If SM0->M0_CODIGO == cEmpAnt .AND. FWGETCODFILIAL >= Mv_Par05 .AND. FWGETCODFILIAL <= Mv_Par06
		Aadd(aFilial, {SM0->M0_CODIGO, FWGETCODFILIAL, SM0->M0_FILIAL} )
	Endif
	DbSkip()
End

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCarrega um array com as regras de cobranca que serao utilizadas pela rotinaณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DbSelectArea("SK0")
DbSetOrder(2)
MsSeek(xFilial("SK0"))
While !Eof()
	nIni := nFim + 1
	nFim := nFim + Val(SK0->K0_PRAZO)
	Aadd(aRegras, {SK0->K0_REGSEL, nIni, nFim})
	DbSelectArea("SK0")
	DbSkip()
End

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณSeleciona todos os Operadores que pertencem ao intervalo de gruposณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DbSelectArea("SU7")
DbSetOrder(1) 
MsSeek(xFilial("SU7"))
While !Eof() .AND. SU7->U7_FILIAL == xFilial("SU7")
	
	If lEnd
		@Prow()+1,001 PSay STR0009 //"CANCELADO PELO OPERADOR"
		Return(.F.)
	Endif
	
	If SU7->U7_POSTO < Mv_Par03 .OR. SU7->U7_POSTO > Mv_Par04
		DbSelectArea("SU7")
		DbSkip()
		Loop
	Endif
	
	DbSelectArea("SU0")
	DbSetOrder(1)
	If !MsSeek(xFilial("SU0") + SU7->U7_POSTO)
		DbSelectArea("SU7")
		DbSkip()
		Loop
	Else	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณVerifico se o operador ้ interno ou externo. De acordo com ณ
		//ณMV_PAR07.                                                  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If Alltrim(Str(MV_PAR07)) <> "3" .And. (Alltrim(Str(MV_PAR07)) != SU0->U0_TIPOIE .Or. Empty(SU0->U0_TIPOIE))
			DbSelectArea("SU7")
			DbSkip()
			Loop			
		EndIf
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Considera filtro do usuario                                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If (!Empty(aReturn[7]) .AND. (!&(aReturn[7])))
		DbSelectarea("SU7")
		DbSkip()
		Loop
	Endif
	
	nPos := Ascan(aRegras, {|x| x[1] == SU0->U0_REGSEL })
	If nPos == 0
		DbSelectarea("SU7")
		DbSkip()
		Loop
	Endif
	
	Aadd(aOperador, {SU7->U7_COD, SU7->U7_POSTO, aRegras[nPos][2], aRegras[nPos][3] } )
	
	DbSelectarea("SU7")
	DbSkip()
End

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCarrrega um array com os valores da coluna Saldo Inicial.ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
U_TK040SaldoIni(@aResult, aFilial, aOperador)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCarrrega um array com os valores da coluna Cobrado.      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
U_TK040Cobrado(@aResult, aFilial, aOperador)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCarrrega um array com os valores da coluna Recuperado.   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
U_Tk040RecCanc(@aResult, aFilial, aOperador)

//--- Ordena pelos agrupamentos do relatorio
if Len(aResult) > 0 

	aResult := ASort(aResult,,,{|x,y| x[3]+x[2] < y[3]+y[2]})
	cGrupo  := ""
	nFilial := 0

EndIf

For nI := 1 To Len(aResult)                         
	
	If cGrupo <> aResult [nI] [3]
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		
		If nI > 1 // verifico se nใo ้ o primeiro registro
		   // os totais serao impressos 
			TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			@ nLi, 000 PSay STR0011
			@ nLi, 040 PSay nQtdIni    Picture '@E 999999'				// Qtd Saldo Inicial
			@ nLi, 048 PSay nVlrIni    Picture '@E 999,999,999.99'	// Val Saldo Inicial
			@ nLi, 066 PSay nQtdEnv    Picture '@E 999999'				// Qtd Cobrado
			@ nLi, 074 PSay nVlrEnv    Picture '@E 999,999,999.99'	// Val Cobrado
			@ nLi, 092 PSay nQtdRecup  Picture '@E 999999'				// Qtd Recuperado
			@ nLi, 100 PSay nVlrRecup  Picture '@E 999,999,999.99'	// Val Recuperado
			@ nLi, 118 PSay nQtdNReal  Picture '@E 999999'				// Qtd Nao Realizado
			@ nLi, 126 PSay nVlrNReal  Picture '@E 999,999,999.99'	// Val Nao Realizado
			@ nLi, 144 PSay nQtdCancel Picture '@E 999999'				// Qtd Cancelado
			@ nLi, 152 PSay nVlrCAncel Picture '@E 999,999,999.99'	// Val Cancelado
			
			@ nLi, 170 PSay nQtdIni + 	nQtdEnv - ( nQtdRecup + nQtdNReal + 	nQtdCancel) Picture '@E 999999'
			@ nLi, 178 PSay nVlrIni + nVlrEnv - ( nVlrRecup + nVlrNReal + nVlrCAncel) Picture '@E 999,999,999.99'
			
			@ nLi, 202 PSay (	nQtdEnv / nVlrIni) * 100 Picture '@E 9999.99'
			@ nLi, 210 PSay (nVlrRecup / nVlrEnv) * 100 Picture '@E 9999.99'
			
			TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			
			@ nLi,000 PSay __PrtFatLine()			
			
			TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			     
			nTQtdIni		+= nQtdIni 
			nTVlrIni		+= nVlrIni		 
			nTQtdEnv		+= nQtdEnv
			nTVlrEnv		+= nVlrEnv
			nTQtdRecup	+= nQtdRecup
			nTVlrRecup	+= nVlrRecup
			nTQtdNReal	+= nQtdNReal
			nTVlrNReal	+= nVlrNReal
			nTQtdCancel	+= nQtdCancel
			nTVlrCAncel	+= nVlrCAncel   
			
			nQtdIni		:= 0
			nVlrIni		:= 0 
			nQtdEnv		:= 0
			nVlrEnv		:= 0
			nQtdRecup	:= 0
			nVlrRecup	:= 0
			nQtdNReal	:= 0
			nVlrNReal	:= 0
			nQtdCancel	:= 0
			nVlrCAncel	:= 0
		
		EndIf
		
		DbselectArea("SU0")
		DBSetorder(1)
		DBseek(xFilial("SU0")+ aResult[nI][3])

		@ nLi, 000 PSay  STR0019 + " -  " + STR0010 + " " + aResult[nI][3]+ "-" + SU0->U0_NOME    //"Empresa/Filial "
      cGrupo := aResult [nI] [3]

	Endif

	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	
	@ nLi, 000 Psay aResult[nI][1] + "/" + aResult[nI][2] 	
	@ nLi, 040 PSay aResult[nI][04] Picture '@E 999999'				// Qtd Saldo Inicial
	@ nLi, 048 PSay aResult[nI][05] Picture '@E 999,999,999.99'		// Val Saldo Inicial
	@ nLi, 066 PSay aResult[nI][06] Picture '@E 999999'				// Qtd Cobrado
	@ nLi, 074 PSay aResult[nI][07] Picture '@E 999,999,999.99'		// Val Cobrado
	@ nLi, 092 PSay aResult[nI][08] Picture '@E 999999'				// Qtd Recuperado
	@ nLi, 100 PSay aResult[nI][09] Picture '@E 999,999,999.99'		// Val Recuperado
	@ nLi, 118 PSay aResult[nI][10] Picture '@E 999999'				// Qtd Nao Realizado
	@ nLi, 126 PSay aResult[nI][11] Picture '@E 999,999,999.99'		// Val Nao Realizado
	@ nLi, 144 PSay aResult[nI][12] Picture '@E 999999'				// Qtd Cancelado
	@ nLi, 152 PSay aResult[nI][13] Picture '@E 999,999,999.99'		// Val Cancelado
	
	@ nLi, 170 PSay aResult[nI][04] + aResult[nI][06] - ( aResult[nI][08] + aResult[nI][10] + aResult[nI][12]) Picture '@E 999999'
	@ nLi, 178 PSay aResult[nI][05] + aResult[nI][07] - ( aResult[nI][09] + aResult[nI][11] + aResult[nI][13]) Picture '@E 999,999,999.99'
	
	@ nLi, 202 PSay (aResult[nI][06] / aResult[nI][05]) * 100 Picture '@E 9999.99'
	@ nLi, 210 PSay (aResult[nI][09] / aResult[nI][07]) * 100 Picture '@E 9999.99'
	
	
	nQtdIni		+= aResult[nI][04]
	nVlrIni		+= aResult[nI][05]
	nQtdEnv		+= aResult[nI][06]
	nVlrEnv		+= aResult[nI][07]
	nQtdRecup	+= aResult[nI][08]
	nVlrRecup	+= aResult[nI][09]
	nQtdNReal	+= aResult[nI][10]
	nVlrNReal	+= aResult[nI][11]
	nQtdCancel	+= aResult[nI][12]
	nVlrCAncel	+= aResult[nI][13]

Next nI                                                          

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)  
TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)   

@ nLi, 000 PSay STR0011												// Totais do cobrador
@ nLi, 040 PSay nQtdIni    Picture '@E 999999'				// Qtd Saldo Inicial
@ nLi, 048 PSay nVlrIni    Picture '@E 999,999,999.99'	// Val Saldo Inicial
@ nLi, 066 PSay nQtdEnv    Picture '@E 999999'				// Qtd Cobrado
@ nLi, 074 PSay nVlrEnv    Picture '@E 999,999,999.99'	// Val Cobrado
@ nLi, 092 PSay nQtdRecup  Picture '@E 999999'				// Qtd Recuperado
@ nLi, 100 PSay nVlrRecup  Picture '@E 999,999,999.99'	// Val Recuperado
@ nLi, 118 PSay nQtdNReal  Picture '@E 999999'				// Qtd Nao Realizado
@ nLi, 126 PSay nVlrNReal  Picture '@E 999,999,999.99'	// Val Nao Realizado
@ nLi, 144 PSay nQtdCancel Picture '@E 999999'				// Qtd Cancelado
@ nLi, 152 PSay nVlrCAncel Picture '@E 999,999,999.99'	// Val Cancelado

@ nLi, 170 PSay nQtdIni + 	nQtdEnv - ( nQtdRecup + nQtdNReal + 	nQtdCancel) Picture '@E 999999'
@ nLi, 178 PSay nVlrIni + nVlrEnv - ( nVlrRecup + nVlrNReal + nVlrCAncel) Picture '@E 999,999,999.99'

@ nLi, 202 PSay (	nQtdEnv / nVlrIni) * 100 Picture '@E 9999.99'
@ nLi, 210 PSay (nVlrRecup / nVlrEnv) * 100 Picture '@E 9999.99'

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)

@ nLi,000 PSay __PrtFatLine()			

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
     
nTQtdIni		+= nQtdIni 
nTVlrIni		+= nVlrIni		 
nTQtdEnv		+= nQtdEnv
nTVlrEnv		+= nVlrEnv
nTQtdRecup	+= nQtdRecup
nTVlrRecup	+= nVlrRecup
nTQtdNReal	+= nQtdNReal
nTVlrNReal	+= nVlrNReal
nTQtdCancel	+= nQtdCancel
nTVlrCAncel	+= nVlrCAncel   


//Impressao do total geral

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)

@ nLi, 000 PSay STR0012												// Total Geral
@ nLi, 040 PSay nTQtdIni 	 Picture '@E 999999'				// Qtd Saldo Inicial
@ nLi, 048 PSay nTVlrIni 	 Picture '@E 999,999,999.99'	// Val Saldo Inicial
@ nLi, 066 PSay nTQtdEnv 	 Picture '@E 999999'				// Qtd Cobrado
@ nLi, 074 PSay nTVlrEnv 	 Picture '@E 999,999,999.99'	// Val Cobrado
@ nLi, 092 PSay nTQtdRecup  Picture '@E 999999'				// Qtd Recuperado
@ nLi, 100 PSay nTVlrRecup	 Picture '@E 999,999,999.99'	// Val Recuperado
@ nLi, 118 PSay nTQtdNReal  Picture '@E 999999'				// Qtd Nao Realizado
@ nLi, 126 PSay nTVlrNReal  Picture '@E 999,999,999.99'	// Val Nao Realizado
@ nLi, 144 PSay nTQtdCancel Picture '@E 999999'				// Qtd Cancelado
@ nLi, 152 PSay nTVlrCAncel Picture '@E 999,999,999.99'	// Val Cancelado

@ nLi, 170 PSay nTQtdIni + 	nTQtdEnv - ( nTQtdRecup + nTQtdNReal + 	nTQtdCancel) Picture '@E 999999'
@ nLi, 178 PSay nTVlrIni + nTVlrEnv - ( nTVlrRecup + nTVlrNReal + nTVlrCAncel) Picture '@E 999,999,999.99'

@ nLi, 202 PSay (	nTQtdEnv / nTVlrIni) * 100 Picture '@E 9999.99'
@ nLi, 210 PSay (nTVlrRecup / nTVlrEnv) * 100 Picture '@E 9999.99'

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)

@ nLi,000 PSay __PrtFatLine()			

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)

nQtdIni		:= 0
nVlrIni		:= 0 
nQtdEnv		:= 0
nVlrEnv		:= 0
nQtdRecup	:= 0
nVlrRecup	:= 0
nQtdNReal	:= 0
nVlrNReal	:= 0
nQtdCancel	:= 0
nVlrCAncel	:= 0

nTQtdIni		:= 0
nTVlrIni		:= 0
nTQtdEnv		:= 0
nTVlrEnv		:= 0
nTQtdRecup	:= 0
nTVlrRecup	:= 0
nTQtdNReal	:= 0
nTVlrNReal	:= 0
nTQtdCancel	:= 0
nTVlrCAncel	:= 0


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณImprime o rodape do relatorioณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Roda(cbCont,cbText,Tamanho)

Set Device To Screen
If ( aReturn[5] = 1 )
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()

Return(.T.)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณTk040SaldoIniบAutorณViviane M. Fernandesบ Data ณ 16/10/03   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para calcular a coluna SALDO INICIAL                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณaResult   - @ Apuracao dos resultados                       บฑฑ
ฑฑบ          ณaFilial   - Filiais validas                                 บฑฑ
ฑฑบ          ณaOperador - Operadores pre selecionados anteriormente       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP8                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบArmando   ณ Revisao do fonte                                           บฑฑ
ฑฑบAndrea F. ณ Tratamento das tabelas SK1 / SE1 / SE5 quando estao compar-บฑฑ
ฑฑบ          ณtilhadas.                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Tk040SaldoIni(aResult, aFilial, aOperador)

Local cSE1		:= "SE1"
Local cSU7		:= "SU7"
Local nI		:= 0
Local nX		:= 0
Local cQuery	:= ""
Local aStruct	:= SK1->(DbStruct())

For nI := 1 To Len(aOperador)
	
	DbSelectArea("SK1")
	DbSetOrder(2)	// K1_FILIAL+DTOS(K1_VENCREA)+K1_CLIENTE+K1_LOJA

	cSE1 		:= "SK1"
	cSU7 		:= "SK1"
	cQuery	:=	" SELECT	SK1.*, SE1.E1_VALOR, SU7.U7_POSTO " +;
				" FROM " +	RetSqlName("SK1") + " SK1, " +;
				RetSqlName("SE1") + " SE1, " +;
				RetSqlName("SU7") + " SU7 " +;
				" WHERE	SK1.K1_FILIAL BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND" +;
				"		SK1.K1_VENCREA 	< '" + DtoS(Mv_Par01-aOperador[nI][4]) + "' AND" +;
				"		SK1.K1_OPERAD 	= '" + aOperador[nI][1] + "' AND" +;
				"		SK1.D_E_L_E_T_ 	= '' AND" +;
				"		SE1.E1_FILIAL 	= SK1.K1_FILIAL AND" +;
				"		SE1.E1_PREFIXO 	= SK1.K1_PREFIXO AND" +;
				"		SE1.E1_NUM 		= SK1.K1_NUM AND" +;
				"		SE1.E1_PARCELA 	= SK1.K1_PARCELA AND" +;
				"		SE1.E1_TIPO 	= SK1.K1_TIPO AND" +;
				"		SE1.D_E_L_E_T_ 	= '' AND" +;
				"		SU7.U7_FILIAL 	= '" + xFilial("SU7") + "' AND" +;
				"		SU7.U7_COD = SK1.K1_OPERAD AND" +;
				"		SU7.D_E_L_E_T_ = ''" +;
				" ORDER BY " + SqlOrder(IndexKey())
	
	cQuery	:= ChangeQuery(cQuery)
	
	// MemoWrite("TK040SK1.SQL", cQuery)
	DbSelectArea("SK1")
	DbCloseArea()
	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SK1', .F., .T.)
	
	For nX := 1 To Len(aStruct)
		If aStruct[nX][2] $ "NDL"
			TCSetField("SK1", aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4])
		Endif
	Next nX
	
	TCSetField("SK1", "E1_VALOR", "N", 12, 2)
		
   While !Eof()
    	
		#IFNDEF TOP
			If SK1->K1_FILIAL < Mv_Par05 .OR. SK1->K1_FILIAL > Mv_Par06
				DbSkip()
				Loop
			Endif
			
			If SK1->K1_VENCREA >= (Mv_Par01-aOperador[nI][4])
				DbSkip()
				Loop
			Endif
			
			If SK1->K1_OPERAD <> aOperador[nI][1]
				DbSkip()
				Loop
			Endif
			
			DbSelectarea("SE1")
			DbSetOrder(1)
			If !MsSeek(SK1->K1_FILIAL+SK1->K1_PREFIXO+SK1->K1_NUM+SK1->K1_PARCELA+SK1->K1_TIPO)
				DbSelectarea("SK1")
				DbSkip()
				Loop
			Endif

			DbSelectarea(cSU7)
			DbSetOrder(1)
			If !MsSeek(xFilial(cSU7)+SK1->K1_OPERAD)
				DbSelectarea("SK1")
				DbSkip()
				Loop
			Endif
		#ENDIF      
		
    	nPos1 := Ascan(aFilial, {|x| x[2] == SK1->K1_FILIAL })
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณSe a tabela SK1 estiver compartilhada, trata no array aResult para carregar os valores da filial atualณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If nPos1 == 0 
			nPos1:=Ascan(aFilial, {|x| x[2] == cFilAnt })//Atualiza com a Filial atual
		Endif
		
		nPos2 := Ascan(aResult, {|x| x[1]+x[3] == aFilial[nPos1][2]+(cSU7)->U7_POSTO })
		If nPos2 == 0
			Aadd(aResult, {	aFilial[nPos1][2],;
							aFilial[nPos1][3],;
							(cSU7)->U7_POSTO,;
							0,;						// Qtd Saldo Inicial
							0,;						// Val Saldo Inicial
							1,;						// Qtd Cobrado
							(cSE1)->E1_VALOR,;		// Val Cobrado
							0,;						// Qtd Recuperado
							0,;						// Val Recuperado
							0,;						// Qtd Nao Realizado
							0,;						// Val Nao Realizado
							0,;						// Qtd Cancelado
							0;						// Val Cancelado
							} )
		Else
			aResult[nPos2][6] := aResult[nPos2][6] + 1
			aResult[nPos2][7] := aResult[nPos2][7] + (cSE1)->E1_VALOR
		Endif
		
		DbSelectArea("SK1")
		DbSkip()
	End
	
	
	DbSelectArea("SK1")
	DbCloseArea()
	ChkFile("SK1")

	
Next nI

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณTk040Cobrado บAutorณViviane M. Fernandesบ Data ณ 16/10/03   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para calcular a coluna COBRADO.                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณaResult   - @ Apuracao dos resultados                       บฑฑ
ฑฑบ          ณaFilial   - Filiais validas                                 บฑฑ
ฑฑบ          ณaOperador - Operadores pre selecionados anteriormente       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP8                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบArmando   ณ Revisao do fonte                                           บฑฑ
ฑฑบAndrea F. ณ Considerar variaveis diferentes para controle de loop.     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Tk040Cobrado(aResult, aFilial, aOperador)

Local cSE1		:= "SE1"
Local cSU7		:= "SU7"
Local nI		:= 0
Local nX		:= 0
Local cQuery	:= ""
Local aStruct	:= SK1->(DbStruct())

For nI := 1 To Len(aOperador)
	
	DbSelectArea("SK1")
	DbSetOrder(2)	// K1_FILIAL+DTOS(K1_VENCREA)+K1_CLIENTE+K1_LOJA

	cSE1 := "SK1"
	cSU7 := "SK1"
	cQuery	:=	" SELECT	SK1.*, SE1.E1_VALOR, SU7.U7_POSTO " +;
				" FROM " +	RetSqlName("SK1") + " SK1, " +;
							RetSqlName("SE1") + " SE1, " +;
							RetSqlName("SU7") + " SU7 " +;
				" WHERE	SK1.K1_FILIAL 	BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND" +;
				"		SK1.K1_VENCREA 	BETWEEN '" + DtoS(Mv_Par01-aOperador[nI][4]) + "' AND '" + DtoS(Mv_Par02-aOperador[nI][3]) + "' AND" +;
				"		SK1.K1_OPERAD 	= '" + aOperador[nI][1] + "' AND" +;
				"		SK1.D_E_L_E_T_ 	= '' AND" +;
				"		SE1.E1_FILIAL 	= SK1.K1_FILIAL AND" +;
				"		SE1.E1_PREFIXO	= SK1.K1_PREFIXO AND" +;
				"		SE1.E1_NUM 		= SK1.K1_NUM AND" +;
				"		SE1.E1_PARCELA	= SK1.K1_PARCELA AND" +;
				"		SE1.E1_TIPO 	= SK1.K1_TIPO AND" +;
				"		SE1.D_E_L_E_T_ 	= '' AND" +;
				"		SU7.U7_FILIAL 	= '" + xFilial("SU7") + "' AND" +;
				"		SU7.U7_COD 		= SK1.K1_OPERAD AND" +;
				"		SU7.D_E_L_E_T_ 	= ''" +;
				" ORDER BY " + SqlOrder(IndexKey())
	
	cQuery	:= ChangeQuery(cQuery)
	// MemoWrite("TK040SE5K1.SQL", cQuery)
	DbSelectArea("SK1")
	DbCloseArea()
	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SK1', .F., .T.)
	
	For nX := 1 To Len(aStruct)
		If aStruct[nX][2] $ "NDL"
			TCSetField("SK1", aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4])
		Endif
	Next nX
	
	TCSetField("SK1", "E1_VALOR", "N", 12, 2)
		
    While !Eof()
    	
		#IFNDEF TOP
			If SK1->K1_FILIAL < Mv_Par05 .OR. SK1->K1_FILIAL > Mv_Par06
				DbSkip()
				Loop
			Endif
			
			If SK1->K1_VENCREA < (Mv_Par01-aOperador[nI][4]) .OR. SK1->K1_VENCREA > (Mv_Par02-aOperador[nI][3])
				DbSkip()
				Loop
			Endif
			
			If SK1->K1_OPERAD <> aOperador[nI][1]
				DbSkip()
				Loop
			Endif
			
			DbSelectarea("SE1")
			DbSetOrder(1)
			If !MsSeek(SK1->K1_FILIAL+SK1->K1_PREFIXO+SK1->K1_NUM+SK1->K1_PARCELA+SK1->K1_TIPO)
				DbSelectarea("SK1")
				DbSkip()
				Loop
			Endif  
			
			DbSelectarea(cSU7)
			DbSetOrder(1)
			If !MsSeek(xFilial(cSU7)+SK1->K1_OPERAD)
				DbSelectarea("SK1")
				DbSkip()
				Loop
			Endif
		
      #ENDIF
    
    	
		nPos1 := Ascan(aFilial, {|x| x[2] == SK1->K1_FILIAL })
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณSe a tabela SK1 estiver compartilhada, trata no array aResult para carregar os valores da filial atualณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If nPos1 == 0 
			nPos1:=Ascan(aFilial, {|x| x[2] == cFilAnt })//Atualiza com a Filial atual
		Endif

		nPos2 := Ascan(aResult, {|x| x[1]+x[3] == aFilial[nPos1][2]+(cSU7)->U7_POSTO })

		If nPos2 == 0 
			Aadd(aResult, {	aFilial[nPos1][2],;
							aFilial[nPos1][3],;
							(cSU7)->U7_POSTO,;
							1,;						// Qtd Saldo Inicial
							(cSE1)->E1_VALOR,;		// Val Saldo Inicial
							0,;						// Qtd Cobrado
							0,;						// Val Cobrado
							0,;						// Qtd Recuperado
							0,;						// Val Recuperado
							0,;						// Qtd Nao Realizado
							0,;						// Val Nao Realizado
							0,;						// Qtd Cancelado
							0;						// Val Cancelado
							} )
		Else
			aResult[nPos2][4] := aResult[nPos2][4] + 1
			aResult[nPos2][5] := aResult[nPos2][5] + (cSE1)->E1_VALOR
		Endif
		
		DbSelectArea("SK1")
		DbSkip()
	End
	

	DbSelectArea("SK1")
	DbCloseArea()
	ChkFile("SK1")
	
Next nI

Return()



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณTk040RecuperaบAutorณViviane M. Fernandesบ Data ณ 16/10/03   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para calcular a coluna RECUPERADO e CANCELADO.       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณaResult   - @ Apuracao dos resultados                       บฑฑ
ฑฑบ          ณaFilial   - Filiais validas                                 บฑฑ
ฑฑบ          ณaOperador - Operadores pre selecionados anteriormente       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP8                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบArmando   ณ Revisao do fonte                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Tk040RecCanc(aResult, aFilial, aOperador)


Local nI	:= 0     
Local cSU7	:= "SU7"
Local cSE5	:= "SE5"
Local cQuery	:= ""

For nI := 1 To Len(aOperador)
	
	DbSelectArea("SE5")
	DbSetOrder(1)	// E5_FILIAL+DTOS(E5_DATA)+E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ
	    
	cSU7 := "SE5"
	cQuery	:=	" SELECT	SE5.E5_FILIAL, SE5.E5_VALOR, SE5.E5_MOTBX, SE5.E5_OPERAD, SU7.U7_POSTO " +;
				" FROM " +	RetSqlName("SE5") + " SE5, " +;
							RetSqlName("SU7") + " SU7 " +;
				" WHERE	SE5.E5_FILIAL BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND" +;
				"		SE5.E5_DATA BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND" +;
				"		SE5.E5_OPERAD 	= '" + aOperador[nI][1] + "' AND" +;
				"		SE5.E5_RECPAG 	= 'R' AND" +;
				"		SE5.E5_SITUACA 	<> 'C' AND" +;
				"		SE5.E5_TIPO 	<> 'ES' AND" +;
				"		SE5.D_E_L_E_T_ 	= '' AND" +;
				"		SU7.U7_FILIAL 	= '" + xFilial("SU7") + "' AND" +;
				"		SU7.U7_COD 		= SE5.E5_OPERAD AND" +;
				"		SU7.D_E_L_E_T_ 	= ''" +;
				" ORDER BY " + SqlOrder(IndexKey())
	
	cQuery	:= ChangeQuery(cQuery)
	// MemoWrite("TK040SE5.SQL", cQuery)
	DbSelectArea("SE5")
	DbCloseArea()
	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SE5', .F., .T.)
	
	TCSetField("SE5", "E5_VALOR", "N", 12, 2)

    While !Eof()
    	
		#IFNDEF TOP
			If SE5->E5_FILIAL < Mv_Par05 .OR. SE5->E5_FILIAL > Mv_Par06
				DbSkip()
				Loop
			Endif
			
			If SE5->E5_DATA < Mv_Par01 .OR. SE5->E5_DATA > Mv_Par02
				DbSkip()
				Loop
			Endif
			
			If SE5->E5_OPERAD <> aOperador[nI][1]
				DbSkip()
				Loop
			Endif
			
			If SE5->E5_RECPAG <> "R"		// Contas a receber
				DbSkip()
				Loop
			Endif
			
			If SE5->E5_SITUACA == "C"		// Lancamento cancelado
				DbSkip()
				Loop
			Endif
			
			If SE5->E5_TIPO == "ES"			// Lancamento de estorno
				DbSkip()
				Loop
			Endif


	      DbSelectarea(cSU7)
			DbSetOrder(1)
			If !MsSeek(xFilial(cSU7)+SE5->E5_OPERAD)
				DbSelectarea("SE5")
				DbSkip()
				Loop
			Endif
		#ENDIF			
		    	
		nPos1 := Ascan(aFilial, {|x| x[2] == SE5->E5_FILIAL })
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณSe a tabela SE5 estiver compartilhada, trata no array aResult para carregar os valores da filial atualณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If nPos1 == 0 
			nPos1:=Ascan(aFilial, {|x| x[2] == cFilAnt })//Atualiza com a Filial atual
		Endif

		nPos2 := Ascan(aResult, {|x| x[1]+x[3] == aFilial[nPos1][2]+(cSU7)->U7_POSTO })
		If nPos2 == 0
			If SE5->E5_MOTBX <> "CEC"
				Aadd(aResult, {	aFilial[nPos1][2],;
								aFilial[nPos1][3],;
								(cSU7)->U7_POSTO,;
								0,;						// Qtd Saldo Inicial
								0,;						// Val Saldo Inicial
								0,;						// Qtd Cobrado
								0,;						// Val Cobrado
								1,;						// Qtd Recuperado
								(cSE5)->E5_VALOR,;		// Val Recuperado
								0,;						// Qtd Nao Realizado
								0,;						// Val Nao Realizado
								0,;						// Qtd Cancelado
								0;						// Val Cancelado
								} )
			Else
				// Compensacao entre carteiras na devolu็ใo de materiais.
				Aadd(aResult, {	aFilial[nPos1][2],;
								aFilial[nPos1][3],;
								(cSU7)->U7_POSTO,;
								0,;						// Qtd Saldo Inicial
								0,;						// Val Saldo Inicial
								0,;						// Qtd Cobrado
								0,;						// Val Cobrado
								0,;						// Qtd Recuperado
								0,;						// Val Recuperado
								0,;						// Qtd Nao Realizado
								0,;						// Val Nao Realizado
								1,;						// Qtd Cancelado
								(cSE5)->E5_VALOR;		// Val Cancelado
								} )
			Endif
		Else
			If SE5->E5_MOTBX <> "CEC"
				aResult[nPos2][8] := aResult[nPos2][8] + 1
				aResult[nPos2][9] := aResult[nPos2][9] + (cSE5)->E5_VALOR
			Else
				aResult[nPos2][12] := aResult[nPos2][12] + 1
				aResult[nPos2][13] := aResult[nPos2][13] + (cSE5)->E5_VALOR
			Endif
		Endif
		
		DbSelectArea("SE5")
		DbSkip()
	End

	DbSelectArea("SE5")
	DbCloseArea()
	ChkFile("SE5")
	
Next nI

Return()



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบPrograma  ณTk040NRealiz บAutorณViviane M. Fernandesบ Data ณ 16/10/03   บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para calcular a coluna NAO REALIZADO.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณaResult   - @ Apuracao dos resultados                       บฑฑ
ฑฑบ          ณaFilial   - Filiais validas                                 บฑฑ
ฑฑบ          ณaOperador - Operadores pre selecionados anteriormente       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP8                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบArmando   ณ Revisao do fonte                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Tk040NRealiz(aResult, aFilial, aOperador)

Local cSE1	:= "SE1"
Local cSU7	:= "SU7"
Local nI	:= 0
Local cQuery	:= ""
Local aStruct	:= SK1->(DbStruct())


For nI := 1 To Len(aOperador)
	
	DbSelectArea("SK1")
	DbSetOrder(2)	// K1_FILIAL+DTOS(K1_VENCREA)+K1_CLIENTE+K1_LOJA
	
	cSE1 := "SK1"
	cSU7 := "SK1"
	cQuery	:=	" SELECT	SK1.*, SE1.E1_VALOR, SU7.U7_POSTO " +;
				" FROM " +	RetSqlName("SK1") + " SK1, " +;
							RetSqlName("SE1") + " SE1, " +;
							RetSqlName("SU7") + " SU7 " +;
				" WHERE	SK1.K1_FILIAL BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND" +;
				"		SK1.K1_VENCREA BETWEEN '" + DtoS(Mv_Par01-aOperador[nI][4]) + "' AND '" + DtoS(Mv_Par02-aOperador[nI][3]) + "' AND" +;
				"		SK1.K1_OPERAD	= '" + aOperador[nI][1] + "' AND" +;
				"		SK1.D_E_L_E_T_ 	= '' AND" +;
				"		SE1.E1_FILIAL 	= SK1.K1_FILIAL AND" +;
				"		SE1.E1_PREFIXO	= SK1.K1_PREFIXO AND" +;
				"		SE1.E1_NUM 		= SK1.K1_NUM AND" +;
				"		SE1.E1_PARCELA 	= SK1.K1_PARCELA AND" +;
				"		SE1.E1_TIPO 	= SK1.K1_TIPO AND" +;
				"		SE1.D_E_L_E_T_ 	= '' AND" +;
				"		SU7.U7_FILIAL 	= '" + xFilial("SU7") + "' AND" +;
				"		SU7.U7_COD 		= SK1.K1_OPERAD AND" +;
				"		SU7.D_E_L_E_T_ 	= ''" +;
				" ORDER BY " + SqlOrder(IndexKey())
	
	cQuery	:= ChangeQuery(cQuery)
	// MemoWrite("TK040SE5K1.SQL", cQuery)
	DbSelectArea("SK1")
	DbCloseArea()
	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SK1', .F., .T.)
	
	For nI := 1 To Len(aStruct)
		If aStruct[nI][2] $ "NDL"
			TCSetField("SK1", aStruct[nI][1], aStruct[nI][2], aStruct[nI][3], aStruct[nI][4])
		Endif
	Next nI
		
	TCSetField("SK1", "E1_VALOR", "N", 12, 2)
			
    While !Eof()
    	
		#IFNDEF TOP
			If SK1->K1_FILIAL < Mv_Par05 .OR. SK1->K1_FILIAL > Mv_Par06
				DbSkip()
				Loop
			Endif
			
			If SK1->K1_VENCREA < (Mv_Par01-aOperador[nI][4]) .OR. SK1->K1_VENCREA > (Mv_Par02-aOperador[nI][3])
				DbSkip()
				Loop
			Endif
			
			If SK1->K1_OPERAD <> aOperador[nI][1]
				DbSkip()
				Loop
			Endif
			
			DbSelectarea("SE1")
			DbSetOrder(1)
			If !MsSeek(SK1->K1_FILIAL+SK1->K1_PREFIXO+SK1->K1_NUM+SK1->K1_PARCELA+SK1->K1_TIPO)
				DbSelectarea("SK1")
				DbSkip()
				Loop
			Endif

			DbSelectarea("SU7")
			DbSetOrder(1)
			If !MsSeek(xFilial("SU7")+SK1->K1_OPERAD)
				DbSelectarea("SK1")
				DbSkip()
				Loop
			Endif
        #ENDIF
    	
		nPos1 := Ascan(aFilial, {|x| x[2] == SK1->K1_FILIAL })
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณSe a tabela SK1 estiver compartilhada, trata no array aResult para carregar os valores da filial atualณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If nPos1 == 0 
			nPos1:=Ascan(aFilial, {|x| x[2] == cFilAnt })//Atualiza com a Filial atual
		Endif

		nPos2 := Ascan(aResult, {|x| x[1]+x[3] == aFilial[nPos1][2]+(cSU7)->U7_POSTO })
		If nPos2 == 0
			Aadd(aResult, {	aFilial[nPos1][2],;
							aFilial[nPos1][3],;
							(cSU7)->U7_POSTO,;
							1,;						// Qtd Saldo Inicial
							(cSE1)->E1_VALOR,;		// Val Saldo Inicial
							0,;						// Qtd Cobrado
							0,;						// Val Cobrado
							0,;						// Qtd Recuperado
							0,;						// Val Recuperado
							0,;						// Qtd Nao Realizado
							0,;						// Val Nao Realizado
							0,;						// Qtd Cancelado
							0;						// Val Cancelado
							} )
		Else
			aResult[nPos2][4] := aResult[nPos2][4] + 1
			aResult[nPos2][5] := aResult[nPos2][5] + (cSE1)->E1_VALOR
		Endif
		
		DbSelectArea("SK1")
		DbSkip()
	End
	
	DbSelectArea("SK1")
	DbCloseArea()
	ChkFile("SK1")
	
Next nI

Return()
