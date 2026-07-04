/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"         
#INCLUDE "FINR315.ch"

///////////////////
// Lista de Defines
#DEFINE 	_DELETED_		"*"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FIR315A  ³ Autor ³ Cristiano D. Alarcon  ³ Data ³ 09.06.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Funcao para diferenciacao de opcao de menu escolhida.      ³±±
±±³          ³ Esta indica que foi escolhida a impressao de listagem      ³±±
±±³          ³ utilizando as ROTAS do modulo OMS                          ³±±
±±³          ³ Seta a var lRota como .T.                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FIR315A ( void )                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAFIN ( Relatorio -> Cobrancas -> Rota de cobranca )     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FIR315A( )

///////////////////////////////
// Chama a funcao principal
// na qual gerencia o relatorio
// Parametro passado como .T.
// indica que ROTA sera usada
U_FINR315( .T. )

RETURN 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FIR315B  ³ Autor ³ Cristiano D. Alarcon  ³ Data ³ 09.06.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Funcao para diferenciacao de opcao de menu escolhida.      ³±±
±±³          ³ Esta indica que foi escolhida a impressao de listagem      ³±±
±±³          ³ utilizando o arquivo SAR (Clientes x Cobrador)             ³±±
±±³          ³ Seta a var lRota como .F.                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FIR315B ( void )                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAFIN ( Relatorio -> Cobrancas -> Lista de cobranca )    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FIR315B( )

///////////////////////////////
// Chama a funcao principal
// na qual gerencia o relatorio
// Parametro passado como .F.
// indica que SAR sera usada
U_FINR315( .F. )

RETURN       

/*/
Diagrama de funcionamento

Legenda:
////////

MENU
(Funcao Chamada,lRota)

    
Rota de Cobranca ÄÄÄÄÄÄÄÄÄÄÄ¿						   ÚÄÄÄ> lRota := .T.
(FIR315A,.T.)               ³						   ³	 X1_GRUPO = "FI315A"
                            ³						   ³
                            ÃÄÄÄ> U_FINR315( lRota ) ÄÄÄÄ´
                            ³						   ³
                            ³						   ³
Lista de CobrancaÄÄÄÄÄÄÄÄÄÄÄÙ						   ÀÄÄÄ> lRota := .F.	
(FIR315B,.F.)												 X1_GRUPO = "FI315B"

/*/

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FINR315  ³ Autor ³ Cristiano D. Alarcon  ³ Data ³ 06.06.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio de cobrancas por cobrador utilizando as rotas    ³±±
±±³          ³ de OMS, ou entao a relacao de clientes de SAR              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FINR315( lRota )                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAFIN                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³        ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FINR315( lRot )

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± lRota: indica que a ordenacao da visita de cobranca sera feita utilizando as definicoes ±±
±±        de logisticas definidas pelo modulo de OMS									   ±±
±±		  Caso contrario, indica que a ordenacao usara o cadastro de relacionamento feitos ±±
±±		  pelo arquivo SAR ( Cliente X Cobrador )										   ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

///////
// Var:
Local 	cDesc1     	:= ""
Local 	cDesc2     	:= ""
Local 	cDesc3     	:= ""
Local 	titulo     	:= ""
Local   aOrd 	    := {}             
Local 	nLin     	:= 80
Private limite      := 131
Private tamanho     := "M"
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nTipo       := 18 
Private lEnd        := .F.
Private lAbortPrint := .F.
Private nomeprog    := "" // Coloque aqui o nome do programa para impressao no cabecalho
Private nLastKey    := 0
Private cPerg       := ""
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cAreaPrinc  := "SAR"      
Private cAreaTRB	:= "TRB"
Private Cabec1 		:= "" // Cabecalho de campos
Private Cabec2 		:= "" // Cabecalho de campos
Private	cQuery 		:= "" // String SQL
Private	cArqTemp  	:= ""
Private lRota		:= lRot
// Var:
///////                                                   
                                                          
///////////////////////////////
// Cabecalho de campos e Rotina
Cabec1 := OemToAnsi( STR0007 )
Cabec2 := OemToAnsi( STR0008 )
cDesc1 := OemToAnsi( STR0001 )
cDesc2 := OemToAnsi( STR0002 )

//////////////////////////////
// Difere o grupo de perguntas
if lRota
	wnrel    := "FINR315A"
	nomeprog := "FINR315A"
	cPerg 	 := "FI315A"
	cDesc3   := OemToAnsi( STR0003 )
	titulo	 := OemToAnsi( STR0005 )
else
	wnrel    := "FINR315B"
	nomeprog := "FINR315B"
	cPerg 	 := "FI315B"              
	cDesc3   := OemToAnsi( STR0004 )
	titulo	 := OemToAnsi( STR0006 )	
endif         

//////////////////////////////////////////
// Variaveis utilizadas para parametros //
// mv_par01  -> Cobrador ?              //
// mv_par02  -> De  Vencimento ?        //
// mv_par03  -> At‚ Vencimento ?        //
// mv_par04  -> De  Cliente ?           //
// mv_par05  -> At‚ Cliente ?           //
// mv_par06  -> Analitico/Sintetico ?   //
// mv_par07  -> Imprimir cheques ?      //
// mv_par08  -> Rota ?                  //
//////////////////////////////////////////
While ( .T. )

	If !pergunte(cPerg,.T.)
		Return
	Endif

	If lRota 
		Do Case
		   Case Empty( mv_par01 )	
		   		MsgInfo( OemToAnsi(STR0009) ) // Informe qual cobrador deseja imprimir a listagem de cobranca.
		   Otherwise	
				Exit
		EndCase
	Else
		If empty(mv_par01)	
			MsgInfo( OemToAnsi(STR0009) ) // Informe qual cobrador deseja imprimir a listagem de cobranca.
		Else
			Exit
		EndIf			
	EndIf
	
EndDo    

////////////////////////////////////////////
// Monta a interface padrao com o usuario...
wnrel := SetPrint("SE1",NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho,,.F.)

If nLastKey == 27
	Return   
Endif

SetDefault( aReturn, cAreaTRB )

If nLastKey == 27
	Return   	
Endif

nTipo := If( aReturn[4]==1, 15, 18 )
         
         
//////////////////////////////////
// Insere Periodo no titulo do Rel
if !Empty(mv_par02) .and. !Empty(mv_par03)
	titulo += " - " + STR0012 + "( "
	if !Empty(mv_par02)
		titulo += STR0013 + " " + DtoC(mv_par02)
	endif
	if !Empty(mv_par03)
		titulo +=  " " + STR0014 + " " + DtoC(mv_par03)
	endif
	titulo += " )"             
endif

//////////////////////////////////////////////
// Cria e seleciona Area de arquivo Temporario
if lRota
	FINR315A1()
else          
	FINR315A2()
endif
DbSelectArea( cAreaTRB )
DbGoTop()


/////////////////////////////////////////////////////////////////////
// Processamento. RPTSTATUS monta janela com a regua de processamento
RptStatus( {|| FINR315R(Cabec1,Cabec2,Titulo,nLin) }, Titulo )

RETURN        

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FINR315A1³ Autor ³ Cristiano D. Alarcon  ³ Data ³ 09.06.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cria a tabela temporaria com a mesma estrutura, usando      ³±±
±±³          ³TOP ou DBF.                                                 ³±±
±±³          ³Neste caso utiliza a relacao de clientes passando por ROTA  ³±±
±±³          ³do modulo de OMS.                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FINR315A1( void )                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ void                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR315                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³        ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FINR315A1( )

///////
// Var:
Local 	cCheques	:= IIF(Type('MVCHEQUES')=='C',MVCHEQUES,MVCHEQUE)
Local 	cTipCheques := ""
Local 	lCheques	:= .F.
Local 	cQuery    	:= ""
Local 	cFiltro		:= ""
Local   cFiltRot	:= ""
Local 	nA			:= 0
Private aTam		:= {}
// Var:
///////

///////////////////////////
// Filtra E1_TIPO = Cheques
If ( mv_par07 = 2 )
	cTipCheques := Substr(cCheques,1,3)
	cFiltro 	+= " and se1.E1_TIPO NOT IN ("
	For nA := 1 to Len(cCheques) Step 4	
		cFiltro += "'"+cTipCheques+"'" 
		If nA+2 <> Len(cCheques)
			cFiltro += ","
			cTipCheques := Substr(cCheques,nA+4,3)
		EndIf
	Next nA
	cFiltro += ")"
EndIf		
	
/////////////////////////////////////
// Filtra tb por Roteiro se informado
cFiltRot := iif( empty(mv_par08), "", " AND da9.DA9_ROTEIR = '"+mv_par08+"' " )
	
/////////////////////////////////////
// Query de consulta pelo Top Connect
cQuery := " SELECT da9.DA9_ROTEIR TRB_ROTA, da8.DA8_DESC TRB_NOMROT, da7.DA7_SEQUEN TRB_SEQUEN, " ;
		+        " se1.E1_FILIAL TRB_FILIAL, se1.E1_PREFIXO TRB_PREFIX, se1.E1_NUM TRB_NUM, " ;
		+ 	     " se1.E1_PARCELA TRB_PARCEL, se1.E1_TIPO TRB_TIPO, se1.E1_NATUREZ TRB_NATURE, " ;
		+	     " se1.E1_CLIENTE TRB_CLIENT, se1.E1_LOJA TRB_LOJA, se1.E1_EMISSAO TRB_EMISSA, " ;
		+	     " se1.E1_VENCTO TRB_VENCTO, se1.E1_VENCREA TRB_VENCRE, se1.E1_VALOR TRB_VALOR, " ;
		+	     " se1.E1_SALDO TRB_SALDO, se1.E1_NOMCLI TRB_NOMCLI, se1.E1_MOEDA TRB_MOEDA, " ;
		+	     " se1.E1_TXMOEDA TRB_TXMOED, se1.E1_SDACRES TRB_SDACRE, se1.E1_SDDECRE TRB_SDDECR, " ;
		+	     " da5.DA5_COBRAD TRB_CODCOB, " ;
		+	     " sa1.A1_NOME TRB_CLINOM, sa1.A1_END TRB_END, sa1.A1_MUN TRB_MUN, sa1.A1_EST TRB_EST, " ;
		+	     " sa1.A1_BAIRRO TRB_BAIRRO, sa1.A1_CEP TRB_CEP, sa1.A1_DDI TRB_DDI, sa1.A1_DDD TRB_DDD, " ;
		+	     " sa1.A1_TEL TRB_TEL, sa1.A1_ENDCOB TRB_ENDCOB, sa1.A1_CONTATO TRB_CONTAT, " ;
		+	     " saq.AQ_NOME TRB_NOMECO  " ;
		+ " FROM " + RetSqlName( "DA9" ) + " da9, " ;
		+	         RetSqlName( "DA8" ) + " da8, " ;
		+	         RetSqlName( "DA7" ) + " da7, " ;
		+	         RetSqlName( "DA5" ) + " da5, " ;
		+	         RetSqlName( "SE1" ) + " se1, " ;
		+	         RetSqlName( "SA1" ) + " sa1, " ;
		+	         RetSqlName( "SAQ" ) + " saq  " ;
		+ " WHERE  da8.DA8_COD = da9.DA9_ROTEIR " ;
		+    " AND da9.DA9_PERCUR = da7.DA7_PERCUR " ;
		+    " AND da9.DA9_ROTA = da7.DA7_ROTA " ;
		+	 " AND da9.DA9_PERCUR = da5.DA5_COD " ;
		+	 " AND da7.DA7_CLIENT = se1.E1_CLIENTE " ;
		+	 " AND da7.DA7_LOJA = se1.E1_LOJA " ;
		+	 " AND da7.DA7_CLIENT = sa1.A1_COD " ;
		+	 " AND da7.DA7_LOJA = sa1.A1_LOJA " ;
		+	 " AND da5.DA5_COBRAD  = saq.AQ_COD " ;
		+	 " AND da9.DA9_FILIAL  = '" + xFilial("DA9") + "' " ;
		+	 " AND da8.DA8_FILIAL  = '" + xFilial("DA8") + "' " ;
		+	 " AND da7.DA7_FILIAL  = '" + xFilial("DA7") + "' " ;
		+	 " AND da5.DA5_FILIAL  = '" + xFilial("DA5") + "' " ;
		+	 " AND se1.E1_FILIAL   = '" + xFilial("SE1") + "' " ;
		+	 " AND sa1.A1_FILIAL   = '" + xFilial("SA1") + "' " ;
		+	 " AND saq.AQ_FILIAL   = '" + xFilial("SAQ") + "' " ;
		+	 " AND da9.D_E_L_E_T_ != '" + _DELETED_      + "' " ;
		+	 " AND da8.D_E_L_E_T_ != '" + _DELETED_      + "' " ;
		+	 " AND da7.D_E_L_E_T_ != '" + _DELETED_      + "' " ;
		+	 " AND da5.D_E_L_E_T_ != '" + _DELETED_      + "' " ;
		+	 " AND se1.D_E_L_E_T_ != '" + _DELETED_      + "' " ;
		+	 " AND sa1.D_E_L_E_T_ != '" + _DELETED_      + "' " ;
		+	 " AND saq.D_E_L_E_T_ != '" + _DELETED_      + "' " ;
		+	 cFiltRot 											;
		+	 " AND da7.DA7_CLIENT >= '" + mv_par04       + "' " ;
		+	 " AND da7.DA7_CLIENT <= '" + mv_par05       + "' " ;
		+	 " AND da5.DA5_COBRAD  = '" + mv_par01       + "' " ;
		+	 " AND se1.E1_SALDO    >  0 " 						;
		+	 " AND se1.E1_VENCREA >= '" + DtoS(mv_par02) + "' " ;
		+	 " AND se1.E1_VENCREA <= '" + DtoS(mv_par03) + "' " ;
		+	 cFiltro  ;
		+ " ORDER BY da9.DA9_ROTEIR, da7.DA7_SEQUEN, se1.E1_PREFIXO, se1.E1_NUM, se1.E1_PARCELA "
		
cQuery := ChangeQuery(cQuery)
dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAreaTRB, .F., .T.)
	
TcSetField( "TRB", "TRB_EMISSA", "D" )
TcSetField( "TRB", "TRB_VENCTO", "D" )
TcSetField( "TRB", "TRB_VENCRE", "D" )

RETURN

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FINR315A2³ Autor ³ Cristiano D. Alarcon  ³ Data ³ 09.06.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cria a tabela temporaria com a mesma estrutura, usando      ³±±
±±³          ³TOP ou DBF.                                                 ³±±
±±³          ³Neste caso utiliza a relacao de clientes do arquivo SAR     ³±±
±±³          ³( Cliente X Cobrador ) relacao em SA1 e SAQ                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FINR315A2( void )                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ void                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR315                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³        ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FINR315A2( )

///////
// Var:
Local 	cCheques	:= IIF(Type('MVCHEQUES')=='C',MVCHEQUES,MVCHEQUE)
Local 	cTipCheques := ""
Local 	lCheques	:= .F.
Local 	cQuery    	:= ""
Local 	cFiltro		:= ""
Local 	nA			:= 0
Private aTam		:= {}
// Var:
///////

///////////////////////////
// Filtra E1_TIPO = Cheques
If ( mv_par07 = 2 )
	cTipCheques := Substr(cCheques,1,3)
	cFiltro 	+= " and se1.E1_TIPO NOT IN ("
	For nA := 1 to Len(cCheques) Step 4	
		cFiltro += "'"+cTipCheques+"'" 
		If nA+2 <> Len(cCheques)
			cFiltro += ","
			cTipCheques := Substr(cCheques,nA+4,3)
		EndIf
	Next nA
	cFiltro += ")"
EndIf	
	
////////////////////////////////////////
// Query de consulta ao Banco Relacional
cQuery := " Select se1.E1_FILIAL TRB_FILIAL, se1.E1_PREFIXO TRB_PREFIX, se1.E1_NUM TRB_NUM, " ;
   		+        " se1.E1_PARCELA TRB_PARCEL, se1.E1_TIPO TRB_TIPO, se1.E1_NATUREZ TRB_NATURE, " ;
		+ 		 " se1.E1_CLIENTE TRB_CLIENT, se1.E1_LOJA TRB_LOJA, se1.E1_EMISSAO TRB_EMISSA, " ;
		+ 		 " se1.E1_VENCTO TRB_VENCTO, se1.E1_VENCREA TRB_VENCRE, se1.E1_VALOR TRB_VALOR, " ;
		+ 		 " se1.E1_SALDO TRB_SALDO, se1.E1_NOMCLI TRB_NOMCLI, se1.E1_MOEDA TRB_MOEDA," ;
		+        " se1.E1_TXMOEDA TRB_TXMOED, se1.E1_SDACRES TRB_SDACRE, se1.E1_SDDECRE TRB_SDDECR, " ;
		+ 		 " sar.AR_CODCOBR TRB_CODCOB, sar.AR_SEQUENC TRB_SEQUEN, " ;
		+ 		 " sa1.A1_NOME TRB_CLINOM, sa1.A1_END TRB_END, sa1.A1_MUN TRB_MUN, " ;
		+ 		 " sa1.A1_EST TRB_EST, sa1.A1_BAIRRO TRB_BAIRRO, sa1.A1_CEP TRB_CEP, " ;
		+ 		 " sa1.A1_DDI TRB_DDI, sa1.A1_DDD TRB_DDD, sa1.A1_TEL TRB_TEL, " ;
		+ 		 " sa1.A1_ENDCOB TRB_ENDCOB, sa1.A1_CONTATO TRB_CONTAT, " ;
		+		 " saq.AQ_NOME TRB_NOMECO " ;	
		+ " From " + RetSqlName( "SE1" ) + " se1, " ; 
	 	+  	         RetSqlName( "SAR" ) + " sar, " ;
		+            RetSqlName( "SA1" ) + " sa1, " ;
		+            RetSqlName( "SAQ" ) + " saq  " ;
		+ " Where se1.E1_CLIENTE = sar.AR_CODCLI " ;
		+   " and se1.E1_LOJA = sar.AR_LOJCLI " ;
		+   " and se1.E1_CLIENTE = sa1.A1_COD " ;
		+   " and se1.E1_LOJA = sa1.A1_LOJA " ;
		+   " and sar.AR_CODCOBR = saq.AQ_COD " ;
		+   " and se1.E1_FILIAL   = '" + xFilial("SE1") + "' " ;
		+   " and sar.AR_FILIAL   = '" + xFilial("SAR") + "' " ;
		+   " and sa1.A1_FILIAL   = '" + xFilial("SA1") + "' " ;
		+   " and saq.AQ_FILIAL   = '" + xFilial("SAQ") + "' " ;
		+   " and se1.D_E_L_E_T_ != '" + _DELETED_      + "' " ;
		+   " and sar.D_E_L_E_T_ != '" + _DELETED_      + "' " ;
		+   " and sa1.D_E_L_E_T_ != '" + _DELETED_      + "' " ;
		+   " and saq.D_E_L_E_T_ != '" + _DELETED_      + "' " ;
		+   " and sar.AR_CODCOBR  = '" + mv_par01       + "' " ;
		+   " and se1.E1_VENCTO  >= '" + DtoS(mv_par02) + "' " ;
		+   " and se1.E1_VENCTO  <= '" + DtoS(mv_par03) + "' " ;
		+   " and se1.E1_CLIENTE >= '" + mv_par04       + "' " ;
		+   " and se1.E1_CLIENTE <= '" + mv_par05       + "' " ;
		+   " and se1.E1_SALDO    > 0 " ;
		+   cFiltro  ;
		+ " Order By sar.AR_SEQUENC, se1.E1_PREFIXO, se1.E1_NUM, se1.E1_PARCELA  "
		  
cQuery := ChangeQuery(cQuery)
dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAreaTRB, .F., .T.)
	
TcSetField( "TRB", "TRB_EMISSA", "D" )
TcSetField( "TRB", "TRB_VENCTO", "D" )
TcSetField( "TRB", "TRB_VENCRE", "D" )

RETURN                                                                                      

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FINR315R ³ Autor ³ Cristiano D. Alarcon  ³ Data ³ 11.06.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Funcao contendo a logica de impressao, usa o arquivo TRB    ³±±
±±³          ³temporario criado pela funcao FIR?00A?()                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FINR315R(ExpC1,ExpC2,ExpC3,ExpN1)                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Cabecalho superior                                 ³±±
±±³          ³ ExpC2 = Cabecalho inferior                                 ³±±
±±³          ³ ExpC3 = Titulo do relatorio                                ³±±
±±³          ³ ExpN1 = Qtde de linhas que cabem no relatorio              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR315                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³        ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FINR315R( Cabec1, Cabec2, Titulo, nLin )

///////
// Var:
Local 	nTamTit		:= 10
Local 	nA			:= 0
Local	cMoeda		:= ""
Local	nMoeda		:= 0
Local 	lAnalitico 	:= iif( mv_par06 == 1, .T., .F. )
Local 	cCliSur	 	:= ""		
Local  	cCodRota	:= ""
Local 	nCliNum    	:= 0
Local 	nAtraso	 	:= 0 // Dias em Atraso do titulo
Local 	nValor		:= 0 
Local 	nSaldo    	:= 0
Local 	aTotCli		:= {} // Array contendo total do mesmo cliente em todas as moedas
Local	aTotGer		:= {} // Array contendo total de todos clientes em todas as moedas
Private cbTxt    	:= Space(10)
Private cbCont   	:= 0
Private nLinha		:= nLin
Private nQtdeLin	:= 55 // Quantidade de linhas do Rel.
Private	cRota		:= ""
Private	cCobrador  	:= ""
Private nRegPrim   	:= 0 // Indica que e primeiro registro da pagina 
Private nPage		:= 0
// Var:
///////   

dbSelectArea( cAreaTRB )

/////////////////////////////////
// Inicializa os Arrays de Totais
For nA := 1  To MoedFin()
	cMoeda := Str(nA,IIf(nA <= 9,1,2))
	If !Empty(GetMv("MV_MOEDA"+cMoeda))
		Aadd( aTotCli, {0,0,GetMv("MV_MOEDA"+cMoeda)} )                            
		Aadd( aTotGer, {0,0,GetMv("MV_MOEDA"+cMoeda)} )
	Else
		Exit
  	Endif
Next nA

// LAY-OUT:
// 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
//           1         2         3         4         5         6         7         8         9         10        11        12        13
//"Seq-(CliCod/Sc) Cliente              DDD Telefone   Contato    Endereco                       Bairro                Municipio     UF            
//"  Titulos -> Prf-Numero         TP  Natureza   Emissao    Vencto     MD   Valor Original   Valor Vencido    Valor a Vencer   Atraso
//"------------------------------------------------------------------------------------------------------------------------------------
// 999-(999999/99) XXXXXXXXXXXXXXXXXXXX 999 9999999999 XXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXX XX 
//              XXX-999999999999-1 XXX XXXXXXXXXX 99/99/9999 99/99/9999 99   999.999.999,99   999.999.999,99   999.999.999,99     9999
//																							  --------------   --------------          								
//  															 Sub-total 99 XXXXXXXXXX -> 9.999.999.999,99 9.999.999.999,99  
//
//
//  											               TOTAL GERAL 99 XXXXXXXXXX -> 9.999.999.999,99 9.999.999.999,99



//////////////////////////////////////////////////////////////////////
// SETREGUA -> Indica quantos registros serao processados para a regua 
SetRegua(RecCount())

While !EOF()
	      
    //////////////////////////////////////////
    // Verifica o cancelamento pelo usuario...
    If lAbortPrint
       @nLinha,00 PSAY "*** CANCELADO PELO OPERADOR ***"
       Exit
    Endif

                      // Cobrador
	cCobrador := Pad( STR0011, nTamTit ) + ": (" + Pad(Alltrim(TRB->TRB_CODCOB),TamSX3("AQ_COD" )[1]) + ")- " + Alltrim(TRB->TRB_NOMECO)    
	if lRota
		cRota := Pad( STR0017, nTamTit ) + ": (" + Pad(Alltrim(TRB->TRB_ROTA)  ,TamSX3("DA8_COD")[1]) + ")- " + Alltrim(TRB->TRB_NOMROT)    
		              // Rota
	endif	
    
	nRegPrim++
    
    //////////////
    // Define Rota
	if lRota
		if ( cCodRota != TRB_ROTA )
			nLinha := nQtdeLin+1
				FINR315C(Cabec1,Cabec2,Titulo)
		
			cCodRota := TRB_ROTA
		endif
	else
		FINR315C(Cabec1,Cabec2,Titulo)
	endif
	
	///////////////////////////
	// imprime dados do Cliente
	// executa uma vez por Cli
	if ( cCliSur != TRB->TRB_CLIENT + TRB->TRB_LOJA )
	
		For nA := 1  To MoedFin()
			cMoeda := Str(nA,IIf(nA <= 9,1,2))
			nMoeda := Val(cMoeda)
			If !Empty(GetMv("MV_MOEDA"+cMoeda))
				aTotCli[nMoeda][1] := 0
				aTotCli[nMoeda][2] := 0
			Else
				Exit
		  	Endif
		Next nA
	
		nLinha++
		nLinha++
			FINR315C(Cabec1,Cabec2,Titulo)
			
		nCliNum++
		if ( nCliNum != 1 ) .and. ( nRegPrim != 1 )
			nLinha++
			FINR315C(Cabec1,Cabec2,Titulo)
		endif
		
		cCliSur := TRB->TRB_CLIENT + TRB->TRB_LOJA
		
		@nLinha,000 PSAY StrZero( nCliNum, 3 ) + "-"
		@nLinha,004 PSAY "(" + Pad(TRB->TRB_CLIENT, 06 )
		@nLinha,011 PSAY "/" + TRB->TRB_LOJA + ")"
		
		if !lAnalitico
			@nLinha,016 PSAY Pad( Alltrim(TRB->TRB_CLINOM), 40 )
		else
			@nLinha,016 PSAY Pad( Alltrim(TRB->TRB_NOMCLI ), 20 )
			@nLinha,037 PSAY Pad( Alltrim(TRB->TRB_DDD )   , 03 )
			@nLinha,041 PSAY Pad( Alltrim(TRB->TRB_TEL )   , 10 )
			@nLinha,052 PSAY Pad( Alltrim(TRB->TRB_CONTAT) , 10 )
			if empty(TRB->TRB_ENDCOB)
				@nLinha,063 PSAY Pad( Alltrim(TRB->TRB_END)   , 30 )
			else
				@nLinha,063 PSAY Pad( Alltrim(TRB->TRB_ENDCOB), 30 )
			endif
			@nLinha,094 PSAY Pad( Alltrim(TRB->TRB_BAIRRO), 21 )
			@nLinha,116 PSAY Pad( Alltrim(TRB->TRB_MUN)   , 13 )
			@nLinha,130 PSAY Pad( Alltrim(TRB->TRB_EST)   , 02 )
		endif

	endif
	
	//////////////////
	// Dados da Fatura
	if lAnalitico
		nLinha++
			FINR315C(Cabec1,Cabec2,Titulo)
		@nLinha,002 PSAY Pad(  Alltrim(TRB->TRB_PREFIX ), 03 ) + "-"
		@nLinha,007 PSAY Pad(  Alltrim(TRB->TRB_NUM    ), 20 )
		@nLinha,029 PSAY "-" + Alltrim(TRB->TRB_PARCEL )
		@nLinha,032 PSAY Pad(  Alltrim(TRB->TRB_TIPO   ), 03 )
		@nLinha,036 PSAY Pad(  Alltrim(TRB->TRB_NATURE ), 10 )
		@nLinha,047 PSAY TRB->TRB_EMISSA
		@nLinha,058 PSAY TRB->TRB_VENCRE
		@nLinha,069 PSAY StrZero( TRB->TRB_MOEDA, 2 )
	endif
	 	
	/////////////////
	// Valor Original
	nValor := TRB->TRB_VALOR * If(TRB->TRB_TIPO$MVABATIM,-1,1)
	if lAnalitico
		@nLinha,074 PSAY ( nValor ) Picture PesqPict("SE1","E1_VALOR",14)
	endif
	        
	////////
	// Saldo
	dDataReaj := IIF( (TRB->TRB_VENCRE < dDataBase), TRB->TRB_VENCRE, dDataBase )
	nSaldo 	  := ( TRB->TRB_SALDO + TRB->TRB_SDACRE - TRB->TRB_SDDECR )        // Alterado  TRB->TR_VALOR p/ TRB->TRB_SALDO
	
	////////////////////////
	// Ajusta valor do Saldo
	If ( TRB->TRB_TIPO $ MVRECANT+"/"+MV_CRNEG )
		nSaldo := -nSaldo
	Endif
	
	///////////////////
	// Titulos Vencidos
	If ( dDataBase > TRB->TRB_VENCRE ) 
	
		If !( TRB->TRB_TIPO $ MVABATIM ) .and. ( lAnalitico )
			@nLinha,091 PSAY nSaldo  Picture PesqPict("SE1","E1_SALDO",14)
		EndIf
		aTotCli[TRB->TRB_MOEDA][1] += nSaldo
		aTotGer[TRB->TRB_MOEDA][1] += nSaldo
		
	///////////////////
	// Titulos A Vencer
	Else
	
		if !( TRB->TRB_TIPO $ MVABATIM ) .and. ( lAnalitico )
			@nLinha,108 PSAY nSaldo Picture PesqPict("SE1","E1_SALDO",14)
		endif
		aTotCli[TRB->TRB_MOEDA][2] += nSaldo
		aTotGer[TRB->TRB_MOEDA][2] += nSaldo 
		
	Endif
		
	/////////////////
	// Dias em Atraso
	IF ( dDataBase > TRB->TRB_VENCRE ) .and. ( lAnalitico )
		nAtraso := ( dDataBase - TRB->TRB_VENCTO )
		IF ( Dow(TRB->TRB_VENCTO) == 1 ) .Or. ( Dow(TRB->TRB_VENCTO) == 7 )
			IF ( Dow(dDataBase) == 2 ) .and. ( nAtraso <= 2 )
				nAtraso := 0
			EndIF
		EndIF
		nAtraso := IIF( nAtraso < 0, 0, nAtraso )
		IF ( nAtraso > 0 )
			@nLinha,127 PSAY nAtraso Picture "9999"
		EndIF
	EndIF	

    dbSkip()	
	    
	/////////
	// Totais
	if ( Eof() ) .or. ( cCliSur != TRB->TRB_CLIENT + TRB->TRB_LOJA ) 
		
		/////////////////////////////////
		// Atribui valores ao total geral
		//aTotGer[TRB->TRB_MOEDA][1] += aTotCli[TRB->TRB_MOEDA][1]
		//aTotGer[TRB->TRB_MOEDA][2] += aTotCli[TRB->TRB_MOEDA][2]
		
		if lAnalitico
			nLinha++
				FINR315C(Cabec1,Cabec2,Titulo)
		endif
		For nA := 1  To MoedFin()
			cMoeda := Str(nA,IIf(nA <= 9,1,2))
			nMoeda := Val(cMoeda)
			If !Empty(GetMv("MV_MOEDA"+cMoeda))
				if ( cMoeda == "1" ) .or. (aTotCli[nMoeda][1]>0) .or. (aTotCli[nMoeda][2]>0)
					nLinha++
						FINR315C(Cabec1,Cabec2,Titulo)
					@nLinha,062 PSAY STR0015
					@nLinha,072 PSAY StrZero(Val(cMoeda),2)
					@nLinha,075 PSAY Pad( Alltrim(GetMv("MV_MOEDA"+cMoeda)), 10 )
					@nLinha,086 PSAY "->"  
					@nLinha,089 PSAY aTotCli[nMoeda][1] Picture PesqPict("SE1","E1_SALDO",16)
					@nLinha,106 PSAY aTotCli[nMoeda][2] Picture PesqPict("SE1","E1_SALDO",16)
				endif
			Else
				Exit
		  	Endif
		Next nA
	endif
	
	If ( nLinha > nQtdeLin )
    	Roda( CbCont, cbtxt, Tamanho )
    EndIf 
 
    If ( eof() )
	   
   		/////////////////////////////
		// Total de todos os clientes
		For nA := 1  To MoedFin()
				
			cMoeda := Str(nA,IIf(nA <= 9,1,2))
			nMoeda := Val(cMoeda)
			
			nLinha++
			nLinha++
				FINR315C(Cabec1,Cabec2,Titulo)		  
			If !Empty(GetMv("MV_MOEDA"+cMoeda))
				if (aTotGer[nMoeda][1]>0) .or. (aTotGer[nMoeda][2]>0)
					nLinha++
						FINR315C(Cabec1,Cabec2,Titulo)
					@nLinha,058 PSAY STR0016 
					@nLinha,072 PSAY StrZero(Val(cMoeda),2)
					@nLinha,075 PSAY Pad( Alltrim(GetMv("MV_MOEDA"+cMoeda)), 10 )
					@nLinha,086 PSAY "->"  
					@nLinha,089 PSAY aTotGer[nMoeda][1] Picture PesqPict("SE1","E1_SALDO",16)
					@nLinha,106 PSAY aTotGer[nMoeda][2] Picture PesqPict("SE1","E1_SALDO",16)
				endif
			Else
				Exit
		  	Endif
		  
		Next nA                   

    	/////////
    	// Rodape
    	Roda( CbCont, cbtxt, Tamanho )      
    	
    EndIf
   
EndDo    

///////////////////////////////////
// Finaliza a execucao do relatorio
SET DEVICE TO SCREEN

///////////////////////////////////////////////////////
// Fecha Area de Arq. Temporario e Apaga DBF temporario
dbSelectArea( cAreaTRB )
dbCloseArea() 
Ferase( cArqTemp + GetDBExtension() )
Ferase( cArqTemp + OrdBagExt()      )

///////////////////////////////////
// Se impressao em disco, 
// chama o gerenciador de impressao
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool( wnrel )
Endif

MS_FLUSH()

RETURN

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ FINR315C ³ Autor ³ Cristiano D. Alarcon  ³ Data ³ 26.06.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Imprime cabecalho do relatorio, ja verificando o estouro    ³±±
±±³          ³de valor de nLinha.                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FINR315C(ExpC1,ExpC2,ExpC3)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Cabecalho superior                                 ³±±
±±³          ³ ExpC2 = Cabecalho inferior                                 ³±±
±±³          ³ ExpC3 = Titulo do relatorio                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ FINR315R                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³        ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FINR315C( Cabec1, Cabec2, Titulo )

If ( nLinha > nQtdeLin ) // Salto de Pagina.

	nPage++
    
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)                       
	       
	nLinha := 8
	       
	////////////////////////////////////
	// Topo da pagina: Dados do cobrador
	nLinha++
	@nLinha,00 PSAY cCobrador
	if lRota               
		nLinha++
		@nLinha,00 PSAY cRota
	endif
	nRegPrim := 1

	If nPage > 1 //Segunda página em diante
		nLinha++
		nLinha++
	EndIf
       
Endif

RETURN