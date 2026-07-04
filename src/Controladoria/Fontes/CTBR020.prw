/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR020.CH"
#INCLUDE "PROTHEUS.CH"


// 17/08/2009 -- Filial com mais de 2 caracteres

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR020  ³ Autor ³ Eduardo Nunes Cirqueira ³ Data ³ 07/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Programa de Impressao do Cadastro de Centro de Custo		  	 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Ctbr020() 		                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGACTB                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CTBR020()

Local oReport

oReport	:= ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Eduardo Nunes      º Data ³  07/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport
Local oSecaoCTT

Local cReport	:=	"CTBR020"					// Nome do Relatorio

Local aArea		:= GetArea()
Local cPerg  	:= "CTR020"						// Nome do grupo de perguntas
Local cAlias	:= "CTT"						// Alias da tabela
Local cSayCusto	:= CtbSayApro("CTT")			// "C Custo"
Local cTitulo	:= STR0007 + cSayCusto			// "Listagem do Cadastro de C Custo"

Local aOrd	 	:= { cSayCusto,;				// "C Custo"
					 OemToAnsi(STR0004)}		// "Descricao"

Local cDesc		:= STR0001+" "+cSayCusto+;		// "Este programa ira imprimir o Cadastro de C Custo"
				   STR0002+;					// "Sera impresso de acordo com os parametros solicitados pelo"
				   STR0003						//	"usuario."
                                                                    
Local nCont
Local cMascara

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³add por Icaro Queiroz em 24 de Agosto de 2010     ³
*³Variaveis para tratamento de tipificacao - CTBR015³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local bTitulo		:= { |cCampo| SX3->( dbSetOrder(2) ), SX3->( MsSeek( cCampo ) ), X3Titulo() }
Local cTitCpo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01		// Do C.Custo                                ³
//³ mv_par02		// ate o C.Custo                             ³
//³ mv_par03		// folha inicial		         		     ³
//³ mv_par04		// Desc na Moeda						     ³
//³ mv_par05		// Imprime Bloqueadas?         	       	     ³ 
//³ mv_par06		// Mascara?                    	       	     ³ 
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("CTT")
dbSetOrder(1)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport	:= TReport():New( cReport,cTitulo,cPerg, { |oReport| Iif( U_CTBR020Imp( oReport,oSecaoCTT ), .T., oReport:CancelPrint() ) }, cDesc )
					
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define tantas secoes quantas Moedas existirem na base, pois somente assim podera imprimir ³
//³ a descricao da moeda que o usuario selecionou atraves do parametro mv_par04               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CTO->( MsSeek( xFilial("CTO"),.T. ) )
oSecaoCTT := TRSection():New( oReport, cSayCusto , {"CTT"}, aOrd )	//	"Listagem do Cadastro de C Custo"

TRCell():New( oSecaoCTT, "CTT_CUSTO"	,"CTT",Upper(cSayCusto)												,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// "C CUSTO"
TRCell():New( oSecaoCTT, "DESCRI"		,"CTT",STR0008															,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| If(CTT->( FieldPos("CTT_DESC"+mv_par04) )>0,CTT->( FieldGet(FieldPos("CTT_DESC"+mv_par04)) ),CTT->CTT_DESC01) } )	// "D E N O M I N A C A O "
TRCell():New( oSecaoCTT, "CTT_CCSUP"	,"CTT",Upper(cSayCusto)+" "+AllTrim(Left(STR0009,10))	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// "C CUSTO SUPERIOR"
TRCell():New( oSecaoCTT, "CTT_BLOQ"		,"CTT",AllTrim(Right(STR0009,5))									,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)	// "BLOQ"

*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
*³Add por Icaro Queiroz em 24 de Agosto de 2010                  ³
*³Caso seja chamado do CTBR015, imprime as calunas de tipificacao³
*ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Upper( FunName() ) == 'CTBR015'
	If 	CTT->( FieldPos( "CTT_TPO01" ) ) > 0 .And.;
		CTT->( FieldPos( "CTT_TPO02" ) ) > 0 .And.;
		CTT->( FieldPos( "CTT_TPO03" ) ) > 0 .And.;
		CTT->( FieldPos( "CTT_TPO04" ) ) > 0

		If MV_TPO01 > 0
			cTitCpo := Eval( bTitulo, ( "CTT_TPO" + StrZero( MV_TPO01, 2 ) ) )
			TRCell():New( oSecaoCTT, "CTT_TPO01"		,"CTT" , cTitCpo,/*Picture*/,/*Tamanho*/,/*lPixel*/, { || &( "CTT->CTT_TPO" + StrZero( MV_TPO01, 2 ) ) } )
		EndIf

		If MV_TPO02 > 0
			cTitCpo := Eval( bTitulo, ( "CTT_TPO" + StrZero( MV_TPO02, 2 ) ) )
			TRCell():New( oSecaoCTT, "CTT_TPO02"		,"CTT" , cTitCpo,/*Picture*/,/*Tamanho*/,/*lPixel*/, { || &( "CTT->CTT_TPO" + StrZero( MV_TPO02, 2 ) ) } )
		EndIf

		If MV_TPO03 > 0
			cTitCpo := Eval( bTitulo, ( "CTT_TPO" + StrZero( MV_TPO03, 2 ) ) )
			TRCell():New( oSecaoCTT, "CTT_TPO03"		,"CTT" , cTitCpo,/*Picture*/,/*Tamanho*/,/*lPixel*/, { || &( "CTT->CTT_TPO" + StrZero( MV_TPO03, 2 ) ) } )
		EndIf

		If MV_TPO04 > 0
			cTitCpo := Eval( bTitulo, ( "CTT_TPO" + StrZero( MV_TPO04, 2 ) ) )
			TRCell():New( oSecaoCTT, "CTT_TPO04"		,"CTT" , cTitCpo,/*Picture*/,/*Tamanho*/,/*lPixel*/, { || &( "CTT->CTT_TPO" + StrZero( MV_TPO04, 2 ) ) } )
		EndIf

	EndIf
EndIf

Return oReport      


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR020Imp ³ Autor ³ Eduardo Nunes Cirqueira ³ Data ³ 17/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Programa de Impressao do Cadastro de Centro de Custo (R4)      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Ctbr020(oReport,oSection)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGACTB                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oReport  = Objeto de impressao da classe TReport               ³±±
±±³          ³ oSection = Matriz contendo as Secoes de impressao. Cada        ³±±
±±³          ³            elemento corresponde a secao de uma moeda           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR020Imp( oReport,oSecaoCTT )

Local lMoedaOk		:= .T.

Local cMascara		:= ""
Local cSeparador	:= ""

Local cChave 		:= ""
Local cIndex		:= ""

Local nSizeCC		:= 0
Local nIndex		:= 0
Local nScanMoeda	:= 0
Local nTamCusto		:= TamSX3("CTT_CUSTO")[1]

Pergunte("CTR020",.F.)

oReport:SetPageNumber( mv_par03 ) //mv_par03 - Pagina Inicial

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verificando se a Moeda informada pelo usuario (mv_par04) esta cadastrada ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If (	Empty(mv_par04)	)	.Or.;										//	Se nao preencheu a moeda ou;
	(	! CTO->( MsSeek( xFilial("CTO")+mv_par04,.F. ) )	)	//	nao encontrou a Moeda no cadastro
	Help(" ",1,"NOMOEDA")
	Return .F.
EndIf

If Empty(mv_par06)
	cMascara := GetMv("MV_MASCCUS")
Else
	cMascara := RetMasCtb(mv_par06,@cSeparador)
EndIf

nSizeCC := IF( Empty(cMascara),nTamCusto,If(Empty(cSeparador),nTamCusto+Len(cMascara),nTamCusto+Len(cSeparador)))
                                            
oSecaoCTT:Cell("CTT_CUSTO"):SetSize(nSizeCC)
oSecaoCTT:Cell("CTT_CCSUP"):SetSize(nSizeCC)
	
oSecaoCTT:Cell("CTT_CUSTO"):SetBlock(	{|| EntidadeCTB(CTT->CTT_CUSTO,000,000,030,.F.,cMascara,cSeparador,,,.F.,,.F.)	}	)
oSecaoCTT:Cell("CTT_CCSUP"):SetBlock(	{|| EntidadeCTB(CTT->CTT_CCSUP,000,000,030,.F.,cMascara,cSeparador,,,.F.,,.F.)	}	)
oSecaoCTT:Cell("CTT_BLOQ" ):SetBlock(	{|| If (CTT->CTT_BLOQ == "1",OemToAnsi(STR0012),OemToAnsi(STR0013)) 	}	)
                                                                               
cCondicao := "CTT_FILIAL =='"+ xFilial('CTT') +"'.And. CTT_CUSTO >= '"+mv_par01+"' .And. CTT_CUSTO <='"+ mv_par02+ "'"
IF mv_par05 == 2
	cCondicao += " .And. CTT_BLOQ <> '1' "
EndIf

oSecaoCTT:SetLineCondition({|| &cCondicao})

// Se NAO selecionou a ordem por codigo do C.Custo
If oSecaoCTT:GetOrder() <> 1

      // Se for Moeda 01
	If mv_par04 == "01"
		// Trabalhando com o indice 4 do CTT ( CTT_FILIAL + CTT_DESC01 )
		oSecaoCTT:SetIdxOrder(4)
	Else                                      		
		//Se NAO for Moeda 01, criar indice temporario por descricao na moeda selecionada
		cChave 	:= "CTT_FILIAL+CTT_DESC"+mv_par04
		cIndex	:= CriaTrab(nil,.f.)
		IndRegua("CTT",cIndex,cChave,,,OemToAnsi(STR0011)) //"Selecionando Registros..."
		nIndex	:= RetIndex("CTT")
		oSecaoCTT:SetIdxOrder(0)
	EndIf
EndIf

oSecaoCTT:Print()

// Se criou novo indice, apaga-lo e retornar o indice 1 do CTT
If oSecaoCTT:GetOrder() <> 1
	If mv_par04 <> "01"
		CTT->( dbClearFilter() )
		RetIndex( "CTT" )
		If !Empty(cIndex)
			FErase( cIndex+OrdBagExt() )
		Endif
	EndIf
	CTT->( dbSetOrder(1) )
EndIf
	
Return .T.