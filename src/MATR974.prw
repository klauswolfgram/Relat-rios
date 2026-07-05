/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR974.CH"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMATR974   บAutor  ณMary C. Hergert     บ Data ณ 08/10/2007  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio de restituicao de ICMS ST de Minas Gerais, nos    บฑฑ
ฑฑบ          ณmoldes dos registros 88 do Sintegra.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigafis                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Matr974(aFRT,aRST,lGera)  

If lGera
	Matr974R3(aFRT,aRST)
Else
    Alert("O Relatorio de restituicao de ICMS ST de Minas Gerais serแ impresso no final do processamento da rontina do SINTEGRA, pois se trata de um relat๓rio de confer๊ncia do registro 88 do Sintegra de MG.")
EndIF		


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMATR974R3 บAutor  ณMary C. Hergert     บ Data ณ 08/10/2007  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio de restituicao de ICMS ST de Minas Gerais, nos    บฑฑ
ฑฑบ          ณmoldes dos registros 88 do Sintegra. - Release 3            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณMatr974                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Matr974R3(aFRT,aRST)

Local Titulo    := OemToAnsi(STR0001)  	// "Restitui็ใo de ICMS ST - Minas Gerais"
Local cDesc1    := OemToAnsi(STR0002) 	// "Este programa ira emitir as listagens necessแrias aos pedidos de"
Local cDesc2    := OemToAnsi(STR0003)  	// "restitui็ใo de ICMS Substitui็ใo Tributแria เ Secretaria da Fazenda de"
Local cDesc3    := OemToAnsi(STR0004)  	// "Minas Gerais, conforme solicita็ใo da fiscaliza็ใo fazendแria."
Local lDic    	:= .F. 					// Habilita/Desabilita Dicionario
Local lComp    	:= .F. 					// Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro  	:= .F. 					// Habilita/Desabilita o Filtro
Local wnrel     := "MATR974"  			// Nome do Arquivo utilizado no Spool
Local nomeprog  := "MATR974"  			// nome do programa
Local cString	:= "SB1"

Local dDataIni	:= ""
Local dDataFin	:= ""
Local dDataFech	:= ""

Private Tamanho := "G"					// P/M/G
Private Limite  := 220					// 80/132/220
//Private cPerg   := "MAT"				// Pergunta do Relatorio
Private aReturn := {STR0005,1,STR0006,1,2,1,"",1}	//"Zebrado"###"Administracao"

Private lEnd    := .F.					// Controle de cancelamento do relatorio
Private m_pag   := 1  					// Contador de Paginas
Private nLastKey:= 0  					// Controla o cancelamento da SetPrint e SetDefault
Default aFRT    := {}
Default aRST	:= {}

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณEnvia para a SetPrint                                                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel:=SetPrint(cString,wnrel,,@titulo,cDesc1,cDesc2,cDesc3,lDic,"",lComp,Tamanho,lFiltro,.F.)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	dbClearFilter()
	Return
Endif

SetDefault(aReturn,cString)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	dbClearFilter()
	Return
Endif 

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica os movimentos de saida, de entrada e de estoque.                                     ณ
//ณA regra para restituicao eh a seguinte:                                                       ณ
//ณNo periodo, verificam-se todas as saidas interestaduais ou isentas                            ณ
//ณNo periodo, verificam-se todas as entradas interestaduais dos produtos que foram vendidos     ณ
//ณVerifica-se o estoque de fechamento dos produtos vendidos (o sistema ira retroagir as entradasณ
//ณate que seja possivel compor a quantidade existente hoje em estoque)                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dDataIni	:= mv_par01
dDataFin	:= mv_par02
dDataFech	:= mv_par15
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณImprime o relatorioณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,nomeprog,Titulo,dDataFech,dDataIni,dDataFin,@aFRT,@aRST)},Titulo)


Set Device To Screen
Set Printer To

If (aReturn[5] = 1)
	dbCommitAll()
	OurSpool(wnrel)
Endif 
MS_FLUSH()


Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpDet    บAutor  ณMary C. Hergert     บ Data ณ 28/09/2004  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime o detalhe do relatorio                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณMatr927                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpDet(lEnd,wnRel,cString,nomeprog,Titulo,dDataFech,dDataIni,dDataFin,aFRT,aRST)

Local aLay	    := {}

Local lHouveMov	:= .F.                                  

Local nLinha	:= 80                          
Local nValST	:= 0
Local nValICMS	:= 0
Local nNumPag	:= 1
Local nPos		:= 0
Local nQtdeTot  := 0       
Local nSTTot	:= 0
Local nICMSTot  := 0
Local nCredita  := 0
Local nRestitui := 0
Local aImp		:= {}
Local nPosImp   := 0

Local nx		:= 0
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณArray R88STITNF  ณ
//ณaRFT: 		    ณ
//ณ[01] = FRT_PRODUTณ
//ณ[02] = FRT_QUANT ณ
//ณ[03] = FRT_VALICMณ
//ณ[04] = FRT_VALST ณ
//ณ[05] = Qtd Saida ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณArray RST(Estoque)  ณ
//ณaRST:		       ณ
//ณ[01] = RST->CODPRD  ณ
//ณ[02] = RST->QUANT   ณ
//ณ[03] = RST->ICMSRET ณ
//ณ[04] = RST->VALICMS ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณRetornando o layout de acordo com o modelo a ser impressoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aLay := RetLayOut()

For nx := 1 To Len(aFRT)       

   	// IncRegua()
	If Interrupcao(@lEnd)
	    Exit
 	Endif
    
    // Verifica o registro correspondente no array dos valores do estoque 
	nPos := aScan(aRST,{|x| Alltrim(x[1]) == Alltrim(aFRT[nx][1])})
	
	// Incrementa e Ordena o array que sera impresso		
	nPosImp:= aScan(aImp,{|x| Alltrim(x[1])== Alltrim(aFRT[nX][1])})
	If nPosImp == 0    
		aadd(aImp,{aFRT[nx][1],; 			// Codigo
		Iif(nPos > 0,aRST[nPos][2],0),; 	// Qtd Estoque
		Iif(nPos > 0,aRST[nPos][3],0),;	// Val ST Estoque
		Iif(nPos > 0,aRST[nPos][4],0),;	// Val Proprio Estoque
		Iif(aFRT[nx][6],aFRT[nx][2],0),;	// Qtde Entrada
		Iif(aFRT[nx][6],aFRT[nx][4],0),;	// Val ST Entrada
		Iif(aFRT[nx][6],aFRT[nx][3],0),;	// Val Proprio Entrada
		aFRT[nx][5],;						// Qtde Saida
		0,;									// Tot Qtde
		0,;									// Tot ST
		0,;									// Tot Proprio
		0,;									// Ressarcir
		0})									// Restituir
	Else
		aImp[nPosImp][5] += Iif(aFRT[nx][6],aFRT[nx][2],0)
		aImp[nPosImp][6] += Iif(aFRT[nx][6],aFRT[nx][4],0)
		aImp[nPosImp][7] += Iif(aFRT[nx][6],aFRT[nx][3],0)
	EndIf

Next nX

For nX := 1 to Len(aImp)
   
		// Calcular os Totais e valor da Restituicao
		nQtdeTot 	:= aImp[nX][5]
		nSTTot   	:= aImp[nX][6]
		nICMSTot 	:= aImp[nX][7]
		
		nCredita 	:= (nICMSTot / nQtdeTot) * aImp[nX][8]
		nRestitui 	:= (nSTTot / nQtdeTot) * aImp[nX][8]
		
		//Limita valor a resituir a quantidade de entrada
		IF nQtdeTot	<   aImp[nX][8]
			nRestitui := nSTTot
			nCredita  := nICMSTot
		Endif
		
		aImp[nX][9] += aImp[nX][2]
		aImp[nX][10]+= aImp[nX][3]
		aImp[nX][11]+= aImp[nX][4]
		aImp[nX][12]+= nRestitui
		aImp[nX][13]+= nCredita
	
		nValST		+= nRestitui
		nValICMS	+= nCredita
	
Next 

// Ordena o Array de impressao pelo produto  

ASort( aImp, , , { |x,y| y[1] > x[1] } ) 

For nX :=1 To Len(aImp)
	If Interrupcao(@lEnd)
	    Exit
 	Endif
 	If nLinha > 60
		If nLinha <> 80
			FmtLin({},aLay[12],,,@nLinha)
			FmtLin({Transform(nValST,"@E 9999999999.99"),Transform(nValICMS,"@E 9999999999.99")},aLay[14],,,@nLinha)
			FmtLin({},aLay[16],,,@nLinha)
		Endif
		Mtr974Cab(@nLinha,dDataIni,dDataFin,@nNumPag,dDataFech)
	Endif
	
		FmtLin({SubStr(aImp[nX][1],1,15),;
			Transform(aImp[nX][2]  ,	"@E 99999999999.99"),;
			Transform(aImp[nX][3]  ,	"@E 99999999999.99"),;
			Transform(aImp[nX][4]  ,	"@E 99999999999.99"),;
			Transform(aImp[nX][5]  ,	"@E 99999999999.99"),;
			Transform(aImp[nX][6]  ,	"@E 99999999999.99"),;
			Transform(aImp[nX][7]  ,	"@E 99999999999.99"),;
			Transform(aImp[nX][8]  ,	"@E 99999999999.99"),; 
			Transform(aImp[nX][9]  ,	"@E 99999999999.99"),;
			Transform(aImp[nX][10] ,	"@E 99999999999.99"),;
			Transform(aImp[nX][11] ,	"@E 99999999999.99"),;
			Transform(aImp[nX][12] ,	"@E 9999999999.99"),;
			Transform(aImp[nX][13] ,	"@E 9999999999.99")},;
			aLay[11],,,@nLinha)
			
	lHouveMov := .T.

Next nX
 	

If !lHouveMov 
	Mtr974Cab(@nLinha,dDataIni,dDataFin,@nNumPag,dDataFech)
	FmtLin({},aLay[15],,,@nLinha)
Else                              
	FmtLin({},aLay[12],,,@nLinha)
	FmtLin({Transform(nValST,"@E 9999999999.99"),Transform(nValICMS,"@E 9999999999.99")},aLay[13],,,@nLinha)
Endif

FmtLin({},aLay[16],,,@nLinha)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMtr974Cab  บAutor  ณMary C. Hergert     บ Data ณ 08/10/2007  บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCabecalho do relatorio                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณMatr974                                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Mtr974Cab(nLinha,dDataIni,dDataFin,nNumPag,dDataFech)

Local aLay	:= RetLayOut()  

Local cDataIni 	:= StrZero(Day(dDataIni),2) + "/" + StrZero(Month(dDataIni),2) + "/" + StrZero(Year(dDataIni),4)
Local cDataFin 	:= StrZero(Day(dDataFin),2) + "/" + StrZero(Month(dDataFin),2) + "/" + StrZero(Year(dDataFin),4)
Local cDataFech	:= StrZero(Day(dDataFech),2) + "/" + StrZero(Month(dDataFech),2) + "/" + StrZero(Year(dDataFech),4)

If nLinha > 60        
	nLinha := 1         
	FmtLin({},aLay[01],,,@nLinha)	
	FmtLin({SM0->M0_NOMECOM},aLay[02],,,@nLinha)
	FmtLin({SM0->M0_INSC},aLay[03],,,@nLinha)
	FmtLin({Transform(SM0->M0_CGC,"@R! NN.NNN.NNN/NNNN-99")},aLay[04],,,@nLinha)
	FmtLin({cDataIni,cDataFin},aLay[05],,,@nLinha)
	FmtLin({cDataFech},aLay[17],,,@nLinha)
	FmtLin({StrZero(nNumPag,6)},aLay[06],,,@nLinha)
	FmtLin({},aLay[07],,,@nLinha)
	FmtLin({},aLay[08],,,@nLinha)
	FmtLin({},aLay[18],,,@nLinha)
	FmtLin({},aLay[19],,,@nLinha)
	FmtLin({},aLay[09],,,@nLinha)
	FmtLin({},aLay[10],,,@nLinha)	
	nNumPag ++
Endif

Return .T.
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณRetLayOut | Autor ณ Mary C. Hergert       ณ Data ณ08/10/2007ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณRetorna o LayOut a ser impresso                             ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณArray com o LayOut                                          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ   DATA   ณ Programador   ณManutencao Efetuada                         ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function RetLayOut()

Local aLay := Array(20)      

aLay[01] := STR0008 //	"RESTITUICAO DE ICMS ST E ICMS OP"                                                                               
aLay[02] := STR0009 //	"Razao Social: ########################################"
aLay[03] := STR0010 //	"IE:           ##############"
aLay[04] := STR0011 //	"CNPJ:         ##################"         
aLay[05] := STR0012 //	"Periodo:      ########## a ##########"
aLay[17] := STR0035 //	"Inventario:   ##########"
aLay[06] := STR0013 //	"RESUMO GERAL POR PRODUTO                                                                                                                                                                                     Pagina: ###### "
					//	0         10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220                                    
					//	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
aLay[07] := 			"+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+"
aLay[08] := STR0037 //	"|                 |                   INVENTARIO                     |               ENTRADAS DO PERIODO               | SAIDAS PERIODO |                      TOTAIS                      |         RESSARCIMENTO         |"
aLay[18] := STR0036 //	"|    CODIGO DO    |----------------+----------------+----------------+---------------+----------------+----------------+----------------+----------------+----------------+----------------+-------------------------------|"
aLay[19] := STR0014 //	"|     PRODUTO     |     Quantidade |  Valor ICMS ST |  Valor ICMS Op |    Quantidade |  Valor ICMS ST |  Valor ICMS Op |     Quantidade |     Quantidade |  Valor ICMS ST |  Valor ICMS Op |       VALOR A |      VALOR DO |"
aLay[09] := STR0015 //	"|                 |                |                |        Propria |               |                |        Propria |                |                |        Propria |                |     RESTITUIR |       CREDITO |"
aLay[10] := 			"|-----------------+----------------+----------------+----------------+---------------+----------------+----------------+----------------+----------------+----------------+----------------+---------------+---------------|"
aLay[11] := STR0016 //	"| ############### | ############## | ############## | ############## | ############# | ############## | ############## | ############## | ############## | ############## | ############## | ############# | ############# |"
aLay[12] := 			"|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------+---------------|"
aLay[13] := STR0017 //	"|                                                                                                                                                                                    Total | ############# | ############# |"	
aLay[14] := STR0018 //	"|                                                                                                                                                                            A Transportar | ############# | ############# |"		
aLay[15] := STR0019 //	"| NAO EXISTEM VALORES DE RESTITUICAO NO PERIODO                                                                                                                                                                            |"
aLay[16] := 			"+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+" 

Return(aLay)                                                           

