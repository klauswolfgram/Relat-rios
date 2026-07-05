/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'REPORT.CH'
#INCLUDE 'TECR820.CH'

STATIC aInfMens := {}
STATIC aInfEnd  := {}

//------------------------------------------------------------------------------
/*/{Protheus.doc} TECR820
	Relatório TReport para impressão do Romaneio de Entrega dos equipamentos 

@sample 	U_TECR820() 

@since		30/12/2013       
@version	P12   
/*/
//------------------------------------------------------------------------------
User Function TECR820()

Local oReport := Nil
Local oCabec  := Nil
Local oItens  := Nil
Local oMens   := Nil
Local oEndEnt := Nil

Private cQryRep820 := ''

Pergunte('TECR820',.F.)

// inicializa os array para controle das impressoes
aInfMens := {}
aInfEnd  := {}

DEFINE REPORT oReport NAME 'TECR820' TITLE STR0001 PARAMETER 'TECR820' ACTION {|oReport| PrintReport(oReport)} //"Romaneio de Entrega"
	
	oReport:HideParamPage()  // inibe a impressão da página de parâmetros
	DEFINE SECTION oCabec OF oReport TITLE STR0001 TABLE 'SM0', 'SF2', 'SA3', 'TFI', 'SA1' LINE STYLE COLUMNS 3  //"Romaneio de Entrega"

		DEFINE CELL NAME 'A1_NOME'    OF oCabec TITLE STR0002 ALIAS 'SF2' ;  //Cliente
			SIZE TamSX3('A1_NOME')[1]+TamSX3('A1_COD')[1]+TamSX3('A1_LOJA')[1] + 7 ;
			BLOCK {|oCell| F2_CLIENTE+'-'+F2_LOJA+' / '+A1_NOME}
			
		DEFINE CELL NAME 'A1_CGC'     OF oCabec ALIAS 'SA1'
		DEFINE CELL NAME 'A3_NOME'    OF oCabec TITLE  STR0003 ALIAS 'SA3'   //Vendedor
		DEFINE CELL NAME 'C5_NUM'     OF oCabec TITLE  STR0004 ALIAS 'SC5'   //Pedido
		DEFINE CELL NAME 'F2_EMISSAO' OF oCabec ALIAS 'SF2'
		DEFINE CELL NAME 'F2_DOC'     OF oCabec TITLE STR0005 ALIAS 'SF2' ; //Nota Fiscal
			SIZE TamSX3('F2_DOC')[1]+TamSX3('F2_SERIE')[1] + 3 ;
			BLOCK {|oCell| F2_DOC+F2_SERIE }
			
		DEFINE CELL NAME 'TFI_PERINI' OF oCabec ALIAS 'TFI'
		DEFINE CELL NAME 'TFI_PERFIM' OF oCabec ALIAS 'TFI'
		DEFINE CELL NAME 'TFI_CONTRT' OF oCabec ALIAS 'TFI'

	DEFINE SECTION oEndEnt OF oCabec TITLE STR0010 TABLE 'ABS','SU5' LINE STYLE COLUMNS 3   //Endereço de Entrega

		DEFINE CELL NAME 'ABS_END'   OF oEndEnt TITLE STR0011 BLOCK {||(cQryRep820)->ABS_END } //Logradouro
		DEFINE CELL NAME 'ABS_MUNIC' OF oEndEnt TITLE STR0012 BLOCK {||(cQryRep820)->ABS_MUNIC } //Município
		DEFINE CELL NAME 'ABS_CEP'   OF oEndEnt TITLE STR0013 BLOCK {||(cQryRep820)->ABS_CEP } //CEP
		DEFINE CELL NAME 'U5_CONTAT' OF oEndEnt TITLE STR0014 BLOCK {||(cQryRep820)->U5_CONTAT } //Contato
		DEFINE CELL NAME 'U5_FONE'   OF oEndEnt TITLE STR0015 BLOCK {||(cQryRep820)->U5_FONE } //Telefone
		
		oEndEnt:bLineCondition := {|oSection|!U_ATR820Has( (cQryRep820)->(F2_DOC+F2_SERIE), aInfEnd ) } // verifica se já houve impressao deste documento
		oEndEnt:bOnPrintLine   := {|oSection| U_ATR820Ins( (cQryRep820)->(F2_DOC+F2_SERIE), aInfEnd ) } // adiciona o documento impresso no array para validação posterior

		DEFINE SECTION oItens OF oCabec TITLE STR0006 TABLE 'SD2', 'SB1', 'TEW' LEFT MARGIN 20  //Itens da Nota
	
			DEFINE CELL NAME 'D2_ITEM'   OF oItens ALIAS 'SD2'
			DEFINE CELL NAME 'D2_COD'    OF oItens ALIAS 'SD2'
			DEFINE CELL NAME 'B1_DESC'   OF oItens ALIAS 'SB1'
			DEFINE CELL NAME 'TEW_BAATD' OF oItens ALIAS 'TEW'

	DEFINE SECTION oMens OF oCabec TITLE STR0007 TABLE 'SC5' LINE STYLE COLUMNS 1   //Mensagens

		DEFINE CELL NAME 'C5_MENNOTA' OF oMens TITLE STR0008 BLOCK {||(cQryRep820)->C5_MENNOTA} ALIAS 'SC5'   //Observações
		DEFINE CELL NAME 'C5_MENPAD'  OF oMens TITLE STR0009 BLOCK {||(cQryRep820)->C5_MENPAD} ALIAS 'SC5'   //Informações Adicionais
		
		oMens:bLineCondition := {|oSection|!U_ATR820Has( (cQryRep820)->(F2_DOC+F2_SERIE), aInfMens) } // verifica se já houve impressao deste documento
		oMens:bOnPrintLine   := {|oSection| U_ATR820Ins( (cQryRep820)->(F2_DOC+F2_SERIE), aInfMens) } // adiciona o documento impresso no array para validação posterior
		
oReport:PrintDialog()

Return 

//------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
	Função que faz o controle de impressão do relatório 

@sample 	U_TECR820() 

@since		30/12/2013       
@version	P12   

@param  	oReport, Objeto, objeto da classe TReport para construção da consulta
	de busca e impressão dos dados 
/*/
//------------------------------------------------------------------------------
Static Function PrintReport(oReport)

Local oCabec  := Nil
Local oItens  := Nil
Local cidWhere:="%"+SerieNfId("SF2",3,"F2_SERIE")+" = '"+ MV_PAR02+"'%"

cQryRep820 := GetNextAlias()

MakeSqlExp('TECR820')

BEGIN REPORT QUERY oReport:Section(1)

BeginSql alias cQryRep820
	SELECT SD2.D2_PEDIDO
		, F2_CLIENTE, F2_LOJA, F2_DOC, F2_SERIE, F2_EMISSAO, D2_ITEM, D2_COD, A1_NOME, A1_CGC, TFI_PERINI
		, TFI_PERFIM, TFI_CONTRT, C5_NUM, C5_MENNOTA, C5_MENPAD, B1_DESC, TEW_BAATD, ABS_END, ABS_BAIRRO
		, ABS_MUNIC, ABS_ESTADO, ABS_CEP, U5_FONE, U5_CONTAT, D2_DOC, D2_SERIE
	
	FROM %Table:SF2% SF2
		INNER JOIN %Table:SD2% SD2 ON SD2.D2_FILIAL = %xFilial:SD2% AND SD2.D2_DOC = SF2.F2_DOC AND SD2.D2_SERIE = SF2.F2_SERIE 
			AND SD2.D2_CLIENTE = SF2.F2_CLIENTE AND SD2.D2_LOJA = SF2.F2_LOJA AND SD2.%NotDel%
		INNER JOIN %Table:SA1% SA1 ON SA1.A1_FILIAL = %xFilial:SA1% AND SA1.A1_COD = SF2.F2_CLIENTE AND SA1.%NotDel%
		INNER JOIN %Table:SC5% SC5 ON SC5.C5_FILIAL = %xFilial:SC5% AND SC5.C5_NUM = SD2.D2_PEDIDO AND SC5.%NotDel%
		INNER JOIN %Table:TEW% TEW ON TEW.TEW_FILIAL = %xFilial:TEW% AND TEW.TEW_NUMPED = SD2.D2_PEDIDO AND TEW.TEW_ITEMPV = SD2.D2_ITEMPV AND TEW.%NotDel%
		INNER JOIN %Table:TFI% TFI ON TFI.TFI_FILIAL = %xFilial:TFI% AND TFI.TFI_COD = TEW.TEW_CODEQU AND TFI.%NotDel%
		INNER JOIN %Table:SB1% SB1 ON SB1.B1_FILIAL = %xFilial:SB1% AND SB1.B1_COD = SD2.D2_COD AND SB1.%NotDel%
		INNER JOIN %Table:ABS% ABS ON ABS.ABS_FILIAL = %xFilial:ABS% AND ABS.ABS_LOCAL = TFI.TFI_LOCAL AND ABS.%NotDel%
		LEFT JOIN %Table:SU5% SU5 ON SU5.U5_FILIAL = %xFilial:SU5% AND SU5.U5_CODCONT = ABS.ABS_CONTAT AND SU5.%NotDel%
	
	WHERE SF2.%NotDel% AND SF2.F2_DOC = %Exp:mv_par01% AND %Exp:cidWhere%

EndSql

END REPORT QUERY oReport:Section(1)

oCabec := oReport:Section(1)

oItens := oCabec:Section(2)  // Itens da Nota Fiscal
oItens:SetParentQuery()
oItens:SetParentFilter( {|cParam| (cQryRep820)->(D2_DOC+D2_SERIE) == cParam},{|| (cQryRep820)->(F2_DOC+F2_SERIE)} )

DbSelectArea(cQryRep820)

oReport:Section(1):Print()

// inicializa os array para controle das impressoes
aSize( aInfMens, 0)
aSize( aInfEnd, 0)

Return

//------------------------------------------------------------------------------
/*/{Protheus.doc} ATR820Has
	 Verifica se um determinado conteúdo está presente na lista

@sample 	U_ATR820Has( '0001', { '0002','0007','0001','0004' } ) ===> .T. 

@since		30/12/2013       
@version	P12   

@param  	cConteudo, Caracter, conteúdo chave a ser verificado
@param  	aInfs, Array, lista a ser verificada
/*/
//------------------------------------------------------------------------------
User Function ATR820Has( cConteudo, aInfs )

Return ( aScan( aInfs, cConteudo ) > 0 ) 

//------------------------------------------------------------------------------
/*/{Protheus.doc} ATR820Ins
	Adiciona o conteúdo aos arrays de controle dos itens já impressos 

@sample 	U_ATR820Ins( '01', {} ) ==> Nil 

@since		30/12/2013       
@version	P12   

@param  	cConteudo, Caracter, conteúdo chave a ser adicionado ao array dos itens já impressos
@param  	aInfs, Array, [referência], lista onde os itens serão adicionados
 
/*/
//------------------------------------------------------------------------------
User Function ATR820Ins( cConteudo, aInfs )

aAdd( aInfs, cConteudo )

Return 