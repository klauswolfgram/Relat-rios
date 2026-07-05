/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR87P.ch"      
#INCLUDE "Protheus.ch"      

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR87P   ºAutor  ³ Ana Paula Nascimento º Data ³ 27/11/09  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio de comprovante de percepção de IGV. (Peru)		 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                    º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS     ³ Motivo da Alteracao                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Jonathan Glz³24/06/15³PCREQ-4256³Se elimina la funcion ajustaSX1() por ³±±
±±³            ³        ³          ³motivo de adecuacion a fuentes para   ³±±
±±³            ³        ³          ³nuevas estructuras SX para Version 12.³±±
±±³            ³        ³          ³                                      ³±±
±±³Jonathan Glz³09/10/15³PCREQ-4261³Merge v12.1.8                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Finr87P(cCert,cSerieC,lDireto)

Local cPerg := "FIN87P"
Default lDireto := .F.

If !lDireto
	If !Pergunte(cPerg,.T.)
		Return nil
	EndIf
EndIf	

Print87P(cCert,cSerieC,lDireto)

return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Print87P  ºAutor  ³Ana Paula Nascimentoº Data ³ 27/11/09  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio de comprovante de percepção de IGV. (Peru)		 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Print87P(cCert,cSerieC,lDireto)
Local aNfs	:= {}
Local cChave
Local cTitulo	:= STR0001 //"COMPROVANTE DE PERCEPCAO DE IGV"
Local oPrint 
Local CTipDoc := ""
Local cDescTipo:= ""
Local lPrint:= .T.
oPrint	:= TMSPrinter():New( cTitulo )
//oPrint:SetPortrait() //Retrato
oPrint:SetLandscape() //Paisagem

If !lDireto   
	cCert:=MV_PAR01
	cSerieC:=MV_PAR02 
EndIf	

DbSelectArea("SFE")
DbSetOrder(9)
lPrint:= (DbSeek(xFilial("SFE")+Alltrim(cCert)+"P") .OR. !lDireto )

cCliente:=SFE->FE_CLIENTE
cLoja:=SFE->FE_LOJCLI
dEmisCert:=SFE->FE_EMISSAO 

DbSelectArea("SA1")
DbSetOrder(1)
DbSeek(xFilial("SA1") + SFE->FE_CLIENTE + SFE->FE_LOJCLI)  
cNome:=SA1->A1_NOME
cRUCCli:=SA1->A1_CGC // Numero do RUC do cliente 
CTipDoc:=SA1->A1_TIPDOC

CImgNome:= AllTrim(SM0->M0_ENDENT)+" "+AllTrim(SM0->M0_CIDENT)+" "+AllTrim(SM0->M0_ESTENT)+" "+AllTrim(SM0->M0_CEPENT)

cChave:=xFilial("SFE")+cCert+Alltrim(cSerieC)+cCliente+cLoja+"P" 

Do While cChave==SFE->FE_FILIAL+SFE->FE_NROCERT+Alltrim(SFE->FE_SERIEC)+SFE->FE_CLIENTE+SFE->FE_LOJCLI+SFE->FE_TIPO .And. !SFE->(Eof())
	
	aArea:=GetArea()
	dbSelectArea("SE1")
	dbSetOrder(2)
	If dbSeek(xFilial("SE1")+SFE->FE_CLIENTE+SFE->FE_LOJCLI+SFE->FE_SERIE+SFE->FE_NFISCAL)
		dEmissao:=SE1->E1_EMISSAO
	Else
		dEmissao:=SFE->FE_EMISSAO	
	EndIf	

	dbSelectArea("CCM")
	dbSetOrder(1)
	dbSeek(xFilial("CCM")+SFE->FE_ESPECIE)
	
	dbSelectArea("CCL")
	dbSetOrder(1)
	dbSeek(xFilial("CCL")+CCM->CCM_CODGOV)	
	cEspecie:= CCL->CCL_CODGOV
			
	aAdd( aNfs , {SFE->FE_SERIE,SFE->FE_NFISCAL,SFE->FE_VALBASE,SFE->FE_VALIMP,SFE->FE_ALIQ,SFE->FE_SERIEC,dEmissao,cEspecie})
	RestArea(aArea)	
	SFE->(DbSkip())

EndDo

SX5->(MsSeek(xFilial("SX5")+"TB"+ CTipDoc ))
cDescTipo :=  Alltrim(SX5->(X5Descri()))

If lPrint
	PrintPag( oPrint , aNfs,cCert,cSerieC,cDescTipo )
	oPrint:Preview()
Endif 

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PrintPag ºAutor  ³Ana Paula Nascimentoº Data ³ 27/11/09  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio de comprovante de percepção de IGV. (Peru)		 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintPag( oPrint , aNfs,cCert,cSerieC,cDescTipo)

Local cStartPath:= GetSrvProfString("StartPath","")
Local cBmp 		:= cStartPath + "lgrl.bmp" //Logo
Local oFont1	:= TFont():New("Arial",14,14,,.T.,,,,.T.,.F.)// Fonte o Titulo Negrito
Local oFont2	:= TFont():New("Arial",11,11,,.F.,,,,.T.,.F.)// Fonte do Sub-Titulo
Local oFont3	:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
Local oFont4	:= TFont():New("Arial",14,14,,.F.,,,,.T.,.F.)
Local nI,nX  
Local nTotPer:= 0

For nX:=1 to 3
	nTotPer:=0
	oPrint:StartPage()
	oPrint:Box(0200,0100,2000,2600)  // Margem principal
	oPrint:Box(0250,1550,0710,2500)  // Retangulo do RUC
	oPrint:Say(0280,1870,STR0003+"   "+transf(SM0->M0_CGC,pesqpict("SA1","A1_CGC")),oFont1) // RUC   //"RUC"  
	oPrint:Say(0380,1735,STR0004,oFont1)  //"COMPROVANTE DE PERCEPÇÃO"
	oPrint:Say(0480,1885,STR0005,oFont1)  //"VENDA INTERNA"
	oPrint:Say(0590,1905,cSerieC+STR0006+cCert,oFont1) 	   //" - "
	
	oPrint:SayBitmap(0300, 0400,cBmp, 350, 350) //Logo
	oPrint:Say( 0680,0300,CImgNome,oFont2) //Logo
	oPrint:Say( 0800,0200,STR0007,oFont2) //  //"Senhores:"
	oPrint:Say( 0800,0500,cNome,oFont2) // Cliente
	
	oPrint:Say( 0855,0200,STR0026,oFont2) // Retenção //"RUC:"
	oPrint:Say( 0855,0950,cDescTipo+" : " + transf(SM0->M0_CGC,pesqpict("SA1","A1_CGC")),oFont2) // Ruc Do cliente
	
	oPrint:Say( 0910,0200,STR0008,oFont2) // Emissão //"Emissão:"
	oPrint:Say( 0910,0500,Dtoc(dEmisCert),oFont2) // Emissão do comprovante
	
	oPrint:box(0985,0200,1085,1170) 							
	oPrint:Say(0989,0285,STR0009,oFont2)  //"Comprovante de Pagamento ou Nota de"
	oPrint:Say(1042,0450,STR0010,oFont2)	//"Debito do Cliente"
	
	oPrint:box(1085,0200,1160,0350) // Caixa Tipo Doc	 
	oPrint:Say(1105,0215,STR0011,oFont2) // Tipo
	
	oPrint:box(1085,0350,1160,0800) // Caixa numero e serie  
  	oPrint:Say(1105,0495,STR0012,oFont2) // numero e serie //"Serie-Nro"
	
	oPrint:box(1085,0800,1160,1170)  // Caixa emissao
	oPrint:Say(1105,0865,STR0008,oFont2) // emissao		
	
	oPrint:box(0985,1170,1160,1502)      //Caixa base
 	oPrint:Say(1030,1225,STR0013,oFont2) // base //
 	oPrint:Say(1090,1245,STR0014,oFont2) // base //
 	
	oPrint:box(0985,1502,1160,1802)            //Caixa aliquota  
 	oPrint:Say(1030,1520,STR0015,oFont2) //aliquota
 	oPrint:Say(1090,1520,STR0016,oFont2) // aliquota
	
	oPrint:box(0985,1802,1160,2102)    //Caixa percepcao
 	oPrint:Say(1030,1845,STR0017,oFont2) // percepçao
 	oPrint:Say(1090,1830,STR0018,oFont2) // Percepção
	
	oPrint:box(0985,2102,1160,2498)    // Caixa Valor total cobrado
 	oPrint:Say(1030,2165,STR0019,oFont2) // Valor total cobrado
 	oPrint:Say(1090,2180,STR0020,oFont2) // Valor total cobrado
	 		
	If nX==1
		oPrint:Say( 1940,2300,STR0021,oFont4) 	 //"CLIENTE"
	Elseif nX==2
		oPrint:Say( 1940,2300,STR0022,oFont4)  //"EMISSOR"
	Else
		oPrint:Say( 1940,2300,STR0023,oFont4) //"SUNAT"
	EndIf  
		
		oPrint:Line(1935,380,1935,1000)
		oPrint:Say( 1940,600,STR0025,oFont4) //Baixado"	
		
	nLin:=1160
	For nI:= 1 To Len(aNFs)
	
		oPrint:box(nLin-2,200,nLin+69,350) // Tipo Doc						
	 	oPrint:box(nLin-2,350,nLin+69,800) // numero e serie
	 	oPrint:box(nLin-2,800,nLin+69,1170)  // emissao
	 	oPrint:box(nLin-2,1170,nLin+69,1502)  //base
	 	oPrint:box(nLin-2,1502,nLin+69,1802) //aliq
	 	oPrint:box(nLin-2,1802,nLin+69,2102)  //percepcao
	 	oPrint:box(nLin-2,2102,nLin+69,2498)   // valor pago
	 		
		oPrint:Say( nLin+10,210,aNFs[nI,8],oFont3) // Tipo Doc
		oPrint:Say( nLin+10,400,aNFs[nI,1],oFont3) // Serie
		oPrint:Say( nLin+10,460,aNFs[nI,2],oFont3) // Numero da nota fiscal 
		oPrint:Say( nLin+10,900,Dtoc(aNFs[nI,7]),oFont3) // Data emissão NF
		oPrint:Say( nLin+10,1200,Transform(aNFs[nI,3], "@E 999,999,999.99"),oFont3) // valor base
		oPrint:Say( nLin+10,1610,Transform(aNFs[nI,5], "@E 999")+"%",oFont3)	// aliquota
		oPrint:Say( nLin+10,1800,Transform(aNFs[nI,4], "@E 999,999,999.99"),oFont3) // valor da percepção
		oPrint:Say( nLin+10,2165,Transform((aNFs[nI,3]+aNFs[nI,4]), "@E 999,999,999.99"),oFont3)   // Total recebido
	
	    nLin+=70
		nTotPer+= aNFs[nI,4]
		
	Next
		
		oPrint:box(nLin-2,1170,nLin+80,1802)
	 	oPrint:Say(nLin+15,1185,STR0024,oFont2) //"Caixa Valor Total de Percepção"
		oPrint:box(nLin-2,1802,nLin+80,2102)
		oPrint:Say( nLin+15,1790,Transform(nTotPer, "@E 999,999,999.99"),oFont2)	//"Valor Total de Percepção"
	
		oPrint:EndPage()
Next
Return
