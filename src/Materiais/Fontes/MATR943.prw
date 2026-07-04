/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Matr943.ch"
#Include "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR943  ³ Autor ³ Juan Jose Pereira     ³ Data ³ 12/12/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Registro de Apuracao de IPI - Modelo P8 (Impressao)        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Marcos Simidu³03/08/98³XXXXXX³Acertos no titulo do campo 17.          ³±±
±±³ Andreia      ³05/11/99³24340a³Troca 'de CGC por CNPJ.                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR943
Local i :=0
Local j :=0
Local aDadosAgl:={}
Local nx,nXFil,nY
Local aFilsAgl:={}           
Local lFiliais:= Iif(!(Type('lFiliais')=='L'),.F.,lFiliais)
Local nTamDesc := 0
local nHandle := 0
local nTamanho := 0
local nContLine := 0
Local x := 0
Local cFilBkp := cFilAnt

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define qual parte da apuracao esta imprimindo                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cImprimindo:="AP_ENT"
If lFiliais 

nConsFil := 2

	For nXFil:=1 to Len(aFilsCalc)             
	
		aFilsAgl:={}
		
		If aFilsCalc[nXFil][1]
		   cFilAnt:=aFilsCalc[nXFil][2]  //aFilsAgl:={aFilsCalc[nXFil][1],aFilsCalc[nXFil][2]}
		   AAdd(aFilsAgl,aFilscalc[nXFil])
		   
		   If nFormApu == 1
				If nConsFil <> 1
					aDadosTmp:=ResumeF3("IP",dDtIni,dDtFim,cNrLivro,.F.,.T.,2,@lAbortPrint,,,,,,AllTrim (aReturn[7]),,,,,,,,,,,,,,,,,,aFilsAgl)
				Else
					aDadosTmp:=ResumeF3("IP",dDtIni,dDtFim,cNrLivro,.F.,.T.,2,@lAbortPrint,nConsFil,cFilInic,cFilFin,,,AllTrim (aReturn[7]),,,,,,,,,,,,,,,,,,aFilsAgl)
				Endif                                                                                                    
			Else                
				If nConsFil <> 1
					aDadosTmp:=ResumeIP(dDtIni,dDtFim,cNrLivro,2,@lAbortPrint,nConsFil,,,aNcm,nApuracao,AllTrim(aReturn[7]),nPerCrd,2,,,,,aFilsAgl)
				Else
					aDadosTmp:=ResumeIP(dDtIni,dDtFim,cNrLivro,2,@lAbortPrint,nConsFil,cFilInic,cFilFin,aNcm,nApuracao,AllTrim(aReturn[7]),nPerCrd,2,,,,,aFilsAgl)
				Endif
			Endif
		   
			If nXFil==1	
				aDadosAgl:=ACLONE(aDadosTmp)
			Else 
				 
				For nX:=1 to Len(aDadosTmp)
					 nPosAgl:=AScan( aDadosAgl,{ |x| x[1]==aDadosTmp[nX,1] })
					 If nPosAgl>0
					 	 For nY:=1 to Len(aDadosTmp[nX])
							  	If Len(aDadosAgl[nPosAgl])==Len(aDadosTmp[nX])
							  		If ValType(aDadosTmp[nX][nY])=='N'
									    aDadosAgl[nPosAgl,nY]+=aDadosTmp[nX,nY]
									Endif
								  
								   
								Endif
						 Next                                         
					 Else
					     Aadd(aDadosAgl,aDadosTmp[nX])	 
					 Endif
				Next			
			Endif
		Endif
	Next
	aDadosApur:=AClone(aDadosAgl)
	cFilant:=cFilBack	
Else

	If nFormApu == 1
		If nConsFil <> 1
			aDadosApur:=ResumeF3("IP",dDtIni,dDtFim,cNrLivro,.F.,.T.,2,@lAbortPrint,,,,,,AllTrim (aReturn[7]),,,,,,,,,,,,,,,,,,aFilsCalc)
		Else
			aDadosApur:=ResumeF3("IP",dDtIni,dDtFim,cNrLivro,.F.,.T.,2,@lAbortPrint,nConsFil,cFilInic,cFilFin,,,AllTrim (aReturn[7]),,,,,,,,,,,,,,,,,,aFilsCalc)
		Endif                                                                                                    
	Else                
		If nConsFil <> 1
			aDadosApur:=ResumeIP(dDtIni,dDtFim,cNrLivro,2,@lAbortPrint,nConsFil,cFilInic,cFilFin,aNcm,nApuracao,AllTrim(aReturn[7]),nPerCrd,2,,,,,aFilsCalc)
		Else
			aDadosApur:=ResumeIP(dDtIni,dDtFim,cNrLivro,2,@lAbortPrint,nConsFil,cFilInic,cFilFin,aNcm,nApuracao,AllTrim(aReturn[7]),nPerCrd,2,,,,,aFilsCalc)
		Endif
	Endif	
Endif
aEntradas:={}
aSaidas:={}
cCFO:=""
nValIPI:=0
nValBase:=0
nValCont:=0
nValIsen:=0
nValOutr:=0
cValIPI:=""
cValBase:=""
cValCont:=""
cValIsen:=""
cValOutr:=""
cCfoAux:="" 
cVContAux:=""
cVBaseAux:=""
cVIPIAux :=""
cVIsenAux:=""
cVOutrAux:=""
nVContAux:=0
nVBaseAux:=0
nVIPIAux :=0
nVIsenAux:=0
nVOutrAux:=0
i:=0
j:=0
cAliq:=""
uValCont:=NIL
uValBase:=NIL
uValICMS:=NIL
cLinha:=""
cConteudo:=""
cArqApur:=""
aCampos:=NIL
nArqIni:=0
nArqFim:=0
cValor:=""
nValor:=0
cTexto:=""
aDriver:=NIL
nLin:=80
nPagina:=nPagIni
cImp:="IP"
nPeriodo:=0
aL:=NIL
cChrImp:=AvalImp(132)
nTamDesc := TamSX3("CDP_DESC")[1]
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis que armazenam os campos do resumo da apuracao      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
n001:=0
n002:=0
n003:=0
a004:={}
a005:={}
n006:=0
n007:=0
n008:=0
n009:=0
a010:={}
a011:={}
a012:={}
n013:=0
n014:=0
n015:=0
n016:=0
n017:=0
aTit:={}
aObs:={}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³         Imprime Termos de Abertura e Encerramento            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nImprime==2
	aDriver:=ReadDriver()
	XFIS_IMPTERM(GetMv("MV_LMOD8AB"),GetMv("MV_LMOD8EN"),cPerg,Iif( aReturn[4] = 1, aDriver[3], aDriver[4] ))
	Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                 Resumo por CFOP                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Separa entradas e saidas                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aResCFOP := ResIpiCFOP(aDadosApur, .T.)
aEntradas := aResCFOP[1]
aSaidas := aResCFOP[2]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acrescenta linha para totalizacao                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(aEntradas)
	AADD(aEntradas,Aclone(aEntradas[1]))
	aEntradas[Len(aEntradas),1]:="TOT"
	Afill(aEntradas[Len(aEntradas)],0,2)
Endif
If !Empty(aSaidas)
	AADD(aSaidas,Aclone(aSaidas[1]))
	aSaidas[Len(aSaidas),1]:="TOT"
	Afill(aSaidas[Len(aSaidas)],0,2)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totaliza entradas                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aEntradas)>0
	nValCont:=0
	nValBase:=0
	nValIPI:=0
	nValIsen:=0
	nValOutr:=0
	aEval(aEntradas,{|x|nValCont:=nValCont+x[11],nValBase:=nValBase+x[3],nValIPI:=nValIPI+x[4],nValIsen:=nValIsen+x[5],nValOutr:=nValOutr+x[6]})
	aEntradas[Len(aEntradas),11]:=nValCont
	aEntradas[Len(aEntradas),3]:=nValBase
	aEntradas[Len(aEntradas),4]:=nValIPI
	aEntradas[Len(aEntradas),5]:=nValIsen
	aEntradas[Len(aEntradas),6]:=nValOutr
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totaliza Saidas                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aSaidas)>0
	nValCont:=0
	nValBase:=0
	nValIPI:=0
	nValIsen:=0
	nValOutr:=0
	aEval(aSaidas,{|x|nValCont:=nValCont+x[11],nValBase:=nValBase+x[3],nValIPI:=nValIPI+x[4],nValIsen:=nValIsen+x[5],nValOutr:=nValOutr+x[6]})
	aSaidas[Len(aSaidas),11]:=nValCont
	aSaidas[Len(aSaidas),3]:=nValBase
	aSaidas[Len(aSaidas),4]:=nValIPI
	aSaidas[Len(aSaidas),5]:=nValIsen
	aSaidas[Len(aSaidas),6]:=nValOutr
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Apuracao                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
R943LayOut()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Entradas                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(Len(aEntradas))
For i:=1 to Len(aEntradas)
	IncRegua()
	If Interrupcao(@lAbortPrint)
		Exit
	Endif
	If nLin>57
		R943Cabec()
	Endif
    cCfo:=Transform(aEntradas[i,1],PESQPICT("SF3","F3_CFO"))
	cValCont:=Transform(aEntradas[i,11],cPictVal)
	cValBase:=Transform(aEntradas[i,3],cPictVal)
	cValIPI:=Transform(aEntradas[i,4],cPictVal)
	cValIsen:=Transform(aEntradas[i,5],cPictVal)
	cValOutr:=Transform(aEntradas[i,6],cPictVal)   
		
	If nSubTot == 1
		If !Empty(cCfoAux) .And. cCfoAux <> Left(aEntradas[i,1],1) 
			cVContAux:=Transform(nVContAux,cPictVal)
			cVBaseAux:=Transform(nVBaseAux,cPictVal)
			cVIPIAux :=Transform(nVIPIAux,cPictVal)
			cVIsenAux:=Transform(nVIsenAux,cPictVal)
			cVOutrAux:=Transform(nVOutrAux,cPictVal)
			FmtLin(Array(6),aL[67],,,@nLin)
			FmtLin({cVContAux,cVBaseAux,cVIPIAux,cVIsenAux,cVOutrAux},aL[68],,,@nLin)
			FmtLin(Array(6),aL[67],,,@nLin)
			If i<Len(aEntradas)
				FmtLin(Array(6),aL[22],,,@nLin)
			Endif	
			nVContAux:= 0
			nVBaseAux:= 0
			nVIPIAux := 0
			nVIsenAux:= 0
			nVOutrAux:= 0
		Endif
		cCfoAux := Left(aEntradas[i,1],1)
		nVContAux+=aEntradas[i,11]
		nVBaseAux+=aEntradas[i,3]
		nVIPIAux +=aEntradas[i,4]
		nVIsenAux+=aEntradas[i,5]
		nVOutrAux+=aEntradas[i,6]
	Endif
	
	If i<Len(aEntradas)
		FmtLin({cCFO,cValCont,cValBase,cValIpi,cValIsen,cValOutr},aL[22],,,@nLin)
	Else
		FmtLin(Array(6),aL[22],,,@nLin)
		FmtLin({cValCont,cValBase,cValIpi,cValIsen,cValOutr},aL[23],,,@nLin)
	Endif

Next i
If Len(aEntradas)==0
	R943Cabec()
	FmtLin({"     ",STR0001,,,,},aL[22],,,@nLin) //"SEM MOVIMENTO"
Endif
If lAbortPrint
	RETURN
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializando variaveis de sub-totais para a impressao das saidas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nSubTot == 1
	cCfoAux:="" 
	cVContAux:=""
	cVBaseAux:=""
	cVIPIAux :=""
	cVIsenAux:=""
	cVOutrAux:=""
	
	nVContAux:=0
	nVBaseAux:=0
	nVIPIAux :=0
	nVIsenAux:=0
	nVOutrAux:=0
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Saidas                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cImprimindo:="AP_SAI"
SetRegua(Len(aSaidas))
For i:=1 to Len(aSaidas)
	IncRegua()
	If Interrupcao(@lAbortPrint)
		Exit
	Endif
	If (nLin>=57 .And. i<>1) .Or. (nLin>47 .And. i==1)
		R943Cabec()
	Else
		If i==1
			U_R943AcertCab(@aL)
			FmtLin(,{aL[11],aL[13],aL[14],aL[15],aL[16],aL[69],aL[18],aL[19],aL[20],al[21]},,,@nLin)
		EndIf
	Endif
    cCfo:=Transform(aSaidas[i,1],PESQPICT("SF3","F3_CFO"))
	cValCont:=Transform(aSaidas[i,11],cPictVal)
	cValBase:=Transform(aSaidas[i,3],cPictVal)
	cValIPI:=Transform(aSaidas[i,4],cPictVal)
	cValIsen:=Transform(aSaidas[i,5],cPictVal)
	cValOutr:=Transform(aSaidas[i,6],cPictVal)
	
	If nSubTot == 1
		If !Empty(cCfoAux) .And. cCfoAux <> Left(aSaidas[i,1],1)
			cVContAux:=Transform(nVContAux,cPictVal)
			cVBaseAux:=Transform(nVBaseAux,cPictVal)
			cVIPIAux :=Transform(nVIPIAux,cPictVal)
			cVIsenAux:=Transform(nVIsenAux,cPictVal)
			cVOutrAux:=Transform(nVOutrAux,cPictVal)
			FmtLin(Array(6),aL[67],,,@nLin)
			FmtLin({cVContAux,cVBaseAux,cVIPIAux,cVIsenAux,cVOutrAux},aL[68],,,@nLin)
			FmtLin(Array(6),aL[67],,,@nLin)
			If i<Len(aSaidas)
				FmtLin(Array(6),aL[22],,,@nLin)
			Endif	
			nVContAux:= 0
			nVBaseAux:= 0
			nVIPIAux := 0
			nVIsenAux:= 0
			nVOutrAux:= 0
		Endif
		cCfoAux := Left(aSaidas[i,1],1)
		nVContAux+=aSaidas[i,11]
		nVBaseAux+=aSaidas[i,3]
		nVIPIAux +=aSaidas[i,4]
		nVIsenAux+=aSaidas[i,5]
		nVOutrAux+=aSaidas[i,6]
	Endif
	
	If i<Len(aSaidas)
		FmtLin({cCFO,cValCont,cValBase,cValIpi,cValIsen,cValOutr},aL[22],,,@nLin)
	Else
		FmtLin(Array(6),aL[22],,,@nLin)
		FmtLin({cValCont,cValBase,cValIpi,cValIsen,cValOutr},aL[23],,,@nLin)
		While nLin<60
			FmtLin(Array(6),aL[22],,,@nLin)
		End
		FmtLin(,aL[01],,,@nLin)
	Endif
Next i
If Len(aSaidas)==0
	U_R943AcertCab(@aL)
	FmtLin(,{aL[11],aL[13],aL[14],aL[15],aL[16],aL[69],aL[18],aL[19],aL[20],al[21]},,,@nLin)
	FmtLin({"     ",STR0001,,,,},aL[22],,,@nLin) //"SEM MOVIMENTO"
	While nLin<60
		FmtLin(Array(6),aL[22],,,@nLin)
	End
	FmtLin(,aL[01],,,@nLin)
	nLin:=80
Endif
If lAbortPrint
	RETURN
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                RESUMO DA APURACAO DO IMPOSTO                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega informacoes dos arquivos .IP?                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aArqApur:={}

If nConsFil <> 1 .AND. Len(aFilsCalc) > 0
    For x:=1 to Len(aFilsCalc)  
        IF aFilsCalc [x][1]
			If (nApuracao==1.or.nApuracao==2.or.!lConcilia) .Or. (nApuracao == 3 .And. nFormApu == 2) 
				AADD(aArqApur,NmArqApur("IP",nAno,nMes,nApuracao,nPerApurado,cNrLivro,IIf(nFormApu==2,.T.,.F.),aFilsCalc[x][2]))
			Else
				Do Case
					Case nApuracao==3
						nMesIni:=nMes
						nMesFim:=nMes
					Case nApuracao==4
						nMesIni:=If(nPerApurado==1,1,7)
						nMesFim:=If(nPerApurado==1,6,12)
					Case nApuracao==5
						nMesIni:=1
						nMesFim:=12
				EndCase
				For i:=nMesIni to nMesFim
					AADD(aArqApur,NmArqApur("IP",nAno,i,1,0,cNrLivro,,aFilsCalc[x][2]))
					AADD(aArqApur,NmArqApur("IP",nAno,i,1,1,cNrLivro,,aFilsCalc[x][2]))
					AADD(aArqApur,NmArqApur("IP",nAno,i,1,2,cNrLivro,,aFilsCalc[x][2]))
					AADD(aArqApur,NmArqApur("IP",nAno,i,1,3,cNrLivro,,aFilsCalc[x][2]))
				Next i
			Endif
		Endif
    Next x
Else
    aAreaSM0 = SM0->(GetArea())
	dbSelectArea("SM0")
    dbSeek(cEmpAnt+cFilInic,.T.)

    While !SM0->(Eof()) .and. FWGrpCompany()+FWCodFil() <= cEmpAnt+cFilFin
        cFilAnt := FWGETCODFILIAL

        If (nApuracao==1.or.nApuracao==2.or.!lConcilia) .Or. (nApuracao == 3 .And. nFormApu == 2) 
            AADD(aArqApur,NmArqApur("IP",nAno,nMes,nApuracao,nPerApurado,cNrLivro,IIf(nFormApu==2,.T.,.F.),cFilAnt))
        Else
            Do Case
                Case nApuracao==3
                    nMesIni:=nMes
                    nMesFim:=nMes
                Case nApuracao==4
                    nMesIni:=If(nPerApurado==1,1,7)
                    nMesFim:=If(nPerApurado==1,6,12)
                Case nApuracao==5
                    nMesIni:=1
                    nMesFim:=12
            EndCase
            For i:=nMesIni to nMesFim
                AADD(aArqApur,NmArqApur("IP",nAno,i,1,0,cNrLivro,,cFilAnt))
                AADD(aArqApur,NmArqApur("IP",nAno,i,1,1,cNrLivro,,cFilAnt))
                AADD(aArqApur,NmArqApur("IP",nAno,i,1,2,cNrLivro,,cFilAnt))
                AADD(aArqApur,NmArqApur("IP",nAno,i,1,3,cNrLivro,,cFilAnt))
            Next i
        Endif
        dbSelectArea("SM0")
        SM0->( dbSkip())
    EndDo
	RestArea(aAreaSM0)
EndIF

cFilAnt := cFilBkp

SetRegua(Len(aArqApur))
For i:=1 to Len(aArqApur)
	IncRegua()
	nPeriodo:=i
	cArqApur:=aArqApur[i]
	If !File(cArqApur)
		Loop
	Endif
	
	aCampos:={.f.,.f.,.f.,.f.,.f.}
	nHandle := FOpen(cArqApur)
	if nHandle > 0
		nTamanho := Fseek(nHandle,0,2)
		FSeek(nHandle,0,0)
		
		FT_FUse(cArqApur)
		FT_FGotop()
		
		//Leitura do arquivo
		nContLine := 0
		While (!FT_FEof()) 
		
			nContLine += 1
			cLinha  := ""
			cLinha  := Alltrim(FT_FREADLN())
			
			if nContLine == 1 .or. empty(cLinha)
				FT_FSkip()
				loop
			
			endif

			cCampo:=Substr(cLinha,1,3)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Carrega valor numerico e descricao                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If IsDigit(Substr(cCampo,1,1)).and.IsDigit(Substr(cCampo,3,1))
				// Soma-se 6 posicoes ao tamanho da descricao da CDP devido à estrutura da linha do arquivo .IP0.			
				// Trecho do FISXAPUR que faz a gravacao:
				// cLinha	:=	aGetApur[i,1]+" "+PADR(Alltrim(aGetApur[i,2]),TamSX3("CDP_DESC")[1],' ')+" "
				// cLinha	+= Transform(aGetApur[i,3],"@E 999,999,999,999.99")+" "
	      		// cLinha += Transform(NoRound(xMoeda(aGetApur[i,3],1,nMoedTit,dDataBase),3),"99999999999.99")
	      		// Exemplo de linha gerada: "001 Por entradas do mercado nacional                               100,00         100.00"			 
				cValor:=Substr(cLinha,nTamDesc + 6,18)  
				cValor:=StrTran(cValor,'.')
				cValor:=StrTran(cValor,',','.')
				nValor:=Val(cValor)
				cTexto:=Substr(cLinha,5,nTamDesc)
			Else
				nValor:=0
				cTexto:=Substr(cLinha,5)
			Endif
			Do Case
				Case cCampo=='001'
					n001:=n001+nValor
				Case cCampo=='002'
					n002:=n002+nValor
				Case cCampo=='003'
					n003:=n003+nValor
				Case cCampo=='004'
					If aCampos[1]
						AADD(a004,{SubStr(cTexto,1,80),nValor,0})
					Else
						aCampos[1]:=.t.
					Endif
				Case cCampo=='005'
					If aCampos[2]
						AADD(a005,{SubStr(cTexto,1,80),nValor,0})
					Else
						aCampos[2]:=.t.
					Endif
				Case cCampo=='007' .and. (nPerApurado!=4.or.(nPerApurado==4.and.i==1))
					n007:=n007+nValor
				Case cCampo=='009'
					n009:=n009+nValor
				Case cCampo=='010'
					If aCampos[3]
						AADD(a010,{SubStr(cTexto,1,80),nValor,0})
					Else
						aCampos[3]:=.t.
					Endif
				Case cCampo=='011' //.and. !lCpo011
	//				lCpo011:=.T.
					//n011:=n011+nValor
					If aCampos[4]
						AADD(a011,{SubStr(cTexto,1,80),nValor,0})
					Else
						aCampos[4]:=.t.
					Endif
				Case cCampo=='012'
					If aCampos[5]
						AADD(a012,{SubStr(cTexto,1,80),nValor,0})
					Else
						aCampos[5]:=.t.
					Endif
				Case cCampo=='TIT'
					AADD(aTit,cTexto)
				Case cCampo=='OBS'
					AADD(aObs,cTexto)
			EndCase
			FT_FSkip()
		EndDo
		FT_FUse()
		FClose(nHandle)
				
	endif

Next i
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz nova totalizacao dos arquivos de apuracao                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ totaliza creditos                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
n006:=n006+n001+n002+n003
For i:=1 to Len(a004)
	a004[Len(a004),3]:=a004[Len(a004),3]+a004[i,2]
	n006:=n006+a004[i,2]
Next
For i:=1 to Len(a005)
	a005[Len(a005),3]:=a005[Len(a005),3]+a005[i,2]
	n006:=n006+a005[i,2]
Next
n008:=n008+n006+n007
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ totaliza debitos                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
n013+=n009
For i:=1 to Len(a010)
	a010[Len(a010),3]+=a010[i,2]
	n013+=a010[i,2]
Next

For i:=1 to Len(a011)
	a011[Len(a011),3]+=a011[i,2]
	n013+=a011[i,2]
Next

For i:=1 to Len(a012)
	a012[Len(a012),3]+=a012[i,2]
	n013+=a012[i,2]
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ totaliza apuracao                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
n014:=n013  // Debito
n015:=n008  // Credito
If n014-n015>0
	n016:=n014-n015 // Saldo Devedor
Else
	n017:=n015-n014 // Saldo Credor
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime valores                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLin:=80
cImprimindo:="DEMO_CRED"
R943Cabec()
SetRegua(15)
While !lAbortPrint
	IncRegua()
	If Interrupcao(@lAbortPrint)
		Loop
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Demonstrativo de creditos                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cImprimindo:="DEMO_CRED"
	FmtLin({n001},aL[29],cPictVal,,@nLin)
	R943Cab2()
	FmtLin({n002},aL[30],cPictVal,,@nLin)
	R943Cab2()
	FmtLin({n003},aL[31],cPictVal,,@nLin)
	R943Cab2()
	FmtLin(,aL[32],,,@nLin)
	R943Cab2()
	For i:=1 to Len(a004)
		FmtLin({a004[i,1],a004[i,2],a004[i,3]},aL[33],cPictVal,,@nLin)
		R943Cab2()
	Next i
	FmtLin(,aL[34],,,@nLin)
	R943Cab2()
	For i:=1 to Len(a005)
		FmtLin({a005[i,1],a005[i,2],a005[i,3]},aL[35],cPictVal,,@nLin)
		R943Cab2()
	Next i
	FmtLin({n006},aL[36],cPictVal,,@nLin)
	R943Cab2()
	FmtLin({n007},aL[37],cPictVal,,@nLin)
	R943Cab2()
	FmtLin({n008},aL[38],cPictVal,,@nLin)
	R943Cab2()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Demonstrativo de Debitos                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Interrupcao(@lAbortPrint)
		Loop
	EndIf
	cImprimindo:="DEMO_DEBI"
	FmtLin(,{aL[39],aL[40],aL[41]},,,@nLin)
	R943Cab2()
	FmtLin({n009},aL[42],cPictVal,,@nLin)
	R943Cab2()
	FmtLin(,aL[43],,,@nLin)
	R943Cab2()
	For i:=1 to Len(a010)
		FmtLin({a010[i,1],a010[i,2],IIf(a010[i,3]==0,'',a010[i,3])},aL[44],cPictVal,,@nLin)
		R943Cab2()
	Next i
	
//	FmtLin({n011},aL[45],cPictVal,,@nLin)
	FmtLin({''},aL[45],,,@nLin)
	R943Cab2()
	For i:=1 to Len(a011)
		FmtLin({a011[i,1],a011[i,2],IIf(a011[i,3]==0,'',a011[i,3])},aL[44],cPictVal,,@nLin)
		R943Cab2()
	Next i

	FmtLin(,aL[46],,,@nLin)
	R943Cab2()
	For i:=1 to Len(a012)
		FmtLin({a012[i,1],a012[i,2],a012[i,3]},aL[47],cPictVal,,@nLin)
		R943Cab2()
	Next i
	FmtLin({n013},aL[48],cPictval,,@nLin)
	R943Cab2()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Apuracao do Saldo                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Interrupcao(@lAbortPrint)
		Loop
	EndIf
	cImprimindo:="APUR_SALDO"
	FmtLin(,{aL[49],aL[50],aL[51]},,,@nLin)
	R943Cab2()
	FmtLin({n014},aL[52],cPictVal,,@nLin)
	R943Cab2()
	FmtLin({n015},aL[53],cPictVal,,@nLin)
	R943Cab2()
	FmtLin({n016},aL[54],cPictVal,,@nLin)
	R943Cab2()
	FmtLin({n017},aL[55],cPictVal,,@nLin)
	R943Cab2()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Informacoes complementares                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Interrupcao(@lAbortPrint)
		Loop
	EndIf
	j:=0
	cImprimindo:="INF_COMPL"
	FmtLin(,{aL[56],aL[57],aL[58],aL[59],aL[60],aL[61]},,,@nLin)
	R943Cab2()
	For i:=1 to Len(aTit)
		FmtLin({aTit[i]},aL[62],,,@nLin)
		R943Cab2()
	Next
	FmtLin(,aL[63],,,@nLin)
	R943Cab2()
	For i:=1 to Len(aObs)
		FmtLin({aObs[i]},aL[IIf(i==1,64,65)],,,@nLin)
		R943Cab2()
	Next
	While nLin<60
		FmtLin(,aL[63],,,@nLin)
	End
	FmtLin(,aL[01],,,@nLin)
	Exit
End

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R943LayOut() ³Autor ³ Juan Jose Pereira    ³Data³ 12/12/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Armazena lay-out para o modelo P8                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R943LayOut

Local lImp  	:= GetNewPar("MV_IMPCABE",.F.)
Local lMVIMPPAGI := GetMV("MV_IMPPAGI",.F.)
aL:={}
Aadd(aL,"+----------------------------------------------------------------------------------------------------------------------------------+") // [01]
	If lImp
		Aadd(aL,STR0043) //[02]"|                                                    REGISTRO DE APURACAO DO IPI  - P8                                             |"
    Else
		Aadd(aL,STR0002) //[02]"|                                                    REGISTRO DE APURACAO DO IPI                                                   |"
	Endif
Aadd(aL,STR0003) // [03] //"|                                                DEMONSTRATIVO DE APURACAO DO IMPOSTO                                              |"
Aadd(aL,"|                                                                                                                                  |") // [04]
Aadd(aL,STR0004) // [05] //"| FIRMA: #########################################################                                                                 |"
Aadd(aL,"|                                                                                                                                  |") // [06]
Aadd(aL,STR0005) // [07] //"| INSC.EST.: ######################## C.N.P.J.: #################                                                                  |"
Aadd(aL,"|                                                                                                                                  |") // [08]
If !lMVIMPPAGI //!lMVIMPPAGI 
	Aadd(aL,STR0006) // [09] //"| FOLHA: ####     MES OU PERIODO/ANO: #########                                                                                    |"
Else
	Aadd(aL,STR0044) // [09] //"| PAGINA: ####     MES OU PERIODO/ANO: #########                                                                                    |"
EndIf
Aadd(aL,"|                                                                                                                                  |") // [10]
Aadd(aL,"|==================================================================================================================================|") // [11]
Aadd(aL,STR0007) // [12] //"|                                                         E N T R A D A S                                                          |"
Aadd(aL,STR0008) // [13] //"|                                                           S A I D A S                                                            |"
Aadd(aL,"|==================================================================================================================================|") // [14]
Aadd(aL,STR0009) // [15] //"|              |                    |                                 IPI - VALORES FISCAIS                                        |"
Aadd(aL,"|              |                    |----------------------------------------------------------------------------------------------|") // [16]
Aadd(aL,STR0039) // [17] //"|              |                    |             OPERACOES COM CREDITO           |               OPERACOES SEM CREDITO            |"
Aadd(aL,STR0040) // [18] //"| CODIFICACAO  |                    |                  DO IMPOSTO                 |                    DO IMPOSTO                  |" 
Aadd(aL,"|--------------|--------------------|----------------------------------------------------------------------------------------------|") // [19]
Aadd(aL,STR0010) // [20] //"|    FISCAL    |  VALORES CONTABEIS |    BASE DE CALCULO   |  IMPOSTO CREDITADO   | ISENTAS OU NAO TRIBUTADAS |      OUTRAS        |"
Aadd(aL,"|==============|====================|======================+======================+===========================+====================|") // [21]
Aadd(aL,"|     ####     | ################## |  ##################  |  ##################  |    ##################     | ################## |") // [22]
Aadd(aL,STR0011) // [23] //"|    TOTAIS    | ################## |  ##################  |  ##################  |    ##################     | ################## |"
Aadd(aL,"|==================================================================================================================================|") // [24]
Aadd(aL,STR0012) // [25] //"| DEMONSTRATIVO DE CREDITOS                                                              |                 VALORES                 |"
Aadd(aL,"|----------------------------------------------------------------------------------------|-----------------------------------------|") // [26]
Aadd(aL,STR0013) // [27] //"|                                                                                        |   COLUNA AUXILIAR  |        SOMA        |"
Aadd(aL,"|                                                                                        |--------------------+--------------------|") // [28]
Aadd(aL,STR0014) // [29] //"| 001 - POR ENTRADAS DO MERCADO NACIONAL                                                 |                    | ################## |"
Aadd(aL,STR0015) // [30] //"| 002 - POR ENTRADAS DO MERCADO EXTERNO                                                  |                    | ################## |"
Aadd(aL,STR0016) // [31] //"| 003 - POR SAIDAS PARA O MERCADO EXTERNO                                                |                    | ################## |"
Aadd(aL,STR0017) // [32] //"| 004 - ESTORNO DE DEBITOS (DISCRIMINAR ABAIX0)                                          |                    |                    |"
Aadd(aL,"|       ################################################################################ | ################## | ################## |") // [33]
Aadd(aL,STR0018) // [34] //"| 005 - OUTROS CREDITOS (DISCRIMINAR ABAIXO)                                             |                    |                    |"
Aadd(aL,"|       ################################################################################ | ################## | ################## |") // [35]
Aadd(aL,STR0019) // [36] //"| 006 - SUBTOTAL                                                                         |                    | ################## |"
Aadd(aL,STR0020) // [37] //"| 007 - SALDO CREDOR DO PERIODO ANTERIOR                                                 |                    | ################## |"
Aadd(aL,STR0021) // [38] //"| 008 - TOTAL                                                                            |                    | ################## |"
Aadd(aL,"|==================================================================================================================================|") // [39]
Aadd(aL,STR0022) // [40] //"| DEMONSTRATIVO DE DEBITOS                                                               |                    |                    |"
Aadd(aL,"|----------------------------------------------------------------------------------------|--------------------+--------------------|") // [41]
Aadd(aL,STR0023) // [42] //"| 009 - POR SAIDAS PARA O MERCADO NACIONAL                                               |                    | ################## |"
Aadd(aL,STR0024) // [43] //"| 010 - ESTORNO DE CREDITOS (DISCRIMINAR ABAIXO)                                         |                    |                    |"
Aadd(aL,"|       ################################################################################ | ################## | ################## |") // [44]
Aadd(aL,STR0025) // [45] //"| 011 - RESSARCIMENTO DE CREDITOS                                                        |                    | ################## |"
Aadd(aL,STR0026) // [46] //"| 012 - OUTROS DEBITOS (DISCRIMINAR ABAIXO)                                              |                    |                    |"
Aadd(aL,"|       ################################################################################ | ################## | ################## |") // [47]
Aadd(aL,STR0027) // [48] //"| 013 - TOTAL                                                                            |                    | ################## |"
Aadd(aL,"|==================================================================================================================================|") // [49]
Aadd(aL,STR0028) // [50] //"| APURACAO DO SALDO                                                                      |                    |                    |"
Aadd(aL,"|----------------------------------------------------------------------------------------|--------------------+--------------------|") // [51]
Aadd(aL,STR0029) // [52] //"| 014 - DEBITO TOTAL (ITEM 013)                                                          |                    | ################## |"
Aadd(aL,STR0030) // [53] //"| 015 - CREDITO TOTAL (ITEM 008)                                                         |                    | ################## |"
Aadd(aL,STR0031) // [54] //"| 016 - SALDO DEVEDOR (ITEM 014-ITEM 015)                                                |                    | ################## |"
Aadd(aL,STR0032) // [55] //"| 017 - SALDO CREDOR  (ITEM 015-ITEM 014)                                                |                    | ################## |"
Aadd(aL,"|==================================================================================================================================|") // [56]
Aadd(aL,STR0033) // [57] //"| INFORMACOES COMPLEMENTARES                                                                                                       |"
Aadd(aL,"|----------------------------------------------------------------------------------------------------------------------------------|") // [58]
Aadd(aL,STR0034) // [59] //"|                         GUIAS DE RECOLHIMENTO                                                                                    |"
Aadd(aL,"|                                                                                                                                  |") // [60]
Aadd(aL,STR0035) // [61] //"| NUMERO   DATA         VALOR               ORGAO ARRECADADOR                                                                      |"
Aadd(aL,"| ####################################################################                                                             |") // [62]
Aadd(aL,"|                                                                                                                                  |") // [63]
Aadd(aL,STR0036) // [64] //"| OBSERVACOES: ##################################################################################                                  |"
Aadd(aL,"|              ##################################################################################                                  |") // [65]
Aadd(aL,"|                                                                                                                                  |") // [66]
Aadd(aL,"|--------------|--------------------|----------------------|----------------------|---------------------------|--------------------|") // [67]
Aadd(aL,STR0041) // [68]  //"|  SUBTOTAL    | ################## |  ##################  |  ##################  |    ##################     | ################## |"
Aadd(aL,STR0042) // [69] //"|              |                    |             OPERACOES COM CREDITO           |               OPERACOES SEM CREDITO            |"
//       123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x
//                10        20        30        40        50        60        70        80        90        100       110       120       30
U_R943AcertCab(@aL)
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R943Cabec()  ³Autor ³ Juan Jose Pereira    ³Data³ 12/12/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime cabecalho do relatorio                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R943Cabec

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
__LogPages()
R943LayOut()
//aImp:=NIL
If Len(aFilsCalc)>0 .and. aFilsCalc[1][2]<>cFilBack
	SM0->(DbSeek(cEmpAnt+cFilBack))
Endif
cNome	:=SM0->M0_NOMECOM
cInscr	:=InscrEst()
cCGC	:=TRANSFORM(SM0->M0_CGC,"@R! NN.NNN.NNN/NNNN-99")

If nApuracao==3
	cPeriodo:=Mes(dDtIni)+' / '+StrZero(Year(dDtIni),4)
Else
	cPeriodo:=Dtoc(dDtIni)+STR0037+Dtoc(dDtFim) //" A "
Endif

cPagina :=StrZero(nPagina,4)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime caracter de controle de largura de impressao         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLin<80
	FMTLIN(,aL[1],,,@nLin)
Endif
nLin:=1
@ nLin,0 PSAY cChrImp

nLin:=2
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime cabecalho                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cImprimindo$'AP_ENT,AP_SAI'
	FMTLIN(,{aL[1],aL[2],aL[4]},,,@nLin)
Else
	FMTLIN(,{aL[1],aL[3],aL[4]},,,@nLin)
EndIf
FMTLIN({cNome},aL[5],,,@nLin)
FMTLIN(,aL[6],,,@nLin)
FMTLIN({cInscr,cCGC},aL[7],,,@nLin)
FMTLIN(,aL[8],,,@nLin)
FMTLIN({cPagina,cPeriodo},aL[9],,,@nLin)
FMTLIN(,aL[10],,,@nLin)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime sub-cabecalho                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case cImprimindo=="AP_ENT" 		// Apuracao (Entradas)
		U_R943AcertCab(@aL)
		FMTLIN(,{aL[11],aL[12],aL[14],aL[15],aL[16],aL[17],aL[18],aL[19],aL[20],al[21]},,,@nLin)
	Case cImprimindo=="AP_SAI" 		// Apuracao (Saidas)
		U_R943AcertCab(@aL)
		FMTLIN(,{aL[11],aL[13],aL[14],aL[15],aL[16],aL[69],aL[18],aL[19],aL[20],al[21]},,,@nLin)
	Case cImprimindo=="DEMO_CRED" 	// Demonstrativo de Creditos
		FMTLIN(,{aL[24],aL[25],aL[26],aL[27],aL[28]},,,@nLin)
	Case cImprimindo=="DEMO_DEBI" 	// Demonstrativo de Debitos
		FMTLIN(,{aL[39],aL[40],aL[41]},,,@nLin)
	Case cImprimindo=="APUR_SALDO"	// Apuracao do saldo
		FMTLIN(,{aL[49],aL[50],aL[51]},,,@nLin)
	Case cImprimindo=="INF_COMPL"	// Informacoes complementares
		FMTLIN(,{aL[56],aL[57],aL[58]},,,@nLin)
EndCase

NovaPg(@nPagina,nQtFeixe)

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R943Cab2     ³Autor ³ Juan Jose Pereira    ³Data³ 12/12/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Preenche ultima linha da folha e chama o cabecalho         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R943Cab2

IncRegua()
If nLin>55
	FmtLin(,aL[1],,,@nLin)
	R943Cabec()
Endif

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R943AcertCab ³Autor ³    Marcos Simidu     ³Data³ 01/07/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta perguntas do Cabecalho.                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R943AcertCab(aL)

If cImprimindo == "AP_SAI"
	aL[20]:= STR0038 // [17] //"|    FISCAL    |  VALORES CONTABEIS |    BASE DE CALCULO   |  IMPOSTO DEBITADO    | ISENTAS OU NAO TRIBUTADAS |      OUTRAS        |"
Endif

Return NIL
