/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "MATR331.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR331  ³ Autor ³ Ricardo Berti			³ Data ³17/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio para listagem de recursividade por movimentacao   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR331()
Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:= ReportDef()
	oReport:PrintDialog()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Ricardo Berti 		³ Data ³17.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport 
Local oSection1
Local oCell         
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= TReport():New("MATR331",STR0001,"MTR331", {|oReport| ReportPrint(oReport)},STR0002+" "+STR0003+" "+STR0004) //"Recursividade por Movimentacao"##"Este relatorio tem como objetivo listar as movimentacoes"###"que geram recursividade no processamento do recalculo do"####"custo medio."
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR331",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                    	³
//³ mv_par01     // Data de emissao inicial                     ³
//³ mv_par02     // Data de emissao final                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection1 := TRSection():New(oReport,STR0012,{"SD3"}) //"Recursividade por Movimentacao"##"Itens de Movimentação Interna"
oSection1 :SetHeaderPage(.F.)

TRCell():New(oSection1,"D3_COD"		,"SD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D3_LOCAL"	,"SD3")
TRCell():New(oSection1,"D3_TM"		,"SD3")
TRCell():New(oSection1,"D3_DOC"		,"SD3")
TRCell():New(oSection1,"D3_EMISSAO"	,"SD3")
TRCell():New(oSection1,"D3_OP"		,"SD3")
oCell:=TRCell():New(oSection1,"C2_PRODUTO"	,"SC2")
oCell:SetTitle(STR0010+CRLF+STR0011) //"Produto da "###"Ordem de Producao"

Return(oReport)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Ricardo Berti 		³ Data ³17.07.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)
Local oSection1	:= oReport:Section(1) 
Local cAliasSD3 := GetNextAlias()
Local cArqTemp	:= "" 
Local cOpVazia	:= Criavar("D3_OP",.F.)
Local cProdMNT  := SuperGetMv("MV_PRODMNT",.F.,"MANUTENCAO")
Local aArqTemp	:= {}
Local nx		:= 0
Local nRegSD3	:= 0
Local nTotReg	:= 0
Local nCount	:= 0
Local aListaReg	:= {}
Local lRet		:= .T.
Local lImp		:= .F. // Indica se algo foi impresso
Local oTempTable := NIL

// Montagem do arquivo de trabalho
Aadd(aArqTemp,{"CODIGO"		, TamSx3( 'B1_COD' )[ 03 ]		, TamSx3( 'B1_COD' )[ 01 ]		, TamSx3( 'B1_COD' )[ 02 ] } )
Aadd(aArqTemp,{"COMPONENTE"	, TamSx3( 'B1_COD' )[ 03 ]		, TamSx3( 'B1_COD' )[ 01 ]		, TamSx3( 'B1_COD' )[ 02 ] } )
Aadd(aArqTemp,{"OP"			, TamSx3( 'D3_OP' )[ 03 ]		, TamSx3( 'D3_OP' )[ 01 ] 		, TamSx3( 'D3_OP' )[ 02 ] } )
Aadd(aArqTemp,{"ARMAZEM"	, TamSx3( 'D3_LOCAL' )[ 03 ]	, TamSx3( 'D3_LOCAL' )[ 01 ]	, TamSx3( 'D3_LOCAL' )[ 02 ] } )
Aadd(aArqTemp,{"MOVIMENTO"	, TamSx3( 'D3_TM' )[ 03 ]		, TamSx3( 'D3_TM' )[ 01 ]		, TamSx3( 'D3_TM' )[ 02 ] } )
Aadd(aArqTemp,{"EMISSAO"	, TamSx3( 'D3_EMISSAO' )[ 03 ]	, TamSx3( 'D3_EMISSAO' )[ 01 ]	, TamSx3( 'D3_EMISSAO' )[ 02 ] } )
Aadd(aArqTemp,{"DOCUMENTO"	, TamSx3( 'D3_DOC' )[ 03 ]		, TamSx3( 'D3_DOC' )[ 01 ]		, TamSx3( 'D3_DOC' )[ 02 ] } )
Aadd(aArqTemp,{"REGISTRO"	, "N", 20, 00 } )
Aadd(aArqTemp,{"G1NIVEL"	, "C", 02, 00 } )
Aadd(aArqTemp,{"G1NIVINV"	, "C", 02, 00 } )

cArqTemp := GetNextAlias()
oTempTable := FWTemporaryTable():New( cArqTemp )
oTempTable:SetFields( aArqTemp )
oTempTable:AddIndex("indice1", {"CODIGO","COMPONENTE","OP"} )
oTempTable:Create()
cNameTemp := oTempTable:GetRealName()

// Leitura para gravacao de dados no arquivo de trabalho
dbSelectArea("SC2")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)

cOrderQry := " ORDER BY D3_OP,D3_COD,D3_EMISSAO "
cQuery := " SELECT DISTINCT D3_OP, C2_PRODUTO, D3_COD, D3_TM, D3_LOCAL, D3_EMISSAO,  MIN( D3_DOC ) DOC, MIN( SD3.R_E_C_N_O_ ) REG,  '01' G1NIVEL, '99' G1NIVINV "+CRLF
cQuery += " FROM "+ RetSQLName( 'SD3' ) +" SD3 "+CRLF
cQuery += " 	INNER JOIN "+ RetSQLName( 'SC2' ) +" SC2 ON ( D3_FILIAL = '"+ FWxFilial( 'SD3' ) +"' AND C2_FILIAL = '"+ FWxFilial( 'SC2' ) +"' AND D3_OP = C2_NUM || C2_ITEM || C2_SEQUEN ) "+CRLF
cQuery += " WHERE D3_EMISSAO BETWEEN '"+ Dtos( Mv_Par01 ) +"' AND '"+ Dtos( Mv_Par02 ) +"' "+CRLF
cQuery += " 		AND D3_OP <> '"+ cOpVazia +"'  "+CRLF
cQuery += " 		AND D3_COD <> '"+ cProdMNT +"' "+CRLF
cQuery += " 		AND D3_CF NOT IN ( 'PR0' , 'PR1' ) "+CRLF
cQuery += " 		AND D3_ESTORNO <> 'S' "+CRLF
cQuery += " 		AND SC2.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " 		AND SD3.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " GROUP BY D3_OP, C2_PRODUTO, D3_COD, D3_TM, D3_LOCAL, D3_EMISSAO "+CRLF
cQuery := ChangeQuery( cQuery )

cQry := " INSERT INTO "+ cNameTemp +" ( OP, CODIGO, COMPONENTE, MOVIMENTO, ARMAZEM, EMISSAO, DOCUMENTO, REGISTRO, G1NIVEL, G1NIVINV ) "+ cQuery + cOrderQry + " "
nRet := TcSQLExec( cQry )
If nRet # 0
	ApMsgStop( TcSQLError(), 'Atencao' )
	lRet := .F.
Else
	lRet := .T.
EndIf

cQry := " SELECT COUNT( 1 ) TOTREG FROM ( "+ cQuery +" ) TRB3 "
IIf( Select( 'WRK' ) > 0, WRK->( dbCloseArea() ), Nil )
dbUseArea( .T., __cRdd, TcGenQry(,,cQry ), 'WRK', .T., .F. )
nTotReg := WRK->TOTREG


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatorio                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea( cArqTemp )
( cArqTemp )->( dbGotop() )
nCount := 0
oSection1:Init()
oReport:SetMeter( nTotReg )
While !oReport:Cancel() .And. ( cArqTemp )->( !Eof() )
	If oReport:Cancel()
		Exit
	EndIf	

	nCount ++
	// Movimenta regua
	oReport:IncMeter( nCount )
	// Checa recursividade
	IF G1NIVEL == "01"
		aListaReg:={}
		lRet := MR331Nivel( ( cArqTemp )->COMPONENTE, ( cArqTemp )->G1NIVEL, cArqTemp, aListaReg )
		IF !lRet
			nRegSD3 := ( cArqTemp )->( Recno() )

			For nX := 1 To Len( aListaReg )
				If nX == 1 .And. lImp
            		oReport:ThinLine()
				EndIf

				// Posiciona o registro
				( cArqTemp )->( dbGoto( aListaReg[ nX ] ) )			
				oSection1:Cell("D3_COD"	 	):SetValue( ( cArqTemp )->COMPONENTE)
				oSection1:Cell("D3_LOCAL"	):SetValue( ( cArqTemp )->ARMAZEM	)
				oSection1:Cell("D3_TM"	 	):SetValue( ( cArqTemp )->MOVIMENTO	)
				oSection1:Cell("D3_DOC"	 	):SetValue( ( cArqTemp )->DOCUMENTO	)
				oSection1:Cell("D3_EMISSAO"	):SetValue( ( cArqTemp )->EMISSAO	)
				oSection1:Cell("D3_OP"		):SetValue( ( cArqTemp )->OP		)
				oSection1:Cell("C2_PRODUTO"	):SetValue( ( cArqTemp )->CODIGO	)
				oSection1:PrintLine()			
				lImp := .T.
			Next nX

			( cArqTemp )->( dbGoto( nRegSD3 ) )
		Endif
	EndIf

	( cArqTemp )->( dbSkip() )
EndDo

oSection1:Finish()			
oTempTable:Delete()

IIf( Select( cAliasSD3 ) > 0, ( cAliasSD3 )->( dbCloseArea() ), Nil )
IIf( Select( 'WRK' ) > 0, WRK->( dbCloseArea() ), Nil )
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MR331Nivel³ Autor ³Rodrigo de A Sartorio  ³ Data ³ 25/04/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Acerta os niveis das estruturas no temporario              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR331                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MR331Nivel(cComp,cNivel,cAliasPr,aListaReg)
Local nRec   := Recno()
Local nSalRec:= 0
Local lRet   := .T.
Local lEof   := .F.
Local nAcho  := 0
Local cSeek  := ""

dbSelectArea( cAliasPr )
dbSetOrder( 1 )

If dbSeek(cComp)
	While !Eof() .and. cComp==CODIGO
		nSalRec:=Recno()
		cSeek  := COMPONENTE
		dbSeek(cSeek)	
		lEof := Eof()
		dbGoto(nSalRec)

		IF Val(cNivel) >= 98  // Testa Erro de estrutura
			lRet := .F.
		Endif

		If Val(cNivel)+1 > Val(G1NIVEL) .and. lRet
			RecLock(cAliasPr,.F.)
			Replace G1NIVEL  With Strzero(Val(cNivel)+1,2)
			Replace G1NIVINV With Strzero(100-Val(G1NIVEL),2,0)
			MsUnLock()
			If !lEof
				lRet := MR331NIVEL(COMPONENTE,G1NIVEL,cAliasPr,aListaReg)
			Endif
		Endif	
		IF !lRet
			IF Val(cNivel) < 98  // Houve erro (no nivel posterior)
				nAcho  := ASCAN(aListaReg,nSalRec)
				// Adiciona, na lista, o registro que originou o erro
				If nAcho == 0
					AADD(aListaReg,nSalRec)
				EndIf
			EndIf		
			Exit
		Endif
		dbSkip()
	End
EndIf

(cAliasPr)->(dbGoto(nRec))
Return(lRet)

Static Function SchedDef()

Local aParam  := {}
Local aOrd := {}

aParam := { "R",;        //Tipo R para relatorio P para processo
            "MTR331",;    //Pergunte do relatorio, caso nao use passar ParamDef
            "SD3",;        //Alias
            aOrd,;        //Array de ordens
            STR0001}    //Titulo

Return aParam
