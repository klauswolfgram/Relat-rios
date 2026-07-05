/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR010.CH"
#INCLUDE "REPORT.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณ 	TMKR010  ณ Autor ณ Vendas Clientes       ณ Data ณ 13/03/03 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Relatorio do Cadastro de Contatos e entidades associadas   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ U_TMKR010(void)                                              ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso		 ณ Relatorio Personalizavel									  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function TMKR010()

Local oReport				// Objeto para geracao do relatorio
Local aArea := GetArea()	// Salva a area

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ Mv_Par01           // Entidade                               ณ
//ณ Mv_Par02           // Do Contato                             ณ
//ณ Mv_Par03           // Ate o Contato                          ณ
//ณ Mv_Par04           // Status do Contato - Atualizado,Nao,Ambsณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Pergunte("TMK010",.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInterface de impressaoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

oReport := ReportDef()
oReport:PrintDialog()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณRestaura a areaณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
RestArea( aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณ Vendas Clientes    บ Data ณ  30/06/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para informar as celulas que serao utilizadas no relaบฑฑ
ฑฑบ          ณlatorio                                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Call Center                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()
Local oReport											// Objeto do relatorio
Local oSection1											// Objeto da secao 1	
Local oSection2											// Objeto da secao 2
Local cAlias1	:= "AC8"								// Pega o proximo Alias Disponivel

#IFDEF TOP
	cAlias1		:= GetNextAlias()						// Pega o proximo Alias Disponivel
#ENDIF	

DEFINE REPORT oReport NAME "TMKR010" TITLE STR0023 PARAMETER "TMK010" ACTION {|oReport| TKR010PrtRpt(oReport, cAlias1)} DESCRIPTION STR0001 + STR0002

DEFINE SECTION oSection1 OF oReport TITLE STR0034 TABLES "SU5" LINE BREAK //Contatos

DEFINE CELL NAME "U5_CODCONT" 	OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "U5_CONTAT" 	OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "U5_END" 		OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "U5_BAIRRO" 	OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "U5_MUN" 		OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "U5_CEP" 		OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "U5_EST" 		OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "U5_DDD" 		OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "U5_FONE" 		OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "U5_CELULAR"	OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "U5_FAX" 		OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "U5_FCOM1" 	OF oSection1 ALIAS "SU5"
DEFINE CELL NAME "U5_EMAIL" 	OF oSection1 ALIAS "SU5"

DEFINE SECTION oSection2 OF oSection1 TITLE STR0035 TABLES "AC8" LINE BREAK //Entidades

DEFINE CELL NAME "AC8_ENTIDA" 	OF oSection2 ALIAS "AC8"																											//Entidade
DEFINE CELL NAME "AC8_CODENT" 	OF oSection2 ALIAS "AC8" TITLE STR0024			  	    BLOCK {|| Padr((cAlias1)->AC8_CODENT,TkEntTam((cAlias1)->AC8_ENTIDA)[1]) }	//Codigo
DEFINE CELL NAME "NOME"			OF oSection2 			 TITLE STR0025 	  		SIZE 30 BLOCK {|| TkEntidade( (cAlias1)->AC8_ENTIDA, (cAlias1)->AC8_CODENT,1 ,,.T.) }	//Nome
DEFINE CELL NAME "ENDERECO"		OF oSection2 			 TITLE STR0026  		SIZE 30 BLOCK {|| TkEntidade( (cAlias1)->AC8_ENTIDA, (cAlias1)->AC8_CODENT,2 ,,.T.) }	//Endereco
DEFINE CELL NAME "MUNICIPIO"	OF oSection2 			 TITLE STR0027 			SIZE 20 BLOCK {|| TkEntidade( (cAlias1)->AC8_ENTIDA, (cAlias1)->AC8_CODENT,3 ,,.T.) }	//Municipio
DEFINE CELL NAME "UF"			OF oSection2 			 TITLE STR0028 	  		SIZE 02 BLOCK {|| TkEntidade( (cAlias1)->AC8_ENTIDA, (cAlias1)->AC8_CODENT,4 ,,.T.) }	//UF
DEFINE CELL NAME "CEP"			OF oSection2 			 TITLE STR0029 	  		SIZE 10 BLOCK {|| TkEntidade( (cAlias1)->AC8_ENTIDA, (cAlias1)->AC8_CODENT,5 ,,.T.) }	//CEP
DEFINE CELL NAME "F_COMERCIAL"	OF oSection2 			 TITLE STR0030			SIZE 15 BLOCK {|| TkEntidade( (cAlias1)->AC8_ENTIDA, (cAlias1)->AC8_CODENT,6 ,,.T.) }	//Fone Comercial
DEFINE CELL NAME "EMAIL"		OF oSection2 			 TITLE STR0031			SIZE 30 BLOCK {|| TkEntidade( (cAlias1)->AC8_ENTIDA, (cAlias1)->AC8_CODENT,7 ,,.T.) }	//e-mail
DEFINE CELL NAME "HPAGE"		OF oSection2 			 TITLE STR0032			SIZE 30 BLOCK {|| TkEntidade( (cAlias1)->AC8_ENTIDA, (cAlias1)->AC8_CODENT,8 ) }	//Home Page
DEFINE CELL NAME "DDD"			OF oSection2 			 TITLE STR0033			SIZE 05 BLOCK {|| TkEntidade( (cAlias1)->AC8_ENTIDA, (cAlias1)->AC8_CODENT,9 ,,.T.) }	//DDD

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTMKR010   บAutor  ณ Vendas Clientes    บ Data ณ  30/06/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para impressao do relatorio personalizavel           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Call Center                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function TKR010PrtRpt(oReport, cAlias1)
Local cQuery		:= "%%"								// Primeira Query
Local cQuery1		:= "%%"								// Segunda Query
Local oSection1		:= oReport:Section(1)		   		// Define a secao 1 do relatorio
Local oSection2		:= oSection1:Section(1)				// Define que a secao 2 serah filha da secao 1
Local cFiltro		:= ""								// Filtro para DBF
	
#IFDEF TOP

	DbSelectArea("AC8")
	DbSetOrder(1)
	
	If !Empty(Mv_Par01)
		cQuery := "%AC8.AC8_ENTIDA = '"+Mv_Par01+ "' AND%"
	Endif

	If Mv_Par04 <> 3
		cQuery1 := "%(SU5.U5_STATUS = '" + Str(Mv_Par04,1) +"' OR SU5.U5_STATUS = '') AND%"
	Endif
	
	MakeSqlExpr("TMKR010")
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณInicializa a secao 1ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	BEGIN REPORT QUERY oSection1

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณQuery da secao 1ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	BeginSql alias cAlias1
		SELECT	AC8_ENTIDA, AC8_CODCON,	AC8_CODENT,	U5_CODCONT, U5_CONTAT,	U5_DDD,
				U5_END,		U5_END, 	U5_FAX,		U5_FCOM1,	U5_FONE,	U5_STATUS,	
				U5_URL,		U5_CEP,		U5_EST, 	U5_MUN,		U5_BAIRRO,	U5_CELULAR,	U5_EMAIL
		FROM %table:SU5% SU5,%table:AC8% AC8
		WHERE	AC8.AC8_FILIAL	= %xfilial:AC8% AND 
				AC8.AC8_CODCON BETWEEN %exp:mv_par02% AND %exp:mv_par03% AND
				AC8.%notDel%						AND
				SU5.U5_FILIAL	= %xfilial:SU5% 	AND
	  			%exp:cQuery%   					
				SU5.U5_CODCONT  = AC8.AC8_CODCON 	AND				
				%exp:cQuery1%     
				SU5.%notDel%				     

		ORDER BY %Order:AC8%

	EndSql

	END REPORT QUERY oSection1

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณBaseada na query da secao1, utiliza filtro para saber quando deve sair do laco de impressaoณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oSection2:SetParentQuery()
	oSection2:SetParentFilter( { | cParam | (cAlias1)->AC8_CODCON == cParam},{|| (cAlias1)->U5_CODCONT } )

	oSection1:SetHeaderSection(.T.)		//Define que o header vai ser apresentado
#ELSE
    
	DbSelectArea("SU5")
	DbSetOrder(1)

	MakeSqlExpr("TMKR010")
    
  	cFiltro := "U5_FILIAL = '" + xFilial(cAlias1) + "'"
	If Mv_Par04 == 3 
		cFiltro += " .AND. U5_STATUS < '" + Str(Mv_Par04,1) + "' .OR. Empty(U5_STATUS)"
	Else
		cFiltro += " .AND. U5_STATUS = '" + Str(Mv_Par04,1) + "' .OR. Empty(U5_STATUS)"
	EndIf

	oSection1:SetFilter( cFiltro )

	oSection1:SetLineCondition({|| TkrChk_AC8() })

	oSection2:SetParentFilter( { | cParam | AC8->AC8_CODCON == cParam},{|| SU5->U5_CODCONT } )
	oSection1:SetHeaderSection(.T.)
	If !Empty(Mv_Par01)
		oSection2:SetRelation({|| xFilial("AC8") + SU5->U5_CODCONT + alltrim(Mv_Par01)},"AC8",1,.T.)
	Else
		oSection2:SetRelation({|| xFilial("AC8") + SU5->U5_CODCONT },"AC8",1,.T.)	
	EndIf
#ENDIF	
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณExecuta a impressao dos dados, de acordo com o filtro ou queryณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oSection1:Print()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณTcrChk_AC8 บAutor  ณ Vendas Clientes    บ Data ณ  30/06/06   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para considerar o grupo de produtos, informado no pa- บฑฑ
ฑฑบ          ณrametro do SetLineCondition em Codebase                      บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ TECR010                                                     บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function TkrChk_AC8()

DbSelectArea("AC8")
DbSetOrder(1)
If !Empty(Mv_Par01)
	Return MsSeek(	xFilial("AC8") + SU5->U5_CODCONT + alltrim(Mv_Par01)) .AND. ;
					Mv_Par04 == 3 .AND. AC8->AC8_CODCON >= Mv_Par02 .AND. ;
					AC8_CODCON <=  Mv_Par03
Else
	Return MsSeek(	xFilial("AC8") + SU5->U5_CODCONT) .AND. Mv_Par04 == 3 .AND. ;
					AC8->AC8_CODCON >= Mv_Par02 .AND. AC8_CODCON <=  Mv_Par03
EndIf