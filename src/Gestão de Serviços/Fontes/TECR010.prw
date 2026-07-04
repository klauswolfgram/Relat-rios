/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TECR010.CH"
#include "report.ch"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)


Static cPergRel := ""

/*/


ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ TECR010  ³ Autor ³ Cleber Martinez       ³ Data ³ 21.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Base instalada ( Amarracao Cliente x Equipamento )		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_TECR010(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Relatorio Personalizavel									  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TECR010()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

If TecHasPerg("MV_PAR01", "TECR010")
	cPergRel := "TECR010"
Else	
	cPergRel := "ATR010"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PARAMETROS                                                             ³
//³ MV_PAR01 : Produto de ?                                                ³
//³ MV_PAR02 : Produto ate?                                                ³
//³ MV_PAR03 : Cliente de ?                                                ³
//³ MV_PAR04 : Cliente ate?                                                ³
//³ MV_PAR05 : Grupo de ?                                                  ³
//³ MV_PAR06 : Grupo ate?                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPergRel,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := Tcr010RptDef()
oReport:PrintDialog()

RestArea( aArea )
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR010R3 ³ Autor ³ Eduardo Riera         ³ Data ³ 10.09.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Base instalada ( Amarracao Cliente x Equipamento )          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³12/01/2000³Sergio Silveira³ Acerto na exibicao do produto e numero de  ³±± 
±±³          ³               ³ serie do Acessorio / Colocacao de Query    ³±± 
±±³          ³               ³ e IndRegua.                                ³±±  
±±³17/05/2000³Sergio Silveira³ Ajuste no lay-out para contemplar SXG      ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function TECR010R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cTitulo   := STR0001 //"Relacao de Equipamentos"
Local cDesc1   := STR0002 //"	Este relatorio ira imprimir a relacao de equipamentos"
Local cDesc2   := STR0003 //"e acessorios conforme os parametros solicitados"
Local cDesc3   := STR0004 //""
Local cString  := "AA3"
Local lDic     := .F.
Local lComp    := .T.
Local lFiltro  := .T.
Local wnrel    := "TECR010"
Local cNomeProg := "TECR010"
Local nTamCli  := 0 
Local aTamSXG  := TamSXG("001")
Local aTamSXG2 := TamSXG("002")
		               
nTamCli  := aTamSXG[1] + aTamSXG2[1] 		

Private Tamanho := "G"
Private Limite  := 220 // 80/132/220
Private aOrdem  := {}  // Ordem do Relatorio
Private aReturn := { STR0005, 1,STR0006, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
						//[1] Reservado para Formulario
						//[2] Reservado para N§ de Vias
						//[3] Destinatario
						//[4] Formato => 1-Comprimido 2-Normal
						//[5] Midia   => 1-Disco 2-Impressora
						//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
						//[7] Expressao do Filtro
						//[8] Ordem a ser selecionada
						//[9]..[10]..[n] Campos a Processar (se houver)

Private lEnd    := .F.// Controle de cancelamento do relatorio
Private m_pag   := 1  // Contador de Paginas
Private nLastKey:= 0  // Controla o cancelamento da SetPrint e SetDefault

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PARAMETROS                                                             ³
//³ MV_PAR01 : Produto de ?                                                ³
//³ MV_PAR02 : Produto ate?                                                ³
//³ MV_PAR03 : Cliente de ?                                                ³
//³ MV_PAR04 : Cliente ate?                                                ³
//³ MV_PAR05 : Grupo de ?                                                  ³
//³ MV_PAR06 : Grupo ate?                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


Pergunte(cPergRel,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrinter                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPergRel,@cTitulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)
If ( nLastKey==27 )
	DbSelectArea(cString)
	DbSetOrder(1)
	Set Filter to
	Return
Endif
SetDefault(aReturn,cString)
If ( nLastKey==27 )
	DbSelectArea(cString)
	DbSetOrder(1)
	Set Filter to
	Return
Endif
#IFDEF WINDOWS
	RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,cNomeProg,cTitulo,nTamCli)},cTitulo)
#ELSE
	ImpDet(.F.,wnrel,cString,cNomeProg,cTitulo,nTamCli)
#ENDIF
Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³ Eduardo Riera         ³ Data ³02.07.1998³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controle de Fluxo do Relatorio.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ 29/08/07 ³ Conrado Q.    ³ -BOPS 131167: Corrigida a exibição do nome ³±±
±±³          ³               ³ do produto.                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpDet(lEnd, wnrel, cString, cNomeProg, cTitulo, nTamCli)

Local li      := 100 // Contador de Linhas
Local lImp    := .F. // Indica se algo foi impresso
Local cbCont  := 0   // Numero de Registros Processados
Local cbText  := ""  // Mensagem do Rodape
//                                    1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                          01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local cCabec1 := STR0008 //"CLIENTE   NOME                 PRODUTO         DESC.PRODUTO                   N.SERIE              VENDA      INSTALACAO GARANTIA   FORNECEDOR DESC.FORNECEDOR      FABRICANTE DESC.FABR.      MODELO                        "
//                          XXXXXX-XX XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX 99/99/9999 99/99/9999 99/99/9999 XXXXXX-XX  XXXXXXXXXXXXXXXXXXXX XXXXXX-XX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Local cCabec2 := STR0009 //"                               ACESSORIO       DESC.ACESS.                    N.SERIE ACESSORIO"
//                                                         XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX
//                                    1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                          01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                          XXXXXXXXXXXXXXXXXXXX-XXXX XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX 99/99/9999 99/99/9999 99/99/9999 XXXXXXXXXXXXXXXXXXXX-XXXX XXXXXXXXXXXXXXXXXXXX-XXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
//                         "                                               ACESSORIO            DESC.ACESS.     N.SERIE ACESSORIO"
//                                                                         XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXX
Local aStruAA3  := {}
Local cOrderBy  := ""
Local cQuery    := ""
Local cQryAd    := ""
Local nX        := 0
Local cName     := ""
Local cCond     := ""
Local cAlias    := ""
Local cIndexKey := ""
Local cIndTrab  := ""
Local nIndice   := 0
Local bFiltro   := { || .T. }

If nTamCli > 8
	cCabec1 := STR0010
	cCabec2 := STR0011
Else
	cCabec1 := STR0008
	cCabec2 := STR0009
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso ultrapasse, utiliza o tamanho grande de Lay-Out                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
    
	If (TcSrvType()#'AS/400')
	
		aStruAA3 := AA3->(dbStruct())
		cOrderBy := SqlOrder( AA3->( IndexKey() ) )
	
		cQuery := "SELECT AA3_CODCLI, AA3_LOJA, AA3_FILIAL, AA3_CODPRO, AA3_NUMSER, AA3_DTVEND, AA3_DTINST, AA3_DTGAR, "
		cQuery += "AA3_FORNEC, AA3_LOJAFO, AA3_CODFAB, AA3_LOJAFA, AA3_MODELO"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Esta rotina foi escrita para adicionar no select os campos do AA3 usados no filtro do usuario ³
		//³quando houver, a rotina acrecenta somente os campos que forem adicionados ao filtro testando  ³
	    //³se os mesmo ja existem no selec ou se forem definidos novamente pelo o usuario no filtro.     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ! Empty(aReturn[7])
			For nX := 1 To AA3->(FCount())
				cName := AA3->(FieldName(nX))
				If AllTrim( cName ) $ aReturn[7]
					If aStruAA3[nX,2] <> "M"
						If !cName $ cQuery .And. !cName $ cQryAd
							cQryAd += ", "+ cName
						EndIf
					EndIf
				EndIf
			Next nX
		EndIf
		cQuery += cQryAd
		cQuery += " FROM " + RetSqlName( "AA3" )+ " AA3, " + RetSqlName( "SB1" )+ " SB1 "
		cQuery += "WHERE AA3_FILIAL = '" + xFilial( "AA3" ) + "'"
		cQuery += " AND AA3_CODPRO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "'"
		cQuery += " AND AA3_CODCLI BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'"
		cQuery += " AND B1_FILIAL = '" + xFilial( "SB1" ) + "'"
		cQuery += " AND B1_GRUPO BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "'"
		cQuery += " AND B1_COD = AA3_CODPRO"
		cQuery += " AND AA3.D_E_L_E_T_ = ' '"
		cQuery += " AND SB1.D_E_L_E_T_ = ' '"
		cQuery += " ORDER BY " + cOrderBy
		cQuery := ChangeQuery( cQuery )
		
		dbUseArea(.T., "TOPCONN", TcGenQry( ,, cQuery ), "TRAB" , .F., .T. )
		
		cAlias := "TRAB"

		For nX := 1 To Len(aStruAA3)
			If aStruAA3[nX][2] <> "C" .and. FieldPos(aStruAA3[nX][1]) > 0
				TcSetField(cAlias,aStruAA3[nX][1],aStruAA3[nX][2],aStruAA3[nX][3],aStruAA3[nX][4])
			EndIf
		Next nX

	Else

#ENDIF

		cIndTrab  := CriaTrab( , .F. )

		AA3->( DbSetOrder( 1 ) )
		cIndexKey := AA3->( IndexKey() )

		cQuery := ""
		cQuery += "AA3_FILIAL == '" + xFilial( "AA3" ) + "' .AND. "
		cQuery += "AA3_CODPRO >= '" + MV_PAR01 + "' .AND. "
		cQuery += "AA3_CODPRO <= '" + MV_PAR02 + "' .AND. "
		cQuery += "AA3_CODCLI >= '" + MV_PAR03 + "' .AND. "
		cQuery += "AA3_CODCLI <= '" + MV_PAR04 + "'"

		IndRegua( "AA3", cIndTrab, cIndexKey, , cQuery, "Criando indice de trabalho !" )

		nIndice := RetIndex( "AA3" ) + 1

		#IFNDEF TOP
			AA3->( DbSetIndex( cIndTrab + OrdBagExt() ) )
		#ENDIF

		cAlias := "AA3"

		AA3->( DbSetOrder( nIndice ) )
		AA3->( DbGotop() )

#IFDEF TOP
	EndIf
#ENDIF

If !Empty( aReturn[7] )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Constroi um code-block a partir do filtro para melhorar performance    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	bFiltro := &( " { || ( cAlias )->( " + aReturn[ 7 ] + " ) } " )
EndIf

DbSelectArea( "AA3" )
SetRegua( LastRec() )

While ( !( cAlias )->( Eof() ) )
	#IFNDEF TOP
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial("SB1")+(cAlias)->AA3_CODPRO)
		If SB1->B1_GRUPO < MV_PAR05 .Or. SB1->B1_GRUPO > MV_PAR06
			(cAlias)->(DbSkip())
			Loop
		EndIf
		lImp := .T.
	#ENDIF

	#IFNDEF WINDOWS
		If LastKey() = 286
			lEnd := .T.
		EndIf
	#ENDIF

	If lEnd
		@ Prow()+1,001 PSAY STR0007 //"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If ( li > 60 )
		li := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,Tamanho,CHRCOMP)
		li++
	Endif
	
	If Eval( bFiltro )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Ajusta o Lay-Out de acordo com o tamanho                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nTamCli > 8
			@ Li,000 PSAY ( cAlias )->AA3_CODCLI+"-"+AA3->AA3_LOJA
			DbSelectArea("SA1")
			DbSetOrder(1)
			If DbSeek(xFilial("SA1")+( cAlias )->AA3_CODCLI+( cAlias )->AA3_LOJA)
				@ Li,026 PSAY SubStr(AllTrim(SA1->A1_NREDUZ),1,20)
			EndIf
			@ Li,047 PSAY ( cAlias )->AA3_CODPRO
			DbSelectArea("SB1")
			DbSetOrder(1)
			If DbSeek(xFilial("SB1")+( cAlias )->AA3_CODPRO)
				@ Li,068 PSAY AllTrim(SB1->B1_DESC)
			EndIf
			@ Li,084 PSAY ( cAlias )->AA3_NUMSER
			@ Li,105 PSAY ( cAlias )->AA3_DTVEND
			@ Li,116 PSAY ( cAlias )->AA3_DTINST
			@ Li,127 PSAY ( cAlias )->AA3_DTGAR
			If Len(AllTrim((( cAlias )->AA3_FORNEC+( cAlias )->AA3_LOJAFO))) > 0
				@ Li,138 PSAY ( cAlias )->AA3_FORNEC+"-"+( cAlias )->AA3_LOJAFO
			EndIf
			If Len(AllTrim(( cAlias )->AA3_CODFAB+( cAlias )->AA3_LOJAFA)) > 0
				@ Li,164 PSAY ( cAlias )->AA3_CODFAB+"-"+( cAlias )->AA3_LOJAFA
			EndIf
			@ Li,190 PSAY ( cAlias )->AA3_MODELO
		Else
			@ Li,000 PSAY ( cAlias )->AA3_CODCLI+"-"+( cAlias )->AA3_LOJA
			DbSelectArea("SA1")
			DbSetOrder(1)
			If DbSeek(xFilial("SA1")+( cAlias )->AA3_CODCLI+( cAlias )->AA3_LOJA)
				@ Li,010 PSAY SubStr(AllTrim(SA1->A1_NREDUZ),1,20)
			EndIf
			@ Li,031 PSAY ( cAlias )->AA3_CODPRO
			DbSelectArea("SB1")
			DbSetOrder(1)
			If DbSeek(xFilial("SB1")+( cAlias )->AA3_CODPRO)
				@ Li,047 PSAY SubStr(AllTrim(SB1->B1_DESC),1,30)
			EndIf
			@ Li,078 PSAY ( cAlias )->AA3_NUMSER
			@ Li,099 PSAY ( cAlias )->AA3_DTVEND
			@ Li,110 PSAY ( cAlias )->AA3_DTINST
			@ Li,121 PSAY ( cAlias )->AA3_DTGAR
			If Len(Alltrim(( cAlias )->AA3_FORNEC+( cAlias )->AA3_LOJAFO)) > 0
				@ Li,132 PSAY ( cAlias )->AA3_FORNEC+"-"+( cAlias )->AA3_LOJAFO
				DbSelectArea("SA2")
				DbSetOrder(1)
				If DbSeek(xFilial("SA2")+( cAlias )->AA3_FORNEC+( cAlias )->AA3_LOJAFO)
					@ Li,143 PSAY SubStr(AllTrim(SA2->A2_NREDUZ),1,20)
				EndIf
			EndIf
			
			If !Empty( AllTrim( ( cAlias )->AA3_CODFAB+( cAlias )->AA3_LOJAFA ) )
				@ Li,164 PSAY ( cAlias )->AA3_CODFAB+"-"+( cAlias )->AA3_LOJAFA
				DbSelectArea("SA1")
				DbSetOrder(1)
				If DbSeek(xFilial("SA1")+( cAlias )->AA3_CODFAB+( cAlias )->AA3_LOJAFA)
					@ Li,175 PSAY SubStr(AllTrim(SA1->A1_NREDUZ),1,15)
				EndIf
			EndIf
			@ Li,191 PSAY ( cAlias )->AA3_MODELO
		EndIf
			
		Li++
	
		AA4->( 	DbSetOrder(1) )
		AA4->( DbSeek(xFilial("AA4")+( cAlias )->AA3_CODCLI+( cAlias )->AA3_LOJA+( cAlias )->AA3_CODPRO+( cAlias )->AA3_NUMSER) )
		While ( !AA4->( Eof() ) .And. xFilial("AA4")  == AA4->AA4_FILIAL .And.;
				( cAlias )->AA3_CODCLI == AA4->AA4_CODCLI .And.;
				( cAlias )->AA3_LOJA	== AA4->AA4_LOJA   .And.;
				( cAlias )->AA3_CODPRO == AA4->AA4_CODPRO .And.;
				( cAlias )->AA3_NUMSER == AA4->AA4_NUMSER )
			
			If nTamCli > 8
				@ Li,047 PSAY AA4->AA4_PRODAC
				DbSelectArea("SB1")
				DbSetOrder(1)
				If DbSeek(xFilial("SB1")+AA4->AA4_PRODAC)
					@ Li,068 PSAY SubStr(AllTrim(SB1->B1_DESC),1,15)
				EndIf
				@ Li,084 PSAY AA4->AA4_NSERAC
				@ Li,116 PSAY AA4->AA4_DTINST
				@ Li,127 PSAY AA4->AA4_DTGAR
				If Len(AllTrim(AA4->AA4_FORNEC+AA4->AA4_LOJAFO)) > 0
					@ Li,138 PSAY AA4->AA4_FORNEC+"-"+AA4->AA4_LOJAFO
				EndIf
				If Len(AllTrim(AA4->AA4_CODFAB+AA4->AA4_LOJAFA)) > 0
					@ Li,164 PSAY AA4->AA4_CODFAB+"-"+AA4->AA4_LOJAFA
				EndIf
				@ Li,190 PSAY AA4->AA4_MODELO
			Else
				@ Li,031 PSAY AA4->AA4_PRODAC
				DbSelectArea("SB1")
				DbSetOrder(1)
				If DbSeek(xFilial("SB1")+AA4->AA4_PRODAC)
					@ Li,047 PSAY SubStr(AllTrim(SB1->B1_DESC),1,30)
				EndIf
				@ Li,078 PSAY AA4->AA4_NSERAC
				@ Li,110 PSAY AA4->AA4_DTINST
				@ Li,121 PSAY AA4->AA4_DTGAR
				@ Li,132 PSAY AA4->AA4_FORNEC+"-"+AA4->AA4_LOJAFO
				DbSelectArea("SA2")
				DbSetOrder(1)
				If DbSeek(xFilial("SA2")+AA4->AA4_FORNEC+AA4->AA4_LOJAFO)
					@ Li,143 PSAY SubStr(AllTrim(SA2->A2_NREDUZ),1,20)
				EndIf
				@ Li,164 PSAY AA4->AA4_CODFAB+"-"+AA4->AA4_LOJAFA
				DbSelectArea("SA1")
				DbSetOrder(1)
				If DbSeek(xFilial("SA1")+AA4->AA4_CODFAB+AA4->AA4_LOJAFA)
					@ Li,175 PSAY SubStr(AllTrim(SA1->A1_NREDUZ),1,15)
				EndIf
				@ Li,191 PSAY AA4->AA4_MODELO
			EndIf

			Li++
			If ( li > 60 )
				li := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,Tamanho,CHRCOMP)
				li++
			EndIf

			AA4->( DbSkip() )
		EndDo
		
	EndIf
		
	( cAlias )->( DbSkip() )
	cbCont++
	IncRegua()
EndDo

If ( lImp )
	Roda(cbCont,cbText,Tamanho)
EndIf

DbSelectArea(cString)
DbClearFilter()
Set Device To Screen
Set Printer To

If ( aReturn[5] == 1 )
	DbCommitAll()
	OurSpool(wnrel)
Endif

#IFDEF TOP
	TRAB->( DbCloseArea() )
#ELSE
	AA3->( DbClearIndex() )
	FErase( cIndTrab + OrdBagExt() )
	
	RetIndex( "AA3" )
#ENDIF

MS_FLUSH()
Return(.T.)          	


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr010RptDef ºAutor  ³Cleber Martinez     º Data ³  21/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR010 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr010RptDef()
Local oReport			// Objeto do relatorio
Local oSection1			// Objeto da secao 1
Local oSection2			// Objeto da secao 2
Local oSection3			// Objeto da secao 3
Local oSectionAg		// Objeto da secao 3
 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//"Relacao de Equipamentos"
DEFINE REPORT oReport NAME "TECR010" TITLE STR0001 PARAMETER cPergRel ACTION {|oReport| Tcr010PrtRpt(oReport)} DESCRIPTION STR0002 + STR0003 + STR0004
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	 	DEFINE SECTION oSectionAg OF oReport TITLE "Resumo Produto x Situação" TABLE "AA3","SB1","SA1","SA2","AA4" 
				
			DEFINE CELL NAME "AA3_CODPRO" 	OF oSectionAg ALIAS "AA3" SIZE 25
			DEFINE CELL NAME "B1_DESC"		OF oSectionAg ALIAS "SB1" SIZE 25
			DEFINE CELL NAME "STATUS"		OF oSectionAg ALIAS "SX5" SIZE 25 TITLE STR0017
			DEFINE CELL NAME "TOTAL"		OF oSectionAg ALIAS "AA3" SIZE 25 TITLE STR0018
	
	
	DEFINE SECTION oSection1 OF oReport TITLE STR0014 TABLES "AA3","SB1","SA1","SA2" 
	//"Cliente X Produto"
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE CELL NAME "AA3_CODCLI" 	OF oSection1 ALIAS "AA3" 
		DEFINE CELL NAME "AA3_LOJA" 	OF oSection1 ALIAS "AA3" 
		DEFINE CELL NAME "A1_NREDUZ"	OF oSection1 ALIAS "SA1" 
		DEFINE CELL NAME "AA3_CODPRO" 	OF oSection1 ALIAS "AA3"
		DEFINE CELL NAME "B1_DESC" 		OF oSection1 ALIAS "SB1"		
		DEFINE CELL NAME "AA3_NUMSER" 	OF oSection1 ALIAS "AA3"		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao2 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		
		
		
			DEFINE SECTION oSection2 OF oSection1 TITLE STR0015 TABLE "AA3","SB1","SA1","SA2" 
		//"Base Instalada"
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao2  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE CELL NAME "AA3_DTVEND" 	OF oSection2 ALIAS "AA3"
			DEFINE CELL NAME "AA3_DTINST" 	OF oSection2 ALIAS "AA3"
			DEFINE CELL NAME "AA3_DTGAR" 	OF oSection2 ALIAS "AA3"
			DEFINE CELL NAME "AA3_FORNEC" 	OF oSection2 ALIAS "AA3"
			DEFINE CELL NAME "AA3_LOJAFO" 	OF oSection2 ALIAS "AA3"
			DEFINE CELL NAME "A2_NREDUZ" 	OF oSection2 ALIAS "SA2"
			DEFINE CELL NAME "AA3_CODFAB" 	OF oSection2 ALIAS "AA3"
			DEFINE CELL NAME "AA3_LOJAFA" 	OF oSection2 ALIAS "AA3"
			DEFINE CELL NAME "A1_NREDUZ" 	OF oSection2 ALIAS "SA1"
			DEFINE CELL NAME "AA3_MODELO" 	OF oSection2 ALIAS "AA3"
			DEFINE CELL NAME "AA3_ENTEQP" 	OF oSection2 ALIAS "AA3"
			DEFINE CELL NAME "AA3_COLEQP" 	OF oSection2 ALIAS "AA3"
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao3 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
			DEFINE SECTION oSection3 OF oSection2 TITLE STR0016 TABLE "AA4","AA3","SB1","SA1","SA2"  
		//"Acessorios da Base Instalada"

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao3  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DEFINE CELL NAME "AA4_PRODAC" 	OF oSection3 ALIAS "AA4" SIZE 25
			DEFINE CELL NAME "B1_DESC" 		OF oSection3 ALIAS "SB1" SIZE 25
			DEFINE CELL NAME "AA4_NSERAC" 	OF oSection3 ALIAS "AA4" SIZE 25
			DEFINE CELL NAME "AA4_DTINST" 	OF oSection3 ALIAS "AA4" SIZE 25
			DEFINE CELL NAME "AA4_DTGAR" 	OF oSection3 ALIAS "AA4" SIZE 25
			DEFINE CELL NAME "AA4_FORNEC" 	OF oSection3 ALIAS "AA4" SIZE 25
			DEFINE CELL NAME "AA4_LOJAFO" 	OF oSection3 ALIAS "AA4" SIZE 25 			
			DEFINE CELL NAME "A2_NREDUZ" 	OF oSection3 ALIAS "SA2" SIZE 25  
			DEFINE CELL NAME "AA4_CODFAB" 	OF oSection3 ALIAS "AA4" SIZE 25 
			DEFINE CELL NAME "AA4_LOJAFA" 	OF oSection3 ALIAS "AA4" SIZE 25 			
			DEFINE CELL NAME "A1_NREDUZ" 	OF oSection3 ALIAS "SA1" SIZE 25  
			DEFINE CELL NAME "AA4_MODELO" 	OF oSection3 ALIAS "AA4" SIZE 25			
		
			
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr010PrtRptºAutor  ³Cleber Martinez     º Data ³  21/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR010 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr010PrtRpt( oReport )
Local oSectionAg := oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection1 := oReport:Section(2)				// Define a secao 1 do relatorio
Local oSection2 := oReport:Section(2):Section(1)			
Local oSection3 := oReport:Section(2):Section(1):Section(1)
Local cAlias1	:= GetNextAlias()					// Pega o proximo Alias Disponivel
Local cAlias2	:= GetNextAlias()					// Pega o proximo Alias Disponivel
Local cAlias3	:= GetNextAlias()					// Pega o proximo Alias Disponivel
Local cAliasAg	:= GetNextAlias()					// Pega o proximo Alias Disponivel
Local lGrupo	:= .F.								// Validacao do grupo

#IFDEF TOP



	DbSelectArea("AA3")
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(cPergRel)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Esta funcao eh chamada aqui apenas p/ evitar Warning na compilacao p/ TOP ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lGrupo := TcrChk_GRUPO()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	BEGIN REPORT QUERY oSectionAg

	If cPergRel == 'ATR010'
		BeginSql alias cAliasAg
			SELECT AA3_CODPRO, B1_DESC, X5_DESCRI STATUS, COUNT(1) TOTAL FROM %Table:AA3% AA3
				INNER JOIN %Table:SB1% SB1 ON SB1.B1_FILIAL = %xfilial:SB1% AND AA3.AA3_CODPRO = SB1.B1_COD AND SB1.%notDel%
				INNER JOIN %Table:SX5% SX5 ON X5_FILIAL = %xfilial:SX5% AND X5_TABELA = 'A5' AND X5_CHAVE = AA3_STATUS  AND SX5.%notDel%
			WHERE AA3_FILIAL = %xfilial:AA3%  AND
				AA3_CODPRO BETWEEN	%exp:mv_par01%	AND  %exp:mv_par02% AND
				AA3_CODCLI BETWEEN	%exp:mv_par03%	AND  %exp:mv_par04%  AND						
				B1_GRUPO BETWEEN	%exp:mv_par05%	AND  %exp:mv_par06%  AND  				
				AA3.%notDel% 
			GROUP BY AA3_CODPRO, B1_DESC, X5_DESCRI
		EndSql
	
	Else	
		BeginSql alias cAliasAg
			SELECT AA3_CODPRO, B1_DESC, X5_DESCRI STATUS, COUNT(1) TOTAL FROM %Table:AA3% AA3
				INNER JOIN %Table:SB1% SB1 ON SB1.B1_FILIAL = %xfilial:SB1% AND AA3.AA3_CODPRO = SB1.B1_COD AND SB1.%notDel%
				INNER JOIN %Table:SX5% SX5 ON X5_FILIAL = %xfilial:SX5% AND X5_TABELA = 'A5' AND X5_CHAVE = AA3_STATUS  AND SX5.%notDel%
			WHERE AA3_FILIAL = %xfilial:AA3%  AND
				AA3_CODPRO BETWEEN	%exp:mv_par01%	AND  %exp:mv_par02% AND  				
				AA3.%notDel% AND 
				AA3_CODCLI BETWEEN	%exp:mv_par03%	AND  %exp:mv_par04%  AND							
				B1_GRUPO BETWEEN	%exp:mv_par05%	AND  %exp:mv_par06%  AND
				(%exp:mv_par07% = '' OR AA3.AA3_STATUS = %exp:mv_par07%) AND  
				(%exp:mv_par08% = '3' OR AA3.AA3_EQALOC = %exp:mv_par08%)
					
			GROUP BY AA3_CODPRO, B1_DESC, X5_DESCRI
		EndSql
	EndIf	

	END REPORT QUERY oSectionAg
	
	
	
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cPergRel == 'ATR010'
		BeginSql alias cAlias1
			SELECT	AA3_CODPRO, AA3_CODCLI, 	AA3_LOJA, 		AA3_FILIAL, 
					AA3_NUMSER, 	B1_COD,			B1_DESC, A1_NREDUZ
					
			FROM %table:AA3% AA3
				LEFT JOIN %table:SA1% SA1 ON A1_FILIAL = %xfilial:SA1% AND A1_COD =	AA3_CODCLI 	AND A1_LOJA = AA3_LOJA AND SA1.%notDel%
				INNER JOIN %table:SB1% SB1 ON B1_FILIAL =	%xfilial:SB1% AND B1_COD = AA3_CODPRO AND SB1.%notDel% 
			WHERE	AA3_FILIAL = %xfilial:AA3%	AND
					AA3_CODPRO BETWEEN	%exp:mv_par01%	AND  %exp:mv_par02%	 AND
					AA3_CODCLI BETWEEN	%exp:mv_par03%	AND  %exp:mv_par04%  AND
							
					B1_GRUPO BETWEEN	%exp:mv_par05%	AND  %exp:mv_par06%  AND					
					AA3.%notDel% 		
	
			ORDER BY AA3_CODPRO, AA3_CODCLI, AA3_LOJA
					
		EndSql
	
	Else
		BeginSql alias cAlias1
			SELECT	AA3_CODPRO, AA3_CODCLI, 	AA3_LOJA, 		AA3_FILIAL, 
					AA3_NUMSER, 	B1_COD,			B1_DESC, A1_NREDUZ
					
			FROM %table:AA3% AA3
				LEFT JOIN %table:SA1% SA1 ON A1_FILIAL = %xfilial:SA1% AND A1_COD =	AA3_CODCLI 	AND A1_LOJA = AA3_LOJA AND SA1.%notDel%
				INNER JOIN %table:SB1% SB1 ON B1_FILIAL =	%xfilial:SB1% AND B1_COD = AA3_CODPRO AND SB1.%notDel% 
			WHERE	AA3_FILIAL = %xfilial:AA3%	AND
					AA3_CODPRO BETWEEN	%exp:mv_par01%	AND  %exp:mv_par02%	 AND
					AA3_CODCLI BETWEEN	%exp:mv_par03%	AND  %exp:mv_par04%  AND
							
					B1_GRUPO BETWEEN	%exp:mv_par05%	AND  %exp:mv_par06%  AND
					(%exp:mv_par07% = '' OR AA3.AA3_STATUS = %exp:mv_par07%) AND  
					(%exp:mv_par08% = '3' OR AA3.AA3_EQALOC = %exp:mv_par08%)  AND
					AA3.%notDel% 		
	
			ORDER BY AA3_CODPRO, AA3_CODCLI, AA3_LOJA
					
		EndSql
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Indica o fim da query, caso utilize range, deve-se informar como parametro ³
	//³{MV_?,MV_?} para que seja incluido no select automaticamente               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	END REPORT QUERY oSection1 //PARAM mv_par01,mv_par02
	
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Inicializa a secao 2³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BEGIN REPORT QUERY oSection2
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Query da secao 2³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BeginSql alias cAlias2
			SELECT	AA3_DTVEND, 	AA3_DTINST, 	AA3_DTGAR, 	
					AA3_FORNEC, 	AA3_LOJAFO, 	AA3_CODFAB, 
					AA3_LOJAFA, 	AA3_MODELO,		AA3_INALOC,
					AA3_FIALOC,		AA3_ENTEQP,		AA3_COLEQP
					
			FROM %table:AA3% AA3
			WHERE	AA3_CODCLI	=	%report_param: (cAlias1)->AA3_CODCLI%	AND
					AA3_LOJA	=	%report_param: (cAlias1)->AA3_LOJA%		AND
					AA3_CODPRO	=	%report_param: (cAlias1)->AA3_CODPRO%	AND
					AA3_NUMSER	=	%report_param: (cAlias1)->AA3_NUMSER% 				
					
			ORDER BY %Order:AA3%
					
		EndSql
		
		END REPORT QUERY oSection2
	
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Inicializa a secao 3³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BEGIN REPORT QUERY oSection3
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Query da secao 3, para impressao dos dados das celulas apenas da secao 3³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BeginSql alias cAlias3
			SELECT	AA4_CODCLI,	AA4_LOJA,	AA4_CODPRO,	AA4_NUMSER,	AA4_PRODAC,
					AA4_NSERAC,	AA4_DTINST,	AA4_DTGAR,	AA4_FORNEC,	AA4_LOJAFO,	
					AA4_CODFAB,	AA4_LOJAFA,	AA4_MODELO,	B1_COD,		B1_DESC
					
			FROM %table:AA4% AA4, %table:SB1% SB1        
			WHERE	AA4_FILIAL	= 	%xfilial:AA4%	AND
					AA4_CODCLI	=	%report_param: (cAlias1)->AA3_CODCLI%	AND
					AA4_LOJA	=	%report_param: (cAlias1)->AA3_LOJA%		AND
					AA4_CODPRO	=	%report_param: (cAlias1)->AA3_CODPRO%	AND
					AA4_NUMSER	=	%report_param: (cAlias1)->AA3_NUMSER%	AND
					B1_FILIAL	=	%xfilial:SB1%	AND
					B1_COD		= 	AA4_PRODAC		AND					
					AA4.%notDel% AND					
					SB1.%notDel%
					
			ORDER BY %Order:AA4%
		EndSql
	
		END REPORT QUERY oSection3
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona nas tabelas secundarias usadas na secao1 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//TRPosition():New(oReport:Section(1),"SA1",1,{|| xFilial("SA1")+(cAlias1)->AA3_CODCLI+(cAlias1)->AA3_LOJA })
		TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1")+(cAlias1)->AA3_CODCLI+(cAlias1)->AA3_LOJA })  
		
	
			TRPosition():New(oSection2,"SA1",1,{|| xFilial("SA1")+(cAlias2)->AA3_CODFAB+(cAlias2)->AA3_LOJAFA })  	
			TRPosition():New(oSection2,"SA2",1,{|| xFilial("SA2")+(cAlias2)->AA3_FORNEC+(cAlias2)->AA3_LOJAFO })
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona nas tabelas secundarias usadas na secao3 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//TRPosition():New(oReport:Section(1):Section(1),"SA1",1,{|| xFilial("SA1")+(cAlias2)->AA4_CODFAB+(cAlias2)->AA4_LOJAFA })
			TRPosition():New(oSection3,"SA1",1,{|| xFilial("SA1")+(cAlias3)->AA4_CODFAB+(cAlias3)->AA4_LOJAFA })
			TRPosition():New(oSection3,"SA2",1,{|| xFilial("SA2")+(cAlias3)->AA4_FORNEC+(cAlias3)->AA4_LOJAFO })
		
	
#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr(cPergRel)

	DbSelectArea("AA3")
	DbSetOrder(1)
    
	cFiltro := "AA3_FILIAL == '" + xFilial( "AA3" ) + "' .AND. "
	cFiltro += "AA3_CODPRO >= '" + mv_par01 + "' .AND. "
	cFiltro += "AA3_CODPRO <= '" + mv_par02 + "' .AND. "
	cFiltro += "AA3_CODCLI >= '" + mv_par03 + "' .AND. "
	cFiltro += "AA3_CODCLI <= '" + mv_par04 + "'" 
	 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Efetua o filtro de acordo com a expressao (somente do AA3), pois o SB1 nao esta sendo utilizado ainda ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Efetua a condicao do codeblock dentro do filtro jah efetuado, efetua o filtro do B1_GRUPO da Pergunte ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetLineCondition({|| TcrChk_GRUPO() })
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa a secao2, com o mesmo filtro da secao1.                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//oSection2:SetRelation({|| xFilial("AA3")+ AA3->AA3_CODCLI + AA3->AA3_LOJA + AA3->AA3_CODPRO + AA3->AA3_NUMSER },"AA3",1,.T.)
	//TRPosition():New(oSection2,"AA3",1,{|| xFilial("AA3")+AA3->AA3_CODCLI+AA3->AA3_LOJA + AA3->AA3_CODPRO + AA3->AA3_NUMSER})	
	oSection2:SetParentFilter({|cParam| AA3->AA3_CODCLI + AA3->AA3_LOJA + AA3->AA3_CODPRO + AA3->AA3_NUMSER == cParam},{|| AA3->AA3_CODCLI + AA3->AA3_LOJA + AA3->AA3_CODPRO + AA3->AA3_NUMSER })
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa a secao3, com o mesmo filtro da secao1 anterior                           ³
	//³A condicao no codeblock, informa que o laco da secao sera enquanto a chave do AA3 ³
	//³for igual a do AA4.                                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
	
	oSection3:SetRelation({|| xFilial("AA4")+ AA3->AA3_CODCLI + AA3->AA3_LOJA + AA3->AA3_CODPRO + AA3->AA3_NUMSER },"AA4",1,.T.)
	oSection3:SetParentFilter({|cParam| AA4->AA4_CODCLI + AA4->AA4_LOJA + AA4->AA4_CODPRO + AA4->AA4_NUMSER == cParam},{|| AA3->AA3_CODCLI + AA3->AA3_LOJA + AA3->AA3_CODPRO + AA3->AA3_NUMSER })
		
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona nas tabelas secundarias usadas na secao1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1")+AA3->AA3_CODCLI+AA3->AA3_LOJA })	
    TRPosition():New(oSection1,"SB1",1,{|| xFilial("SB1")+AA3->AA3_CODPRO })
	
	
		TRPosition():New(oSection2,"SA1",1,{|| xFilial("SA1")+AA3->AA3_CODFAB+AA3->AA3_LOJAFA })
		TRPosition():New(oSection2,"SA2",1,{|| xFilial("SA2")+AA3->AA3_FORNEC+AA3->AA3_LOJAFO })

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona nas tabelas secundarias usadas na secao2 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    
    	TRPosition():New(oSection3,"SB1",1,{|| xFilial("SB1")+AA4->AA4_PRODAC })
    	TRPosition():New(oSection3,"SA1",1,{|| xFilial("SA1")+AA4->AA4_CODFAB+AA4->AA4_LOJAFA })
    	TRPosition():New(oSection3,"SA2",1,{|| xFilial("SA2")+AA4->AA4_FORNEC+AA4->AA4_LOJAFO })
    		
	
#ENDIF	


oSection3:SetLineBreak()
	
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

While (cAliasAg)->(!EOF())
	oSectionAg:Print()
	(cAliasAg)->(DbSkip())
EndDo	

oSection1:Print()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³TcrChk_GRUPºAutor  ³Hanna / Fabiomr     º Data ³  18/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para considerar o grupo de produtos, informado no pa- º±±
±±º          ³rametro do SetLineCondition em Codebase                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR010                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TcrChk_GRUPO()

DbSelectArea( "SB1" )                                                       
DbSetOrder( 1 )
Return DbSeek( xFilial( "SB1" ) + AA3->AA3_CODPRO ) .AND. SB1->B1_GRUPO >= MV_PAR05 .AND. SB1->B1_GRUPO <= MV_PAR06
