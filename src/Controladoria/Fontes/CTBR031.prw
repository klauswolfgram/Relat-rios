/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR031.CH"
#INCLUDE "PROTHEUS.CH"

// 17/08/2009 -- Filial com mais de 2 caracteres

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ CTBR031  ณ Autor ณ Alexandre       Silva ณ Data ณ17/02/2003ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Este relatorio tem o obejtivo de uma mostrar a lista de    ณฑฑ
ฑฑณDescri…o ณ correlativos bem com seus respectivos lancamentos          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ Void U_CTBR031(void)                                         ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CTBR031()

Local cTitulo 		:= FunDesc()
Local nMoeda

Private cPerg	 	:= "CTR031"
Private nomeProg 	:= "CTBR031"
Private oFont08	:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)//Nao mudar o nome da fonte (oFont8 e oFont10)
Private oFont10	:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)//compatibilidade com as funcoes ctbxfun
Private oArial08	:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
Private oArial10	:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
Private oArial10N	:= TFont():New("Arial",10,10,,.T.,,,,.T.,.F.)
Private oArial14N	:= TFont():New("Arial",14,14,,.T.,,,,.T.,.F.)
Private oPrint		:= TMSPrinter():New(cTitulo )
Private oPen		:= TPen():New(,7,CLR_BLACK,oPrint)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Descricao dos parametros               ณ
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ mv_par01	// Correlativo de           ณ
//ณ mv_par02	// Correlativo ate          ณ
//ณ mv_par03	// Sublote de               ณ
//ณ mv_par04	// sublote ate              ณ
//ณ mv_par05	// Data de                  ณ
//ณ mv_par06	// Data Ate                 ณ
//ณ mv_par07	// Moeda                    ณ
//ณ mv_par08	// Cod. Config. Livros      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณConfigura o tipo da pagina.       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oPrint:SetPortrait()

If Pergunte(cPerg,.T.)
	nMoeda := Val(mv_par07)
	cTitulo += " - " + GetMv("MV_MOEDA"+STR(nMoeda,1))
	MsgRun(STR0001,"",{|| CursorWait(), U_Ctr031Det(cTitulo) ,CursorArrow()}) //"Gerando relatorio, aguarde..."
Endif

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบProgram   ณCtr031Det บAuthor ณAlexandre Silva     บ Date ณ  17-02-03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera o detalhe  para o relatorio                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUse       ณ AP7                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Ctr031Det(cTitulo)

Local nValor		:= 0
Local nLin 			:= 2901
Local nPag			:= 1
Local nMoeda		:= Val(mv_par07)
Local cCorrel		:= ""  
Local cDocCT2		:= ""
Local cCT2Chave	:= ""
Local cCorrelIm	:= ""
Local cValPict		:= PesqPict("CT2","CT2_VALOR", 20)
Local cMascara		:= ""
Local cSeparador	:= ""
Local aCabCor  	:= {}// Guarda as caracteristicas do 1 cabecalho, Coluna,Texto,Fonte
Local aCabOri  	:= {}// Guarda as caracteristicas do 2 cabecalho, Coluna,Texto,Fonte
Local aCtkSel		:= {}// Guarda o numero dos registros para posterior consulta.
Local aSetOfBook 	:= CTBSetOf(mv_par08)

If Empty(aSetOfBook[2])
	cMascara := GetMv("MV_MASCARA")
Else
	cMascara := RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf

dbSelectArea("CT2")
DBOrderNickName("CT2CORRELA")

DbSeek( xFilial("CT2")+mv_par01,.T.)

Do While CT2_FILIAL == xFilial("CT2") .And. !Eof() .And. CT2_SEGOFI >= mv_par01 .And. CT2_SEGOFI <= mv_par02
   
   If nLin > 2900
		Ctr031Cab(cTitulo,@nPag,@aCabCor,@nLin)		
	EndIf
	
	nValor	:= xMoeda(CT2_VALOR,Val(CT2_MOEDLC),nMoeda,CT2_DATA,MsDecimais(nMoeda))
	cCorrel  := CT2_SEGOFI
	cDocCT2	:= CT2_LOTE+"-"+CT2_DOC
	cCT2Chave:= xFilial("CT2")+CT2_SEQUEN+CT2_LP

	If !(CT2_SBLOTE >= mv_par03 .And. CT2_SBLOTE <= mv_par04)
		dbskip()
		Loop
	ElseIf !(DTOS(CT2_DATA) >= DtoS(mv_par05) .And. DTOS(CT2_DATA) <= DtoS(mv_par06))
		dbskip()
		Loop
	EndIf

	dbSkip()

	If cCT2Chave != xFilial("CT2")+CT2_SEQUEN+CT2_LP
		dbSelectArea("CTK")
		dbSetOrder(1)
		If DbSeek(cCT2Chave) .And.! Empty(CTK_KEY)
			aCtkSel	:= {}
			Do While xFilial("CTK")+CTK_SEQUEN+CTK_LP == cCT2Chave
				AADD(aCtkSel,Recno())
				If cCorrel != cCorrelIm 
					oPrint:Say(nLin,aCabCor[1,1],cCorrel			,oArial10)
					oPrint:Say(nLin,aCabCor[2,1],CTK_SBLOTE		,oArial10)
					oPrint:Say(nLin,aCabCor[3,1],Dtoc(CTK_DATA)	,oArial10)
					oPrint:Say(nLin,aCabCor[4,1],cDocCT2 			,oArial10)
					EntidadeCTB(CTK_DEBITO,nLin,aCabCor[5,1],23,.F.,cMascara,cSeparador,,,.T.,oPrint)
					EntidadeCTB(CTK_CREDIT,nLin,aCabCor[6,1],23,.F.,cMascara,cSeparador,,,.T.,oPrint)
					oPrint:Say(nLin,aCabCor[7,1],lTrim(Trans(nValor,cValPict)),oArial10)
					oPrint:Say(nLin,aCabCor[8,1],Substr(CTK_HIST,1,34)			,oArial10)
					nLin += 30                                         
				EndIf				
				cCorrelIm := cCorrel
				dbSkip()
			EndDo
			If Len(aCtkSel)>0
				CtrDetOri(aCtkSel,@aCabOri,@nLin)
			EndIf
			cCorrelIm := ""
			nLin += 50
			oPrint:Line(nLin,30,nLin,2380 )   	// horizontal                          			
			dbSelectArea("CTK")
			If nLin > 2900
				U_CtbR031Rod(oPrint,nLin)
			EndIf				
		EndIf
	EndIf		
	dbSelectArea("CT2")
	DbSetOrder(1)
EndDo

U_CtbR031Rod(oPrint,2900)
oPrint:Preview()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณCtr031Cab บAutor  ณAlexandre Silva     บFecha ณ  17/02/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime o cabecalho do relatorio                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGACTB                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Ctr031Cab(cTitulo,nPag,aCabCor,nLin)		

Local nCol 	:= 40
Local nx		:= 0
nLin := 300

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:Box(075,030,250,2380)
oPrint:SayBitmap(080,050, "\Bitmaps\LogoSiga.bmp",300,150) // Tem que estar abaixo do RootPath
oPrint:Say(080,2050,RptFolha + TRANSFORM(nPag,'999999'),oFont08 )
oPrint:Say(170,050,"SIGA/"+nomeprog+"/v."+cVersao,oFont08)
oPrint:Say(140,2050,RptDtRef+Dtoc(Date()),oFont08)        
oPrint:Say(140,(2350 - (Len(cTitulo) * 16)) / 2,cTitulo,oArial14N )
oPrint:Say(200,050,RptHora +time(),oFont08)
oPrint:Say(185,2050,RptEmiss+DTOC(dDataBase),oFont08)                  

If Len(aCabCor) == 0
	AADD(aCabCor,{nCol+=000,Rtrim(RetTitle("CT2_SEGOFI"))	})
	AADD(aCabCor,{nCol+=260,Rtrim(RetTitle("CTK_SBLOTE"))	})
	AADD(aCabCor,{nCol+=160,Rtrim(RetTitle("CTK_DATA"))		})
	AADD(aCabCor,{nCol+=260,Rtrim(RetTitle("CT2_DOC"))		})
	AADD(aCabCor,{nCol+=270,Rtrim(RetTitle("CTK_DEBITO"))	})
	AADD(aCabCor,{nCol+=230,Rtrim(RetTitle("CTK_CREDIT"))	})
	AADD(aCabCor,{nCol+=270,Rtrim(RetTitle("CT2_VALOR"))	})
	AADD(aCabCor,{nCol+=160,Rtrim(RetTitle("CTK_HIST"))		})
EndIf

oPrint:Box(nLin-30,030,nLin+50,2380 )

For nX = 1 to Len(aCabCor)
	oPrint:Say(nLin,aCabCor[nX,1],aCabCor[nX,2],oArial10N)                  
Next Nx

nLin += 60
nPag++

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณCtr031Cab บAutor  ณAlexandre Silva     บFecha ณ  18/02/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFaz a impressao do cabecalho de origem do lancamento a      บฑฑ
ฑฑบDesc.     ณpartir do CTL.                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGACTB                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CtrDetOri(aCtkSel,aCabOri,nLin)		

Local aArea 	:= GetArea()

Local aCabPos	:= {0}
Local	nPosMark	:= 0
Local nPosCab	:= 0
Local nCol		:= 20
Local cChave	:= ""
Local cChaveTmp:= ""
Local nX			:= 0
Local nY			:= 0

CTK->(dbGoto(aCtkSel[1]))

dbSelectArea("CTL")
dbSetOrder(1)
dbSeek(xFilial("CTL")+CTK->CTK_LP)

If (nPosCab := Ascan(aCabOri,{|x| x[1] == CTL_ALIAS})) == 0

	AADD(aCabOri,{ CTL_ALIAS})
	
	cChave 	:= rTrim( CTL_KEY)+"+"
	nPosMark := At("+",cChave)
	nPosCab 	:= Len(aCabOri)

	Do While nPosMark > 0 
		cChaveTmp := Substr(cChave,1,nPosMark-1)
		If !("_FILIAL" $ cChaveTmp)
			AADD(aCabOri[nPosCab],{cChaveTmp,Alltrim(RetTitle(cChaveTmp)),TamSx3(cChaveTmp)[1]+TamSx3(cChaveTmp)[2]})
	   EndIf
		cChave := Right(cChave,Len(cChave)-nPosMark)
		nPosMark := At("+",cChave)
	EndDo

Endif

//Impressao do cabecalho 2
nLin += 40

oPrint:Say(nLin,040,STR0002,oArial08)
oPrint:Say(nLin,nCol+=130,Substr(CTL_DESC,1,20),oArial08)
nCol += 400

For nX = 2 To Len(aCabOri[nPosCab])
	AADD(aCabPos,nCol)
	oPrint:Say(nLin,nCol,aCabOri[nPosCab,nX,2],oArial08)                  
	nCol += iIf(aCabOri[nPosCab,nX,3] < Len(aCabOri[nPosCab,nX,2]),Len(aCabOri[nPosCab,nX,2])* 20,aCabOri[nPosCab,nX,3]*20)
Next Nx

//Impressao de detalhe                   
dbSelectArea(CTL->CTL_ALIAS)
dbSetOrder(Val(CTL->CTL_ORDER))
For nY = 1 to Len(aCtkSel)
	CTK->(dbGoto(aCtkSel[nY]))
	If dbSeek(Alltrim(CTK->CTK_KEY))
		nLin 	+= 30
		For nX = 2 To Len(aCabOri[nPosCab])
			oPrint:Say(nLin,aCabPos[nX],&(aCabOri[nPosCab,nX,1]),oArial08)                  
		Next Nx
	EndIf		
Next nY

RestArea(aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณCtbr031Rodณ Autor ณ Alexandre Silva       ณ Data ณ 20.02.03 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณRodape do  relatorio.             	                       ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ CtbRodape(ExpO1,ExpN1) 	   		                          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ                                                            ณฑฑ
ฑฑณ          ณ ExpO1 = Objeto oPrint                                      ณฑฑ
ฑฑณ          ณ ExpN2 = Contador de linhas                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ                                                            ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CtbR031Rod(oPrint,nLin)

nLin+=80

oPrint:Line(nLin,030,nLin,2380 )   	// horizontal
oPrint:SayBitmap(nlin+10,030, "\Bitmaps\LogoSiga.bmp",300,150) // Tem que estar abaixo do RootPath
oPrint:Say(nLin+30,1900,RptEnd + " " + TIME(),oFont10 )
oPrint:Line(nLin+100,030,nLin+100,2380)   	// horizontal
oPrint:EndPage() 	 	 				

Return

