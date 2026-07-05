/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr415.ch"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR415
Relatorio dos funcionarios classificados por doenca  da CID.
O usuario pode selecionar o codigo da doenca, obtendo como
resultado a relacao de funcionarios que possui determinada
doenca. Este relatorio esta baseado nas informacoes contidas
na tabela do diagnostico medico  (TMT). No final do relato-
rio encontra-se um resumo dos diagnosticos pesquisados.

@author Marcio Costa
@since 12/01/2000

@sample MDTR415

@return .T.
/*/
//---------------------------------------------------------------------
User Function MDTR415()
//----------------------------------------------------
//  Armazena variaveis p/ devolucao (NGRIGHTCLICK) 	-
//----------------------------------------------------
Local aNGBEGINPRM := NGBEGINPRM()

Local oReport
Local aArea := GetArea()
Local aPerg := {}
Private lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
Private lPrestSX6 := .F.

PRIVATE cPerg := If(!lSigaMdtPS,"MDT415    ","MDT415PS  ")

If SuperGetMv("MV_NGMDTPS",.F.,"N") == "S" //Parametro especifico pra Unimed-Prestador
	lPrestSX6  := .T.
Endif

Private nSizeSI3   := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
Private cAliasCC   := "SI3"
Private cDescr     := "SI3->I3_DESC"

//Objetos das tabelas temporarias
Private oTempTRB
Private oTempImp
Private oTempImp2

//Tabelas temporarias
Private cAliasImp  := GetNextAlias()
Private cAliasImp2 := GetNextAlias()
Private cAliasGrv  := GetNextAlias()

fCreateTRB()

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cDescr   := "CTT->CTT_DESC01"
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
Endif
If !MDTRESTRI(cPrograma)
	//-------------------------------------------------
	//  Devolve variaveis armazenadas (NGRIGHTCLICK)  -
	//-------------------------------------------------
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/*
//-----------------------------------------
//PERGUNTAS DO PADRÃO						|
|  01  De  CID ?             				|
|  02  Ate CID ?             				|
|  03  De  Data Diagnost. ?  				|
|  04  Ate Data Diagnost. ?  				|
|  05  De Ficha ?            				|
|  06  Ate Ficha ?           				|
|  07  De Cliente ?          				|
|  08  Ate Cliente ?  						|
|  09  Agrupar Por ?       					|
| 												|
//PERGUNTAS DO PRESTADOR DE SERVIÇO		|
|  01  De  Cliente ?         				|
	| 02  Loja                  |
	| 03  Até Cliente ?         |
	| 04  Loja                  |
	| 05  De  CID ?             |
	| 06  Ate CID ?             |
	| 07  De  Data Diagnost. ?  |
	| 08  Ate Data Diagnost. ?  |
	| 09  De Ficha ?            |
	| 10  Ate Ficha ?           |
|  11  Agrupar Por ?      					|
//-----------------------------------------
*/

If TRepInUse()
   //-- Interface de impressao
   oReport := ReportDef()
   oReport:SetPortrait()
   oReport:PrintDialog()
Else
   U_MDTR415R3()
EndIf
RestArea(aArea)

//-------------------------------------------------
//  Devolve variaveis armazenadas (NGRIGHTCLICK)  -
//-------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)

Return .T.
//---------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define as secoes impressas no relatorio

@author Andre E. Perez Alvarez
@since 16/11/2006

@sample MDTR415

@return oReport
/*/
//---------------------------------------------------------------------
Static Function ReportDef()

Static cIdade
Static oReport
Static oSection0
Static oSection1
Static oSection2
Static oSection3
Static oSection4
Static oBreak1
Static oCell
Static oCel2
Static oCel3
Static oCel4

/*        1         2         3         4         5         6         7         8         9       100       110       120       130       140
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
_______________________________________________________________________________________________________________________________________________

                                                       CID x Funcionario
_______________________________________________________________________________________________________________________________________________

CID			Descricao
-----------------------------------------
123456789  123456789012345678901234567890

Matricula  Nome Funcionario           Sexo      Admissao  Idade  Dt. Diag.  C. Custo   Funcao Descricao
---------------------------------------------------------------------------------------------------------------------
123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890
123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890
123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890
123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890

CID			Descricao
-----------------------------------------
123456789  123456789012345678901234567890

Matricula  Nome Funcionario           Sexo      Admissao  Idade  Dt. Diag.  C. Custo   Funcao Descricao
---------------------------------------------------------------------------------------------------------------------
123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890
123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890
123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890
123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890

_______________________________________________________________________________________________________________________________________________
Resumo do Relatorio
Total de Diagnosticos Pesquisados:  xxx

C.I.D.    Descricao                                 Masculinos Femininos Total
------------------------------------------------------------------------------
12345678  1234567890123456789012345678901234567890         xxx       xxx   xxx
12345678  1234567890123456789012345678901234567890         xxx       xxx   xxx
12345678  1234567890123456789012345678901234567890         xxx       xxx   xxx

*/


//--------------------------------------------------------------------------
// Criacao do componente de impressao                                      -
//                                                                         -
// TReport():New                                                           -
// ExpC1 : Nome do relatorio                                               -
// ExpC2 : Titulo                                                          -
// ExpC3 : Pergunte                                                        -
// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  -
// ExpC5 : Descricao                                                       -
//                                                                        -
//--------------------------------------------------------------------------
oReport := TReport():New("MDTR415",OemToAnsi(STR0004),cPerg,{|oReport| ReportPrint()},;  //"CID x Funcionarios"
           STR0001+STR0002+STR0003)
// STR0001 - "Relatorio de apresentacao dos funcionarios por tipo de doenca,    "
// STR0002 - "conforme definicao feita pelo medico atraves do diangostico.      "
// STR0003 - "As doencas sao classificadas pela tabela CID.   "

Pergunte(oReport:uParam,.F.)
//----------------------------------------------------------------
//  Variaveis utilizadas para parametros                         -
//  mv_par01             // De CID                               -
//  mv_par02             // Ate CID                              -
//  mv_par03             // De Data Diagnostico                  -
//  mv_par04             // Ate Data Diagnostico                 -
//  mv_par05             // De Ficha                             -
//  mv_par06             // Ate Ficha                            -
//So para prestador de servico										  -
//  mv_par07             // De Cliente                           -
//  mv_par08             // Ate Cliente                          -
//----------------------------------------------------------------

//--------------------------------------------------------------------------
// Criacao da secao utilizada pelo relatorio                               -
//                                                                         -
// TRSection():New                                                         -
// ExpO1 : Objeto TReport que a secao pertence                             -
// ExpC2 : Descricao da seçao                                              -
// ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   -
//         sera considerada como principal para a seção.                   -
// ExpA4 : Array com as Ordens do relatório                                -
// ExpL5 : Carrega campos do SX3 como celulas                              -
//         Default : False                                                 -
// ExpL6 : Carrega ordens do Sindex                                        -
//         Default : False                                                 -
//                                                                         -
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
// Criacao da celulas da secao do relatorio                                -
//                                                                         -
// TRCell():New                                                            -
// ExpO1 : Objeto TSection que a secao pertence                            -
// ExpC2 : Nome da celula do relatório. O SX3 será consultado              -
// ExpC3 : Nome da tabela de referencia da celula                          -
// ExpC4 : Titulo da celula                                                -
//         Default : X3Titulo()                                            -
// ExpC5 : Picture                                                         -
//         Default : X3_PICTURE                                            -
// ExpC6 : Tamanho                                                         -
//         Default : X3_TAMANHO                                            -
// ExpL7 : Informe se o tamanho esta em pixel                              -
//         Default : False                                                 -
// ExpB8 : Bloco de código para impressao.                                 -
//         Default : ExpC2                                                 -
//                                                                         -
//--------------------------------------------------------------------------

If lSigaMdtps
	//********************* Secao 0 - Cliente
	oSection0 := TRSection():New (oReport, STR0026, {cAliasGrv,"SA1"} ) //"Cliente"
	oCell := TRCell():New(oSection0, "( cAliasGrv )->CLIENTE", cAliasGrv , STR0026, "@!", nTa1  )  //"Cliente"
	oCell := TRCell():New(oSection0, "( cAliasGrv )->LOJA"   , cAliasGrv , STR0036, "@!", nTa1L  )  //"Loja"
	oCell := TRCell():New(oSection0, "SA1->A1_NOME", "SA1" , STR0013, "@!", 40  )  //"Nome"
	TRPosition():New (oSection0, "SA1", 1, {|| xFilial("SA1") + ( cAliasGrv )->CLIENTE + ( cAliasGrv )->LOJA } )
Else
	If lPrestSX6
		//********************* Secao 0 - Cliente
		oSection0 := TRSection():New (oReport, STR0026, {cAliasGrv,"SA1"} ) //"Cliente"
		oCell := TRCell():New(oSection0, "( cAliasGrv )->CLIENTE", cAliasGrv , STR0026, "@!", 06  )  //"Cliente"
		oCell := TRCell():New(oSection0, "SA1->A1_NOME", "SA1" , STR0013, "@!", 40  )  //"Nome"
		TRPosition():New (oSection0, "SA1", 1, {|| xFilial("SA1") + ( cAliasGrv )->CLIENTE } )
	Endif
Endif

//********************* Secao 1 - CID
oSection1 := TRSection():New (oReport, STR0010, { cAliasGrv,"TMR"} ) //"C.I.D."
oCell := TRCell():New(oSection1, "( cAliasGrv )->CID"  , cAliasGrv , STR0010, "@!", 08  )  //"C.I.D."
oCell := TRCell():New(oSection1, "SubStr( TMR->TMR_DOENCA,1,45 )", "TMR" , STR0011, "@!", 60  )  //"Descricao"
oCell := TRCell():New(oSection1, "( cAliasGrv )->GRPCID" , cAliasGrv , STR0050, "@!", 03  )  //"Grupo C.I.D."
TRPosition():New (oSection1, "TMR", 1, {|| xFilial("TMR") + ( cAliasGrv )->CID } )

//********************* Secao 2 - Funcionários
oSection2 := TRSection():New (oReport,STR0023, { cAliasGrv,"TMT","TM0",cAliasCC, "SRJ"},,,,,,,,,,5 ) //Funcionarios
oCel2 := TRCell():New (oSection2, "( cAliasGrv )->MAT"   	, cAliasGrv, STR0012, "@!", 10, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Matrícula"
oCel2 := TRCell():New (oSection2, "( cAliasGrv )->NUMFIC"	, cAliasGrv, STR0060, "@!", 17, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Ficha Médica"
oCel2 := TRCell():New (oSection2, "TM0_NOMFIC" 	, "TM0", STR0013, "@!", 40, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Nome"
oCel2 := TRCell():New (oSection2, "( cAliasGrv )->SEXO"  	,      , STR0014, "@!", 15, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Sexo"
oCel2 := TRCell():New (oSection2, "( cAliasGrv )->ADMISSA"	,cAliasGrv	, STR0015, "99/99/9999", 15, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Admissao"
oCel2 := TRCell():New (oSection2, "( cAliasGrv )->IDADE"	,cAliasGrv	, STR0016, "@!",5, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Idade"

//********************* Seção 4 - Diagnósticos
oSection4 := TRSection():New ( oReport,"Diagnósticos", { cAliasGrv,"TMT","TM0",cAliasCC, "SRJ"},,,,,,,,,,10 ) //"Diagnósticos"
oCel4 := TRCell():New (oSection4, "( cAliasGrv )->DTATEN", cAliasGrv, STR0017, "99/99/9999", 13, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Dt.Diag."
oCel4 := TRCell():New (oSection4, "( cAliasGrv )->HRATEN", cAliasGrv, STR0059, "99:99", 13, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Hora Diagn."
oCel4 := TRCell():New (oSection4, "( cAliasGrv )->CC"    , cAliasGrv, STR0018, "@!", nSizeSI3+6, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"C.Custo"
oCel4 := TRCell():New (oSection4, "( cAliasGrv )->CODFUN", cAliasGrv, STR0019, "@!", 08, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Funcao"
oCel4 := TRCell():New (oSection4, "RJ_DESC"    , "SRJ", STR0011, "@!", 40, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Descricao"

TRPosition():New (oSection2, "TMT", 1, {|| xFilial("TMT") + ( cAliasGrv )->NUMFIC + DTOS(( cAliasGrv )->DTATEN) + ( cAliasGrv )->HRATEN } )
TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + ( cAliasGrv )->NUMFIC } )
TRPosition():New (oSection2, "SRA", 1, {|| xFilial("SRA") + ( cAliasGrv )->MAT } )
TRPosition():New (oSection2, cAliasCC, 1, {|| xFilial(cAliasCC) + ( cAliasGrv )->CC } )
TRPosition():New (oSection2, "SRJ", 1, {|| xFilial("SRJ") + ( cAliasGrv )->CODFUN } )

Return oReport
//---------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o relatorio.

@author Andre E. Perez Alvarez
@since 16/11/2006

@sample MDTR415

@return .T.
/*/
//---------------------------------------------------------------------
Static Function ReportPrint()

Local nX
Local nLinha
Local aResumo := {}
Local aResumoCli := {}
Local nMasculino, nFeminino
Local cCID

//So para Prestadores de Servico
Local cCliente
Local nTotCli
Local nPOS
//Identifica Forma de agrupamento de acordo com o ambiente em execucao
Local nAgrup := U_MDTR415AGR()
Local aCds := {}
Local nI := 0
Local cNumFic

Processa( {|lEND| TRBgrava()}, STR0020, STR0021 ) //"Aguarde" ## "Processando os diagnósticos..."

dbSelectArea( cAliasGrv )
dbSetOrder( 1 )
dbGoTop()

oReport:SetMeter( RecCount() )
nX := 1

//-------------------------------------------
// Agrupamento por CID+CID Complementar
//-------------------------------------------
If nAgrup == 2
	oSection3 := TRSection():New ( oReport,STR0052, {} ,,,,,,,,,,15 ) // "CID + CID Complementar"
	oCel3 := TRCell():New( oSection3,"", , STR0051, "@!", 08, /*lPixel*/, {|| aCds[nI][2] } ) //"CID Comp."
	oCel3 := TRCell():New( oSection3,"", , STR0052, "@!", 03, /*lPixel*/, {|| aCds[nI][1] } ) //"Grupo CID Comp."
EndIf

If lSigaMdtps

	While !oReport:Cancel() .AND.;
		  !Eof()

	    cCliente := ( cAliasGrv )->CLIENTE+( cAliasGrv )->LOJA
		oSection0:Init()
		oSection0:PrintLine()
		nTotCli := 0
		nX := 1
		aResumoCli := {}

	    While !oReport:Cancel() 		  .AND.;
    	  	  !Eof()					  .AND.;
    		  cCliente == ( cAliasGrv )->CLIENTE+( cAliasGrv )->LOJA

    		cCID := ( cAliasGrv )->CID
			nMasculino := nFeminino := 0

    		dbSelectArea( "TMR" )
			dbSetOrder( 1 )
			dbSeek( xFilial("TMR") + ( cAliasGrv )->CID )
			Aadd( aResumoCli, { ( cAliasGrv )->CID, SubStr( TMR->TMR_DOENCA,1,35 ), nMasculino, nFeminino } )

			oSection1:Init() //-- CID
			oSection1:PrintLine()
			oSection2:Init() //-- Funcionarios
			DbSelectArea( cAliasGrv )
		    While !oReport:Cancel() 		  .AND.;
		    	  !Eof()					  .AND.;
		    	  ( cAliasGrv )->CID == cCID			  .AND.;
		    	  cCliente == ( cAliasGrv )->CLIENTE+( cAliasGrv )->LOJA

				cNumFic := ( cAliasGrv )->NUMFIC

				oReport:IncMeter()
		    	oSection2:PrintLine()

		    	oSection4:Init() //-- Diagnósticos
		    	DbSelectArea( cAliasGrv )
		    	While !oReport:Cancel() .And.  !EoF() .And. ( cAliasGrv )->CID == cCID .And. cCliente == ( cAliasGrv )->CLIENTE+( cAliasGrv )->LOJA .And. ( cAliasGrv )->NUMFIC == cNumFic

			    	// Imprime diagnósticos do Funcionário
			    	oSection4:PrintLine()

					//----------------------------------------------------------
			    	// Imprime Cids complementares relacionados ao Diagnósticos
			    	//----------------------------------------------------------
					If nAgrup == 2
						oSection3:Init() // "CID + CID Complementar"
						aCds := MDTR415AC2( ( cAliasGrv )->NUMFIC,( cAliasGrv )->CID,DTOS( ( cAliasGrv )->DTCONS ),( cAliasGrv )->HRCONS,( cAliasGrv )->CLIENTE+( cAliasGrv )->LOJA ) // Retorna CID's complementares do Diagnósticos
						If Len( aCds ) > 0
							For nI := 1 To Len( aCds )
								oSection3:PrintLine()
							Next nI
						EndIf
						oSection3:Finish()
						oReport:SkipLine()
					EndIf

					aCds := {}
					If( ( cAliasGrv )->SEXO == STR0005, nMasculino++, nFeminino++) //"Masculino"
		    		nTotCli++

		    		DbSelectArea( cAliasGrv )
		    		DbSkip()
				EndDo
				oSection4:Finish()
				oReport:SkipLine()
		    EndDo

		    oSection2:Finish()
		    oSection1:Finish()

		    aResumoCli[nX][3] := nMasculino
		    aResumoCli[nX][4] := nFeminino
		    nX++

    	End
    	oSection0:Finish()

    	//-----------------------------------------------
    	// Imprime totalizadores do Cliente.
    	//-----------------------------------------------
    	oReport:SkipLine()
		oReport:FatLine()
		oReport:SkipLine()
		oReport:PrintText( STR0025 ) //"Resumo do Cliente"
		oReport:PrintText( STR0008 + AllTrim(STR( nTotCli )) ) //"Total de Diagnósticos Pesquisados: "
		nLinha := oReport:nRow

		If nAgrup == 2 // Caso agrupamento por CID+CID Comp.

			oReport:PrintText( STR0010, nLinha, 10 )   //"C.I.D."
			oReport:PrintText( STR0011, nLinha, 120 )  //"Descricao"
			oReport:PrintText( STR0050, nLinha, 750 )  // "Grupo CID"
			oReport:PrintText( STR0051, nLinha, 1100 )  //"CID Comp."
			oReport:PrintText( STR0052, nLinha, 1450 ) //"Grupo CID Comp."
			oReport:PrintText( STR0005, nLinha, 1810 ) //"Masculino" + 400
			oReport:PrintText( STR0006, nLinha, 2010 ) //"Feminino"
			oReport:PrintText( STR0009, nLinha, 2310 ) //"Total"

			//---------------------------------------------------------------------------------
			// Atribui a variável de resumo do relatório, o resultado da função de agrupamento
			// de CID + CID Comp.
			//---------------------------------------------------------------------------------
			aResumoCli := {}
			aResumoCli := MDT415AGRUP( .F.,cCliente ) // Contabiliza por cliente.

			oReport:SkipLine()
			oReport:SkipLine()
			For nX := 1 To Len( aResumoCli )

				//Usar a mesma linha corrente - var x
				nLinha := oReport:nRow	//Usar a mesma linha corrente
				oReport:PrintText( aResumoCli[nX][1], nLinha, 10 ) //CID
				oReport:PrintText( SubStr( aResumoCli[nX][2],1,45 ), nLinha, 120 ) //Descricao
				oReport:PrintText( aResumoCli[nX][3], nLinha, 750 ) //Grupo Cid Principal
				oReport:PrintText( aResumoCli[nX][4], nLinha, 1100 ) //Cid Comp.
				oReport:PrintText( aResumoCli[nX][5], nLinha, 1450 ) //Grupo Cid Comp.
				oReport:PrintText( AllTrim(STR(aResumoCli[nX][6])), nLinha, 1920 ) //Masculinos
				oReport:PrintText( AllTrim(STR(aResumoCli[nX][7])), nLinha, 2105 ) //Femininos
				oReport:PrintText( AllTrim(STR(aResumoCli[nX][8])), nLinha, 2365 ) //Total
				oReport:SkipLine()
			Next nX

		Else

			oReport:PrintText( STR0010, nLinha, 10 )   //"C.I.D."
			oReport:PrintText( STR0011, nLinha, 120 )  //"Descricao"
			oReport:PrintText( STR0050, nLinha, 500 )  //"Grupo CID"
			oReport:PrintText( STR0005, nLinha, 1810 ) //"Masculino" + 400
			oReport:PrintText( STR0006, nLinha, 2010 ) //"Feminino"
			oReport:PrintText( STR0009, nLinha, 2310 ) //"Total"

			oReport:SkipLine()
			oReport:SkipLine()
			For nX := 1 To Len(aResumoCli)
				//Usar a mesma linha corrente - var x
				nLinha := oReport:nRow	//Usar a mesma linha corrente
				oReport:PrintText( aResumoCli[nX][1], nLinha, 10 ) //CID
				oReport:PrintText( aResumoCli[nX][2], nLinha, 120 ) //Descricao
				oReport:PrintText( AllTrim(STR(aResumoCli[nX][3])), nLinha, 1920 ) //Masculinos
				oReport:PrintText( AllTrim(STR(aResumoCli[nX][4])), nLinha, 2105 ) //Femininos
				oReport:PrintText( AllTrim(STR(aResumoCli[nX][3] + aResumoCli[nX][4])), nLinha, 2365 ) //Total
				oReport:SkipLine()
				If ( nPOS  := aSCAN( aResumo, { |x| x[1] == aResumoCli[nX][1]}) ) > 0
					aResumo[nPOS][3] += aResumoCli[nX][3]
					aResumo[nPOS][4] += aResumoCli[nX][4]
					aResumo[nPOS][5] += aResumoCli[nX][3] + aResumoCli[nX][4]
				Else
					AADD( aResumo, {aResumoCli[nX][1], aResumoCli[nX][2], aResumoCli[nX][3], aResumoCli[nX][4], aResumoCli[nX][3]+aResumoCli[nX][4] } )
				Endif
			Next nX

		EndIf

	End

Else

	If !lPrestSX6
		DbSelectArea( cAliasGrv )
		While !oReport:Cancel() .AND.;
			  !Eof()

			cCID := ( cAliasGrv )->CID
			nMasculino := nFeminino := 0

			dbSelectArea( "TMR" )
			dbSetOrder( 1 )
			dbSeek( xFilial("TMR") + ( cAliasGrv )->CID )
			Aadd( aResumo, { ( cAliasGrv )->CID, SubStr( TMR->TMR_DOENCA,1,35 ), nMasculino, nFeminino } )

			oSection1:Init() //-- CID
			oSection1:PrintLine()
			oSection2:Init() //-- Funcionarios

			DbSelectArea( cAliasGrv )
		    While !oReport:Cancel() 		.AND.;
		    	  !Eof()					.AND.;
		    	  ( cAliasGrv )->CID == cCID

		    	oReport:IncMeter()
		    	oSection2:PrintLine()

		    	cNumFic := ( cAliasGrv )->NUMFIC
		    	oSection4:Init() //-- Diagnósticos
		    	// Impressão de seção de Diagnósticos
		    	DbSelectArea( cAliasGrv )
		    	While !oReport:Cancel() .And. !EoF() .And. ( cAliasGrv )->CID == cCID .And. ( cAliasGrv )->NUMFIC == cNumFic

					oSection4:PrintLine()

			    	//----------------------------------------------------------
			    	// Imprime Cids complementares relacionados ao Diagnósticos
			    	//----------------------------------------------------------
					If nAgrup == 2
						oSection3:Init() // "CID + CID Complementar"
						aCds := MDTR415AC2( ( cAliasGrv )->NUMFIC,( cAliasGrv )->CID,DTOS( ( cAliasGrv )->DTCONS ),( cAliasGrv )->HRCONS ) // Retorna CID's complementares dos Diagnósticos
						If Len( aCds ) > 0
							For nI := 1 To Len( aCds )
								oSection3:PrintLine()
							Next nI
						EndIf
						oSection3:Finish()
						oReport:SkipLine()
					EndIf

					aCds := {}

					If( ( cAliasGrv )->SEXO == STR0005, nMasculino++, nFeminino++) //"Masculino"
		    		DbSelectArea( cAliasGrv )
		    		DbSkip()
		    		oReport:SkipLine()
				EndDo
		    End

			oSection4:Finish()
		    oSection2:Finish()
		    oSection1:Finish()

		    aResumo[nX][3] := nMasculino
		    aResumo[nX][4] := nFeminino
		    nX++

		End

	Else

		While !oReport:Cancel() .AND.;
			  !Eof()

		    cCliente := ( cAliasGrv )->CLIENTE
			oSection0:Init()
			oSection0:PrintLine()
			nTotCli := 0
			nX := 1
			aResumoCli := {}

		    While !oReport:Cancel() 		  .AND.;
	    	  	  !Eof()					  .AND.;
	    		  cCliente == ( cAliasGrv )->CLIENTE

	    		cCID := ( cAliasGrv )->CID
				nMasculino := nFeminino := 0

	    		dbSelectArea( "TMR" )
				dbSetOrder( 1 )
				dbSeek( xFilial("TMR") + ( cAliasGrv )->CID )
				Aadd( aResumoCli, { ( cAliasGrv )->CID, SubStr( TMR->TMR_DOENCA,1,35 ), nMasculino, nFeminino } )

				oSection1:Init() //-- CID
				oSection1:PrintLine()
				oSection2:Init() //-- Funcionarios

			    While !oReport:Cancel() 		  .AND.;
			    	  !Eof()					  .AND.;
			    	  ( cAliasGrv )->CID == cCID			  .AND.;
			    	  cCliente == ( cAliasGrv )->CLIENTE

					oReport:IncMeter()
			    	oSection2:PrintLine()
			    	If( ( cAliasGrv )->SEXO == STR0005, nMasculino++, nFeminino++) //"Masculino"
			    	nTotCli++
			    	dbSelectArea( cAliasGrv )
			    	dbSkip()
			    End

			    oSection2:Finish()
			    oSection1:Finish()

			    aResumoCli[nX][3] := nMasculino
			    aResumoCli[nX][4] := nFeminino
			    nX++

	    	End
	    	oSection0:Finish()

	    	oReport:SkipLine()
			oReport:FatLine()
			oReport:SkipLine()
			oReport:PrintText( STR0025 ) //"Resumo do Cliente"
			oReport:PrintText( STR0008 + AllTrim(STR( nTotCli )) ) //"Total de Diagnósticos Pesquisados: "
			nLinha := oReport:nRow
			oReport:PrintText( STR0010, nLinha, 10 )   //"C.I.D."
			oReport:PrintText( STR0011, nLinha, 120 )  //"Descricao"
			oReport:PrintText( STR0005, nLinha, 1810 ) //"Masculino" + 400
			oReport:PrintText( STR0006, nLinha, 2010 ) //"Feminino"
			oReport:PrintText( STR0009, nLinha, 2310 ) //"Total"

			oReport:SkipLine()
			oReport:SkipLine()
			For nX := 1 To Len(aResumoCli)
				//Usar a mesma linha corrente - var x
				nLinha := oReport:nRow	//Usar a mesma linha corrente
				oReport:PrintText( aResumoCli[nX][1], nLinha, 10 ) //CID
				oReport:PrintText( aResumoCli[nX][2], nLinha, 120 ) //Descricao
				oReport:PrintText( AllTrim(STR(aResumoCli[nX][3])), nLinha, 1920 ) //Masculinos
				oReport:PrintText( AllTrim(STR(aResumoCli[nX][4])), nLinha, 2105 ) //Femininos
				oReport:PrintText( AllTrim(STR(aResumoCli[nX][3] + aResumoCli[nX][4])), nLinha, 2365 ) //Total
				oReport:SkipLine()
				If ( nPOS  := aSCAN( aResumo, { |x| x[1] == aResumoCli[nX][1]}) ) > 0
					aResumo[nPOS][3] += aResumoCli[nX][3]
					aResumo[nPOS][4] += aResumoCli[nX][4]
					aResumo[nPOS][5] += aResumoCli[nX][3] + aResumoCli[nX][4]
				Else
					AADD( aResumo, {aResumoCli[nX][1], aResumoCli[nX][2], aResumoCli[nX][3], aResumoCli[nX][4], aResumoCli[nX][3]+aResumoCli[nX][4] } )
				Endif
			Next nX

		End

	Endif

Endif

//-------------------------------------------------------
// Resumo geral do relatório, abrange prestador e padrão.
//-------------------------------------------------------
/*
_______________________________________________________________________________________________________________________________________________
Resumo do Relatorio
Total de Diagnosticos Pesquisados:  xxx

C.I.D.    Descricao                                 Masculinos Femininos Total
------------------------------------------------------------------------------
12345678  1234567890123456789012345678901234567890         xxx       xxx   xxx
12345678  1234567890123456789012345678901234567890         xxx       xxx   xxx
12345678  1234567890123456789012345678901234567890         xxx       xxx   xxx

*/

oReport:SkipLine()
oReport:FatLine()
oReport:SkipLine()
oReport:PrintText( STR0007 ) //"Resumo do Relatório"
oReport:PrintText( STR0008 + AllTrim(STR( ( cAliasGrv )->(RecCount()) )) ) //"Total de Diagnósticos Pesquisados: "
nLinha := oReport:nRow

If nAgrup == 2

	oReport:PrintText( STR0010, nLinha, 10 )   //"C.I.D."
	oReport:PrintText( STR0011, nLinha, 120 )  //"Descricao"
	oReport:PrintText( STR0050, nLinha, 700 )  // "Grupo CID"
	oReport:PrintText( STR0051, nLinha, 900 )  //"CID Comp."
	oReport:PrintText( STR0052, nLinha, 1200 )  //"Grupo CID Comp."
	oReport:PrintText( STR0005, nLinha, 1610 ) //"Masculino" + 400
	oReport:PrintText( STR0006, nLinha, 1810 ) //"Feminino"
	oReport:PrintText( STR0009, nLinha, 2110 ) //"Total"

	oReport:SkipLine()
	oReport:SkipLine()

	aResumo := {}
	aResumo := MDT415AGRUP( .T. ) //Contabiliza Geral
	For nX := 1 To Len( aResumo )

		nLinha := oReport:nRow	//Usar a mesma linha corrente
		oReport:PrintText( aResumo[nX][1], nLinha, 10 ) //CID
		oReport:PrintText( SubStr( aResumo[nX][2], 1,40 ), nLinha, 120 ) //Descricao
		oReport:PrintText( aResumo[nX][3], nLinha, 700 )  //Grupo CID
		oReport:PrintText( aResumo[nX][4], nLinha, 900 )  //Cid Comp.
		oReport:PrintText( aResumo[nX][5], nLinha, 1200 ) //Grupo CID Comp.
		oReport:PrintText( AllTrim(STR(aResumo[nX][6])), nLinha, 1720 ) //Masculinos
		oReport:PrintText( AllTrim(STR(aResumo[nX][7])), nLinha, 1905 ) //Femininos
		oReport:PrintText( AllTrim(STR(aResumo[nX][8])), nLinha, 2165 ) //Total
		oReport:SkipLine()

	Next nX

Else
	oReport:PrintText( STR0010, nLinha, 10 )   //"C.I.D."
	oReport:PrintText( STR0011, nLinha, 120 )  //"Descricao"
	oReport:PrintText( STR0050, nLinha, 1100 ) //"Grupo CID"
	oReport:PrintText( STR0005, nLinha, 1610 ) //"Masculino" + 400
	oReport:PrintText( STR0006, nLinha, 1810 ) //"Feminino"
	oReport:PrintText( STR0009, nLinha, 2110 ) //"Total"

	oReport:SkipLine()
	oReport:SkipLine()
	For nX := 1 To Len(aResumo)
		nLinha := oReport:nRow	//Usar a mesma linha corrente
		oReport:PrintText( aResumo[nX][1], nLinha, 10 )  //CID
		oReport:PrintText( aResumo[nX][2], nLinha, 120 ) //Descricao
		oReport:PrintText( U_MDT415RETGRP( aResumo[nX][1] ), nLinha, 1100 ) //Grupo CID
		oReport:PrintText( AllTrim(STR(aResumo[nX][3])), nLinha, 1720 )  //Masculinos
		oReport:PrintText( AllTrim(STR(aResumo[nX][4])), nLinha, 1905 )  //Femininos
		oReport:PrintText( AllTrim(STR(aResumo[nX][3] + aResumo[nX][4])), nLinha, 2165 ) //Total
		oReport:SkipLine()
	Next nX

EndIf
//---------------------------------------------
// Deleta o arquivo temporario fisicamente
//---------------------------------------------
oTempTRB:Delete()
oTempImp:Delete()

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} TRBgrava
 Processa os registros de acordo com os parametros e grava
no arquivo temporario.
@author Andre E. Perez Alvarez
@since 13/12/2006

@sample MDTR415

@return .T.
/*/
//---------------------------------------------------------------------
Static Function TRBgrava()

	//Variaveis para filtro
	Local cChave	:= ""
	Local cCampos	:= ""
	Local aDBF		:= {}
	Local aArea		:= GetArea()
	Local cTRBTMT	:= GetNextAlias()

	DbSelectArea( "TMT" )
	dbSetOrder( 1 )
	//------------------------------------
	// Filtra os registros da tabela TL5 -
	//------------------------------------
	If lSigaMdtps
		xm_par1 := MV_PAR05
		xm_par2 := MV_PAR06
		xm_par3 := MV_PAR07
		xm_par4 := MV_PAR08
		xm_par5 := MV_PAR09
		xm_par6 := MV_PAR10
	Else
		xm_par1 := MV_PAR01
		xm_par2 := MV_PAR02
		xm_par3 := MV_PAR03
		xm_par4 := MV_PAR04
		xm_par5 := MV_PAR05
		xm_par6 := MV_PAR06
	EndIf

	If lSigaMdtps
		cChave  := "%TMT.TMT_FILIAL, TMT.TMT_CID, TMT.TMT_DTATEN, TMT.TMT_NUMFIC, TMT.TMT_CC%"
		cCampos := "%TMT.TMT_CID, TMT.TMT_NUMFIC, TMT.TMT_GRPCID, TMT.TMT_DTATEN, TMT.TMT_HRATEN, TMT.TMT_CC, TMT.TMT_CODFUN, TMT.TMT_DTCONS, TMT.TMT_HRCONS, TMT.TMT_CLIENT, TMT.TMT_LOJA%"
	Else
		If !lPrestSX6
			cChave := "%TMT.TMT_FILIAL, TMT.TMT_CID, TMT.TMT_DTATEN, TMT.TMT_NUMFIC%"
		Else
			cChave := "%TMT.TMT_FILIAL, TMT.TMT_CID, TMT.TMT_DTATEN, TMT.TMT_NUMFIC, TMT.TMT_CC%"
		EndIf
		cCampos := "%TMT.TMT_CID, TMT.TMT_NUMFIC, TMT.TMT_GRPCID, TMT.TMT_DTATEN, TMT.TMT_HRATEN, TMT.TMT_CC, TMT.TMT_CODFUN, TMT.TMT_DTCONS, TMT.TMT_HRCONS%"
	EndIf

	//----------------------------------------
	//Condição para Prestador
	//----------------------------------------
	cSQLPrest := "%%"
	If lSigaMdtps
		cSQLPrest := "%SUBSTRING(TMT.TMT_CC,1,"+ValToSQL(nSizeTD)+") BETWEEN " + ;
			ValToSQL( mv_par01 + mv_par02 ) + " AND " + ValToSQL( mv_par03 + mv_par04 ) + "% AND"
	Else
		If lPrestSX6
			cSQLPrest := "%SUBSTRING(TMT.TMT_CC,1,"+ValToSQL(6)+") BETWEEN " + ;
				ValToSQL( MV_PAR07 ) + " AND " + ValToSQL( MV_PAR08 ) + "% AND"
		EndIf
	EndIf

	cTamCID := Space( TAMSX3( "TMT_CID" )[1] )
	cTamDTA := SToD( Space( TAMSX3( "TMT_DTATEN" )[1] ) )

	BeginSQL Alias cTRBTMT
		SELECT %exp:cCampos%
		FROM %table:TMT% TMT
		WHERE
		TMT.TMT_FILIAL = %xFilial:TMT% AND
		TMT.TMT_CID <> %exp:cTamCID% AND //Verifica se campo esta preenchido
		TMT.TMT_CID BETWEEN %exp:xm_par1% AND %exp:xm_par2% AND
		TMT.TMT_DTATEN <> %exp:cTamDTA% AND //Verifica se campo esta preenchido
		TMT.TMT_DTATEN BETWEEN %exp:xm_par3% AND %exp:xm_par4% AND
		TMT.TMT_NUMFIC BETWEEN %exp:xm_par5% AND %exp:xm_par6% AND
		%exp:cSQLPrest%
		TMT.%notDel%
		ORDER BY %exp:cChave%
	EndSQL

	//----------------------------------------
	// Grava os dados no arquivo temporario
	//----------------------------------------
	DbSelectArea( cTRBTMT )
	DbGoTop()
	DbSelectArea( cAliasGrv )
	DbGotop()
	ProcRegua( 10 )

	While !oReport:Cancel() .And. ( cTRBTMT )->( !Eof() )

		IncProc()
		( cAliasGrv )->( dbAppend() )
		( cAliasGrv )->CID    := ( cTRBTMT )->TMT_CID
		( cAliasGrv )->NUMFIC := ( cTRBTMT )->TMT_NUMFIC
		( cAliasGrv )->GRPCID := ( cTRBTMT )->TMT_GRPCID

		dbSelectArea( "TM0" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "TM0" ) + ( cTRBTMT )->TMT_NUMFIC )

		( cAliasGrv )->MAT	  := TM0->TM0_MAT
		( cAliasGrv )->SEXO	  := IIf( TM0->TM0_SEXO = '1', STR0005, STR0006 ) //'Masculino' //'Feminino'
		( cAliasGrv )->DTATEN := SToD( ( cTRBTMT )->TMT_DTATEN )
		( cAliasGrv )->HRATEN := ( cTRBTMT )->TMT_HRATEN
		( cAliasGrv )->CC     := ( cTRBTMT )->TMT_CC
		( cAliasGrv )->CODFUN := ( cTRBTMT )->TMT_CODFUN
		( cAliasGrv )->DTCONS := SToD( ( cTRBTMT )->TMT_DTCONS )
		( cAliasGrv )->HRCONS := ( cTRBTMT )->TMT_HRCONS

		If lSigaMdtps
			( cAliasGrv )->CLIENTE := ( cTRBTMT )->TMT_CLIENT
			( cAliasGrv )->LOJA    := ( cTRBTMT )->TMT_LOJA
		Else
			If lPrestSX6
				( cAliasGrv )->CLIENTE := Substr( ( cTRBTMT )->TMT_CC, 1, 6 )
			Endif
		Endif

		dbSelectArea( "SRA" )
		dbSetOrder( 1 )
		If dbSeek( TM0->TM0_FILFUN + TM0->TM0_MAT )
			( cAliasGrv )->ADMISSA := SRA->RA_ADMISSA
			( cAliasGrv )->IDADE   := R555ID( SRA->RA_NASC, dDataBase )
		Else
			( cAliasGrv )->IDADE   := R555ID( TM0->TM0_DTNASC, dDataBase )
		Endif

		( cTRBTMT )->( dbSkip() )
	End

	( cTRBTMT )->( dbCloseArea() )

	RestArea( aArea )

Return .T.
//---------------------------------------------------------------------
/*/{Protheus.doc} MDT415Fic
Valida a pergunta Ate Ficha Medica

@author Andre E. Perez Alvarez
@since 29/11/2006

@sample MDTR415

@return .T.
/*/
//---------------------------------------------------------------------
User Function MDT415Fic()

If lSigaMdtps
	If mv_par10 == Replicate("Z",9)
		Return .T.
	Else
		Return ExistCPO('TM0',mv_par10) .AND. AteCodigo('TM0',mv_par09,mv_par10,9)
	Endif
Else
	If mv_par06==Replicate("Z",9)
		Return .T.
	Else
		Return ExistCPO('TM0',mv_par06) .AND. AteCodigo('TM0',mv_par05,mv_par06,9)
	Endif
Endif

Return .t.
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR415R3
Relatorio dos funcionarios classificados por doenca  da CID.
O usuario pode selecionar o codigo da doenca, obtendo como
resultado a relacao de funcionarios que possui determinada
doenca. Este relatorio esta baseado nas informacoes contidas
na tabela do diagnostico medico  (TMT). No final do relatório
encontra-se um resumo dos diagnosticos pesquisados.

@author Marcio Costa
@since 12/01/2000

@sample MDTR415

@return nil
/*/
//---------------------------------------------------------------------
User Function MDTR415R3()
//----------------------------------------------------------------
//  Define Variaveis                                             -
//----------------------------------------------------------------
LOCAL wnrel   := "MDTR415"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatorio de apresentacao dos funcionarios por tipo de doenca,    "
LOCAL cDesc2  := STR0002 //"conforme definicao feita pelo medico atraves do diangostico.      "
LOCAL cDesc3  := STR0003 //"As doencas sao classificadas pela tabela CID.   "
LOCAL cString := "TMT"


PRIVATE nomeprog := "MDTR415"
PRIVATE tamanho  := "M"
PRIVATE aReturn  := {STR0027,1,STR0028, 1, 2, 1, "",1 } //"Zebrado"  //"Administracao"
PRIVATE titulo   := STR0004   //"CID x Funcionarios"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2
PRIVATE nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
PRIVATE nSizeSRJ := If((TAMSX3("RJ_FUNCAO")[1]) < 1,4,(TAMSX3("RJ_FUNCAO")[1]))

//----------------------------------------------------------------
//  Verifica as perguntas selecionadas                           -
//----------------------------------------------------------------
pergunte(cPerg,.F.)
//----------------------------------------------------------------
//  Variaveis utilizadas para parametros                         -
//  mv_par01             // De CID                               -
//  mv_par02             // Ate CID                              -
//  mv_par03             // De Data Diagnostico                  -
//  mv_par04             // Ate Data Diagnostico                 -
//  mv_par05             // De Ficha                             -
//  mv_par06             // Ate Ficha                            -
//  mv_par07             // De Cliente                           -
//  mv_par08             // Ate Cliente                          -
//----------------------------------------------------------------
//----------------------------------------------------------------
//  Envia controle para a funcao SETPRINT                        -
//----------------------------------------------------------------
wnrel:="MDTR415"

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

RptStatus({|lEnd| R415Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} R415Imp
Cham relatório

@author Inacio Luiz Kolling
@since 13/04/2000

@sample MDTR415

@return nil
/*/
//---------------------------------------------------------------------
Static Function R415Imp(lEnd,wnRel,titulo,tamanho)

//----------------------------------------------------------------
//  Define Variaveis                                             -
//----------------------------------------------------------------
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0

//----------------------------------------------------------------
//  Variaveis para controle do cursor de progressao do relatorio -
//----------------------------------------------------------------
LOCAL nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

//----------------------------------------------------------------
//  Variaveis locais exclusivas deste programa                   -
//----------------------------------------------------------------

LOCAL cChave           := SPACE(16)
LOCAL lContinua        := .T.

//----------------------------------------------------------------------
// Define se agrupamento por CID ( = 1 ) ou CID+CID Complementar ( = 2 )
//----------------------------------------------------------------------
Local nAgrup := U_MDTR415AGR()

//-------------------------------------------------------------------------
// Vars usadas no controle de impressão dos cids agrupados: CID+CID Comp.
//-------------------------------------------------------------------------
Local nI         := 0
Local aResults   := {}
Local aCidsComps := {}

// Controle de Layout
Local cNumFicha := ""
//----------------------------------------------------------
// Variável para índice usado na impressão do relatório
// normal prestador.
//----------------------------------------------------------
Local nInd := NGRETORDEM("TMT","TMT_FILIAL+TMT_CLIENT+TMT_LOJA+TMT_CID",.F.)
nInd := If( nInd <= 0,11,nInd )

//----------------------------------------------------------------
//  Contadores de linha e pagina                                 -
//----------------------------------------------------------------
PRIVATE li := 80 ,m_pag := 1

//----------------------------------------------------------------
//  Verifica se deve comprimir ou nao                            -
//----------------------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)

//----------------------------------------------------------------
//  Monta os Cabecalhos                                          -
//----------------------------------------------------------------

cabec1 := STR0029 //"C.I.D.    Descricao                                                                 Grupo C.I.D."
//cabec2 := STR0030 //"Matricula  Nome Funcionario                          Sexo       Admissao Idade Dt.Diag.  C.Custo   Funcao Des. Funcao"
cabec2 := STR0030 // "Matrícula    Ficha Médica     Nome Funcionário                    Sexo          Data Admissão"

/*
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04                                 <Relatorio de Questionario Medico>                               DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************

             1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
C.I.D.     Descricao
Matricula  Nome Funcionario                          Sexo       Admissao Idade Dt.Diag.  C.Custo   Funcao
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

xxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxx  99/99/99  99   99/99/99  xxxxxxxxx  xxxx - xxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxx  99/99/99  99   99/99/99  xxxxxxxxx  xxxx - xxxxxxxxxxxxxxxxxxxxxxxxxx

Resumo do Relatorio
Total de Diagnosticos Pesquisados.: 999.999
C.I.D.     Descricao                                                                                   Masculinos  Femininos    Total

xxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     999.999    999.999  999.999
xxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     999.999    999.999  999.999

*/

If lSigaMdtPs

	dbSelectArea("TMT")
	dbSetOrder( nInd )  // TMT_FILIAL+TMT_CLIENT+TMT_LOJA+TMT_CID
	dbSeek(xFilial("TMT")+MV_PAR01+MV_PAR02,.T.)

	SetRegua(LastRec())

	//------------------------------------------------------------
	//  Correr TMT para ler os  Diagnosticos                     -
	//------------------------------------------------------------

	While !Eof()                                   .AND.;
	      TMT->TMT_FILIAL == xFIlial('TMT')        .AND.;
	      TMT->(TMT_CLIENT+TMT_LOJA) <= MV_PAR03+MV_PAR04

		If TMT->TMT_CID < MV_PAR05 .or. TMT->TMT_CID > MV_PAR06
			dbSelectArea("TMT")
			dbSKIP()
			loop
		Endif

		IncRegua()

		If TMT->TMT_DTATEN < MV_PAR07 .OR. TMT->TMT_DTATEN > MV_PAR08 .OR. Empty( TMT->TMT_CID )
			dbSelectArea("TMT")
			dbSKIP()
			loop
		Endif

		If TMT->TMT_NUMFIC < MV_PAR09 .OR. TMT->TMT_NUMFIC > MV_PAR10
			dbSelectArea("TMT")
			dbSKIP()
			loop
		Endif

		dbSelectArea("TM0")
		dbSetOrder(01)
		dbSeek(xFilial("TM0")+TMT->TMT_NUMFIC)

		( cAliasImp )->(DbAppend())
		( cAliasImp )->CLIENTE    := TMT->TMT_CLIENT
		( cAliasImp )->LOJA       := TMT->TMT_LOJA
		( cAliasImp )->CID        := TMT->TMT_CID
		( cAliasImp )->MATRICULA  := TM0->TM0_MAT
		( cAliasImp )->SEXO       := TM0->TM0_SEXO
		( cAliasImp )->DTDIAG     := TMT->TMT_DTATEN
		( cAliasImp )->HRDIAG     := TMT->TMT_HRATEN
		( cAliasImp )->CUSTO      := TMT->TMT_CC
		( cAliasImp )->FUNCAO     := TMT->TMT_CODFUN
		( cAliasImp )->NUMFIC     := TMT->TMT_NUMFIC
		( cAliasImp )->DTCONS     := TMT->TMT_DTCONS
		( cAliasImp )->HRCONS     := TMT->TMT_HRCONS
		( cAliasImp )->GRPCID     := TMT->TMT_GRPCID

		dbSelectArea( cAliasImp2 )
		dbSetorder(1)
		If !dbSeek(( cAliasImp )->CLIENTE+( cAliasImp )->LOJA+TMT->TMT_CID)
			( cAliasImp2 )->(DbAppend())
			( cAliasImp2 )->CID     := TMT->TMT_CID
			( cAliasImp2 )->CLIENTE := ( cAliasImp )->CLIENTE
			( cAliasImp2 )->LOJA    := ( cAliasImp )->LOJA
		Endif

		If TM0->TM0_SEXO = '1'
			( cAliasImp2 )->MASCUL := ( cAliasImp2 )->MASCUL + 1
		Else
			( cAliasImp2 )->FEMINI := ( cAliasImp2 )->FEMINI + 1
		Endif

		dbSelectArea("TMT")
		dbSKIP()

	End

	dbSelectArea( cAliasImp )
	dbGOTOP()

	nTOTDIAG := 0
	li := 80

	While !EoF()
		nTOTCLI := 0
		cCliente := ( cAliasImp )->CLIENTE+( cAliasImp )->LOJA
		lPrint := .t.
		While !EOF() .and. ( cAliasImp )->CLIENTE+( cAliasImp )->LOJA == cCliente
			//nTOTCLI := 0
			cCID := ( cAliasImp )->CID
			If lPrint
				Dbselectarea("SA1")
				Dbsetorder(1)
				Dbseek(xFilial("SA1")+cCliente)
				Somalinha()
				@Li,00 PSAY STR0042 + Alltrim(SA1->A1_COD) + "-" + AllTrim(SA1->A1_LOJA) + " - " + Alltrim(SA1->A1_NOME)  //"Cliente/Loja: "
				Somalinha()
				lPrint := .f.
			Endif
	        Somalinha()
	        @Li,000 PSAY cCID PICTURE "@!"
	        dbSelectArea("TMR")
	        dbSetOrder(01)
	        dbSeek(xFilial("TMR")+( cAliasImp )->CID)
	        @Li,010 PSAY Substr(TMR->TMR_DOENCA,1,35)
	        @Li,085 PSAY U_MDT415RETGRP( cCID )
	        Somalinha()
	        dbSelectArea( cAliasImp )
			While !EOF() .and. ( cAliasImp )->CLIENTE+( cAliasImp )->LOJA == cCliente .and. ( cAliasImp )->CID == cCID
				//nTOTDIAG++
				//nTOTCLI++
				//nTOTCLI := 0
				Somalinha()
				dbSelectArea("SRA")
				dbSetOrder(01)
				dbSeek(xFilial("SRA")+( cAliasImp )->MATRICULA)
				dbSelectArea("TM0")
				dbSetOrder(1)
				dbSeek( xFilial("TM0") + ( cAliasImp )->NUMFIC )

				// Seção de dados do Funcionário
				@Li,000 PSAY ( cAliasImp )->MATRICULA PICTURE "@!"
				@Li,013 PSAY ( cAliasImp )->NUMFIC PICTURE "@!"
				@Li,030 PSAY SubStr(TM0->TM0_NOMFIC,1,30)
				If ( cAliasImp )->SEXO == '1'
					@Li,066 PSAY STR0005 //'Masculino'
				Else
					@Li,066 PSAY STR0006 //'Feminino'
				Endif
				@Li,080 PSAY SRA->RA_ADMISSA PICTURE '99/99/9999'
				@Li,099 PSAY R555ID( TM0->TM0_DTNASC,dDataBase ) PICTURE '999' // Idade atual

				// Seção de dados do diagnóstico
				cNumFicha := ( cAliasImp )->NUMFIC
				SomaLinha()
				@Li,012 Psay STR0058 // "Data Diag.    Hora Diag.     Idade  C. Custo                Função"
				SomaLinha()
				@Li,012 Psay Replicate( "-",80 )
				SomaLinha()
				DbSelectArea( cAliasImp )
				While !EoF() .And. ( cAliasImp )->CLIENTE+( cAliasImp )->LOJA == cCliente .And. ( cAliasImp )->NUMFIC == cNumFicha .And. ( cAliasImp )->CID ==  cCID
					nTOTCLI++  // Contabiliza quantidade de diagnósticos do cliente
					nTOTDIAG++ // Contabiliza quantidade de diagnósticos
					@Li,012 PSAY ( cAliasImp )->DTDIAG PICTURE "99/99/99" // Data do Diagnóstico
					@Li,026 PSAY ( cAliasImp )->HRDIAG // Hr. Diagnóstico
					@Li,041 PSAY R555ID( TM0->TM0_DTNASC,( cAliasImp )->DTDIAG ) Picture "999" // Idade na data de Diagnóstico
					@Li,048 PSAY ( cAliasImp )->CUSTO PICTURE "@!" // Centro de Custo

					DbSelectArea( "SRJ" )
					DbSetOrder( 01 )
					If DbSeek( xFilial("SRJ")+( cAliasImp )->FUNCAO )
						@Li,072 PSAY SubStr( AllTrim( ( cAliasImp )->FUNCAO ) + " - " + Alltrim( SRJ->RJ_DESC ) ,1,32 ) // Função
					Endif

					//------------------------------------------------------------------------------------
					// Imprime Cids Complementares do Diagnóstico caso agrupamento por CID+CIDComplementar
					//------------------------------------------------------------------------------------
					If nAgrup == 2
						aCidsComps := MDTR415AC2( ( cAliasImp )->NUMFIC,( cAliasImp )->CID,DTOS( ( cAliasImp )->DTCONS ),( cAliasImp )->HRCONS,( cAliasImp )->CLIENTE+( cAliasImp )->LOJA )
						If Len( aCidsComps ) > 0
							SomaLinha()
							@Li, 20 Psay STR0051 + Space( 10 ) + STR0052 //"CID Comp."#"Grupo CID Comp."
							SomaLinha()
							@Li, 20 Psay Replicate( "-",40 )
							SomaLinha()
						EndIf
						For nI := 1 To Len( aCidsComps )
							@Li, 20 Psay aCidsComps[nI][2]  // Cid
							@Li, 39 Psay  aCidsComps[nI][1] // Grupo Cid
							SomaLinha()
						Next nI
						aCidsComps := {}
					EndIf

					SomaLinha()

					DbSelectArea( cAliasImp )
					DbSkip()
				EndDo

			Enddo
			SomaLinha()
		End

		//--------------------------------------------------------------
		// Imprime totalizadores do cliente.
		//--------------------------------------------------------------
		If nTOTCLI > 0
			SomaLinha()
			@ LI,000 PSAY STR0025 //"Resumo do Cliente"
			SomaLinha()
			@ LI,000 PSAY STR0008 //"Total de Diagnosticos Pesquisados.:"
			@ LI,036 PSAY nTOTCLI PICTURE '@E 999,999'
			SomaLinha()

			// Imprime totalizadores para agrupamento Cid+CidComplementar
			If nAgrup == 2
				@ LI,000 PSAY STR0053+Space(5)+STR0034 //"C.I.D.   Descricao                                                     C.I.D.2"//"Masculinos  Femininos  Total"
				SomaLinha()

				aResults := MDT415AGRUP( .F.,cCliente ) // Retorna a contabilização de CID+CID Comp com base nos diagnósticos registrados no TRB

				For nI := 1 To Len( aResults )
					@ Li,000 Psay aResults[nI][1] // Cid Principal
					@ Li,008 Psay SubStr( aResults[nI][2],1,42 ) // Descrição Cid Principal
					@ Li,051 Psay If ( Empty( aResults[nI][3] ),Space( 3 ),aResults[nI][3] ) // Grupo Cid Principal
					@ Li,064 Psay aResults[nI][4] // Cid Comp.
					@ Li,079 Psay If ( Empty( aResults[nI][5] ), Space( 3 ),aResults[nI][5] ) // Grupo Cid Comp.
					@ Li,111 Psay aResults[nI][6] // Masculino
					@ Li,122 Psay aResults[nI][7] // Feminino
					@ Li,131 Psay aResults[nI][8] // Total
					SomaLinha()
				Next nI

				aResults := {}

			Else // Imprime totalizadores sem agrupamento
				@ LI,000 PSAY STR0033+Space(25)+STR0034 //"C.I.D.   Descricao                                               Grupo C.I.D."//"Masculinos  Femininos  Total"
				SomaLinha()
				dbSelectArea( cAliasImp2 )
				Dbsetorder(1)
				If Dbseek(cCliente)
					SomaLinha()
				Endif
				While !EoF() .and. ( cAliasImp2 )->CLIENTE+( cAliasImp2 )->LOJA == cCliente
					@ Li,000 PSAY ( cAliasImp2 )->CID   PICTURE "@!"
					dbSelectArea("TMR")
					dbSetOrder(01)
					dbSeek(xFilial("TMR")+( cAliasImp2 )->CID)
					@Li,010 PSAY Substr(TMR->TMR_DOENCA,1,50)
					@Li,065 PSAY U_MDT415RETGRP( ( cAliasImp2 )->CID )
					@ Li,105 PSAY ( cAliasImp2 )->MASCUL               PICTURE '@E 999,999'
					@ Li,116 PSAY ( cAliasImp2 )->FEMINI               PICTURE '@E 999,999'
					@ Li,125 PSAY ( cAliasImp2 )->MASCUL+( cAliasImp2 )->FEMINI  PICTURE '@E 999,999'
					SomaLinha()
					dbSelectArea( cAliasImp2 )
					dbskip()
				Enddo
			EndIf

		Endif
		If !EoF()
			SomaLinha()
			@ Li,000 PSAY __PrtThinLine()
		Endif

	End

	//--------------------------------------------------------------
	// Imprime totalizadores gerais.
	//--------------------------------------------------------------
	If nTOTDIAG > 0
		SomaLinha()
		@ LI,000 PSAY STR0007 //"Resumo do Relatorio"
		SomaLinha()
		@ LI,000 PSAY STR0008 //"Total de Diagnosticos Pesquisados.:"
		@ LI,036 PSAY nTOTDIAG PICTURE '@E 999,999'
		SomaLinha()

		If nAgrup == 2
			@ LI,000 PSAY STR0053+Space(5)+STR0034 //"C.I.D.  Descricao                                  Grupo C.I.D. C.I.D. Comp.   Grupo C.I.D. Comp."//"Masculinos  Femininos  Total"

				SomaLinha()

				aResults := MDT415AGRUP( .T. ) // Retorna a contabilização de CID+CID Comp com base nos diagnósticos registrados no TRB

				For nI := 1 To Len( aResults )
					@ Li,000 Psay SubStr( aResults[nI][1],1,6  ) // Cid Principal
					@ Li,008 Psay SubStr( aResults[nI][2],1,40 ) // Descrição Cid Principal
					@ Li,051 Psay aResults[nI][3] // Grupo Cid Principal
					@ Li,064 Psay aResults[nI][4] // Cid Comp.
					@ Li,079 Psay If ( Empty( aResults[nI][5] ), Space( 3 ),aResults[nI][5] ) // Grupo Cid Comp.
					@ Li,111 Psay aResults[nI][6] // Masculino
					@ Li,122 Psay aResults[nI][7] // Feminino
					@ Li,131 Psay aResults[nI][8] // Total
					SomaLinha()
				Next nI

				aResults := {}

		Else
			@ LI,000 PSAY STR0033+Space(25)+STR0034 //"C.I.D.   Descricao                                               Grupo C.I.D."//"Masculinos  Femininos  Total"

			SomaLinha()
			dbSelectArea( cAliasImp2 )
			Dbsetorder(2)
			dbGOTOP()
			While !EoF()
				cCidtrb2 := ( cAliasImp2 )->CID
				nMasc := 0
				nFemi := 0
				While !eof() .and. ( cAliasImp2 )->CID == cCidtrb2
					nFemi += ( cAliasImp2 )->FEMINI
					nMasc += ( cAliasImp2 )->MASCUL
					dbSelectArea( cAliasImp2 )
					dbskip()
				End
				SomaLinha()
				@ Li,000 PSAY cCidtrb2 PICTURE "@!"
				dbSelectArea("TMR")
				dbSetOrder(01)
				dbSeek(xFilial("TMR")+cCidtrb2)
				@ Li,009 PSAY Substr(TMR->TMR_DOENCA,1,50)
				@ Li,065 PSAY U_MDT415RETGRP( cCidtrb2 )
				@ Li,105 PSAY nMasc       PICTURE '@E 999,999'
				@ Li,116 PSAY nFemi       PICTURE '@E 999,999'
				@ Li,125 PSAY nMasc+nFemi PICTURE '@E 999,999'
				dbSelectArea( cAliasImp2 )
			Enddo
		EndIf
	Endif

Else

	cCondicao  := "!EOF()"
	cCondicao2 := "!EOF() .and. ( cAliasImp )->CID == cCID"
	If lPrestSX6
		cCondicao  := "!EOF() .and. ( cAliasImp )->CLIENTE == cCliente"
		cCondicao2 := "!EOF() .and. ( cAliasImp )->CLIENTE == cCliente .and. ( cAliasImp )->CID == cCID"
	Endif

	dbSelectArea("TMT")
	dbSetOrder(04)
	dbSeek(xFilial("TMT")+MV_PAR01,.T.)

	SetRegua(LastRec())

	//------------------------------------------------------------
	//  Correr TMT para ler os  Diagnosticos                     -
	//------------------------------------------------------------

	While !Eof()                                   .AND.;
	      TMT->TMT_FILIAL == xFIlial('TMT')        .AND.;
	      TMT->TMT_CID <= MV_PAR02

		IncRegua()

		If TMT->TMT_DTATEN < MV_PAR03 .OR. TMT->TMT_DTATEN > MV_PAR04 .OR. Empty(TMT->TMT_CID)
			dbSelectArea("TMT")
			dbSKIP()
			loop
		Endif

		If TMT->TMT_NUMFIC < MV_PAR05 .OR. TMT->TMT_NUMFIC > MV_PAR06
			dbSelectArea("TMT")
			dbSKIP()
			loop
		Endif

		If lPrestSX6
			If SUBSTR(TMT->TMT_CC,1,6) < MV_PAR05 .OR. SUBSTR(TMT->TMT_CC,1,6) > MV_PAR06
				dbSelectArea("TMT")
				dbSkip()
				loop
			Endif
		Endif

		dbSelectArea("TM0")
		dbSetOrder(01)
		dbSeek(xFilial("TM0")+TMT->TMT_NUMFIC)

		( cAliasImp )->(DbAppend())
		( cAliasImp )->CLIENTE    := If(lPrestSX6,Substr(TMT->TMT_CC,1,6),space(6))
		( cAliasImp )->CID        := TMT->TMT_CID
		( cAliasImp )->MATRICULA  := TM0->TM0_MAT
		( cAliasImp )->SEXO       := TM0->TM0_SEXO
		( cAliasImp )->DTDIAG     := TMT->TMT_DTATEN
		( cAliasImp )->HRDIAG     := TMT->TMT_HRATEN
		( cAliasImp )->CUSTO      := TMT->TMT_CC
		( cAliasImp )->FUNCAO     := TMT->TMT_CODFUN
		( cAliasImp )->NUMFIC     := TMT->TMT_NUMFIC
		( cAliasImp )->DTCONS     := TMT->TMT_DTCONS
		( cAliasImp )->HRCONS     := TMT->TMT_HRCONS
		( cAliasImp )->GRPCID     := TMT->TMT_GRPCID

		dbSelectArea( cAliasImp2 )
		dbSetorder(1)
		If !dbSeek(( cAliasImp )->CLIENTE+TMT->TMT_CID)
			( cAliasImp2 )->(DbAppend())
			( cAliasImp2 )->CID     := TMT->TMT_CID
			( cAliasImp2 )->CLIENTE := ( cAliasImp )->CLIENTE
		Endif

		If TM0->TM0_SEXO = '1'
			( cAliasImp2 )->MASCUL := ( cAliasImp2 )->MASCUL + 1
		Else
			( cAliasImp2 )->FEMINI := ( cAliasImp2 )->FEMINI + 1
		Endif

		dbSelectArea("TMT")
		dbSKIP()

	End

	dbSelectArea( cAliasImp )
	dbGOTOP()

	//-------------------------------------------------
	// Imprime totalizadores.
	//-------------------------------------------------
	nTOTDIAG := 0
	While ! EoF()
		nTOTCLI := 0
		cCliente := ( cAliasImp )->CLIENTE
		lPrint := .t.
		While &cCondicao //!EOF()

			cCID := ( cAliasImp )->CID
			If lPrestSX6 .and. lPrint
				li := 80
				Dbselectarea("SA1")
				Dbsetorder(1)
				Dbseek(xFilial("SA1")+( cAliasImp )->CLIENTE)
				Somalinha()
				@Li,00 PSAY STR0032 //"Cliente..:"
				@Li,11 PSay Alltrim(( cAliasImp )->CLIENTE)+" - "+Alltrim(SA1->A1_NOME)
				Somalinha()
				lPrint := .f.
			Endif
	        Somalinha()
	        @Li,000 PSAY cCID PICTURE "@!"
	        dbSelectArea("TMR")
	        dbSetOrder(01)
	        dbSeek(xFilial("TMR")+( cAliasImp )->CID)
	        @Li,010 PSAY Substr(TMR->TMR_DOENCA,1,70)
	        @Li,084 Psay ( cAliasImp )->GRPCID
	        Somalinha()
	        dbSelectArea( cAliasImp )
			While &cCondicao2 //!EOF() .and. TRB->CID == cCID
				//nTOTDIAG := nTOTDIAG + 1
				nTOTCLI++
				Somalinha()
				dbSelectArea("SRA")
				dbSetOrder(01)
				dbSeek(xFilial("SRA")+( cAliasImp )->MATRICULA)
				dbSelectArea("TM0")
				dbSetOrder(1)
				dbSeek( xFilial("TM0") + ( cAliasImp )->NUMFIC )

				// Seção de dados do Funcionário
				@Li,000 PSAY ( cAliasImp )->MATRICULA PICTURE "@!"
				@Li,013 PSAY ( cAliasImp )->NUMFIC PICTURE "@!"
				@Li,030 PSAY SubStr( TM0->TM0_NOMFIC,1,30 )
				If ( cAliasImp )->SEXO = '1'
					@Li,066 PSAY STR0005 //'Masculino'
				Else
					@Li,066 PSAY STR0006 //'Feminino'
				Endif
				@Li,080 PSAY SRA->RA_ADMISSA PICTURE '99/99/9999'
				@Li,099 PSAY R555ID( TM0->TM0_DTNASC,dDataBase ) PICTURE '999' // Idade atual

				// Seção de dados do Atendimento/Diagnóstico
				cNumFicha := ( cAliasImp )->NUMFIC
				SomaLinha()
				@Li,012 Psay STR0058 // "Data Diag.    Hora Diag.     Idade  C. Custo                Função"
				SomaLinha()
				@Li,012 Psay Replicate( "-",80 )
				SomaLinha()
				DbSelectArea( cAliasImp )
				While !EoF() .And. ( cAliasImp )->NUMFIC == cNumFicha .And. ( cAliasImp )->CID ==  cCID
					nTOTDIAG++
					@Li,012 PSAY ( cAliasImp )->DTDIAG PICTURE "99/99/99" // Data do Diagnóstico
					@Li,026 PSAY ( cAliasImp )->HRDIAG // Hr. Diagnóstico
					@Li,041 PSAY R555ID( TM0->TM0_DTNASC,( cAliasImp )->DTDIAG ) Picture "999" // Idade na data de Diagnóstico
					@Li,048 PSAY ( cAliasImp )->CUSTO PICTURE "@!" // Centro de Custo

					DbSelectArea( "SRJ" )
					DbSetOrder( 01 )
					If DbSeek( xFilial("SRJ")+( cAliasImp )->FUNCAO )
						@Li,072 PSAY SubStr( AllTrim( ( cAliasImp )->FUNCAO ) + " - " + Alltrim( SRJ->RJ_DESC ) ,1,32 ) // Função
					Endif

					//------------------------------------------------------------------------------------
					// Imprime Cids Complementares do Diagnóstico caso agrupamento por CID+CIDComplementar
					//------------------------------------------------------------------------------------
					If nAgrup == 2
						aCidsComps := MDTR415AC2( ( cAliasImp )->NUMFIC,( cAliasImp )->CID,DTOS( ( cAliasImp )->DTCONS ),( cAliasImp )->HRCONS )
						If Len( aCidsComps ) > 0
							SomaLinha()
							@Li, 20 Psay STR0051 + Space( 10 ) + STR0052 //"CID Comp."#"Grupo CID Comp."
							SomaLinha()
							@Li, 20 Psay Replicate( "-",40 )
							SomaLinha()
						EndIf
						For nI := 1 To Len( aCidsComps )
							@Li, 20 Psay aCidsComps[nI][2]  // Cid
							@Li, 39 Psay  aCidsComps[nI][1] // Grupo Cid
							SomaLinha()
						Next nI
						aCidsComps := {}
					EndIf

					SomaLinha()

					DbSelectArea( cAliasImp )
					DbSkip()
				EndDo
			Enddo
			SomaLinha()
		End

		//-----------------------------------------------
		// Imprime totalizadores de ambiente Unimed.
		//-----------------------------------------------
		If nTOTCLI > 0 .and. lPrestSX6
			SomaLinha()
			@ LI,000 PSAY Replicate("-",132)
			SomaLinha()
			@ LI,000 PSAY STR0025 //"Resumo do Cliente"
			SomaLinha()
			@ LI,000 PSAY STR0008 //"Total de Diagnosticos Pesquisados.:"
			@ LI,036 PSAY nTOTCLI PICTURE '@E 999,999'
			SomaLinha()
			@ LI,000 PSAY STR0033+Space(83)+STR0034 //"C.I.D.   Descricao                                               Grupo C.I.D."##"Masculinos  Femininos  Total"
			SomaLinha()
			dbSelectArea( cAliasImp2 )
			Dbsetorder(1)
			Dbseek(cCliente)
			While ! eof() .and. ( cAliasImp2 )->CLIENTE == cCliente
				SomaLinha()
				@ Li,000 PSAY ( cAliasImp2 )->CID   PICTURE "@!"
				dbSelectArea("TMR")
				dbSetOrder(01)
				dbSeek(xFilial("TMR")+( cAliasImp2 )->CID)
				@Li,010 PSAY Substr(TMR->TMR_DOENCA,1,90)
				@ Li,105 PSAY ( cAliasImp2 )->MASCUL               PICTURE '@E 999,999'
				@ Li,116 PSAY ( cAliasImp2 )->FEMINI               PICTURE '@E 999,999'
				@ Li,125 PSAY ( cAliasImp2 )->MASCUL+( cAliasImp2 )->FEMINI  PICTURE '@E 999,999'
				dbSelectArea( cAliasImp2 )
				dbskip()
			Enddo
		Endif
	End

	//-----------------------------------------------------
	// Imprime totalizadores ambiente padrão.
	//-----------------------------------------------------
	If nTOTDIAG > 0
		SomaLinha()
		@ LI,000 PSAY Replicate("-",132)
		SomaLinha()
		@ LI,000 PSAY STR0007 //"Resumo do Relatorio"
		SomaLinha()
		@ LI,000 PSAY STR0008 //"Total de Diagnosticos Pesquisados.:"
		@ LI,036 PSAY nTOTDIAG PICTURE '@E 999,999'
		SomaLinha()

		//-----------------------------------------------------
		// Agrupamento por Cid+CidComplementar
		//-----------------------------------------------------
		If nAgrup == 2
			@ LI,000 PSAY STR0053+Space(3)+STR0034 //"C.I.D.   Descricao                                   Grupo C.I.D.           C.I.D. Comp.   Grupo C.I.D. Comp."//"Masculinos  Femininos  Total"
			SomaLinha()

			aResults := MDT415AGRUP( .T. ) // Retorna a contabilização de CID+CID Comp com base nos diagnósticos registrados no TRB

			For nI := 1 To Len( aResults )
				@ Li,000 Psay aResults[nI][1] // Cid Principal
				@ Li,008 Psay SubStr( aResults[nI][2],1,42 ) // Descrição Cid Principal
				@ Li,051 Psay aResults[nI][3] // Grupo Cid Principal
				@ Li,064 Psay aResults[nI][4] // Cid Comp.
				@ Li,079 Psay If ( Empty( aResults[nI][5] ), Space( 3 ),aResults[nI][5] )  // Grupo Cid Comp.
				@ Li,109 Psay aResults[nI][6] // Masculino
				@ Li,120 Psay aResults[nI][7] // Feminino
				@ Li,129 Psay aResults[nI][8] // Total
				SomaLinha()
			Next nI

			aResults := {}

		Else // Sem Agrupamento.

			@ LI,000 PSAY STR0033+Space(25)+STR0034 //"C.I.D.   Descricao                                          Grupo C.I.D. Comp."//"Masculinos  Femininos  Total"

			SomaLinha()
			dbSelectArea( cAliasImp2 )
			Dbsetorder(2)
			DbGoTop()
			While ! eof()
				cCidtrb2 := ( cAliasImp2 )->CID
				nMasc := 0
				nFemi := 0
				While !eof() .and. ( cAliasImp2 )->CID == cCidtrb2
					nFemi += ( cAliasImp2 )->FEMINI
					nMasc += ( cAliasImp2 )->MASCUL
					dbSelectArea( cAliasImp2 )
					dbskip()
				End
				SomaLinha()
				@ Li,000 PSAY cCidtrb2 PICTURE "@!"
				dbSelectArea("TMR")
				dbSetOrder(01)
				dbSeek(xFilial("TMR")+cCidtrb2)
				@ Li,009 PSAY Substr(TMR->TMR_DOENCA,1,47)
				@ Li,065 Psay U_MDT415RETGRP( cCidtrb2 ) PICTURE "@!"
				@ Li,105 PSAY nMasc       PICTURE '@E 999,999'
				@ Li,116 PSAY nFemi       PICTURE '@E 999,999'
				@ Li,125 PSAY nMasc+nFemi PICTURE '@E 999,999'
				dbSelectArea( cAliasImp2 )
			Enddo
		EndIf
	Endif

Endif

//EJECT

//  Roda(nCntImpr,cRodaTxt,Tamanho)

//----------------------------------------------------------------
//  Devolve a condicao original do arquivo principal             -
//----------------------------------------------------------------
RetIndex("TMT")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()

oTempTRB:Delete()
oTempImp:Delete()
oTempImp2:Delete()

dbSelectArea("TMT")
dbSetOrder(01)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha
Incrementa Linha e Controla Salto de Pagina

@author Inacio Luiz Kolling
@since 01/06/1997

@sample MDTR415

@return
/*/
//---------------------------------------------------------------------
Static Function Somalinha()

Li++

If Li > 58
	Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
EndIf

Return

//----------------------------------------------------------------------------------------------
/*/{Protheus.doc} MDTR415AC2
Retorna array de Cids Complementares relacionados a Ficha Medica+Cid+DtConsulta+HrConsulta e para
caso de Prestador, considera o C.C.

@author André Felipe Joriatti
@since 23/11/2012
@version MP11

@param cFichaMed: Ficha médica para realizar a pesquisa.
@param cCid: Cid para se realizar a pesquisa.
@param dConsulta: Data da consulta (do diagnóstico).
@param cHrConsulta: Hora da consulta (do diagnóstico).
@param cCC: Centro de Custo, para caso de Prestador.

@return aCids
		aCids[n][1]: Grupo do Cid Complementar.
		aCids[n][2]: Cid Complementar.
/*/
//----------------------------------------------------------------------------------------------
Static Function MDTR415AC2( cFichaMed,cCid,cDtConsulta,cHrConsulta,cCC )

	Local aArea    := GetArea()
	Local aCids    := {}
	Local cCliLoja := If( cCC != Nil,SubStr( cCC,1, nSizeTD )," " ) // nSizeTD, variável private, informa o tamanho do cliente + loja no campo TMT->TMT_CC
	Local nInd := NGRETORDEM( "TMT","TMT_FILIAL+TMT_CLIENT+TMT_LOJA+TMT_NUMFIC+DTOS(TMT_DTCONS)+TMT_HRCONS",.F. )
	nInd := If( nInd <= 0,10,nInd )

	If lSigaMdtPs .And. cCC != Nil

		//---------------------------------------------------------
		// Contabiliza para CID complementar da TMT
		//---------------------------------------------------------
		DbSelectArea( "TMT" )
		DbSetOrder( nInd ) // TMT_FILIAL+TMT_CLIENT+TMT_LOJA+TMT_NUMFIC+DTOS(TMT_DTCONS)+TMT_HRCONS
		DbSeek( xFilial("TMT") + cCliLoja + cFichaMed + cDtConsulta + cHrConsulta )
		While !EoF() .And. TMT->TMT_FILIAL == xFilial('TMT') .And. AllTrim( TMT->TMT_CLIENT+TMT->TMT_LOJA ) == AllTrim( cCliLoja );
			.And. TMT->TMT_NUMFIC == cFichaMed .And. DTOS( TMT->TMT_DTCONS ) == cDtConsulta .And. TMT->TMT_HRCONS == cHrConsulta

			If AllTrim( TMT->TMT_CID ) != AllTrim( cCid )
				DbSelectArea("TMT")
				DbSkip()
				Loop
			EndIf

			//------------------------------------------------
			// Caso Cid complementar não esteja vazio e ainda
			// não exista no array de Cids ( para que os CIDS
			// Complementares não fiquem repetidos no array).
			//------------------------------------------------
			If !Empty( TMT->TMT_CID2 ) .And. aScan( aCids, { |x| AllTrim( x[2] ) == AllTrim( TMT->TMT_CID2 ) } ) == 0
				aAdd( aCids, { U_MDT415RETGRP( TMT->TMT_CID2 ),TMT->TMT_CID2 } )
			EndIf

			DbSelectArea("TMT")
			DbSkip()
			Loop

		EndDo

	Else

		//---------------------------------------------------------
		// Contabiliza para CID complementar da TMT
		//---------------------------------------------------------
		DbSelectArea( "TMT" )
		DbSetOrder( 3 ) // TMT_FILIAL+TMT_NUMFIC+DTOS(TMT_DTCONS)+TMT_HRCONS
		DbSeek( xFilial("TMT") + cFichaMed + cDtConsulta + cHrConsulta )
		While !EoF() .And. TMT->TMT_FILIAL == xFilial('TMT') .And. TMT->TMT_NUMFIC == cFichaMed .And. DTOS( TMT->TMT_DTCONS ) == cDtConsulta;
			.And. TMT->TMT_HRCONS == cHrConsulta

			If AllTrim( TMT->TMT_CID ) != AllTrim( cCid )
				DbSelectArea("TMT")
				DbSkip()
				Loop
			EndIf

			//------------------------------------------------
			// Caso Cid complementar não esteja vazio e ainda
			// não exista no array de Cids ( para que os CIDS
			// Complementares não fiquem repetidos no array).
			//------------------------------------------------
			If !Empty( TMT->TMT_CID2 ) .And. aScan( aCids, { |x| AllTrim( x[2] ) == AllTrim( TMT->TMT_CID2 ) } ) == 0
				aAdd( aCids, { U_MDT415RETGRP( TMT->TMT_CID2 ),TMT->TMT_CID2 } )
			EndIf

			DbSelectArea("TMT")
			DbSkip()
			Loop

		EndDo

	EndIf

	//-------------------------------------------------------------------------
	// Contabiliza para CID complementar da TKJ, igual para padrão e prestador.
	//-------------------------------------------------------------------------
	DbSelectArea( "TKJ" )
	DbSetOrder( 1 ) // TKJ_FILIAL+TKJ_NUMFIC+DTOS(TKJ_DTCONS)+TKJ_HRCONS+TKJ_GRPCID+TKJ_CID
	If DbSeek( xFilial( "TKJ" ) + cFichaMed + cDtConsulta + cHrConsulta )
		While !EoF() .And. xFilial( "TKJ" ) == TKJ->TKJ_FILIAL .And. AllTrim( TKJ->TKJ_NUMFIC ) == AllTrim( cFichaMed ) .And. DTOS( TKJ->TKJ_DTCONS ) == cDtConsulta;
			.And. TKJ->TKJ_HRCONS == cHrConsulta

				If aScan( aCids, { |x| AllTrim( x[2] ) == AllTrim( TKJ->TKJ_CID ) } ) == 0
					aAdd( aCids, { U_MDT415RETGRP( TKJ->TKJ_CID ),TKJ->TKJ_CID } )
				EndIf

			DbSelectArea("TKJ")
			DbSkip()
			Loop
		EndDo
	EndIf

	RestArea( aArea )

Return aCids

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR415AGR
Retorna o tipo de agrupamento de acordo com o ambiente em execucao,
se Padrao, se Prestador.

@author André Felipe Joriatti
@since 08/11/2012
@version MP11
@parametros Nenhum
@return: Se agrupa por CID: 1.
		 Se agrupa por CID + CID Comp.: 2.
/*/
//---------------------------------------------------------------------
User Function MDTR415AGR()

	Local nAgrup

	If lSigaMdtPs //Prestador
		nAgrup := MV_PAR11
	Else //MDT Padrao
		nAgrup := MV_PAR07
	EndIf

Return nAgrup

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT415RETGRP
Retorna Grupo do Cid informado no parametro.

@author André Felipe Joriatti
@since 23/11/2012
@version MP11
@param cCid: Cid que se deseja descrobrir o grupo.
@return: cGrupoCid: Grupo do Cid passado no parametro.
/*/
//---------------------------------------------------------------------
User Function MDT415RETGRP( cCid )

	Local cGrupoCid := SubStr( AllTrim( cCid ) ,1,3 )

Return cGrupoCid

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT415AGRUP
Retorna array de agrupamento de CID+CIDComplementar, de acordo com
diagnóstico que se estiver posicionado no momento.

@author André Felipe Joriatti
@since 23/11/2012
@version MP11
@param lTotGeral: Indica se deve calcular o total geral, ou se deve
	   		contabilizar por cliente caso Prestador.
	   cCliLoja: Indica o Cliente+Loja para prestador.

@return aResults: array com cids agrupados aos cids comp.

@estrutura aCidsAgrup
	aCidsAgrup[n][1]: Cid Principal
	aCidsAgrup[n][2]: Cid Comp.
	aCidsAgrup[n][3]: 2 para Femin. e 1 para Mascul.
	aCidsAgrup[n][4]: Cliente+Loja (para prestador).

@estrutura aResults
	aResults[n][1] Cid Principal
	aResults[n][2] Desc. Cid Principal
	aResults[n][3] Grupo Cid Principal
	aResults[n][4] Cid Comp.
	aResults[n][5] Grupo Cid Comp.
	aResults[n][6] Total Masculino
	aResults[n][7] Total Feminino
	aResults[n][8] Total
	aResults[n][9] Cliente+Loja (para prestador)
/*/
//---------------------------------------------------------------------
Static Function MDT415AGRUP( lTotGeral,cCliLoja )

	Local aArea          := GetArea()
	Local aCidsAgrup     := {}
	Local aResults       := {}
	Local nI             := 0
	Local nCont          := 0
	Local nQtdeM, nQtdeF := 0
	Local cGrpCid        := ""
	Local cGrpCid2       := ""

	Default lTotGeral := .F.

	DbSelectArea( cAliasGrv )

	If lSigaMdtPs .And. !lTotGeral

		DbSetorder( 01 ) // CLIENTE+LOJA+CID+MATRICULA+NUMFIC
		DbSeek( cCliLoja )

		While !EoF() .And. ( cAliasGrv )->CLIENTE + ( cAliasGrv )->LOJA == cCliLoja

			cSexo := AllTrim( ( cAliasGrv )->SEXO )
			If cSexo == "1"
				cSexo := STR0005 //"Masculino"
			ElseIf cSexo == "2"
				cSexo := STR0006 //"Feminino"
			EndIf

			DbSelectArea( "TMT" )
			DbSetorder( 9 ) // TMT_FILIAL+TMT_CLIENT+TMT_LOJA+DTOS(TMT_DTCONS)+TMT_NUMFIC
			DbSeek( xFilial( "TMT" ) + cCliLoja + DTOS( ( cAliasGrv )->DTCONS ) + ( cAliasGrv )->NUMFIC )
			While !EoF() .And. AllTrim( TMT->TMT_FILIAL+TMT->TMT_CLIENT+TMT->TMT_LOJA+DTOS(TMT->TMT_DTCONS)+TMT->TMT_NUMFIC ) == ;
				AllTrim( xFilial( "TMT" ) + cCliLoja + DTOS( ( cAliasGrv )->DTCONS ) + ( cAliasGrv )->NUMFIC )

				If ( cAliasGrv )->HRCONS != TMT->TMT_HRCONS
					DbSelectArea( "TMT" )
					DbSkip()
					Loop
				EndIf

				//---------------------------------------------------------------------------
				// Caso o Cid2 na TMT esteja vazio e ele não possua Cid Complementar na TKJ
				//---------------------------------------------------------------------------
				If Empty( TMT->TMT_CID2 ) .And. !MDT415VCCOMP( ( cAliasGrv )->NUMFIC + DTOS( ( cAliasGrv )->DTCONS ) + ( cAliasGrv )->HRCONS )
					aAdd( aCidsAgrup, { TMT->TMT_CID,TMT->TMT_CID2,cSexo,( cAliasGrv )->CLIENTE + ( cAliasGrv )->LOJA } )
				EndIf
				If !Empty( TMT->TMT_CID2 )
					aAdd( aCidsAgrup, { TMT->TMT_CID,TMT->TMT_CID2,cSexo,( cAliasGrv )->CLIENTE + ( cAliasGrv )->LOJA } )
				EndIf

				DbSelectArea( "TKJ" )
				DbSetOrder( 1 ) // TKJ_FILIAL+TKJ_NUMFIC+DTOS(TKJ_DTCONS)+TKJ_HRCONS+TKJ_GRPCID+TKJ_CID
				DbSeek( xFilial( "TKJ" ) + ( cAliasGrv )->NUMFIC + DTOS( ( cAliasGrv )->DTCONS ) + ( cAliasGrv )->HRCONS )
				While !EoF() .And. AllTrim( TKJ->TKJ_FILIAL+TKJ->TKJ_NUMFIC+DTOS(TKJ->TKJ_DTCONS)+TKJ->TKJ_HRCONS ) == ;
					AllTrim( xFilial("TKJ") + ( cAliasGrv )->NUMFIC + DTOS( ( cAliasGrv )->DTCONS ) + ( cAliasGrv )->HRCONS )

					aAdd( aCidsAgrup, { TMT->TMT_CID,TKJ->TKJ_CID,cSexo,( cAliasGrv )->CLIENTE + ( cAliasGrv )->LOJA } )

					DbSelectArea( "TKJ" )
					DbSkip()
				EndDo

				DbSelectArea( "TMT" )
				DbSkip()
			EndDo

			DbSelectArea( cAliasGrv )
			DbSkip()
			Loop

		EndDo

		aSort( aCidsAgrup,,, { |x,y| x[4]+x[1]+x[2] < y[4]+y[1]+y[2] } )

		For nI := 1 To Len( aCidsAgrup )
            // Se Agrupamento de Cid+CidComp já não esteja no agrupamento
			If aScan( aResults, { |x| x[9]+ x[1] + x[4] == aCidsAgrup[nI][4] + aCidsAgrup[nI][1] + aCidsAgrup[nI][2] } ) == 0
				nQtdeM := If(aCidsAgrup[nI][3] == STR0005,1,0) //"Masculino"
				nQtdeF := If(aCidsAgrup[nI][3] == STR0006,1,0) //"Feminino"

				cGrpCid := U_MDT415RETGRP( aCidsAgrup[nI][1] )
				cGrpCid := If( Empty( cGrpCid ),Space( 3 ),cGrpCid )

				cGrpCid2 := U_MDT415RETGRP( aCidsAgrup[nI][2] )
				cGrpCid2 := If( Empty( cGrpCid ),Space( 3 ),cGrpCid2 )

				aAdd( aResults, { aCidsAgrup[nI][1],SubStr( NGSEEK("TMR",aCidsAgrup[nI][1],1,"TMR_DOENCA"),1,35 ),cGrpCid,aCidsAgrup[nI][2],cGrpCid2,nQtdeM,nQtdeF,1,aCidsAgrup[nI][4] } )
				nCont := 1
				While nCont <= Len( aCidsAgrup )
					// Compara Cliente+Loja e CidPrincipal+CidComp
					If aResults[Len( aResults )][9] == aCidsAgrup[nCont][4] .And. aResults[Len( aResults )][1]+aResults[Len( aResults )][4] == aCidsAgrup[nCont][1]+aCidsAgrup[nCont][2]
						If nCont != nI
							If aCidsAgrup[nCont][3] == STR0005 // Contabiliza sexo masculino "Masculino"
								aResults[Len( aResults )][6]++
							Else // Contabiliza sexo feminino
								aResults[Len( aResults )][7]++
							EndIf
							// Contabiliza Total
							aResults[Len( aResults )][8]++
						EndIf
					EndIf
					nCont++
				EndDo
			EndIf
		Next nI

	ElseIf lTotGeral

		DbGoTop()
		While !EoF()

			cSexo := AllTrim( ( cAliasGrv )->SEXO )
			If cSexo == "1"
				cSexo := STR0005 //"Masculino"
			ElseIf cSexo == "2"
				cSexo := STR0006 //"Feminino"
			EndIf

			DbSelectArea( "TMT" )
			DbSetorder( 3 ) // TMT_FILIAL+TMT_NUMFIC+DTOS(TMT_DTCONS)+TMT_HRCONS
			DbSeek( xFilial( "TMT" ) + ( cAliasGrv )->NUMFIC + DTOS( ( cAliasGrv )->DTCONS ) + ( cAliasGrv )->HRCONS )
			While !EoF() .And. AllTrim( TMT->TMT_FILIAL + TMT->TMT_NUMFIC + DTOS( TMT->TMT_DTCONS ) + TMT->TMT_HRCONS ) == ;
				AllTrim( xFilial( "TMT" ) + ( cAliasGrv )->NUMFIC + DTOS( ( cAliasGrv )->DTCONS ) + ( cAliasGrv )->HRCONS )

				//---------------------------------------------------------------------------
				// Caso o Cid2 na TMT esteja vazio e ele não possua Cid Complementar na TKJ
				//---------------------------------------------------------------------------
				If Empty( TMT->TMT_CID2 ) .And. !MDT415VCCOMP( ( cAliasGrv )->NUMFIC + DTOS( ( cAliasGrv )->DTCONS ) + ( cAliasGrv )->HRCONS )
					aAdd( aCidsAgrup, { TMT->TMT_CID,TMT->TMT_CID2,cSexo } )
				EndIf

				If !Empty( TMT->TMT_CID2 )
					aAdd( aCidsAgrup, { TMT->TMT_CID,TMT->TMT_CID2,cSexo } )
				EndIf
				DbSelectArea( "TKJ" )
				DbSetOrder( 1 ) // TKJ_FILIAL+TKJ_NUMFIC+DTOS(TKJ_DTCONS)+TKJ_HRCONS+TKJ_GRPCID+TKJ_CID
				DbSeek( xFilial( "TKJ" ) + ( cAliasGrv )->NUMFIC + DTOS( ( cAliasGrv )->DTCONS ) + ( cAliasGrv )->HRCONS )
				While !EoF() .And. AllTrim( TKJ->TKJ_FILIAL+TKJ->TKJ_NUMFIC+DTOS(TKJ->TKJ_DTCONS)+TKJ->TKJ_HRCONS ) == ;
					AllTrim( xFilial("TKJ") + ( cAliasGrv )->NUMFIC + DTOS( ( cAliasGrv )->DTCONS ) + ( cAliasGrv )->HRCONS )

					aAdd( aCidsAgrup, { TMT->TMT_CID,TKJ->TKJ_CID,cSexo } )

					DbSelectArea( "TKJ" )
					DbSkip()
				EndDo

				DbSelectArea( "TMT" )
				DbSkip()
			EndDo

			DbSelectArea( cAliasGrv )
			DbSkip()

		EndDo

		aSort( aCidsAgrup,,, { |x,y| x[1]+x[2] < y[1]+y[2] } )

		For nI := 1 To Len( aCidsAgrup )
            // Se Agrupamento de Cid+CidComp já não esteja no agrupamento
			If aScan( aResults, { |x| x[1] + x[4] == aCidsAgrup[nI][1] + aCidsAgrup[nI][2] } ) == 0
				nQtdeM := If( aCidsAgrup[nI][3] == STR0005,1,0 ) //"Masculino"
				nQtdeF := If( aCidsAgrup[nI][3] == STR0006,1,0 )  //"Feminino"

				cGrpCid := U_MDT415RETGRP( aCidsAgrup[nI][1] )
				cGrpCid := If( Empty( cGrpCid ),Space( 3 ),cGrpCid )

				cGrpCid2 := U_MDT415RETGRP( aCidsAgrup[nI][2] )
				cGrpCid2 := If( Empty( cGrpCid ),Space( 3 ),cGrpCid2 )

				aAdd( aResults, { aCidsAgrup[nI][1],SubStr( NGSEEK("TMR",aCidsAgrup[nI][1],1,"TMR_DOENCA"),1,35 ),cGrpCid,aCidsAgrup[nI][2],cGrpCid2,nQtdeM,nQtdeF,1 } )
				nCont := 1
				While nCont <= Len( aCidsAgrup )
					// Compara CidPrincipal+CidComp
					If aResults[Len( aResults )][1]+aResults[Len( aResults )][4] == aCidsAgrup[nCont][1]+aCidsAgrup[nCont][2]
						If nCont != nI
							If aCidsAgrup[nCont][3] == STR0005 //"Masculino" // Contabiliza sexo masculino
								aResults[Len( aResults )][6]++
							Else // Contabiliza sexo feminino
								aResults[Len( aResults )][7]++
							EndIf
							// Contabiliza Total
							aResults[Len( aResults )][8]++
						EndIf
					EndIf
					nCont++
				EndDo
			EndIf
		Next nI

	EndIf

	RestArea( aArea )

Return aResults

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT415VCCOMP
Retorna se Diagnóstico teve registro de Cid Comp. na tabela de
complementares TKJ.

@author André Felipe Joriatti
@since 28/11/2012
@version MP11
@param cChave, chave a ser pesquisada na TKJ, composta da seguinte forma:
			FichaMedica+DtCons+HrCons.

@return .T. caso encontre CID Comp, .F. caso não encontre.
/*/
//---------------------------------------------------------------------
Static Function MDT415VCCOMP( cChave )

	Local lRet := .F.
	Local aArea := GetArea()

	//-----------------------------------------------------------------
	// O índice é o mesmo para padrão e prestador.
	//-----------------------------------------------------------------
	DbSelectArea( "TKJ" )
	DbSetOrder( 1 ) // TKJ_FILIAL+TKJ_NUMFIC+DTOS(TKJ_DTCONS)+TKJ_HRCONS+TKJ_GRPCID+TKJ_CID
	lRet := DbSeek( xFilial( "TKJ" ) + cChave )

	RestArea( aArea )

Return lRet

//---------------------------------------------------------------------
/*/{Protheus.doc} fCreateTRB
Função para realizar a criação das TRBs.

@Param

@author Jean Pytter da Costa
@since 20/01/2017
@version P12
@return
/*/
//---------------------------------------------------------------------
Static Function fCreateTRB()

	Local nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	Local nSizeSRJ := If((TAMSX3("RJ_FUNCAO")[1]) < 1,4,(TAMSX3("RJ_FUNCAO")[1]))

	//Tabela temporaria de Gravação
	//----------------------------------------------
	aDBF := {}
	If lSigaMdtps
		Aadd( aDBF, {"CLIENTE", "C", nTa1} )
		Aadd( aDBF, {"LOJA"   , "C", nTa1L} )
	Else
		If lPrestSX6
			Aadd( aDBF, {"CLIENTE", "C", 06} )
		Endif
	Endif
	AADD(aDBF,{"CID"      ,"C",08,0})
	AADD(aDBF,{"NUMFIC"   ,"C",09,0})
	AADD(aDBF,{"MAT"      ,"C",06,0})
	AADD(aDBF,{"SEXO"     ,"C",09,0})
	AADD(aDBF,{"DTATEN"   ,"D",08,0})
	AADD(aDBF,{"HRATEN"   ,"C",05,0})
	AADD(aDBF,{"CC"       ,"C",nSizeSI3,0})
	AADD(aDBF,{"ADMISSA"  ,"D",08,0})
	AADD(aDBF,{"IDADE"    ,"C",03,0})
	AADD(aDBF,{"CODFUN"   ,"C",05,0})
	AADD(aDBF,{"DTCONS"   ,"D",08,0})
	AADD(aDBF,{"HRCONS"   ,"C",05,0})
	AADD(aDBF,{"GRPCID"   ,"C",03,0})

	oTempTRB := FWTemporaryTable():New( cAliasGrv, aDBF )
	If lSigaMdtps
		oTempTRB:AddIndex( "1", { "CLIENTE","LOJA","CID","MAT","NUMFIC","DTATEN" } )
	Else
		If lPrestSX6
			oTempTRB:AddIndex( "1", { "CLIENTE","CID","MAT","NUMFIC","DTATEN" } )
		Else
			oTempTRB:AddIndex( "1", { "CID","MAT","NUMFIC","DTATEN" } )
		Endif
	EndIf
	oTempTRB:Create()
	//----------------------------------------------

	//Tabela temporaria da impressão 1
	//----------------------------------------------
	aDBF1 := {}
	If lSigaMdtps
		AADD(aDBF1,{"CLIENTE"  ,"C",nTa1,0})
		AADD(aDBF1,{"LOJA"     ,"C",nTa1L,0})
	Else
		AADD(aDBF1,{"CLIENTE"  ,"C",06,0})
	EndIf
	AADD(aDBF1,{"CID"      ,"C",08,0})
	AADD(aDBF1,{"MATRICULA","C",06,0})
	AADD(aDBF1,{"SEXO"     ,"C",01,0})
	AADD(aDBF1,{"DTDIAG"   ,"D",08,0})
	AADD(aDBF1,{"HRDIAG"   ,"C",05,0})
	AADD(aDBF1,{"CUSTO"    ,"C",nSizeSI3,0})
	AADD(aDBF1,{"FUNCAO"   ,"C",nSizeSRJ,0})
	AADD(aDBF1,{"NUMFIC"   ,"C",09,0})
	AADD(aDBF1,{"DTCONS"   ,"D",08,0})
	AADD(aDBF1,{"HRCONS"   ,"C",05,0})
	AADD(aDBF1,{"GRPCID"   ,"C",03,0})
	oTempImp := FWTemporaryTable():New( cAliasImp, aDBF1 )
	If lSigaMdtps
		oTempImp:AddIndex( "1", {"CLIENTE","LOJA","CID","MATRICULA","NUMFIC"} )
	Else
		oTempImp:AddIndex( "1", {"CLIENTE","CID","MATRICULA","NUMFIC"} )
	EndIf
	oTempImp:Create()
	//----------------------------------------------

	//Tabela temporaria da impressão 2
	//----------------------------------------------
	aDBF2 := {}
	If lSigaMdtps
		AADD(aDBF2,{"CLIENTE","C",nTa1,0})
		AADD(aDBF2,{"LOJA"   ,"C",nTa1L,0})
	Else
		AADD(aDBF2,{"CLIENTE","C",06,0})
	EndIf
	AADD(aDBF2,{"CID"   ,"C",08,0})
	AADD(aDBF2,{"MASCUL","N",06,0})
	AADD(aDBF2,{"FEMINI","N",06,0})

	oTempImp2 := FWTemporaryTable():New( cAliasImp2, aDBF2 )
	#IFDEF CDX
		If lSigaMdtps
			oTempImp2:AddIndex( "1", {"CLIENTE","LOJA","CID"} )
			oTempImp2:AddIndex( "2", {"CID","CLIENTE","LOJA"} )
		Else
			oTempImp2:AddIndex( "1", {"CLIENTE","CID"} )
			oTempImp2:AddIndex( "2", {"CID"} )
		EndIf
	#ELSE
		oTempImp2:AddIndex( "1", {"CLIENTE","CID"} )
		If lSigaMdtps
			oTempImp2:AddIndex( "2", {"CID","CLIENTE","LOJA"} )
		Else
			oTempImp2:AddIndex( "2", {"CID"} )
		EndIf
	#ENDIF
	oTempImp2:Create()
	//----------------------------------------------

Return
