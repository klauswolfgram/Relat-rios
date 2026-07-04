/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "SGAR140.ch"
#include "protheus.ch"
#define _nVERSAO 2
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSGAR140   บAutor  ณRoger Rodrigues     บ Data ณ  21/01/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio de Objetivos e Metas                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSIGASGA                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function SGAR140(nTipoImp)
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)
Default nTipoImp 	:= 1	
Private cStartPath := AllTrim(GetSrvProfString("Startpath",""))
Private oPrintMeta
PRIVATE cPerg    :="SGR140", aPerg := {}

//Varํaveis para verificar tamanho dos campos
Private nTamQAA := If((TAMSX3("QAA_MAT")[1]) < 1,10,(TAMSX3("QAA_MAT")[1]))
Private nTamTBH := If((TAMSX3("TBH_CODOBJ")[1]) < 1,6,(TAMSX3("TBH_CODOBJ")[1]))
Private nTamTAA := If((TAMSX3("TAA_CODPLA")[1]) < 1,6,(TAMSX3("TAA_CODPLA")[1]))

Private lConsulta := IsInCallStack("SGAC060")
//Verifica se o UPDSGA17 foi aplicado
If !SG90UPDVL()
	Return .F.
EndIf

//Se for a consulta de objetivos e metas
If lConsulta
	MV_PAR01 := TBH->TBH_CODOBJ
	MV_PAR02 := TBH->TBH_CODOBJ
	MV_PAR03 := Space(Len(TBI->TBI_META))
	MV_PAR04 := Replicate("Z",Len(TBI->TBI_META))
	MV_PAR05 := TBH->TBH_RESPON
	MV_PAR06 := TBH->TBH_RESPON
	MV_PAR07 := TBH->TBH_PRAZO
	MV_PAR08 := TBH->TBH_PRAZO
	MV_PAR09 := nTipoImp
	MV_PAR10 := 0
	Processa({|lEnd| SGR140IMP()}) // MONTE TELA PARA ACOMPANHAMENTO DO PROCESSO.
Else
	If pergunte(cPerg,.T.)
		Processa({|lEnd| SGR140IMP()}) // MONTE TELA PARA ACOMPANHAMENTO DO PROCESSO.
	EndIf
EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSGR140IMP บAutor  ณRoger Rodrigues     บ Data ณ  21/01/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFaz a impressใo do relat๓rio                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSGAR140                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SGR140IMP()
Local lPrint		:= .F.//Verifica se existiram dados para montar o relatorio
Local cFormula		:= ""        
Local cDetalhe		:= ""              
Local aResultado  := {}
Local nCompilado	:= 0                   
Local nLinhas		:= 0
Local nCor			:= 0
Local nLinMemo		:= 0
Local i

Private nPagNum := 1
//Varํaveis para extracao de imagens
Private cBARRAS  := If(isSRVunix(),"/","\")
Private cTemp    := GetTempPath() //"C:"+cBARRAS+"Temp"+cBARRAS
Private cImagens := cTemp+STR0021+cBARRAS //"Objetivos"

//Declara variaveis de fonte
oFont13 := TFont():New("Courier New",13,13,,.T.,,,,.F.,.F.)

oFont11 := TFont():New("Courier New",11,11,,.F.,,,,.F.,.F.)

//Inicializa Objeto
oPrintMeta	:= TMSPrinter():New(OemToAnsi(STR0022)) //"Relat๓rio de Objetivos e Metas"
oPrintMeta:Setup()
oPrintMeta:SetLandScape()//Padrao Paisagem
Lin := 1
Somalinha(.T.)
//Percorre Objetivos
dbSelectArea("TBH")
dbSetOrder(1)
dbGoTop()
dbSeek(xFilial("TBH")+MV_PAR01,.T.)
ProcRegua(RecCount())
While !eof() .and. TBH->TBH_FILIAL == xFilial("TBH") .and. TBH->TBH_CODOBJ <= MV_PAR02
	IncProc()//Incrementa barra de processamento
	//Nao considera os em analise e cancelados
	If !lConsulta
		If TBH->TBH_SITUAC == "1" .OR. TBH->TBH_SITUAC == "4"
			dbSelectArea("TBH")
			dbSkip()
			Loop
		EndIf
	EndIf
	//Filtra por responsavel
	If TBH->TBH_RESPON < MV_PAR05 .OR. TBH->TBH_RESPON > MV_PAR06
		dbSelectArea("TBH")
		dbSkip()
		Loop
	EndIf
	//Filtra por prazo
	If TBH->TBH_PRAZO < MV_PAR07 .OR. TBH->TBH_PRAZO > MV_PAR08
		dbSelectArea("TBH")
		dbSkip()
		Loop
	EndIf

	If lPrint
		Somalinha()
		oPrintMeta:Line(Lin,0,Lin,5000)
	EndIf
	//Se for primeiro objetivo extrai imagens
	If !lPrint
		SGR140IMG()
	EndIf
	//Imprime Objetivo
	lPrint := .T.
	Somalinha()
	oPrintMeta:Say(Lin,30,STR0023,oFont13) 					//"Objetivo:"
	oPrintMeta:Say(Lin,350,TBH->TBH_CODOBJ)
	oPrintMeta:Say(Lin,500," - "+AllTrim(TBH->TBH_DESCRI),oFont13)
	Lin+=5
	Somalinha()
	oPrintMeta:Say(Lin,30,STR0024,oFont11)						//"Prazo: "
	oPrintMeta:Say(Lin,350,DTOC(TBH->TBH_PRAZO),oFont11)
	oPrintMeta:Say(Lin,755,STR0025,oFont11)					//"Abertura: "
	oPrintMeta:Say(Lin,1000,DTOC(TBH->TBH_ABERTU),oFont11) 
	oPrintMeta:Say(Lin,1315,STR0026,oFont11)				//"Fechamento: "
	oPrintMeta:Say(Lin,1600,DTOC(TBH->TBH_FECHAM),oFont11) 
	oPrintMeta:Say(Lin,1940,STR0028,oFont11)				//"Situa็ใo: "
	oPrintMeta:Say(Lin,2180,AllTrim(NGRETSX3BOX("TBH_SITUAC",TBH->TBH_SITUAC)),oFont11) 
	oPrintMeta:Say(Lin,2440,STR0029,oFont11)				//"Prioridade: "
	oPrintMeta:Say(Lin,2720,AllTrim(NGRETSX3BOX("TBH_PRIORI",TBH->TBH_PRIORI)),oFont11)
	Somalinha()
	oPrintMeta:Say(Lin,30,STR0027,oFont11)					//"Responsแvel: "
	oPrintMeta:Say(Lin,350,TBH->TBH_RESPON)
	oPrintMeta:Say(Lin,750," - "+Substr(NGSEEK("QAA",TBH->TBH_RESPON,1,"QAA->QAA_NOME"),1,30),oFont11) 
	Somalinha()
	//Percore Metas
	dbSelectArea("TBI")
	dbSetOrder(1)
	dbSeek(xFilial("TBI")+TBH->TBH_CODOBJ)
	While !eof() .and. xFilial("TBI")+TBH->TBH_CODOBJ == TBI->TBI_FILIAL+TBI->TBI_OBJETI
		//Filtra por meta
		If TBI->TBI_META < MV_PAR03 .OR. TBI->TBI_META > MV_PAR04
			dbSelectArea("TBI")
			dbSkip()
			Loop
		EndIf
		dbSelectArea("TAA")
		dbSetOrder(1)
		If dbSeek(xFilial("TAA")+TBI->TBI_META)
			//Verifica se nao foi cancelado
			If TAA->TAA_STATUS == "3"
				dbSelectArea("TBI")
				dbSkip()
				Loop
			EndIf
			//Imprime meta
			Somalinha()
			Somalinha()
			oPrintMeta:Say(Lin,75,STR0030,oFont13) 	//"Meta:"
			oPrintMeta:Say(Lin,470,TBI->TBI_META)
			oPrintMeta:Say(Lin,620," - "+TAA->TAA_NOME,oFont13)
			Lin+=5
			Somalinha()
			oPrintMeta:Say(Lin,75,STR0031,oFont11)				//"Status: 
			oPrintMeta:Say(Lin,470,If(Empty(TAA->TAA_STATUS),STR0032,NGRETSX3BOX("TAA_STATUS",TAA->TAA_STATUS)),oFont11)		//"Pendente"
			oPrintMeta:Say(Lin,780,STR0033,oFont11)				//"Tipo Meta: "
			oPrintMeta:Say(Lin,1040,If(Empty(TAA->TAA_TPMETA),STR0034,NGRETSX3BOX("TAA_TPMETA",TAA->TAA_TPMETA)),oFont11)	//"Crescente"
			oPrintMeta:Say(Lin,1400,STR0035,oFont11)			//"Meta: "
			oPrintMeta:Say(Lin,1700,Transform(TAA->TAA_META,"@E 999,999.99"),oFont11) 	
			oPrintMeta:Say(Lin,2010,STR0036,oFont11)			//"Qtd. Atual: "
			oPrintMeta:Say(Lin,2330,Transform(TAA->TAA_QTDATU,"@E 999,999.99"),oFont11) 
			oPrintMeta:Say(Lin,2660,STR0037,oFont11)			//"Implanta็ใo: "
			oPrintMeta:Say(Lin,2960,DTOC(TAA->TAA_DTIMPL),oFont11) 
			Somalinha()
			oPrintMeta:Say(Lin,75,STR0038,oFont11)				//"Inํcio Prev.: "
			oPrintMeta:Say(Lin,470,DTOC(TAA->TAA_DTINPR),oFont11) 
			oPrintMeta:Say(Lin,780,STR0039,oFont11)				//"Fim Prev.: "
			oPrintMeta:Say(Lin,1040,DTOC(TAA->TAA_DTFIPR),oFont11) 
			oPrintMeta:Say(Lin,1400,STR0040,oFont11)			//"Inํcio Real: "
			oPrintMeta:Say(Lin,1700,DTOC(TAA->TAA_DTINRE),oFont11) 
			oPrintMeta:Say(Lin,2010,STR0041,oFont11)			//"Fim Real: "
			oPrintMeta:Say(Lin,2300,DTOC(TAA->TAA_DTFIRE),oFont11) 
		  	SomaLinha()		  	
			If NGCADICBASE('TAA_FORMUL','A','TAA',.F.) //se usa f๓rmula 
				cFormula := ""
				cDetalhe := ""
				DbSelectArea("TDP")
				TDP->(DbSetOrder(1))
				If !Empty(TAA->TAA_FORMUL) .AND. TDP->(DbSeek(xFilial("TDP")+TAA->TAA_FORMUL))
					cFormula := Alltrim(TDP->TDP_DESCRI)
					cDetalhe := STRTRAN(Alltrim(MSMM(TDP->TDP_FORMUL)),space(2))
					
				EndIf                 
				If !Empty(cFormula)
					oPrintMeta:Say(Lin,75,STR0050,oFont11)	//"F๓rmula: " 
					oPrintMeta:Say(Lin,470,cFormula,oFont11)        
					
					nLinhas :=  MLCOUNT((cDetalhe),60)
					
					oPrintMeta:Say(Lin,1460,STR0051,oFont11) //"Detalhamento: "	
					
					For nCor := 1 to nLInhas
						oPrintMeta:Say(Lin,1100+680,MemoLine(cDetalhe,60,nCor),oFont11) 
						Somalinha()
					Next nCor					
				EndIf
				
				cFormula := ""
				cDetalhe := ""
				DbSelectArea("TDP")
				TDP->(DbSetOrder(1))
				If !Empty(TAA->TAA_FORFEC) .AND. TDP->(DbSeek(xFilial("TDP")+TAA->TAA_FORFEC))
					cFormula := Alltrim(TDP->TDP_DESCRI)
					cDetalhe := STRTRAN(Alltrim(MSMM(TDP->TDP_FORMUL)),space(2))					
				EndIf         
				
				If !Empty(cFormula)
					Somalinha()
					oPrintMeta:Say(Lin,75,STR0053,oFont11)					//"F๓rmula Compilado: " 
					oPrintMeta:Say(Lin,520,cFormula,oFont11)                                         
					
					nLinhas :=  MLCOUNT((cDetalhe),60)
					
					oPrintMeta:Say(Lin,1460,STR0051,oFont11) //"Detalhamento: "	
					
					For nCor := 1 to nLInhas
						oPrintMeta:Say(Lin,1100+680,MemoLine(cDetalhe,60,nCor),oFont11) 
						Somalinha()
					Next nCor
					
				EndIf
				
			Else  
				Somalinha()  			
			EndIf		   
		EndIf
					
		dbSelectArea("TBK")
		dbSetOrder(1)
		If dbSeek(xFilial("TBK")+TBI->TBI_OBJETI+TBI->TBI_META)
			oPrintMeta:Say(Lin,75,STR0042,oFont11) //"Resultados:"
			Lin += 5
			Somalinha()
		EndIf
		
		If !Empty(TAA->TAA_DTPRFI)
			oPrintMeta:Say(Lin,75,STR0052+IIF(TAA->TAA_DTPRFI=="1","   Sim",IIF(TAA->TAA_DTPRFI=="2","   Nใo","")),oFont11) //"Finaliza Dt. Prev. "
			SomaLinha()
		EndIf              
		
		aResultado := {}
		//Percorre resultados da meta
		dbSeek(xFilial("TBK")+TBI->TBI_OBJETI+TBI->TBI_META)
		While !eof() .and. xFilial("TBK")+TBI->TBI_OBJETI+TBI->TBI_META == TBK->TBK_FILIAL+TBK->TBK_CODOBJ+TBK->TBK_META
			oPrintMeta:Say(Lin,75,STR0043+DTOC(TBK_DTRESU),oFont11) //"Data: "
			oPrintMeta:Say(Lin,450+110,STR0027+TBK->TBK_RESPON+" - "+Substr(NGSEEK("QAA",TBK->TBK_RESPON,1,"QAA->QAA_NOME"),1,30),oFont11) //"Responsแvel: "
			oPrintMeta:Say(Lin,2610,STR0044,oFont11)					//"Valor: "
			oPrintMeta:Say(Lin,2900,Transform(TBK->TBK_VALOR,"@E 999,999,999"),oFont11) 
			
			
			AADD(aResultado,{" ",TBK->TBK_DTRESU,TBK->TBK_VALOR})
			
			//Verifica a legenda da Meta
			nLegMeta := SG310VLEG(TBI->TBI_META,TBK->TBK_VALOR,TBK->TBK_DTRESU)
			//Se meta nใo atingida
			If nLegMeta == -1
				If File(cImagens+"NG_METAS_BAIXO_LEG.PNG")
					oPrintMeta:SayBitmap(Lin,2500,cImagens+"NG_METAS_BAIXO_LEG.PNG",45,45)
				EndIf
			ElseIf nLegMeta == 0//Se Atingida
				If File(cImagens+"NG_METAS_IGUAL_LEG.PNG")
					oPrintMeta:SayBitmap(Lin,2500,cImagens+"NG_METAS_IGUAL_LEG.PNG",45,45)
				EndIf
			ElseIf nLegMeta == 1//Se acima da meta
				If File(cImagens+"NG_METAS_CIMA_LEG.PNG")
					oPrintMeta:SayBitmap(Lin,2500,cImagens+"NG_METAS_CIMA_LEG.PNG",45,45)
				EndIf
			EndIf
			Somalinha()
			dbSelectArea("TBK")
			dbSkip()
		End        
                                                         
		If NGCADICBASE('TAA_FORMUL','A','TAA',.F.) //se usa f๓rmula 
			
			nCompilado := Sg31Comp(TAA->TAA_CODPLA,TAA->TAA_DTFIRE,aResultado,.T.,.T.)
			
			If ValType(nCompilado) == "N"			
				oPrintMeta:Say(Lin,2610,STR0054,oFont11)	//"Compilado Geral: "
				oPrintMeta:Say(Lin,2900,Transform(nCompilado,"@E 999,999,999"),oFont11) 
			EndIf
			
		EndIf
		
		SomaLinha()			
		If MV_PAR10 == 1
			nLinMemo := MlCount(TAA->TAA_OBS,080)
			Somalinha()
			oPrintMeta:Say(Lin,75,STR0059,oFont11)//"Observa็๕es: "
			For i := 1 to nLinMemo
				oPrintMeta:Say (Lin,430, Memoline(TAA->TAA_OBS,080,i),oFont11)
				SomaLinha()		
			Next
		EndIf
		Somalinha()
		oPrintMeta:Line(Lin,75,Lin,1000)
		
		SomaLinha()	
		dbSelectArea("TBI")
		dbSkip()
	End
	dbSelectArea("TBH")
	dbSkip()	
End

//Verifica se existem dados para montar o relat๓rio
If lPrint
	If Mv_Par09 == 1
		oPrintMeta:Preview()
	Else
		oPrintMeta:Print()
	EndIf
Else
	MsgInfo(STR0045,STR0046) //"Nใo existem dados para montar o relat๓rio."###"Aten็ใo"
EndIf

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSomalinha บAutor  ณRoger Rodrigues     บ Data ณ  21/01/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณIncremeta linha e imprime cabe็alho                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSGAR140                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Somalinha(lCabec)
//Varแiveis para controle de empresa e filial
Local cSMCOD := If(FindFunction("FWGrpCompany"),FWGrpCompany(),SM0->M0_CODIGO)
Local cSMFIL := If(FindFunction("FWCodFil"),FWCodFil(),SM0->M0_CODFIL)
Lin += 45

//Termina Folha
If Lin > 2300
	oPrintMeta:EndPage()
	lCabec := .T.
	Lin := 320
EndIf
//Impressใo do cabecalho
If lCabec
	oPrintMeta:StartPage()
	oPrintMeta:Line(50, 0, 50, 5000)
	//Procura logo para impressใo
	cLogo := cStartPath+"LGRL"+cSMCOD+cSMFIL+".BMP"
	If !File(cLogo)
		cLogo := cStartPath+"LGRL"+cSMCOD+".BMP"	
	EndIf
	//Imprime logo da empresa
	If File(cLogo)
		oPrintMeta:SayBitMap(60,30,cLogo,305,155)
	EndIf
	oPrintMeta:Say(230,10,"SIGA / SGAR140",oFont11)
	oPrintMeta:Say(110,1200,STR0022,oFont13) //"Relat๓rio de Objetivos e Metas"
	oPrintMeta:Say(90,2450,STR0047+AllTrim(Str(nPagNum)),oFont11) //"Folha..:"
	oPrintMeta:Say(150,2450,STR0048+AllTrim(DTOC(dDatabase)),oFont11) //"Emissใo:"
	oPrintMeta:Say(210,2450,STR0049+SubStr(Time(),1,5),oFont11) //"Hora...:"
	oPrintMeta:Line(280, 0, 280, 5000)
	Lin := 320
	//Incrementa Numero de Pแgina
	nPagNum ++
EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSGR140IMG บAutor  ณRoger Rodrigues     บ Data ณ  22/01/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExtrai imagens                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSGAR140                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SGR140IMG()
Local nX
Local aImagens		:= {	"NG_METAS_CIMA_LEG.PNG","NG_METAS_BAIXO_LEG.PNG","NG_METAS_IGUAL_LEG.PNG",;
							"NG_METAS_CIMA_16.PNG","NG_METAS_BAIXO_16.PNG","NG_METAS_IGUAL_16.PNG"}
//Cria Pasta Temp
If !ExistDir(cTemp)
	MakeDir(cTemp)
EndIf
//Cria pasta no Temp
If !ExistDir(cImagens)
	MakeDir(cImagens)
EndIf	

For nX := 1 to Len(aImagens)
	//Exclui imagem se ela ja existir no diretorio
	FErase(cImagens+aImagens[nX])

	//Exporta imagens do RPO para a pasta especificada
	Resource2File(aImagens[nX],cImagens+aImagens[nX])
Next nX

Return .T.