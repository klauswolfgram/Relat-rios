/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "RwMake.ch"
#Include "Protheus.ch"
#Include "TopConn.ch"
#Include "ATFR032.ch"

#define PIX_DIF_COLUNA_VALORES		148		// Pixel inicial para impressao dos tracos das colunas dinamicas
#define PIX_INICIAL_VALORES			148		// Pixel para impressao do traco vertical
#define PIX_EQUIVALENTE				110		// Pixel inicial para impressao das colunas dinamicas
#define MASK_VALOR					"@E 99999,999.99"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR032   º Autor ³ Totvs              º Data ³  18/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Detalhes do Ativo Fixo Reavaliado Formato 7.2               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ATFR032                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR032()

Local cPerg		:= "ATR032"
Local olReport

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ mv_par01 - Exercicio? - Ano do exercicio para emissao            ³
³ mv_par02 - Seleciona filiais? - Filiais para considerar no filtro³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
If TRepInUse()
	Pergunte(cPerg,.F.)

	olReport := ATFRelat(cPerg)
	olReport:SetParam(cPerg)
	olReport:PrintDialog()
EndIf

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ATFRelat  ³ Autor ³ Totvs                 ³ Data | 14/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Criação do objeto TReport para a impressão do relatorio.    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ATFRelat( cPerg )           				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 = Perguntas dos parametros                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ATFRelat( cPerg )

Local clNomProg		:= FunName()
Local clTitulo 		:= STR0001 //"Formato 7.2:Registro de Activos Fijos-Detalhes do Ativo Fixo Reavaliados"
Local clDesc   		:= STR0001 //"Formato 7.2:Registro de Activos Fijos-Detalhes do Ativo Fixo Reavaliados"
Local olReport

olReport:=TReport():New(clNomProg,clTitulo,cPerg,{|olReport| ATFProc(olReport)},clDesc)
olReport:SetLandscape()					// Formato paisagem
olReport:oPage:nPaperSize	:= 8 		// Impressão em papel A3
olReport:lHeaderVisible 	:= .F. 		// Não imprime cabeçalho do protheus
olReport:lFooterVisible 	:= .F.		// Não imprime rodapé do protheus
olReport:lParamPage			:= .F.		// Não imprime pagina de parametros
olReport:SetEdit(.F.)                   // Não permite personilizar o relatório, desabilitando o botão <Personalizar>

//+----------------+
//|Define as fontes|
//+----------------+

Return olReport

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ATFProc   ³ Autor ³ Totvs                 ³ Data | 14/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressão do relatorio.								      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ATFProc( ExpC1 )         				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 = Objeto tReport                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ATFProc( olReport )

Local nReg			:= 0 //Quantidade de registros impressos
Local nPag			:= 0 //Quantidade de paginas por pagina
Local nCol			:= 0
Local cQuery			:= ""
Local aCnts			:= {}

Local aColGrp1      := { STR0005,STR0008,""		,STR0012,STR0015,STR0018,STR0021,STR0023,""		,STR0026,STR0029,""		,STR0032,""			,STR0036,STR0039,STR0042,STR0045,STR0048,STR0051,STR0053,STR0056,STR0059,STR0062	,STR0064,STR0067,""		,STR0071,""			,STR0075,STR0078,STR0081 }
Local aColGrp12     := { STR0006,STR0009,STR0011,STR0013,STR0016,STR0019,STR0022,STR0024,STR0025,STR0027,STR0030,STR0031,STR0033,STR0035	,STR0037,STR0040,STR0043,STR0046,STR0049,STR0052,STR0054,STR0057,STR0060,STR0063	,STR0065,STR0068,STR0070,STR0072,STR0074	,STR0076,STR0079,STR0082 }
Local aColGrp13     := { STR0007,STR0010,""		,STR0014,STR0017,STR0020,""		,""		,""	,STR0028,""			,""	,STR0034,""			,STR0038,STR0041,STR0044,STR0047,STR0050,""		,STR0055,STR0058,STR0061,STR0090	,STR0066,STR0069,""		,STR0073,""			,STR0077,STR0080,STR0083 }

Local aEquivale 	:= { "N1_CBASE","N3_CCONTAB","N1_DESCRIC","N1_MARCA","N1_MODELO","N1_CHAPA","NSLDINIC","NAQUIS","NAMPLIA","NBAIXAS","NAJUSTES","NVOLUN","NSOCIE","NOUTROS","NHIST","NAJUSINFLA","NAJUSTADO","N1_AQUISIC","N3_DINDEPR","CMETODO","N3_AUTDEPR","N3_TXDEPR1","NDEPRACM","NDEPRACM2","NDEPRBXS","NAJUSTES2","NVOLUL2","NSOCIE2","NOUTROS2","NDEPRHIST","NAJUDINFLA","NDEPRHIST"}
Local aInfo         := {}
Local aTotais		:= {}               
Local nInc			:= 0 
Local nPos			:= 0
Local nPosEquiv		:= 0
Local nCnts			:= 0 
Local nValor		:= 0
Local cStrFil		:= ""
Local oFont7 		:= TFont():New( "Courier New",, -06 )
Local oFont8 		:= TFont():New( "Courier New",, -08 )
Local aVert			:= { 100, 230, 350, PIX_INICIAL_VALORES }
Local nIniDin		:= PIX_INICIAL_VALORES					// Pixel redimencionado dinamicamente
Local nLimitrofe	:= 4850
Local nLinHist 		:= 1 
Local aHistorico	:= {}
Local aSelFil		:= {}
Local nRowStart		:= 0 
Local cValZero      := "0.00"
Local nPosIni       := 0
Local nPosFim       := 0
Local nCount        := 0
Local cDescActivo   := ""

PRIVATE aMetodo     := {"",""}

// Se aFil nao foi enviada, exibe tela para selecao das filiais
If MV_PAR02 == 1
	aSelFil := AdmGetFil()

	If Len( aSelFil ) <= 0
		Return
	EndIf 
EndIf

// Inicia o array totalizador com zero
aFill( aTotais, 0 )

//Query para trazer o saldo das contas
//cQuery := "SELECT DISTINCT N1_CBASE, N1_ITEM, N1_MARCA, N1_MODELO, N3_CCONTAB, substring( N1_DESCRIC, 1, 12 ) N1_DESCRIC, N1_CHAPA " //, N3_QUANTD, N3_VORIG1, N1_AQUISIC, N3_DINDEPR, N3_TPDEPR, N3_AUTDEPR, N3_TXDEPR1 "

cQuery := "SELECT DISTINCT "
cQuery += "N1_CBASE, 
cQuery += "N1_ITEM, "
cQuery += "N1_MARCA, "
cQuery += "N1_MODELO, "
cQuery += "N1_DESCRIC, "
cQuery += "N1_CHAPA, "
cQuery += "N1_AQUISIC, "
cQuery += "N3_VORIG1, "
cQuery += "N3_CCONTAB, "
cQuery += "N3_QUANTD, "
cQuery += "N3_DINDEPR, "
cQuery += "N3_TPDEPR, "
cQuery += "N3_AUTDEPR, "
cQuery += "N3_TXDEPR1 "
cQuery += "FROM " 
cQuery += RetSqlName( "SN1" ) + " AS SN1, " 
cQuery += RetSqlName( "SN3" ) + " AS SN3 "
cQuery += "WHERE SN1.N1_CBASE = SN3.N3_CBASE "
cQuery += " AND SN3.N3_TIPO = '01' AND "

// Filtro de filiais
If MV_PAR02 == 1
	For nInc := 1 To Len( aSelFil )
		cStrFil += "'" + aSelFil[nInc] + "'"

		If nInc < Len( aSelFil )
			cStrFil += ", "
		EndIf
	Next

	cQuery += "SN1.N1_FILIAL IN ( " + cStrFil + " ) AND "
Else
	cQuery += "SN1.N1_FILIAL = '" + xFilial( "SN1" ) + "' AND "
EndIf

If TcSrvType() == "AS/400"
	cQuery += " SN1.@DELETED@ <> '*' AND "
	cQuery += " SN3.@DELETED@ <> '*' "
Else
	cQuery += " SN1.D_E_L_E_T_ <> '*' AND "
	cQuery += " SN3.D_E_L_E_T_ <> '*' "
Endif

cQuery += "ORDER BY N1_CBASE, N1_ITEM "
cQuery := ChangeQuery( cQuery )
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), "PER",.T.,.T.)

TCSetField( "PER", "N1_AQUISIC",	"D", 08, 0 )
TCSetField( "PER", "N3_DINDEPR",	"D", 08, 0 )
TCSetField( "PER", "N3_VORIG1",		"N", TamSX3( "N3_VORIG1" )[1], TamSX3( "N3_VORIG1" )[2] )
TCSetField( "PER", "N3_VRDACM1",	"N", TamSX3( "N3_VRDACM1" )[1], TamSX3( "N3_VRDACM1" )[2] )

DbSelectArea( "PER" )                       
PER->( DbGoTop() )
If PER->( !Eof() )
	FCabR032( olReport, nCol, aColGrp1, aColGrp12, aColGrp13 ) //Impressão do cabeçalho
	aTotais	:= FR032Array( aEquivale )
EndIf

// Determina o pixel vertical inicial
nRowStart		:= olReport:Row()

PER->(dbGoTop())
olReport:SetMeter( RecCount() )

While PER->(!Eof())
	If olReport:Cancel()
		Exit
	EndIf         

	FR032PgMtd(PER->N3_TPDEPR)
		
	aVert := { 120 }                      
	nPosEquiv := 120	//PIX_EQUIVALENTE
	aInfo := FRInfoATF( PER->N1_CBASE, PER->N1_ITEM, MV_PAR01 )
	For nInc := 1 To Len( aEquivale )
                             
		If PER->( FieldPos( aEquivale[nInc] ) ) > 0
			If ValType( PER->&( aEquivale[nInc] ) ) == "C"

				If Upper( aEquivale[nInc] ) == "N1_DESCRIC"
					//For Next para tratamento de quebra de linha para impressão da descrição do Bem.
					//quando o mesmo ultrapassar 12 caracteres.					
					lExit := .F.
					For nCount := 1 To MlCount(RTrim(PER->N1_DESCRIC),13)           
						nPosIni := If(nCount==1,1,If(nCount==2,14,If(nCount==3,27,40)))
						nPosFim := If(nCount==1,13,nCount*13) 
                		cDescActivo := RTrim(Subs(PER->N1_DESCRIC,nPosIni,nPosFim))
  						If Empty(cDescActivo) 
					 		Exit
						Endif
 			 			If nCount > 1
							FR032PrnA( olReport,.F.)
							olReport:SkipLine( 1 )
						EndIf                
						olReport:Say( olReport:Row(), nPosEquiv, cDescActivo, oFont7 )	 
						If nCount == 2
							olReport:Say( olReport:Row(), 2932, aMetodo[nCount], oFont7)
						EndIf						
						If nCount == 1
							FR032PrtCol(olReport,aInfo,aEquivale,aTotais,nPosEquiv,aVert)
							lExit := .T.
						EndIf	
                    Next nCount
                    If lExit
                    	Exit
                    EndIf	
                Else    
					olReport:Say( olReport:Row(), nPosEquiv, PER->&( aEquivale[nInc] ), oFont7 )
                EndIf
			ElseIf ValType( PER->&( aEquivale[nInc] ) ) == "D"
				olReport:Say( olReport:Row(), nPosEquiv, DtoC( PER->&( aEquivale[nInc] ) ),  oFont7 )

			ElseIf ValType( PER->&( aEquivale[nInc] ) ) == "N"
				olReport:Say( olReport:Row(), nPosEquiv, Transform( PER->&( aEquivale[nInc] ), MASK_VALOR), oFont7 )

				// Ajusta os totalizadores
				aTotais[nInc] += PER->&( aEquivale[nInc] )
			EndIf

		Else
			If !Empty( aInfo )
				If Upper( aEquivale[nInc] ) == "NAMPLIA"
					nValor := aInfo[1]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NBAIXAS"
					nValor := aInfo[2]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NDEPRACM"
					nValor := aInfo[3]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NDEPRACM2"
					nValor := aInfo[4]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NDEPRBXS"
					nValor := aInfo[5]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NDEPRHIST"
					nValor := aInfo[3] + aInfo[4] + aInfo[5] + aInfo[13] + aInfo[14] + aInfo[15]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NSLDINIC"
					// Se o bem foi adquirido em exercícios anteriores, obter o valor do registro tipo 01. 
					// Caso contrário, preencher com 0 (zero).
					If Year( PER->N1_AQUISIC ) < MV_PAR01
						nValor := PER->N3_VORIG1
					EndIf
	
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor
	
				ElseIf Upper( aEquivale[nInc] ) == "NAQUIS"
					// Se o bem foi adquirido no exercício do relatório, obter do registro tipo 01. 
					// Caso contrário, preencher com 0 (zero).
					If Year( PER->N1_AQUISIC ) == MV_PAR01
						nValor := PER->N3_VORIG1
					EndIf
	
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NVOLUN"
					nValor := aInfo[9]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NSOCIE"
					nValor := aInfo[10]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NOUTROS"
					nValor := aInfo[12]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NVOLUL2"
					nValor := aInfo[13]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor
                                           
				ElseIf Upper( aEquivale[nInc] ) == "NSOCIE2"
					nValor := aInfo[14]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NOUTROS2"
					nValor := aInfo[15]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NHIST"
					nValor := PER->N3_VORIG1 - aInfo[2] + aInfo[9] + aInfo[10] + aInfo[12]
					aInfo[16] := nValor
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "CMETODO"
					If PER->N3_TPDEPR <> "1"
						olReport:Say( olReport:Row(), nPosEquiv, Subs(GetTPDesc( "20", PER->N3_TPDEPR ),1,13), oFont7 )
	               	EndIf   	     

				ElseIf Upper( aEquivale[nInc] ) == "NAJUSTES"
					nValor := aInfo[11]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NAJUSINFLA"
					nValor := aInfo[16]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NAJUSTADO"
					nValor := aInfo[15] + aInfo[16]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aInfo[17] := nValor
					aTotais[nInc] += nValor
					
				ElseIf Upper( aEquivale[nInc] ) == "NAJUSTES2"
					nValor := aInfo[20]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NAJUDINFLA"
					nValor := aInfo[21]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
					aTotais[nInc] += nValor
				EndIf 
			EndIf
		EndIf
		nPosEquiv += PIX_DIF_COLUNA_VALORES
		aAdd( aVert, nPosEquiv )                     
	Next

	nLimitrofe := nIniDin
	//olReport:Box(olReport:Row()+2,olReport:Col()-004, olReport:Row()+2, nLimitrofe )
	
	// Imprime a linhas verticais e passa para proxima linha
	FR032Traco( olReport, .F. )
	FR032PrnA( olReport,.F.)
	olReport:SkipLine( 1 )

	olReport:OnPageBreak( { || FCabR032( olReport, nCol, aColGrp1, aColGrp12, aColGrp13 ) } )
	If nPag > 80
		If nReg > 0
			FTotR032( olReport, nCol, aTotais )
		EndIf

		olReport:EndPage()
		nPag := 0
		olReport:setRow( nRowStart )
	EndIf

	DbSelectArea("PER")
	PER->( DbSkip() )
	
	olReport:IncMeter()

	nPag++				// Quantidade de registros por pagina
	nReg++				// Quantidade de registros impressos
End

If nReg > 0
	FTotR032( olReport, nCol, aTotais )
EndIf

PER->( DbCLoseArea() )

Return olReport

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FCabR032  ³ Autor ³ Totvs                 ³ Data | 06/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cabeçalho do relatorio.								      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FCabR032(Expo1,ExpN1,ExpA1)  				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1 = Objeto tReport                                      ³±±
±±³          ³ExpN1 = Posição da coluna de impressão                      ³±±
±±³          ³ExpA1 = Array com as contas do ativo                        ³±±
±±³          ³ExpA2 = Array com as contas do passivo                      ³±±
±±³          ³ExpA3 = Array com as contas de patrimonio                   ³±±
±±³          ³ExpA4 = Array com as contas de gasto                        ³±±
±±³          ³ExpA5 = Array com as contas de receita                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FCabR032( olReport, nCol, aColGrp1, aColGrp12, aColGrp13 )
Local nInc			:= 0
//Local nColPix		:= olReport:Col() + 100
Local aVert			:= { 100, 396, 988, 1728, 2172, 2912, 3208, 3504, 3948, 4392, 4836}
Local nIniDin		:= PIX_INICIAL_VALORES						// Pixel redimencionado dinamicamente
//Local oFont7 		:= TFont():New( "Courier New",, -06 )
Local oFont7b 		:= TFont():New( "Courier New",, -06,,.T. )
Local oFont8 		:= TFont():New( "Courier New",, -08 )
Local oFont8b 		:= TFont():New( "Courier New",, -08,,.T. )
Local nLimitrofe	:= 4850
Local nCharPCol		:= 15  
Local cRUC      	:= If(Empty(SM0->M0_CGC),"53113791000122",SM0->M0_CGC)
Local cApellido 	:= If(Empty(SM0->M0_NOMECOM),"TOTVS S.A.",SM0->M0_NOMECOM)
//Local nChar := 1

//For nChar := 1 To 255
//	MsgStop(Chr(nChar),StrZero(nChar,3))
//Next nChar	

//Cabeçalho    
olReport:Say( olReport:Row()+35  ,110, STR0001, oFont8b )		
olReport:Say( olReport:Row()+55  ,110, STR0002, oFont8b )	   			 		// Período
olReport:Say( olReport:Row()+55  ,890, ":",oFont8) 
olReport:Say( olReport:Row()+55  ,910, Str(mv_par01,4),oFont8) 
olReport:Say( olReport:Row()+85  ,110, STR0003, oFont8b )						// RUC
olReport:Say( olReport:Row()+85  ,890, ":",oFont8)
olReport:Say( olReport:Row()+85  ,910, cRuc,oFont8) 
olReport:Say( olReport:Row()+110 ,110, STR0004, oFont8b )						// Apellidos y nombres...
olReport:Say( olReport:Row()+110 ,890, ":",oFont8)
olReport:Say( olReport:Row()+110 ,910, AllTrim( Upper(Capital( cApellido) )), oFont8 )
olReport:SkipLine( 04 )

// Primeira linha
FR032Traco( olReport,.T. )
olReport:SkipLine( 1 )                             


FR032Prnt( olReport,aVert, .F. )
olReport:Say( olReport:Row()+20, 396, PadC( STR0084,	4 * nCharPCol ),	oFont7b )		// "Detalles del Act. Fijo"      
olReport:Say( olReport:Row()+20,1696, PadC( STR0085,	4 * nCharPCol ),	oFont7b )		// "Val. Reevaluac. Efect."      
olReport:Say( olReport:Row()+20,2912, PadC( STR0086,	2 * nCharPCol ),	oFont7b )		// "Depreciac."
olReport:Say( olReport:Row()+20,3504, PadC( STR0087,	3 * nCharPCol ),	oFont7b )		// "Val. de la Deprec."
olReport:Say( olReport:Row()+20,3948, PadC( STR0088,	3 * nCharPCol ),	oFont7b )		// "Val. Reevaluac. Efect."
olReport:SkipLine( 1 )
nIniDin *= Len( aColGrp1 )
//aAdd( aVert, nIniDin )

nLimitrofe := nIniDin
//olReport:Box(olReport:Row()-004,olReport:Col()-004, olReport:Row()+032, nLimitrofe )
FR032Traco( olReport, .F.)
FR032Prnt( olReport,aVert, .F. )													// Imprime a linhas verticais e passa para proxima linha
olReport:SkipLine( 1 )

// Segunda linha
aVert	:= { 100 }	//PIX_INICIAL_VALORES }                                     
nIniDin	:= 100
nLinPix := 32
For nInc := 1 To Len( aColGrp1 )
	olReport:Say( olReport:Row(), nIniDin, PadC( aColGrp1[nInc], 16 ), oFont7b )
	//olReport:Box( olReport:Row()-004, aVert[nInc], olReport:Row()+nLinPix, aVert[nInc] ) 			// Traco vertical
	//olReport:Say( olReport:Row()-004, nIniDin, "|", oFont8b )	 

	nIniDin += PIX_DIF_COLUNA_VALORES
	aAdd( aVert, nIniDin )
Next
nIniDin += PIX_DIF_COLUNA_VALORES
aAdd( aVert, nIniDin )
      
FR032Prnt( olReport, aVert,.F. )																	// Imprime a linhas verticais e passa para proxima linha
olReport:SkipLine( 1 )


// Terceira linha
// Imprime as contas
nIniDin	:= 100	//olReport:Col()
For nInc := 1 To Len( aColGrp12 )
	olReport:Say( olReport:Row(), nIniDin, PadC( aColGrp12[nInc], 16 ), oFont7b )
	nIniDin += PIX_DIF_COLUNA_VALORES
Next

FR032Prnt( olReport, aVert, .F. )														// Imprime a linhas verticais e passa para proxima linha
olReport:SkipLine( 1 )

// Quarta linha
// Imprime as contas
nIniDin	:= 100	//olReport:Col()
For nInc := 1 To Len( aColGrp13 )
	olReport:Say( olReport:Row(), nIniDin, PadC( aColGrp13[nInc], 16 ), oFont7b )
	nIniDin += PIX_DIF_COLUNA_VALORES
Next                             

FR032Traco( olReport, .F. )
FR032Prnt( olReport, aVert, .F. )														// Imprime a linhas verticais e passa para proxima linha
olReport:SkipLine( 1 )

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FTotR032  ³ Autor ³ Totvs                 ³ Data | 06/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cabeçalho do relatorio.								      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FTotR032(Expo1,ExpN1,ExpA1)  				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1 = Objeto tReport                                      ³±±
±±³          ³ExpN1 = Posição da coluna de impressão                      ³±±
±±³          ³ExpA1 = Array com as contas do ativo                        ³±±
±±³          ³ExpA2 = Array com as contas do passivo                      ³±±
±±³          ³ExpA3 = Array com as contas de patrimonio                   ³±±
±±³          ³ExpA4 = Array com as contas de gasto                        ³±±
±±³          ³ExpA5 = Array com as contas de receita                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FTotR032( olReport, nCol, aTotais )
Local nInc			:= 0
//Local nColPix		:= 110
Local aVert			:= { 120 }
Local nIniDin		:= 120
//Local nValPrnt		:= PIX_EQUIVALENTE
//Local oFont7 		:= TFont():New( "Courier New",, -06 )
Local oFont7b 		:= TFont():New( "Courier New",, -06,,.T. )
Local nLimitrofe	:= 4850

For nInc := 1 To Len( aTotais )
	If nInc < 6
		aTotais[nInc]:=""
	EndIf	
	If nInc == 6
		olReport:Say( olReport:Row()+10, aVert[nInc], "Totales", 			oFont7b )		// Totais
    Else
		If ValType( aTotais[nInc] ) == "N"
			olReport:Say( olReport:Row()+10, aVert[nInc], Transform(aTotais[nInc], MASK_VALOR ), oFont7b )
		EndIf
	EndIf	
	nIniDin += PIX_DIF_COLUNA_VALORES
	aAdd( aVert, nIniDin )
Next

nLimitrofe := nIniDin
//olReport:Box(olReport:Row()-004,olReport:Col()-004, olReport:Row()+031, nLimitrofe )

aVert   := {100}
nIniDin := 100
For nInc := 1 To 33 //Len(aTotais)
	nIniDin += PIX_DIF_COLUNA_VALORES
	aAdd( aVert, nIniDin)
Next nInc
	
FR032Prnt( olReport, aVert, .T. )	// Imprime a linhas verticais e passa para proxima linha
olReport:SkipLine( 1 )

Return


/*/
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FR032Traco ³ Autor ³ Jose Lucas           ³ Data | 24/06/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime a linha vertical do relatorio.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FR032Traco( ExpO1, ExpA1 )   				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1 = Objeto Report.                                      ³±±
±±³          ³ExpA1 = Array com as colunas                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR032Traco( olReport, lAvanca, cId )
Local nInc 		:= 1
Local nIniDin   := 100
Local nLinPix	:= 34
//Local oFont8b	:= TFont():New( "Courier New",, -08,,.T. ) 
Local oFont8	:= TFont():New( "Courier New",, -08,,.F. ) 
Local aTraco    := { 100, PIX_INICIAL_VALORES } 
Local nIniCol   := 005
                   
For nInc := 1 To nLinPix
	If nInc < 34      
		nIniCol := If(nInc==1,010,nIniCol)
		//olReport:Box( olReport:Row(), aCol[nInc], olReport:Row()+nLinPix, aCol[nInc] ) 		// Traco vertical
   	 	If lAvanca
			olReport:Say( olReport:Row()+015, aTraco[nInc]+nIniCol,If(nInc==33,"___________","______________"), oFont8 )     	   		//Traço
		Else
			olReport:Say( olReport:Row()    , aTraco[nInc]+nIniCol,If(nInc==33,"___________","______________"), oFont8 )     	   		//Traço
		EndIf
	EndIf			
	nIniDin += PIX_DIF_COLUNA_VALORES
	aAdd( aTraco, nIniDin )
Next nInc                                   

Return                   

/*/
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FR032Prnt  ³ Autor ³ Jose Lucas           ³ Data | 24/06/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime as linhas verticais e horizontais do relatorio.     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FR032Prnt( ExpO1, ExpA1 )   				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpA1 = Array com as colunas                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/      
Static Function FR032Prnt( olReport, aCol, lJuncao, cId )
Local nInc 		:= 1
//Local nLinPix	:= 25
Local nIniDim   := 0
//Local oFont8b	:= TFont():New( "Courier New",, -08,,.T. ) 
Local oFont8	:= TFont():New( "Courier New",, -08,,.F. )      
Local nIniCol   := 005

DEFAULT cId := ""

If Len(aCol) >= 33
	nIniDim := aCol[Len(aCol)] += PIX_DIF_COLUNA_VALORES  
	aAdd(aCol,nIniDim)
EndIf	
             
For nInc := 1 To Len(aCol)
	//olReport:Box( olReport:Row(), aCol[nInc], olReport:Row()+nLinPix, aCol[nInc] ) 		// Traco vertical
	olReport:Say( olReport:Row(), aCol[nInc]+005, "|", oFont8 )
	olReport:Say( olReport:Row()+15, aCol[nInc]+005, "|", oFont8 )
	If lJuncao
		nIniCol := If(nInc==1,010,nIniCol)
		If nInc < 33                                                    
		   	//	olReport:Say( olReport:Row()+015, aCol[nInc]+nIniCol,If(nInc==33,"___________"   ,"______________"), oFont8 )     		//Traço
		   	If nInc <> 33
		   		olReport:Say( olReport:Row()+015, aCol[nInc]+nIniCol,If(nInc<32     ,"______________","___________"), oFont8 )     		//Traço
				olReport:Say( olReport:Row(), aCol[nInc]+005, "|", oFont8 )
			EndIf	
		EndIf	
	EndIf      
Next                                   

Return

/*/
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FR032PrnA ³ Autor ³ Jose Lucas           ³ Data | 24/06/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime as linhas verticais e horizontais do relatorio.     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FR032PrnA( ExpO1, ExpA1 )   				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpA1 = Array com as colunas                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/    
Static Function FR032PrnA( olReport, lJuncao, cId )
Local nInc 		:= 1
//Local nLinPix	:= 26 //25  
//Local oFont8b	:= TFont():New( "Courier New",, -08,,.T. ) 
Local oFont8	:= TFont():New( "Courier New",, -08,,.F. ) 
Local nLen      := 34
Local aCol      := {100}
Local nIniDin   := 100
             
For nInc := 1 To nLen
	//olReport:Box( olReport:Row(), aCol[nInc], olReport:Row()+nLinPix, aCol[nInc] ) 		// Traco vertical
	olReport:Say( olReport:Row(), aCol[nInc]+005, "|", oFont8 )
	olReport:Say( olReport:Row()+15, aCol[nInc]+005, "|", oFont8 )
	If lJuncao
		If nInc < 34
			olReport:Say( olReport:Row()+015, aCol[nInc]+005,If(nInc==33,"___________","______________"), oFont8 )     		//Traço
			olReport:Say( olReport:Row(), aCol[nInc]+005, "|", oFont8 )
			//olReport:Say( olReport:Row()+015, aCol[nInc]+005, Chr(016), oFont8 )				//Junção
		EndIf	
	EndIf     
	nIniDin += PIX_DIF_COLUNA_VALORES          
	aAdd(aCol,nIniDin)
Next                                   

Return

/*/
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FR032Array³ Autor ³ Totvs                 ³ Data | 07/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica quais colunas tem totalizadores e retorna array    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FR032Array( ExpA1 )         				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA1 = Array com os campos                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR032Array( aEquivale )
Local aRet	:= {}
Local nInc	:= 0

If Select( "PER" ) > 0
	For nInc := 1 To Len( aEquivale )
		If PER->( FieldPos( aEquivale[nInc] ) ) > 0
			If ValType( PER->&( aEquivale[nInc] ) ) == "N"
				aAdd( aRet, 0 )
			Else
				aAdd( aRet, NIL )
			EndIf
		Else
			// Se foi atribuido variavel numerica, define 0
			If Upper( Left( aEquivale[nInc], 1 ) ) == "N"
				aAdd( aRet, 0 )
			Else
				aAdd( aRet, NIL )
			EndIf
		EndIf
	Next
EndIf

Return aRet

/*/
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FRInfoATF ³ Autor ³ Totvs                 ³ Data | 20/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna um array com historico/valores do ativo             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FRInfoATF( cBase, cItem, cExercicio, lConsBaixados )	      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FRInfoATF( cBase, cItem, nExercicio, lConsBaixados )
Local aRet		 := {}
Local aAreaSN3	 := SN3->( GetArea() )
Local aAreaSN4	 := SN4->( GetArea() )
Local nAmplia	 := 0
Local nAmplia2	 := 0
Local nReaval	 := 0
Local nReaval2	 := 0
Local nBaixas	 := 0
Local nDeprAcm	 := 0
Local nDeprAcm2	 := 0
Local nDeprBxs	 := 0
Local nVolul	 := 0
Local nSocie	 := 0
Local nOutros	 := 0
Local nVolul2	 := 0
Local nSocie2	 := 0
Local nOutros2	 := 0
Local nAjustes   := 0
Local nAjustado  := 0
Local nAjustes2  := 0
Local nAjusInfla := 0
Local nAjuDInfla := 0                   
Local nHistorico := 0

DEFAULT lConsBaixados := .F.

DbSelectArea( "SN4" )
SN4->( DbSetOrder(1) )
SN4->( DbSeek( xFilial( "SN4" ) + cBase + cItem ) )
While SN4->( !Eof() ) .AND. xFilial( "SN4" ) + cBase + cItem == SN4->( N4_FILIAL + N4_CBASE + N4_ITEM )

	If SN4->N4_TIPO == "01" .AND. SN4->N4_OCORR == "09" .AND. SN4->N4_TIPOCNT == "1"		// Melhorias
		nAmplia += SN4->N4_VLROC1

	ElseIf SN4->N4_TIPO == "02" .AND. SN4->N4_OCORR == "05" .AND. SN4->N4_TIPOCNT == "1"	// Reavaliacoes
		nReaval += SN4->N4_VLROC1

		// Obs.: considerar somente os registros da SN4 cujo seu correspondente na SN3 tenha N3_TIPREAV = 1 
		// (para localizar o registro na SN3 use os campos N4_SEQREAV e N3_SEQREAV.
		If SN3->( FieldPos( "N3_TIPREAV" ) ) > 0
			DbSelectArea( "SN3" )
			SN3->( DbSetOrder( 1 ) )
			If SN3->(dbSeek(xFilial("SN3")+SN4->N4_CBASE+SN4->N4_ITEM+SN4->N4_TIPO+"0"+SN4->N4_SEQ))
				If 	   RTrim(SN3->N3_TIPREAV) == "1" .AND. SN3->N3_SEQREAV == SN4->N4_SEQREAV 
					nVolul += SN4->N4_VLROC1    
//					nVolul2 += SN4->N4_VLROC2
				ElseIf RTrim(SN3->N3_TIPREAV) == "2" .AND. SN3->N3_SEQREAV == SN4->N4_SEQREAV 
					nSocie += SN4->N4_VLROC1 
//					nSocie2 += SN4->N4_VLROC2
				ElseIf RTrim(SN3->N3_TIPREAV) == "3" .AND. SN3->N3_SEQREAV == SN4->N4_SEQREAV 
					nOutros += SN4->N4_VLROC1
//					nOutros2 += SN4->N4_VLROC2
				EndIf
			EndIf
		EndIf
		
	ElseIf SN4->N4_TIPO == "01" .AND. SN4->N4_OCORR == "01" .AND. SN4->N4_TIPOCNT == "1"	// Baixas
		nBaixas += SN4->N4_VLROC1

	ElseIf SN4->N4_TIPO == "01" .AND. SN4->N4_OCORR == "01" .AND. SN4->N4_TIPOCNT == "4"	// Depreciação sobre as Baixas
		nDeprBxs += SN4->N4_VLROC1 

	ElseIf SN4->N4_TIPO == "01" .AND. SN4->N4_OCORR == "01" .AND. SN4->N4_TIPOCNT == "3"	// Outras depreciacoes                            
		nAjustes += SN4->N4_VLROC1

	ElseIf SN4->N4_TIPO == "05" .AND. SN4->N4_TIPOCNT == "1"								// Ampliacao
		nAmplia2 += SN4->N4_VLROC1

	ElseIf SN4->N4_TIPO == "05" .AND. SN4->N4_TIPOCNT == "3"								// Reavaliacoes
		nReaval2 += SN4->N4_VLROC1                     

	ElseIf SN4->N4_OCORR == "06" .AND. SN4->N4_TIPOCNT == "4"								// Depreciacao acumulado no exercicio anterior
	    // Valor da depreciação até o final do exercício anterior. 
		If Year( SN4->N4_DATA ) < nExercicio
			nDeprAcm += SN4->N4_VLROC1
		EndIf                               
				
	ElseIf SN4->N4_OCORR == "06" .AND. SN4->N4_TIPOCNT == "3"								
		// Total da depreciação calculada no exercício. 
		If Year( SN4->N4_DATA ) == nExercicio
			If SN4->N4_TIPO == "02"			//reavaliacoes
				If SN3->( FieldPos( "N3_TIPREAV" ) ) > 0      	
					DbSelectArea( "SN3" )
					SN3->( DbSetOrder( 1 ) )
					If SN3->(dbSeek(xFilial("SN3")+SN4->N4_CBASE+SN4->N4_ITEM+SN4->N4_TIPO+"0"+SN4->N4_SEQ))
						If RTrim(SN3->N3_TIPREAV) == "1" .AND. SN3->N3_SEQREAV == SN4->N4_SEQREAV 
							nVolul2 += SN4->N4_VLROC1
						ElseIf RTrim(SN3->N3_TIPREAV) == "2" .AND. SN3->N3_SEQREAV == SN4->N4_SEQREAV 
							nSocie2 += SN4->N4_VLROC1
						ElseIf RTrim(SN3->N3_TIPREAV) == "3" .AND. SN3->N3_SEQREAV == SN4->N4_SEQREAV 
							nOutros2 += SN4->N4_VLROC1
						EndIf
					EndIf
				EndIf
			Else
				nDeprAcm2 += SN4->N4_VLROC1
			Endif
		EndIf
		DbSelectArea( "SN3" )
		SN3->( DbSetOrder( 1 ) )
		If SN3->(dbSeek(xFilial("SN3")+SN4->N4_CBASE+SN4->N4_ITEM+SN4->N4_TIPO+"1"+SN4->N4_SEQ))
			nDeprAcm2 := 0
		EndIf	
	EndIf

	SN4->( DbSkip() )
End

aAdd( aRet, nAmplia )					// 01- Melhorias = ampliacao
aAdd( aRet, nBaixas + nAmplia2)			// 02- Baixas + Ampliacao
aAdd( aRet, nDeprAcm )					// 03- Depreciacao Acumulada no exercicio anterior
aAdd( aRet, nDeprAcm2 )					// 04- Depreciacao Acumulada no exercicio atual
aAdd( aRet, nDeprBxs + nReaval2 )		// 05- Baixas no exercicio atual + reavaliacoes
aAdd( aRet, nReaval )					// 06- Reavaliacoes
aAdd( aRet, nAmplia )					// 07- Ampliacoes
aAdd( aRet, nBaixas+nAmplia2 )			// 08- Baixas e Ampliacoes
aAdd( aRet, nVolul )					// 09- Reavaliacao voluntaria
aAdd( aRet, nSocie )					// 10- Reavaliacao por reorganizacao de sociedade
aAdd( aRet, nAjustes )					// 11- Outros ajustes
aAdd( aRet, nOutros )					// 12- Reavaliacao outros
aAdd( aRet, nVolul2 )					// 13- Reavaliacao voluntaria - OCORRENCIA 6
aAdd( aRet, nSocie2 )					// 14- Reavaliacao por reorganizacao de sociedade - OCORRENCIA 6
aAdd( aRet, nOutros2 )			   		// 15- Reavaliacao outros - OCORRENCIA 6
aAdd( aRet, nHistorico )                // 16- Valor historico do ativo fixo em 31/12
aAdd( aRet, nAjusInfla ) 				// 17- Ajustes por Inflação.
aAdd( aRet, nAjustado )                 // 18- Valor ajustado do ativo fixo em 31/12
aAdd( aRet, "CMETODO" )					// 19- Metodo Aplicado.
aAdd( aRet, nAjustes2 )					// 20- Depreciação relacionada outros Ajustes - OCORRENCIA 6
aAdd( aRet, nAjuDInfla )				// 21- Ajustes por Depreciação de inflação

RestArea( aAreaSN3 )
RestArea( aAreaSN4 )

Return aRet

/*/
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³getTPDesc ³ Autor ³ Totvs                 ³ Data | 20/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna a descricao do tipo de depreciacao.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³getTPDesc( SN3->N3_TPDEPR )                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function getTPDesc( cChave, cTpDepr )
Local cDesc := ""

DbSelectArea( "SN0" )
SN0->( DbSetOrder( 1 ) )
If SN0->( DbSeek( xFilial( "SN0" ) + cChave + cTpDepr ) )
	cDesc := AllTrim(SN0->N0_DESC01)
EndIf

Return cDesc

/*/
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FR032PrtCol ³ Autor ³ Jose Lucas         ³ Data | 28/06/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprimir demais colunas quando N1_CBASE impresso em 2 ou + ³±±
±±³          ³ linhas.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR032PrtCol(olReport,aInfo,aEquivale,aTotais,nPosEquiv,aVert)
Local nValor := 0.00
Local nInc   := 1
Local oFont7 		:= TFont():New( "Courier New",, -06 )
//Local oFont7b 		:= TFont():New( "Courier New",, -06,,.T. )

nPosEquiv += PIX_DIF_COLUNA_VALORES

For nInc := 4 To Len(aEquivale)							
	If !Empty( aInfo )
	If Upper( aEquivale[nInc] ) == "N1_MARCA"
		olReport:Say( olReport:Row(), nPosEquiv, PER->&( aEquivale[nInc] ),  oFont7 )
			
	ElseIf Upper( aEquivale[nInc] ) == "N1_MODELO"
		olReport:Say( olReport:Row(), nPosEquiv, PER->&( aEquivale[nInc] ),  oFont7 )
			
	ElseIf Upper( aEquivale[nInc] ) == "N1_CHAPA"
		olReport:Say( olReport:Row(), nPosEquiv, PER->&( aEquivale[nInc] ),  oFont7 )
		
	ElseIf Upper( aEquivale[nInc] ) == "NAMPLIA"
		nValor := aInfo[1]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NBAIXAS"
		nValor := aInfo[2]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NDEPRACM"
		nValor := aInfo[3]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NDEPRACM2"
		nValor := aInfo[4]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NDEPRBXS"
		nValor := aInfo[5]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NDEPRHIST"
		nValor := aInfo[3] + aInfo[4] + aInfo[5] + aInfo[13] + aInfo[14] + aInfo[15]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NSLDINIC"
		// Se o bem foi adquirido em exercícios anteriores, obter o valor do registro tipo 01. 
		// Caso contrário, preencher com 0 (zero).
		If Year( PER->N1_AQUISIC ) < MV_PAR01
			nValor := PER->N3_VORIG1
		EndIf
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NAQUIS"
		// Se o bem foi adquirido no exercício do relatório, obter do registro tipo 01. 
		// Caso contrário, preencher com 0 (zero).
		If Year( PER->N1_AQUISIC ) == MV_PAR01
			nValor := PER->N3_VORIG1
		EndIf
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NVOLUN"
		nValor := aInfo[9]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NSOCIE"
		nValor := aInfo[10]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NOUTROS"
		nValor := aInfo[12]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NVOLUL2"
		nValor := aInfo[13]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor                                         
	ElseIf Upper( aEquivale[nInc] ) == "NSOCIE2"
		nValor := aInfo[14]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NOUTROS2"
		nValor := aInfo[15]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NHIST"
		nValor := PER->N3_VORIG1 - aInfo[2] + aInfo[9] + aInfo[10] + aInfo[12]
		aInfo[16] := nValor
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "N1_AQUISIC"
		olReport:Say( olReport:Row(), nPosEquiv+20, DtoC( PER->&( aEquivale[nInc] ) ),  oFont7 )
		aTotais[nInc] := ""
	ElseIf Upper( aEquivale[nInc] ) == "N3_DINDEPR"
		olReport:Say( olReport:Row(), nPosEquiv+20, DtoC( PER->&( aEquivale[nInc] ) ),  oFont7 )
		aTotais[nInc] := ""
	ElseIf Upper( aEquivale[nInc] ) == "CMETODO"
		If PER->N3_TPDEPR <> "1"
			olReport:Say( olReport:Row(), nPosEquiv, Subs(GetTPDesc( "20", PER->N3_TPDEPR ),1,13), oFont7 )
       	EndIf   	     
	ElseIf Upper( aEquivale[nInc] ) == "N3_TXDEPR1"
		olReport:Say( olReport:Row(), nPosEquiv, Transform( PER->&( aEquivale[nInc] ), MASK_VALOR), oFont7 )
		aTotais[nInc] := ""
	ElseIf Upper( aEquivale[nInc] ) == "NAJUSTES"
		nValor := aInfo[11]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NAJUSINFLA"
		nValor := aInfo[17]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NAJUSTADO"
		nValor := aInfo[16] + aInfo[17]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aInfo[17] := nValor
		aTotais[nInc] += nValor		
	ElseIf Upper( aEquivale[nInc] ) == "NAJUSTES2"
		nValor := aInfo[20]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	ElseIf Upper( aEquivale[nInc] ) == "NAJUDINFLA"
		nValor := aInfo[21]
		olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont7 )
		aTotais[nInc] += nValor
	EndIf 
	EndIf
	nPosEquiv += PIX_DIF_COLUNA_VALORES
	aAdd( aVert, nPosEquiv )
Next nInc	
Return( aTotais )    

/*/
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FR032PgMtd  ³ Autor ³ Jose Lucas         ³ Data | 28/06/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Quebrar descricao do metodo de calculo em 2 elementos para ³±±
±±³          ³ ser impresso em 2 linhas.                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR032PgMtd()
Local nCount  := 0
Local nPosIni := 0
Local nPosFim := 0
Local cDscMetodo := ""       

If ! PER->N3_TPDEPR $ " |1"
	aMetodo := {}
	cMetodo := GetTPDesc( "20", PER->N3_TPDEPR )
	For nCount := 1 To MlCount(RTrim(cMetodo),13)           
		nPosIni := If(nCount==1,1,If(nCount==2,14,If(nCount==3,27,40)))
		nPosFim := If(nCount==1,13,nCount*13) 
   		cDscMetodo := RTrim(Subs(cMetodo,nPosIni,nPosFim))
		If Empty(cDscMetodo) 
		   Exit
		Endif
		AADD(aMetodo,cDscMetodo)
    Next nCount
EndIf 	     
Return
