/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "RwMake.ch"
#Include "Protheus.ch"
#Include "TopConn.ch"
#Include "ATFR161.ch"

#define PIX_DIF_COLUNA_VALORES		250		// Pixel inicial para impressao dos tracos das colunas dinamicas
#define PIX_INICIAL_VALORES			250		// Pixel para impressao do traco vertical
#define PIX_EQUIVALENTE				050		// Pixel inicial para impressao das colunas dinamicas
#define MASK_VALOR					"@E 99999999999.99"
#define MASK_TAXA					"@E 999999999.9999"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR161   º Autor ³ Totvs              º Data ³  14/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Detalhes da Diferenca de Cambio                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ATFR161                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR161()
Local cPerg			:= "ATR161"
Local olReport

Private aFieldSM0	:= {"M0_NOMECOM", "M0_CGC"}
Private aDatosEmp	:= IIf (cVersao <> "11" ,FWSM0Util():GetSM0Data(cEmpAnt, cFilAnt, aFieldSM0),"")
Private cRUC		:= Trim(IIf (cVersao <> "11" ,aDatosEmp[2][2],SM0->M0_CGC))
Private cApellido	:= Trim(IIf (cVersao <> "11" ,aDatosEmp[1][2],SM0->M0_NOMECOM))

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
Local clTitulo		:= STR0001 //"Detalhes da Diferenca de Cambio"
Local clDesc		:= STR0001 //"Detalhes da Diferenca de Cambio"
Local cPict		:= "@E 999,999,999.99" 
Local olReport
Local oSection1	    := NIL 

olReport:=TReport():New(clNomProg,clTitulo,cPerg,{|olReport| ATFProc(olReport)},clDesc)
olReport:SetLandscape()					// Formato paisagem
olReport:oPage:nPaperSize	:= 8 		// I
olReport:lHeaderVisible 	:= .F. 		// Não imprime cabeçalho do protheus
olReport:lFooterVisible 	:= .F.		// Não imprime rodapé do protheus
olReport:lParamPage			:= .F.		// Não imprime pagina de parametros
olReport:DisableOrientation()           // Não permite mudar o formato de impressão para Vertical, somente landscape
olReport:SetEdit(.F.)                   // Não permite personilizar o relatório, desabilitando o botão <Personalizar>

//Incluindo sessoes a serem impressas no modo planilla 
oSection1 := TRSection():New( olReport, "",,,,,,,,,,,7,,0,.F.)
oSection1:SetTotalInLine(.F.)
oSection1:SetTotalText(STR0040) //Totales


	//Definicao de colunas da sessao
	TRCell():New( oSection1, "N1_CBASE"		,"PER",STR0037+CRLF+STR0041+CRLF+STR0038  			   ,/*Picture*/  ,TamSX3( "N1_CBASE" )[1]   	,, ,"CENTER"	, .T.,"CENTER",,0,.F.) //"Código relac. con activo fijo""
	TRCell():New( oSection1, "N1_AQUISIC"	,"PER",STR0007+CRLF+STR0008+CRLF+STR0009  			   ,/*Picture*/  ,TamSX3( "N1_AQUISIC" )[1] 	,, ,"CENTER"	, .T.,"CENTER",,0,.F.) //"Cuenta Contable del activo"
	TRCell():New( oSection1, "nVOrigX"		,	  ,STR0010+CRLF+STR0011+CRLF+STR0012    		   ,/*Picture*/  ,14                        	,, ,"CENTER"	, .T.,"CENTER",,0,.F.) //"Descripción"
	TRCell():New( oSection1, "N1_TXMOEDA"	,"PER",STR0019+CRLF+STR0020+CRLF+STR0014+CRLF+STR0015  ,/*Picture*/  ,TamSX3( "N1_TXMOEDA" )[1] 	,, ,"CENTER"	, .T.,"CENTER",,0,.F.) //"Marca del activo Fijo"
	TRCell():New( oSection1, "N3VORIG1"		,"PER",STR0016+CRLF+STR0017+CRLF+STR0018 			   ,/*Picture*/  ,14 						 	,, ,"CENTER"	, .T.,"CENTER",,0,.F.) //"Modelo del activo Fijo"
	TRCell():New( oSection1, "nTxMoedX"		,	  ,STR0019+CRLF+STR0020+CRLF+STR0027 			   ,/*Picture*/  ,14					     	,, ,"CENTER"	, .T.,"CENTER",,0,.F.) //"Nº Serie y/o placa del activo"
	TRCell():New( oSection1, "nDifCambio"	,	  ,STR0022+CRLF+STR0023+CRLF+STR0024			   ,cPict		 ,14                     		,, ,"RIGHT"	    , .T.,"CENTER",,0,.F.) //"Saldo Inicial"
	TRCell():New( oSection1, "nValorX"		,	  ,STR0025+CRLF+STR0026+CRLF+STR0027			   ,cPict		 ,14                     		,, ,"RIGHT"	    , .T.,"CENTER",,0,.F.) //"Adquisición Adicional"
	TRCell():New( oSection1, "NDEPREC"		,"PER",STR0028+CRLF+STR0029+CRLF		         	   ,cPict		 ,14                         	,, ,"RIGHT"	    , .T.,"CENTER",,0,.F.) //"Mejoras"
	TRCell():New( oSection1, "NDEPRBXS"		,"PER",STR0030+CRLF+STR0031+CRLF	 				   ,cPict		 ,14                     		,, ,"RIGHT"	    , .T.,"CENTER",,0,.F.) //"Retira y/o Bajas"
	TRCell():New( oSection1, "NDEPOUT"		,"PER",STR0032+CRLF+STR0033+CRLF+STR0034		       ,cPict		 ,14                         	,, ,"RIGHT"	    , .T.,"CENTER",,0,.F.) //"Otros Ajustes"
	TRCell():New( oSection1, "NHIST"		,"PER",STR0035+CRLF+STR0036+CRLF 					   ,cPict		 ,14                     		,, ,"RIGHT"	    , .T.,"CENTER",,0,.F.) //"Valor del historial del activo fijo al 31.12"

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
Local aColAtv		:= { STR0007,STR0010,STR0013,STR0016,STR0019,STR0022,STR0025 }
Local aColAtv2		:= { STR0008,STR0011,STR0014,STR0017,STR0020,STR0023,STR0026 }
Local aColAtv3		:= { STR0009,STR0012,STR0015,STR0018,STRTRAN(STR0021,"/","."),STR0024,STRTRAN(STR0027,"/",".") }
Local aColDep		:= { STR0028,STR0030,STR0032,STR0035 }
Local aColDep2		:= { STR0029,STR0031,STR0033,STR0036 }
Local aColDep3		:= { ""     ,""     ,STR0034,""      }
Local nInc			:= 0
Local nPosEquiv		:= 0
Local nValor		:= 0
Local cStrFil		:= ""
Local oFont 		:= TFont():New( "Courier New",, -08 )
Local aVert			:= { 5, 130, 250, PIX_INICIAL_VALORES }
Local nIniDin		:= PIX_INICIAL_VALORES					// Pixel redimencionado dinamicamente
Local nLimitrofe	:= 4850
Local aSelFil		:= {}
Local cCampo		:= ""
Local nRowStart		:= 0
Local cFch			:= ""
Local nValorCamb	:= 0
Local cTpCamb3112   := "0.00"
Local oSection1		:= olReport:Section(1) 

Private lPlan       := (olReport:nDevice == 4)
Private aEquivale	:= { "N1_CBASE","N1_AQUISIC","nVOrigX","N1_TXMOEDA","N3VORIG1","nTxMoedX","nDifCambio","nValorX","NDEPREC","NDEPRBXS","NDEPOUT","NHIST" }
Private aTotais		:= {}

// Se aFil nao foi enviada, exibe tela para selecao das filiais
If MV_PAR02 == 1
	aSelFil := AdmGetFil()

	If Len( aSelFil ) <= 0
		Return
	EndIf
	For nInc := 1 To Len( aSelFil )
		cStrFil += "'" + aSelFil[nInc] + "'"
		If nInc < Len( aSelFil )
			cStrFil += ", "
		EndIf
	Next

Else
	cStrFil := Chr(39) +  xFilial('SN1') + Chr(39)

EndIf

//Incluindo condicao de impressao do tipo planilha
if 	lPlan 

	//Define colunas ativas na impressao do tipo planilha
	oSection1:Cell(	"N1_CBASE"		):Enable()	 
	oSection1:Cell(	"N1_AQUISIC"	):Enable()
	oSection1:Cell(	"nVOrigX"		):Enable()	
	oSection1:Cell(	"N1_TXMOEDA"	):Enable()
	oSection1:Cell(	"N3VORIG1"		):Enable()
	oSection1:Cell(	"nTxMoedX"		):Enable()	
	oSection1:Cell(	"nDifCambio"	):Enable()
	oSection1:Cell(	"nValorX"		):Enable()	
	oSection1:Cell(	"NDEPREC"		):Enable()		
	oSection1:Cell(	"NDEPRBXS"		):Enable()	
	oSection1:Cell(	"NDEPOUT"		):Enable()	
	oSection1:Cell(	"NHIST"			):Enable()		

	//Define as bordas do cabeçalho
	oSection1:Cell( "N1_CBASE"		):SetBorder("TOP"		, 1, 000000, .T.)
	oSection1:Cell( "N1_AQUISIC"	):SetBorder("TOP"		, 1, 000000, .T.)
	oSection1:Cell( "nVOrigX"		):SetBorder("TOP"		, 1, 000000, .T.)
	oSection1:Cell( "N1_TXMOEDA"	):SetBorder("TOP"		, 1, 000000, .T.)
	oSection1:Cell( "N3VORIG1"		):SetBorder("TOP"		, 1, 000000, .T.)
	oSection1:Cell( "nTxMoedX"		):SetBorder("TOP"		, 1, 000000, .T.)
	oSection1:Cell( "nDifCambio"	):SetBorder("TOP"		, 1, 000000, .T.)
	oSection1:Cell( "nValorX"		):SetBorder("TOP"		, 1, 000000, .T.)
	oSection1:Cell( "NDEPREC"		):SetBorder("TOP"		, 1, 000000, .T.)
	oSection1:Cell( "NDEPRBXS"		):SetBorder("TOP"		, 1, 000000, .T.)
	oSection1:Cell( "NDEPOUT"		):SetBorder("TOP"		, 1, 000000, .T.)
	oSection1:Cell( "NHIST"			):SetBorder("TOP"		, 1, 000000, .T.)

Endif

// Inicia o array totalizador com zero
aFill( aTotais, 0 )
cStrFil := "%" + cStrFil+ "%"
cFch := "%" +Chr(39) + MV_PAR01 + "1231" + Chr(39) + "%"

BeginSql Alias "PER"
	SELECT N1_CBASE, N1_ITEM, N1_AQUISIC, N1_MOEDAQU, N1_TXMOEDA,N1_PRODUTO,N3_VORIG1,N3_NODIA

	FROM  %table:SN1% SN1,%table:SN3% SN3

	WHERE SN1.N1_CBASE = SN3.N3_CBASE AND
		  SN1. N1_ITEM = SN3.N3_ITEM AND
		  SN1. N1_FILIAL = SN3.N3_FILIAL AND
		  SN1.N1_AQUISIC <=  %Exp:cFch%  AND
		 (SN1.N1_BAIXA = ' '  OR SN1.N1_BAIXA > %Exp:cFch% ) AND
		  SN1.N1_FILIAL IN ( %Exp:cStrFil%  ) AND
		  SN3.%NotDel% AND SN1.%NotDel%

	ORDER BY N1_CBASE, N1_ITEM
EndSql

TCSetField( "PER", "N1_AQUISIC",	"D", 08, 0 )
TCSetField( "PER", "N1_TXMOEDA",	"N", GetSX3Cache("N1_TXMOEDA","X3_TAMANHO"), GetSX3Cache("N1_TXMOEDA","X3_DECIMAL") )
TCSetField( "PER", "N3_VORIG1",		"N", GetSX3Cache("N3_VORIG1", "X3_TAMANHO"), GetSX3Cache("N3_VORIG1", "X3_DECIMAL") )
TCSetField( "PER", "N3_VORIG2",		"N", GetSX3Cache("N3_VORIG2", "X3_TAMANHO"), GetSX3Cache("N3_VORIG2", "X3_DECIMAL") )
TCSetField( "PER", "N3_VRDACM1",	"N", GetSX3Cache("N3_VRDACM1","X3_TAMANHO"), GetSX3Cache("N3_VRDACM1","X3_DECIMAL") )

DbSelectArea( "PER" )
PER->( DbGoTop() )

If PER->( !Eof() )
	FCabR161( olReport, nCol, aColAtv, aColAtv2, aColAtv3, aColDep, aColDep2, aColDep3 ) //Impressão do cabeçalho
	aTotais	:= FR460Array( aEquivale )
EndIf

// Determina o pixel vertical inicial
nRowStart		:= olReport:Row()

PER->(dbGoTop())
olReport:SetMeter( RecCount() )

While PER->(!Eof())
	If olReport:Cancel()
		Exit
	EndIf

	nPosEquiv 	:= PIX_EQUIVALENTE
	For nInc := 1 To Len( aEquivale )
		aVert		:= { 5, PIX_INICIAL_VALORES }
		If nInc > 1
			nPosEquiv 	+= PIX_DIF_COLUNA_VALORES
		EndIf

		If PER->( FieldPos( aEquivale[nInc] ) ) > 0
			If ValType( PER->&( aEquivale[nInc] ) ) == "C"
				olReport:Say( olReport:Row(), nPosEquiv, PER->&( aEquivale[nInc] ), oFont )

			ElseIf ValType( PER->&( aEquivale[nInc] ) ) == "D"
				olReport:Say( olReport:Row(), nPosEquiv, DtoC( PER->&( aEquivale[nInc] ) ),  oFont )

			ElseIf ValType( PER->&( aEquivale[nInc] ) ) == "N"
				If Upper(aEquivale[nInc]) == "N1_TXMOEDA"
					If PER->&( aEquivale[nInc] ) > 0
						olReport:Say( olReport:Row(), nPosEquiv, Transform( PER->&( aEquivale[nInc] ), MASK_TAXA), oFont )
					Else
						olReport:Say( olReport:Row(), nPosEquiv, Transform( RecMoeda(PER->N1_AQUISIC,PER->N1_MOEDAQU), MASK_TAXA), oFont )
					Endif

				Else
					olReport:Say( olReport:Row(), nPosEquiv, Transform( PER->&( aEquivale[nInc] ), MASK_VALOR), oFont )

					// Ajusta os totalizadores
					aTotais[nInc] += PER->&( aEquivale[nInc] )

				Endif

			EndIf

		Else
			aInfo := FRInfoATF( PER->N1_CBASE, PER->N1_ITEM, Val(MV_PAR01 ))
			If !Empty( aInfo )
				If Upper( aEquivale[nInc] ) == "NDEPREC"
					nValor := aInfo[2]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NDEPRBXS"
					nValor := aInfo[3] + aInfo[4]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NDEPOUT"
					nValor := aInfo[6]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NHIST"
					nValor := aInfo[2] + aInfo[3] + aInfo[4] + aInfo[6]
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR), oFont )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "N3VORIG1"		//valor original na moeda 1
					olReport:Say( olReport:Row(), nPosEquiv, Transform( aInfo[7], MASK_VALOR), oFont )
					aTotais[nInc] += aInfo[7]

				ElseIf Upper( aEquivale[nInc] ) == "NVORIGX"		//valor original na moeda de aquisicao
					olReport:Say( olReport:Row(), nPosEquiv, Transform( aInfo[8], MASK_VALOR), oFont )
					aTotais[nInc] += aInfo[8]

				ElseIf Upper( aEquivale[nInc] ) == "NTXMOEDX"
					// Taxa da moeda de aquisicao do ativo no final do perioro (31/12)
					cCampo := "M2_MOEDA1"
					If PER->N1_MOEDAQU > 0
						cCampo := "M2_MOEDA" + AllTrim( Str( PER->N1_MOEDAQU ) )
					EndIf

					DbSelectArea( "SM2" )
					SM2->( DbSetOrder( 1 ) )
					If SM2->(DbSeek(AllTrim(MV_PAR01) + "1231"))
						olReport:Say( olReport:Row(), nPosEquiv, Transform( SM2->&cCampo, MASK_TAXA ), oFont )
						cTpCamb3112 := Transform( SM2->&cCampo, MASK_TAXA )
					EndIf

				ElseIf Upper( aEquivale[nInc] ) == "NDIFCAMBIO"
					// Diferanca de cambio entre "nValorX" e N3VORIG1
					nValor := xMoeda( aInfo[8], PER->N1_MOEDAQU, 1, CtoD( "31/12/" + AllTrim( MV_PAR01) ) )  - aInfo[7]
					nValor += aInfo[5]
					nValorCamb := nValor //variavel que armazena o valor da diferenca de cambio 

					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR ), oFont )
					aTotais[nInc] += nValor

				ElseIf Upper( aEquivale[nInc] ) == "NVALORX"
					// Valor em moeda 1 convertido com a taxa da variavel "nTxMoedX"
					nValor := xMoeda( aInfo[7], PER->N1_MOEDAQU, 1, CtoD( "31/12/" + AllTrim( MV_PAR01) ) )
					olReport:Say( olReport:Row(), nPosEquiv, Transform( nValor, MASK_VALOR ), oFont )
					aTotais[nInc] += nValor

				EndIf
			EndIf


		EndIf

		//Imprime totais no modo de impressao planilla
		If (olReport:nDevice == 4) 
			//Totalizadores
			TRFunction():New(oSection1:Cell("nVOrigX")		,NIL, "SUM", /*oBreak*/, "", "@E 999,999,999.99"	 , /*uFormula*/, .T., .F.)
			TRFunction():New(oSection1:Cell("N3VORIG1")		,NIL, "SUM", /*oBreak*/, "", "@E 999,999,999.99"	 , /*uFormula*/, .T., .F.)
			TRFunction():New(oSection1:Cell("nValorX")		,NIL, "SUM", /*oBreak*/, "", "@E 999,999,999.99"	 , /*uFormula*/, .T., .F.)
		Endif

	Next

		//Impressao dos registros na sessao para o tipo de impressao planilla
		If 	olReport:nDevice == 4 

			oSection1:Cell( "N1_CBASE"		):SetValue(PER->N1_CBASE)
			oSection1:Cell( "N1_AQUISIC"	):SetValue(PER->N1_AQUISIC)
			oSection1:Cell( "nVOrigX"		):SetValue(aInfo[8])
			oSection1:Cell( "N1_TXMOEDA"	):SetValue(RecMoeda(PER->N1_AQUISIC,PER->N1_MOEDAQU)) 
			oSection1:Cell( "N3VORIG1"		):SetValue(Transform( aInfo[7], MASK_VALOR)) 
			oSection1:Cell( "nTxMoedX"		):SetValue(cTpCamb3112)
			oSection1:Cell( "nDifCambio"	):SetValue(nValorCamb)
			oSection1:Cell( "nValorX"		):SetValue(aInfo[7])
			oSection1:Cell( "NDEPREC"		):SetValue(aInfo[2])
			oSection1:Cell( "NDEPRBXS"		):SetValue(aInfo[3] + aInfo[4])
			oSection1:Cell( "NDEPOUT"		):SetValue(aInfo[6])
			oSection1:Cell( "NHIST"			):SetValue(aInfo[2] + aInfo[3] + aInfo[4] + aInfo[6])

			oSection1:PrintLine() 

		Endif

	nIniDin	:= 0
	For nInc := 1 To Len( aTotais )
		nIniDin += PIX_DIF_COLUNA_VALORES
		aAdd( aVert, nIniDin )
	Next

	nLimitrofe := nIniDin
	olReport:Box(olReport:Row()+2,olReport:Col()-004, olReport:Row()+2, nLimitrofe )

	// Imprime a linhas verticais e passa para proxima linha
	FR161Prnt( olReport, aVert )

	//Ajuste de quebra de linhas para o formato planilla
	If !(olReport:nDevice == 4)
		olReport:SkipLine( 1 )
	Endif

	olReport:OnPageBreak( { || FCabR161( olReport, nCol, aColAtv, aColAtv2, aColAtv3, aColDep, aColDep2, aColDep3 ) } )
	If nPag > 80
		If nReg > 0
			FTotR161( olReport, nCol, aTotais )
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
	FTotR161( olReport, nCol, aTotais )
EndIf

If cPaisLoc == "PER"
	If MV_PAR03 == 1
		IF MSGYESNO(STR0043,"") // "¿Confirma la generación del archivo TXT?"
		   Processa({|| GerArq(AllTrim(MV_PAR04))},,STR0044)  // "Generando archivo TXT"
		Endif
	EndIF
EndIf

PER->( DbCLoseArea() )

oSection1:Finish() 

Return olReport

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FCabR161  ³ Autor ³ Totvs                 ³ Data | 06/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cabeçalho do relatorio.								      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FCabR161(Expo1,ExpN1,ExpA1)  				                  ³±±
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
Static Function FCabR161( olReport, nCol, aColAtv, aColAtv2, aColAtv3, aColDep, aColDep2, aColDep3 )
Local nInc			:= 0
Local nColPix		:= olReport:Col() + 10
Local aVert			:= { olReport:Col() + 5, PIX_INICIAL_VALORES }
Local nIniDin		:= PIX_INICIAL_VALORES					// Pixel redimencionado dinamicamente
Local oFont			:= TFont():New( "Courier New",, -08 )
Local nLimitrofe	:= 4850
Local nTamPad		:= 0
Local nCharPCol		:= 16							// Quantidade de caracteres por coluna

Private lPdf       := (olReport:nDevice == 6)


nCol := olReport:Col() + 10
olReport:PrintText( Upper(AllTrim(" 7.3: " + STR0001)),olReport:Row()+35   ,nColPix)                                     // "DETALLE DE LA DIFERENCIA DE CAMBIO"
olReport:PrintText( STR0002 + AllTrim(Str(Year(Date())))	,olReport:Row()+35   ,nColPix)                               // Periodo:
olReport:PrintText( STR0003 + AllTrim( cRUC )											,olReport:Row()+35,nColPix)  // RUC:
olReport:PrintText( STR0004 + AllTrim( Capital( cApellido ) )						,olReport:Row()+40,nColPix) 	 // Apellidos y nombres, denominación o razón social:
olReport:SkipLine( 2 )
olReport:Section(1):Init() //Inicia Sessao

//implementación del método box() cuando la opción es pdf
If lPdf
	olReport:Box(olReport:Row()-004,olReport:Col()-005, olReport:Row()+032, 3001) 
Endif
// Primeira linha
nTamPad	:= Len( aColAtv ) * nCharPCol
olReport:Say( olReport:Row(), nColPix+0130,	PadC( STR0038, nTamPad ),	oFont )		// Ativo Fixo - Coluna 2
nIniDin += ( PIX_DIF_COLUNA_VALORES * Len( aColAtv ) )
aAdd( aVert, nIniDin )

nTamPad	:= Len( aColDep ) * nCharPCol
olReport:Say( olReport:Row(), nIniDin, 			PadC( STR0039, nTamPad ), 	oFont )		// Passivo
nIniDin += ( PIX_DIF_COLUNA_VALORES * Len( aColDep ) )
aAdd( aVert, nIniDin )

nLimitrofe := nIniDin
//Impressao da box para opciones difentes de PDF
If !lPdf
	olReport:Box(olReport:Row()-004,olReport:Col()-004, olReport:Row()+032, nLimitrofe )
Endif
FR161Prnt( olReport, aVert )													// Imprime a linhas verticais e passa para proxima linha
olReport:SkipLine( 1 )

// Segunda linha
// Imprime as contas
nIniDin	:= PIX_INICIAL_VALORES
olReport:Say(olReport:Row(),6,PadC(STR0037,18),oFont)   //"Código"

For nInc := 1 To Len( aColAtv )
	olReport:Say( olReport:Row(), nIniDin, PadC( aColAtv[nInc], 18 ), oFont )
	nIniDin += PIX_DIF_COLUNA_VALORES

	aAdd( aVert, nIniDin )
Next

For nInc := 1 To Len( aColDep )
	olReport:Say( olReport:Row(), nIniDin, PadC( aColDep[nInc], 18 ), oFont )
	nIniDin += PIX_DIF_COLUNA_VALORES

	aAdd( aVert, nIniDin )
Next

FR161Prnt( olReport, aVert )														// Imprime a linhas verticais e passa para proxima linha
olReport:SkipLine( 1 )

// Terceira linha
// Imprime as contas
nIniDin	:= PIX_INICIAL_VALORES
olReport:Say(olReport:Row(),6,PadC(STR0041,18),oFont) //"Vinculado con"

For nInc := 1 To Len( aColAtv2 )
	olReport:Say( olReport:Row(), nIniDin, PadC( aColAtv2[nInc], 18 ), oFont )
	nIniDin += PIX_DIF_COLUNA_VALORES

	aAdd( aVert, nIniDin )
Next

For nInc := 1 To Len( aColDep2 )
	olReport:Say( olReport:Row(), nIniDin, PadC( aColDep2[nInc], 18 ), oFont )
	nIniDin += PIX_DIF_COLUNA_VALORES

	aAdd( aVert, nIniDin )
Next

FR161Prnt( olReport, aVert )														// Imprime a linhas verticais e passa para proxima linha
olReport:SkipLine( 1 )

// Quarta linha
// Imprime as contas
nIniDin	:= PIX_INICIAL_VALORES
olReport:Say(olReport:Row(),6,PadC(STR0042,18),oFont) //  "El activo fijo"

For nInc := 1 To Len( aColAtv3 )
	olReport:Say( olReport:Row(), nIniDin, PadC( aColAtv3[nInc], 18 ), oFont )
	nIniDin += PIX_DIF_COLUNA_VALORES

	aAdd( aVert, nIniDin )
Next

For nInc := 1 To Len( aColDep3 )
	olReport:Say( olReport:Row(), nIniDin, PadC( aColDep3[nInc], 18 ), oFont )
	nIniDin += PIX_DIF_COLUNA_VALORES

	aAdd( aVert, nIniDin )
Next

FR161Prnt( olReport, aVert )														// Imprime a linhas verticais e passa para proxima linha
olReport:SkipLine( 1 )

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FTotR161  ³ Autor ³ Totvs                 ³ Data | 06/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cabeçalho do relatorio.								      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FTotR161(Expo1,ExpN1,ExpA1)  				                  ³±±
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
Static Function FTotR161( olReport, nCol, aTotais )
Local nInc			:= 0
Local nColPix		:= 10
Local aVert			:= { PIX_INICIAL_VALORES }
Local nIniDin		:= 0
Local nValPrnt		:= PIX_EQUIVALENTE
Local oFont			:= TFont():New( "Courier New",, -08 )
Local nLimitrofe	:= 4850

//reserva el valor inicial del vector que se utilizará en el método say() de impresión de registros
aVertBkp := aVert


//Define las dimensiones para la impresión box()
For nInc := 1 To Len( aTotais )
	If nInc > 1
		nValPrnt += PIX_INICIAL_VALORES
	EndIf

	nIniDin += PIX_DIF_COLUNA_VALORES
	aAdd( aVert, nIniDin )
Next

nLimitrofe := nIniDin


//Imprime linhas
olReport:Box(olReport:Row()-007,olReport:Col()-005, olReport:Row()+031, nLimitrofe + 002 )
//Imprime texto totais
olReport:Say( olReport:Row(), nColPix, STR0040, 			oFont )		// Totais

//Recupera valores iniciales para usar posiciones en el método say()
nValPrnt   := PIX_EQUIVALENTE
aVert 	   := aVertBkp

//Imprimir valores totales de columnas definidas
For nInc := 1 To Len( aTotais )
	If nInc > 1
		nValPrnt += PIX_INICIAL_VALORES
	EndIf

	If ValType( aTotais[nInc] ) == "N"
		olReport:Say( olReport:Row(), nValPrnt, Transform(aTotais[nInc], MASK_VALOR ), oFont )
	EndIf
Next

FR161Prnt( olReport, aVert )// Imprime a linhas verticais e passa para proxima linha
olReport:SkipLine( 1 )

Return


/*/
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FR161Prnt ³ Autor ³ Totvs                 ³ Data | 07/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime as linhas verticais e horizontais do relatorio      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FR161Prnt( ExpA1 )         				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA1 = Array com as colunas                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR161Prnt( olReport, aCol )
Local nInc		:= 1
Local nLinPix	:= 34

For nInc := 1 To Len( aCol )
	olReport:Box( olReport:Row(), aCol[nInc], olReport:Row()+nLinPix, aCol[nInc] ) 			// traco vertical
Next

Return

/*/
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FR460Array³ Autor ³ Totvs                 ³ Data | 07/05/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica quais colunas tem totalizadores e retorna array    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³FR460Array( ExpA1 )         				                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA1 = Array com os campos                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR460Array( aEquivale )
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
Local aRet			:= {}
Local aBaixa		:= {}
Local aAreaSN3		:= SN3->( GetArea() )
Local aAreaSN4		:= SN4->( GetArea() )
Local nReaval		:= 0
Local nDeprAcm		:= 0
Local nDeprAcm2		:= 0
Local nDeprBxs		:= 0
Local nDifCambio	:= 0
Local nOutrasDep	:= 0
Local nVlrOrigM1	:= 0
Local nVlrOrigMAq	:= 0
Local nAmpliacao	:= 0
Local nVlrBaixas	:= 0
Local nExerc		:= 0
Local cFilSN4		:= xFilial( "SN4" )

DEFAULT lConsBaixados := .F.

nExerc	:=	nExercicio

DbSelectArea( "SN4" )
SN4->( DbSetOrder( 1 ) ) //N4_FILIAL+N4_CBASE+N4_ITEM+N4_TIPO+DTOS(N4_DATA)+N4_OCORR+N4_SEQ
SN4->( MsSeek( cFilSN4 + cBase + cItem ) )

While SN4->( !Eof() ) .AND. cFilSN4 + cBase + cItem == SN4->( N4_FILIAL + N4_CBASE + N4_ITEM )
	// Desconsidera ativos baixados conforme parametrizacao
	If !lConsBaixados .AND. Year( SN4->N4_DATA ) < nExerc
		SN4->( DbSkip() )
		Loop
	EndIf

	If SN4->N4_TIPO == "01" .And. SN4->N4_OCORR == "05" .AND. SN4->N4_TIPOCNT == "1"		//valor original
		nVlrOrigM1  += SN4->N4_VLROC1
		cCampo := "N4_VLROC1"
		If PER->N1_MOEDAQU > 0
			cCampo := "N4_VLROC" + AllTrim( Str( PER->N1_MOEDAQU ) )
		EndIf
		If SN4->(FieldPos(cCampo)) > 0
			nVlrOrigMAq += SN4->(&cCampo)
		EndIf

	ElseIf  SN4->N4_TIPO == "01" .And. SN4->N4_OCORR == "09" .AND. SN4->N4_TIPOCNT == "1"		//valor ampliacao (ATFA150)
		If nExerc == Year( SN4->N4_DATA )
			nAmpliacao  += SN4->N4_VLROC1
		Endif

	ElseIf SN4->N4_TIPO == "01" .And. SN4->N4_OCORR == "06" .AND. SN4->N4_TIPOCNT == "3"
		// Total da depreciação calculada no exercício.
		If nExerc == Year( SN4->N4_DATA )
			If Ascan(aBaixa,SN4->N4_IDMOV) > 0
				nDeprBxs += SN4->N4_VLROC1
			Else
				nDeprAcm2 += SN4->N4_VLROC1
			Endif
		EndIf

	ElseIf SN4->N4_OCORR == "01" .AND. SN4->N4_TIPOCNT == "1"
		If Ascan(aBaixa,SN4->N4_IDMOV) == 0
			Aadd(aBaixa,SN4->N4_IDMOV)
		Endif
		If nExerc == Year( SN4->N4_DATA )
			nVlrBaixas += SN4->N4_VLROC1
		Endif

	ElseIf SN4->N4_TIPO == "05" .AND. SN4->N4_TIPOCNT == "3"								// Reavaliacoes
		nReaval += SN4->N4_VLROC1

	ElseIf SN4->N4_TIPO == "13" .AND. SN4->N4_OCORR == "05" .AND. SN4->N4_TIPOCNT == "1"	// Diferenca de Cambio das parcelas quitadas
		nDifCambio += SN4->N4_VLROC1

	ElseIf SN4->N4_OCORR == "06" .AND. SN4->N4_TIPOCNT == "3"	// Outras depreciações
		nOutrasDep += SN4->N4_VLROC1

	EndIf

	SN4->( DbSkip() )
End

If nAmpliacao > 0
	nIndice := nAmpliacao / (nVlrOrigM1 - nVlrBaixas)
	nDeprAmpl := Round(nDeprAcm2 * nIndice,GetSX3Cache("N4_VLROC1","X3_DECIMAL"))
	nDeprAcm2 -= nDeprAmpl
	nOutrasDep += nDeprAmpl
Endif

aAdd( aRet, nDeprAcm )					// 01- Depreciacao Acumulada no exercicio anterior
aAdd( aRet, nDeprAcm2 )					// 02- Depreciacao Acumulada no exercicio atual
aAdd( aRet, nDeprBxs )					// 03- Baixas no exercicio atual + reavaliacoes
aAdd( aRet, nReaval )					// 04- Reavaliacoes
aAdd( aRet, nDifCambio )				// 05- Diferenca de Cambio das parcelas quitadas
aAdd( aRet, nOutrasDep )				// 06- Outras depreciações
aAdd( aRet, nVlrOrigM1 )				// 07- Valor original na moeda 1
aAdd( aRet, nVlrOrigMAq )				// 08- Valor original na moeda de aquisicao

RestArea( aAreaSN3 )
RestArea( aAreaSN4 )

Return aRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao     ³ GerArq                                 ³ Data ³ 04.01.2017 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao  ³ Gera o arquivo magnético                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Parametros ³ cDir - Diretorio de criacao do arquivo.                    ³±±
±±³            ³ cArq - Nome do arquivo com extensao do arquivo.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno    ³ Nulo                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso        ³ 7.3 REGISTRO DE ACTIVOS FIJOS - DETALLE DIFERENCIA DE CAMBIO±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GerArq(cDir)
Local nHdl			:= 0
Local cLin			:= ""
Local cSep			:= "|"
Local cArq			:= ""
Local nCont			:= 0
local lConsBaixados	:= .F.
Local cCampo3		:= ""
Local lUsaCbar		:= GetMV( "MV_USACBAR")
Local cVorigx		:= ""
Local cVorig1		:= ""
Local cTxtMoedx		:= ""
Local cDifCambio	:= ""
Local cDeprec		:= ""
Local cDept			:= ""
Local nInc			:= 0
Local aBaixa		:= {}
Local dFechaAnt		:= CtoD("")
Local aInfo			:= {}

cArq += "LE"					// Fixo  'LE'
cArq += AllTrim(cRUC)			// Ruc
cArq += AllTrim(MV_PAR01)		// Ano
cArq += "00"					// Mes Fixo '00'
cArq += "00"					// Fixo '00'
cArq += "070300"				// Fixo '070300'
cArq += "00"					// Fixo '00'
cArq += "1"
cArq += "1"
cArq += "1"
cArq += "1"
cArq += ".TXT"					// Extensao

FOR nCont:=LEN(ALLTRIM(cDir)) TO 1 STEP -1
   IF SUBSTR(cDir,nCont,1)=='\'
      cDir:=Substr(cDir,1,nCont)
      EXIT
   ENDIF
NEXT

nHdl := fCreate(cDir+cArq)

If nHdl <= 0
	ApMsgStop(STR0045) // "Error al generar el archivo TXT"

Else
	dbSelectArea("PER")
	PER->(dbGoTop())

	Do While PER->(!EOF())
		If Val(MV_PAR01) < 2010
			Alert (STR0046)
			fClose(nHdl) // "Para impresión del archivo TXT, el período debe ser igual o superior a 2010"
			return nil
		EndIf

		cLin		:= ""
		aSize(aBaixa, 0)
		nReaval		:= 0
		nDeprAcm	:= 0
		nDeprAcm2	:= 0
		nDeprBxs	:= 0
		nDifCambio	:= 0
		nOutrasDep	:= 0
		nVlrOrigM1	:= 0
		nVlrOrigMAq	:= 0
		nAmpliacao	:= 0
		nVlrBaixas	:= 0
		nExerc		:= 0
		nExercicio	:= Val(MV_PAR01)

		DEFAULT lConsBaixados := .F.
		nExerc		:= nExercicio

		DbSelectArea( "SN4" )
		SN4->( DbSetOrder(1) )
		SN4->( DbSeek( xFilial( "SN4" ) + PER->N1_CBASE + PER->N1_ITEM ) )

		While SN4->( !Eof() ) .AND. xFilial( "SN4" ) + PER->N1_CBASE + PER->N1_ITEM == SN4->( N4_FILIAL + N4_CBASE + N4_ITEM )
			If !lConsBaixados .AND. YEAR(SN4->N4_DATA) < nExerc
				SN4->( DbSkip() )
				Loop
			EndIf

			If SN4->N4_TIPO == "01" .And. SN4->N4_OCORR == "05" .AND. SN4->N4_TIPOCNT == "1"		//valor original
				nVlrOrigM1  += SN4->N4_VLROC1
				cCampo := "N4_VLROC1"
				If PER->N1_MOEDAQU > 0
					cCampo := "N4_VLROC" + AllTrim( Str( PER->N1_MOEDAQU ) )
				EndIf
				If SN4->(FieldPos(cCampo)) > 0
					nVlrOrigMAq += SN4->(&cCampo)
				EndIf

			ElseIf  SN4->N4_TIPO == "01" .And. SN4->N4_OCORR == "09" .AND. SN4->N4_TIPOCNT == "1"		//valor ampliacao (ATFA150)
				If nExerc == YEAR(SN4->N4_DATA)
					nAmpliacao  += SN4->N4_VLROC1
				Endif

			ElseIf SN4->N4_TIPO == "01" .And. SN4->N4_OCORR == "06" .AND. SN4->N4_TIPOCNT == "3"
				// Total da depreciação calculada no exercício.
				If nExerc == YEAR(SN4->N4_DATA)
					If Ascan(aBaixa,SN4->N4_IDMOV) > 0
						nDeprBxs += SN4->N4_VLROC1
					Else
						nDeprAcm2 += SN4->N4_VLROC1
					Endif
				EndIf

			ElseIf SN4->N4_OCORR == "01" .AND. SN4->N4_TIPOCNT == "1"
				If Ascan(aBaixa,SN4->N4_IDMOV) == 0
					Aadd(aBaixa,SN4->N4_IDMOV)
				Endif
				If nExerc == YEAR(SN4->N4_DATA)
					nVlrBaixas += SN4->N4_VLROC1
				Endif

			ElseIf SN4->N4_TIPO == "05" .AND. SN4->N4_TIPOCNT == "3"								// Reavaliacoes
				nReaval += SN4->N4_VLROC1

			ElseIf SN4->N4_TIPO == "13" .AND. SN4->N4_OCORR == "05" .AND. SN4->N4_TIPOCNT == "1"	// Diferenca de Cambio das parcelas quitadas
				nDifCambio += SN4->N4_VLROC1

			ElseIf SN4->N4_OCORR == "06" .AND. SN4->N4_TIPOCNT == "3"	// Outras depreciações
				nOutrasDep += SN4->N4_VLROC1

			EndIf

			SN4->( DbSkip() )
		EndDo

		If nAmpliacao > 0
			nIndice := nAmpliacao / (nVlrOrigM1 - nVlrBaixas)
			nDeprAmpl := Round(nDeprAcm2 * nIndice,GetSX3Cache("N4_VLROC1","X3_DECIMAL"))
			nDeprAcm2 -= nDeprAmpl
			nOutrasDep += nDeprAmpl
		Endif

		cLin := ""

		//01 - Periodo
		cLin += AllTrim(MV_PAR01)+"0000"
		cLin += cSep

		//02 - Código Único de la Operación (CUO)
		cLin += ALLTRIM(PER->N3_NODIA)
        cLin += cSep

		//03 - Número correlativo del asiento contable identificado en el campo 2.
		cCampo3 := Right(AllTrim(PER->N3_NODIA),9)
		cCampo3 := Strtran( PadL(cCampo3,9), Space(1), "0")
		cLin += "M" + cCampo3
		cLin += cSep

		//04 - Código del catálogo utilizado. Sólo se podrá incluir las opciones 3 y 9 de la tabla 13.
		DbSelectArea("SB1")
        SB1->(DbSetOrder(1))
		SB1->(MsSeek(xFilial("SB1")+PER->N1_PRODUTO))
		If lUsaCbar .And. AllTrim(SB1->B1_CODBAR) != ""
			cLin += "3"
		Else
			cLin += "9"
		EndIf
		cLin += cSep

		//05 - Código propio del activo fijo correspondiente al catálogo señalado en el campo 4.
		If lUsaCbar .And. AllTrim(SB1->B1_CODBAR) != ""
			cLin += AllTrim(SB1->B1_CODBAR)
		Else
			cLin += AllTrim(PER->N1_CBASE)
		EndIf
		cLin += cSep

		//06 - Fecha de adquisición del Activo Fijo
        cLin += SubStr(DTOC(PER->N1_AQUISIC),1,6)+SubStr(DTOS(PER->N1_AQUISIC),1,4)
        cLin += cSep

		aInfo := FRInfoATF( PER->N1_CBASE, PER->N1_ITEM, Val(MV_PAR01))
		For nInc := 1 To Len( aEquivale )
			If Upper( aEquivale[nInc] ) == "NVORIGX"        //07 - Valor de adquisición del Activo Fijo en moneda extranjera
         		cVorigx	   := AllTrim(Transform(aInfo[8],"@E 999999999.99"))
			ElseIf Upper( aEquivale[nInc] ) == "N3VORIG1"   //09 - Valor de adquisición del Activo Fijo en moneda nacional
         		cVorig1    := AllTrim(Transform(aInfo[7],"@E 999999999.99"))
			ElseIf Upper( aEquivale[nInc] ) == "NTXMOEDX"   //10 - Tipo de cambio de la moneda extranjera al 31.12 del periodo que corresponda
				If DtoS(dFechaAnt) <> (AllTrim(MV_PAR01) + "1231")
					LimpaMoeda()	// Reset de fecha en RecMoeda()
					dFechaAnt := StoD(AllTrim(MV_PAR01) + "1231")
				EndIf
         		cTxtMoedx := AllTrim(Str(RecMoeda(StoD(AllTrim(MV_PAR01) + "1231"),PER->N1_MOEDAQU, .T.),7,3))
         	ElseIf Upper( aEquivale[nInc] ) == "NDIFCAMBIO" //11 - Ajuste por diferencia de cambio del Activo Fijo
         		cDifCambio := AllTrim(Transform(aTotais[nInc],"@E 999999999.99"))
         	ElseIf Upper( aEquivale[nInc] ) == "NDEPREC"    //12 - Depreciación del ejercicio
         		cDeprec    := AllTrim(Transform(aTotais[nInc],"@E 999999999.99"))
         	ElseIf Upper( aEquivale[nInc] ) == "NDEPRBXS"   //13 - Depreciación del ejercicio relacionada, con los retiros y/o bajas del Activo Fijo
         		cDept      := AllTrim(Transform(aTotais[nInc],"@E 999999999.99"))
         	EndIf
		Next

		//07 - Valor de adquisición del Activo Fijo en moneda extranjera
		cLin += cVorigx
		cLin += cSep

		//08 - Tipo de cambio de la moneda extranjera en la fecha de adquisición
		If PER->N1_TXMOEDA > 0
			cLin += AllTrim(Str(PER->N1_TXMOEDA,7,3))
		ElseIf PER->N1_MOEDAQU > 0
			If PER->N1_AQUISIC <> dFechaAnt
				LimpaMoeda()	// Reset de fecha en RecMoeda()
				dFechaAnt := PER->N1_AQUISIC
			EndIf
			cLin += AllTrim(Str(RecMoeda(PER->N1_AQUISIC,PER->N1_MOEDAQU),7,3))
		Else
			cLin += "1.000"
		EndIf
		cLin += cSep

		//09 - Valor de adquisición del Activo Fijo en moneda nacional
		cLin += cVorig1
		cLin += cSep

		//10 - Tipo de cambio de la moneda extranjera al 31.12 del periodo que corresponda
		cLin += cTxtMoedx
		cLin += cSep

		//11 - Ajuste por diferencia de cambio del Activo Fijo
		cLin += cDifCambio
		cLin += cSep

		//12 - Depreciación del ejercicio
		cLin += cDeprec
		cLin += cSep

		//13 - Depreciación del ejercicio relacionada, con los retiros y/o bajas del Activo Fijo
		cLin += cDept
		cLin += cSep

		//14 - Depreciación relacionada con otros ajustes
		cLin += "0.00"
		cLin += cSep

		//15 - Indica el estado de la operación
		cLin += "1"
		cLin += cSep

		cLin += chr(13)+chr(10)

		fWrite(nHdl,cLin)
		PER->(dbSkip())
	EndDo

	fClose(nHdl)
	MsgAlert(STR0047,"") // "Archivo TXT generado con éxito"
EndIf

Return Nil
