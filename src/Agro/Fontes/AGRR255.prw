/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³ AGRR255  ³ Autor ³ Danyel Bernuci        ³ Data ³ 09/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Producao Por Talhao							              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAAGR                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³           ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function AGRR255()
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Media de Producao por Talhao"
Local titulo         := "Produção por Talhão"
Local nLin           := 220
Local Cabec1         := ""
Local Cabec2         := ""

Private aOrd        := {}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := 'AGRR255'
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private cPerg       := "AGR255"
Private wnrel       := "AGRR255"

dbSelectArea("NN4")
dbSetOrder(1)

Pergunte(cPerg,.F.)

wnrel := SetPrint('NN4',NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.f.,aOrd,.f.,Tamanho,,.t.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,'NN4')

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³RunReport ³ Autor ³ Danyel Bernuci        ³ Data ³ 09/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ³±±
±±³			 ³ monta a janela com a regua de processamento.				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ AGRR255                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local 	aArea   	:= GetArea()
Local 	aAbreFecha	:=	{"Aberto","Fechado"}                          
Local	aVarieds	:=	{}
Local 	cFiltro 	:= ""
Local	nPerVar		:=	0
Local	cUm			:=	Alltrim(Posicione("SB1",1,xFilial("SB1")+Alltrim(Posicione('NN1',1,xFilial('NN1')+Alltrim(mv_par01),'NN1_CODPRO')),"B1_UM"))
Local	cDescUm		:=	Posicione('SAH',1,xFilial('SAH')+If(Len(Alltrim(mv_par10))==0,cUm,Alltrim(mv_par10)),"AH_DESCPO")
Local	cFiltUser	:=	aReturn[7]
Local	aTpDesp		:=	{}
Local	cAbeFech	:=	''
Local	lFirstFaz	:=	.t.
Local	lFirstTal	:=	.t.
Local 	nHectar		:=	0
Local 	nGHectar	:=	0
Local 	nVHectar	:=	0
Local 	nTALHec		:=	0	
Local 	nPrevis		:=	0	
Local 	nGPrevis	:=	0
Local 	nVPrevis	:=	0
Local 	nTALPre		:=	0	
Local 	nRealiz		:=	0	
Local 	nGRealiz	:=	0
Local 	nVRealiz	:=	0
Local 	nTALRea		:=	0	
Local 	nPBruto		:=	0	
Local 	nGPBruto	:=	0
Local 	nVPBruto	:=	0
Local 	nTALBru		:=	0	
Local 	nDescOU		:=	0	
Local 	nGDescOU	:=	0
Local 	nVDescOU	:=	0
Local 	nTALDOU		:=	0	
Local 	nPDesOU		:=	0	
Local 	nGPDesOU	:=	0
Local 	nVPDesOU	:=	0
Local 	nTALPOU		:=	0	
Local 	nPLiqui		:=	0	
Local 	nGPLiqui	:=	0
Local 	nVPLiqui	:=	0
Local 	nTALPLi		:=	0	
Local	nCarga		:=	0	
Local 	nGCarga		:=	0
Local 	nVCarga		:=	0
Local	nTALCar		:=	0	
Local	nQtdVarie	:=	0
Local	nSQtdTaA	:=	0
Local	nSQtdTaF	:=	0
Local	_c,__k
Local	nCargTrans	:=	0
Local	nPesExtim	:=	0

Private	nASHectar	:=	0	
Private	nFSHectar	:=	0	
Private	nATHectar	:=	0	
Private	nFTHectar	:=	0	
Private	nASPrevis	:=	0	
Private	nFSPrevis	:=	0	
Private	nATPrevis	:=	0	
Private	nFTPrevis	:=	0	
Private	nASRealiz	:=	0	
Private	nFSRealiz	:=	0	
Private	nATRealiz	:=	0	
Private	nFTRealiz	:=	0	
Private	nASPBruto	:=	0	
Private	nFSPBruto	:=	0	
Private	nATPBruto	:=	0	
Private	nFTPBruto	:=	0	
Private	nASPLiqui	:=	0	
Private	nFSPLiqui	:=	0	
Private	nATPLiqui	:=	0	
Private	nFTPLiqui	:=	0	
Private	nASCarga	:=	0	
Private	nFSCarga	:=	0	
Private	nATCarga	:=	0	
Private	nFTCarga	:=	0	
Private	nDesc1		:=	0	
Private	nTALD1		:=	0	
Private	nPDes1		:=	0	
Private	nTALP1		:=	0	
Private	nASDesc1	:=	0	
Private	nFSDesc1	:=	0	
Private	nAPSDes1	:=	0	
Private	nFPSDes1	:=	0	
Private	nATDesc1	:=	0	
Private	nFTDesc1	:=	0	
Private	nAPTDes1	:=	0
Private	nFPTDes1	:=	0
Private	nGDesc1		:=	0	
Private	nGPDes1		:=	0	
Private	nVDesc1		:=	0	
Private	nVPDes1		:=	0	
Private	nDesc2		:=	0	
Private	nTALD2		:=	0	
Private	nPDes2		:=	0	
Private	nTALP2		:=	0	
Private	nASDesc2	:=	0	
Private	nFSDesc2	:=	0	
Private	nAPSDes2	:=	0	
Private	nFPSDes2	:=	0	
Private	nATDesc2	:=	0	
Private	nFTDesc2	:=	0	
Private	nAPTDes2	:=	0
Private	nFPTDes2	:=	0
Private	nGDesc2		:=	0	
Private	nGPDes2		:=	0	
Private	nVDesc2		:=	0	
Private	nVPDes2		:=	0	
Private	nDesc3		:=	0	
Private	nTALD3		:=	0	
Private	nPDes3		:=	0	
Private	nTALP3		:=	0	
Private	nASDesc3	:=	0	
Private	nFSDesc3	:=	0	
Private	nAPSDes3	:=	0	
Private	nFPSDes3	:=	0	
Private	nATDesc3	:=	0	
Private	nFTDesc3	:=	0	
Private	nAPTDes3	:=	0
Private	nFPTDes3	:=	0
Private	nGDesc3		:=	0	
Private	nGPDes3		:=	0	
Private	nVDesc3		:=	0	
Private	nVPDes3		:=	0	
Private	nDesc4		:=	0	
Private	nTALD4		:=	0	
Private	nPDes4		:=	0	
Private	nTALP4		:=	0	
Private	nASDesc4	:=	0	
Private	nFSDesc4	:=	0	
Private	nAPSDes4	:=	0	
Private	nFPSDes4	:=	0	
Private	nATDesc4	:=	0	
Private	nFTDesc4	:=	0	
Private	nAPTDes4	:=	0
Private	nFPTDes4	:=	0
Private	nGDesc4		:=	0	
Private	nGPDes4		:=	0	
Private	nVDesc4		:=	0	
Private	nVPDes4		:=	0	
Private	nASDescOU	:=	0	
Private	nFSDescOU	:=	0	
Private	nAPSDesOU	:=	0	
Private	nFPSDesOU	:=	0	
Private	nATDescOU	:=	0	
Private	nFTDescOU	:=	0	
Private	nAPTDesOU	:=	0
Private	nFPTDesOU	:=	0	

//Variaveis para arquivos temporarios
Private cArqTMP := ""
Private cIndTMP := ""
Private cChvTMP := ""
Private aArqTMP := {}

titulo	:= Alltrim(titulo) +" - Safra: "+AllTrim(Substr((Posicione('NN1',1,xFilial('NN1')+Alltrim(mv_par01),'NN1_DESCRI')),1,25))
titulo  += " - Produto: "+AllTrim(SubStr(NN1->NN1_DESPRO,1,20))+" - Periodo de: "+Dtoc(mv_par06)+" a "+Dtoc(mv_par07)

cFiltro := "NN4_SAFRA=MV_PAR01 .And. "
cFiltro += "NN4_FAZ >= MV_PAR02 .And. "
cFiltro += "NN4_FAZ <= MV_PAR03 .And. "
//Considera Filiais
If mv_par13==1
	cFiltro += "NN4_FILIAL >= MV_PAR14 .And. "
	cFiltro += "NN4_FILIAL <= MV_PAR15 .And. "
Endif
cFiltro += "NN4_TALHAO >= MV_PAR04 .And. "
cFiltro += "NN4_TALHAO <= MV_PAR05"
	
dbSetFilter( {|| &cFiltro }, cFiltro )

		 //          0         0         0         0         0         0         0         0         0         1         1         1         1
		 //          1         2         3         4         5         6         7         8         9         0         1         2         3
		 //012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
Cabec1 := "Fazenda                                 |"+PadC(AllTrim(cDescUm),151,'-')+"|"
Cabec2 := "Talhao  Variedade               Area(Ha)| Previsto/Ha Realizado/Ha   Peso Bruto"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Cria o Cabecalho de acordo com os tipos de descontos escolhidos³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For _c := 1 To Len(mv_par12) Step 6
	DbSelectArea("NNH")
	DbSetOrder(1)
	If DbSeek(xFilial("NNH")+SubStr(mv_par12,_c,6))
		Cabec2 +=	Space(13-Len(Alltrim((Upper(SubStr(nnh->nnh_descri,1,1))+Lower(SubStr(nnh->nnh_descri,2,11))))))+Alltrim((Upper(SubStr(nnh->nnh_descri,1,1))+Lower(SubStr(nnh->nnh_descri,2,11))))+Space(03)+"%"+Upper(SubStr(nnh->nnh_descri,1,1))+Lower(SubStr(nnh->nnh_descri,2,2))		
		Aadd(aTpDesp,nnh->nnh_codigo)
	Endif
Next _c 
For _c := (Len(aTpDesp)+1) To 4	
	Cabec2	+=	" Xxxxxxxxxxxx   %Xxx" 	
Next _c
Cabec2 +="       Outros   %Out Peso Liquido| "+If(Len(Alltrim(mv_par11))==0,"P.Liq./SEGUM","P.Liquido/"+Alltrim(mv_par11))+"      Cargas F"

DbSelectArea('NN4')
DbSetOrder(2)
SetRegua(RecCount())
nn4->(Dbgotop())
While nn4->(!Eof())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verficia o Status de Talhao a Listar            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("NN3")
	DbSetOrder(1)		
	DbSeek(If(Len(Alltrim(xFilial("NN3")))==0,xFilial("NN3"),nn4->nn4_filial)+nn4->nn4_safra+nn4->nn4_faz+nn4->nn4_talhao)
	cAbeFech		:=	Upper(Alltrim(nn3->nn3_fechad))	
	If mv_par08<>3
		If mv_par08==1
			If	cAbeFech=="S" 
				nn4->(DbSkip())
				Loop
			Endif			
		Else
			If	cAbeFech=="N" 
				nn4->(DbSkip())
				Loop
			Endif					
	    Endif
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Avalia filtro do usuario                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFiltUser).And.!(&cFiltUser)
		dbSkip()
		Loop
	EndIf

   	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      	If nLin < 80
	  		Roda()
	  	EndIf
      	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      	nLin := 9
   	Endif             

   	If lAbortPrint
      	@nLin,00 Psay "*** CANCELADO PELO OPERADOR ***"
      	Exit
   	Endif
                                                                                                          
	lFirstFaz	:=	.t.
	
    cFazenda	:=	nn4->nn4_faz                                                   

	nASHectar	:=	0	
	nFSHectar	:=	0	
	nASPrevis	:=	0	
	nFSPrevis	:=	0	
	nASRealiz	:=	0	
	nFSRealiz	:=	0	
	nASPBruto	:=	0	
	nFSPBruto	:=	0	
	nASDescOU	:=	0	
	nFSDescOU	:=	0	
	nAPSDesOU	:=	0	
	nFPSDesOU	:=	0	
	nASPLiqui	:=	0	
	nFSPLiqui	:=	0	
	nASCarga	:=	0	
	nFSCarga	:=	0	

	nASDesc1	:=	0	
	nFSDesc1	:=	0	
	nAPSDes1	:=	0	
	nFPSDes1	:=	0	
	nASDesc2	:=	0	
	nFSDesc2	:=	0	
	nAPSDes2	:=	0	
	nFPSDes2	:=	0	
	nASDesc3	:=	0	
	nFSDesc3	:=	0	
	nAPSDes3	:=	0	
	nFPSDes3	:=	0	
	nASDesc4	:=	0	
	nFSDesc4	:=	0	
	nAPSDes4	:=	0	
	nFPSDes4	:=	0	

	nSQtdTaA	:=	0
	nSQtdTaF	:=	0

	While nn4->(!Eof()) .And. nn4->nn4_faz==cFazenda
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verficia o Status de Talhao a Listar            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("NN3")
		DbSetOrder(1)
		DbSeek(If(Len(Alltrim(xFilial("NN3")))==0,xFilial("NN3"),nn4->nn4_filial)+nn4->nn4_safra+nn4->nn4_faz+nn4->nn4_talhao)
		cAbeFech		:=	Upper(Alltrim(nn3->nn3_fechad))	
		If mv_par08<>3
			If mv_par08==1
				If	cAbeFech=="S" 
					nn4->(DbSkip())
					Loop
				Endif			
			Else
				If	cAbeFech=="N" 
					nn4->(DbSkip())
					Loop
				Endif					
		    Endif
		Endif
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFiltUser).And.!(&cFiltUser)
			dbSkip()
			Loop
		EndIf	
	
	   	If lAbortPrint
	      	@nLin,00 Psay "*** CANCELADO PELO OPERADOR ***"
	      	Exit
	   	Endif
	                                                                                                          
	   	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	      	If nLin < 80
		  		Roda()
		  	EndIf
	      	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	      	nLin := 9
	   	Endif             

    	cTalhao		:=	nn4->nn4_talhao                                                   

		lFirstTal   :=	.t.     

		nTALHec		:=	0	
		nTALPre		:=	0	
		nTALRea		:=	0	
		nTALBru		:=	0	
		nTALDOU		:=	0	
		nTALPOU		:=	0	
		nTALPLi		:=	0	
		nTALCar		:=	0	

		nTALD1		:=	0	
		nTALP1		:=	0	
		nTALD2		:=	0	
		nTALP2		:=	0	
		nTALD3		:=	0	
		nTALP3		:=	0	
		nTALD4		:=	0	
		nTALP4		:=	0	

		nQtdVarie	:=	0

		nCarga		:=	0

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calcula a Quantidade de Carga ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("NPA")
		DbSetOrder(2)
		If DbSeek(xFilial("NPA")+nn4->nn4_safra+nn4->nn4_faz+nn4->nn4_talhao)
			While npa->(!Eof()) .And. npa->npa_filial==cFilial .And. npa->npa_safra==nn4->nn4_safra .And. npa->npa_faz==nn4->nn4_faz .And. npa->npa_talhao==nn4->nn4_talhao 
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Procura o Romaneio Relacionado ao Apontamento³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectArea("NPO")
				DbSetOrder(2)
				If DbSeek(xFilial("NPO")+npa->npa_codigo)
                	nCarga++
				Else
					nCargTrans++
					nPesExtim	+=	npa->npa_qtdest										
				Endif        
        		npa->(DbSkip())
        	EndDo
        Endif

		aDdTalhao	:=	{}       

		n0Desc1		:=	0	
		n0PDes1		:=	0	
		n0Desc2		:=	0	
		n0PDes2		:=	0	
		n0Desc3		:=	0	
		n0PDes3		:=	0	
		n0Desc4		:=	0	
		n0PDes4		:=	0	
		n0DescOU	:=	0	
		n0PDesOU	:=	0	
		lBranco		:=	.t.

		While nn4->(!Eof()) .And. nn4->nn4_faz==cFazenda .And. nn4->nn4_talhao==cTalhao
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verficia o Status de Talhao a Listar            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea("NN3")
			DbSetOrder(1)
			DbSeek(If(Len(Alltrim(xFilial("NN3")))==0,xFilial("NN3"),nn4->nn4_filial)+nn4->nn4_safra+nn4->nn4_faz+nn4->nn4_talhao)
			cAbeFech		:=	Upper(Alltrim(nn3->nn3_fechad))	
			If mv_par08<>3
				If mv_par08==1
					If	cAbeFech=="S" 
						nn4->(DbSkip())
						Loop
					Endif			
				Else
					If	cAbeFech=="N" 
						nn4->(DbSkip())
						Loop
					Endif					
			    Endif
			Endif
				
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Avalia filtro do usuario                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(cFiltUser).And.!(&cFiltUser)
				dbSkip()
				Loop
			EndIf	
		
		   	If lAbortPrint
		      	@nLin,00 Psay "*** CANCELADO PELO OPERADOR ***"
		      	Exit
		   	Endif
		                                                                                                          
		   	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		      	If nLin < 80
			  		Roda()
			  	EndIf
		      	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		      	nLin := 9
		   	Endif                            
		   	
			cAlias	:=	Alias()			
			
    		cCodVar		:=	nn4->nn4_codvar
    		cDescVar    :=	nn4->nn4_desvar

			n0PLiqui	:=	0
			n0PBruto	:=	0

			nHectar		:=	0
			nPrevis		:=	0	
			nRealiz		:=	0	
			nPBruto		:=	0	
			nPLiqui		:=	0	
	
			nDesc1		:=	0	
			nPDes1		:=	0	
			nDesc2		:=	0	
			nPDes2		:=	0	
			nDesc3		:=	0	
			nPDes3		:=	0	
			nDesc4		:=	0	
			nPDes4		:=	0	
			nDescOU		:=	0	
			nPDesOU		:=	0	

			n0Desc1		:=	0	
			n0PDes1		:=	0	
			n0Desc2		:=	0	
			n0PDes2		:=	0	
			n0Desc3		:=	0	
			n0PDes3		:=	0	
			n0Desc4		:=	0	
			n0PDes4		:=	0	
			n0DescOU	:=	0	
			n0PDesOU	:=	0	
				
			While nn4->(!Eof()) .And. nn4->nn4_faz==cFazenda .And. nn4->nn4_talhao==cTalhao .And. nn4->nn4_codvar==cCodVar

				IncRegua('Faz:'+cFazenda+' Talhao:'+cTalhao)        
	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verficia o Status de Talhao a Listar            ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectArea("NN3")
				DbSetOrder(1)
				DbSeek(If(Len(Alltrim(xFilial("NN3")))==0,xFilial("NN3"),nn4->nn4_filial)+nn4->nn4_safra+nn4->nn4_faz+nn4->nn4_talhao)
				cAbeFech		:=	Upper(Alltrim(nn3->nn3_fechad))	
				If mv_par08<>3
					If mv_par08==1
						If	cAbeFech=="S" 
							nn4->(DbSkip())
							Loop
						Endif			
					Else
						If	cAbeFech=="N" 
							nn4->(DbSkip())
							Loop
						Endif					
				    Endif
				Endif
	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Avalia filtro do usuario                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !Empty(cFiltUser).And.!(&cFiltUser)
					dbSkip()
					Loop
				EndIf	
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Alteração para contemplar a area utilizada.     ³
				//³ Ricardo Tomasi -> 2006-01-20                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Empty(nn3->nn3_utilha)
					nHectar		+=	nn4->nn4_hectar
				Else
					nHectar     +=  ((nn3->nn3_utilha*((nn4->nn4_hectar*100)/nn3->nn3_hectar))/100)
				EndIf
				nPrevis		+=	nn4->nn4_medpro
	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Procura os Apontamentos de Producao do Talhao³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectArea("NPA")
				DbSetOrder(2)
				If DbSeek(xFilial("NPA")+nn4->nn4_safra+nn4->nn4_faz+nn4->nn4_talhao)
					While npa->(!Eof()) .And. npa->npa_filial==cFilial .And. npa->npa_safra==nn4->nn4_safra .And. npa->npa_faz==nn4->nn4_faz .And. npa->npa_talhao==nn4->nn4_talhao 								
													
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³Procura as Variedades dos Apontamentos³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					    	DbSelectArea("NPB")
					    	DbSetOrder(2)
					    	If DbSeek(xFilial("NPB")+npa->npa_codigo+nn4->nn4_codvar)	
	                    		nPerVar	:=	npb->npb_pervar		
					        Else
								npa->(dbSkip())
							    Loop				        	
					        Endif
	
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³Procura o Romaneio Relacionado ao Apontamento³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							DbSelectArea("NPO")
							DbSetOrder(2)
							If DbSeek(xFilial("NPO")+npa->npa_codigo)
								
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³Valida a Data e se o Talhao esta fechado³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								If !(npo->npo_data >= MV_PAR06 .And. npo->npo_data <= MV_PAR07)
									npo->(dbSkip())
								    Loop
								Endif
		
								nPLiqui	:=	((npo->npo_psliqu*nPerVar)/100)
								nPBruto	:=	((npo->npo_pssubt*nPerVar)/100)
								n0PLiqui+=	nPLiqui
								n0PBruto+=	nPBruto		   

								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³Procura nos Itens Romaneio Relacionado ao Apontamento³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								DbSelectArea("NPP")
								DbSetOrder(1)
								If DbSeek(xFilial("NPP")+npo->npo_codigo) 
									While npp->(!Eof()) .And. npp->npp_filial==cFilial .And. npp->npp_codigo==npo->npo_codigo


										_c	:=	aScan(aTpDesp,Alltrim(npp->npp_coddes))

										If _c>0
											&("nDesc"+StrZero(_c,1))	+=	If(nPBruto>0,npp->npp_pesdes,0)
											&("nPDes"+StrZero(_c,1))	+=	(nPBruto*npp->npp_perdes)											
											&("n0Desc"+StrZero(_c,1))	+=	If(nPBruto>0,npp->npp_pesdes,0)
											&("n0PDes"+StrZero(_c,1))	+=	(nPBruto*npp->npp_perdes)											
										Else
											nDescOU		+=	If(nPBruto>0,npp->npp_pesdes,0)
											nPDesOU		+=	(nPBruto*npp->npp_perdes)											
											n0DescOU	+=	If(nPBruto>0,npp->npp_pesdes,0)
											n0PDesOU	+=	(nPBruto*npp->npp_perdes)											
										Endif					

	                            		npp->(dbSkip())
	                            	EndDo
							    Endif
							Endif									        
						npa->(dbSkip())
	    			EndDo
	    		Endif
				nn4->(dbSkip())    			    	
	    	EndDo	

			nPLiqui := 	n0PLiqui
			nPBruto	:=	n0PBruto					

    		DbSelectArea(cAlias)
            
			For _c	:= 1 to 4
				&("nPDes"+StrZero(_c,1))	:=	 ((&("nPDes"+StrZero(_c,1)))/nPBruto)						
			Next _c
			
			nPDesOU		:=	(nPDesOU/nPBruto)	
			
			nRealiz		:=	(nPLiqui/nHectar)	
			
			Aadd(aDdTalhao,{cCodVar,cDescVar,nHectar,nPrevis,nRealiz,nPBruto,nDesc1,nPDes1,nDesc2,nPDes2,nDesc3,nPDes3,nDesc4,nPDes4,nDescOU,nPDesOU,nPLiqui,n0Desc1,n0PDes1,n0Desc2,n0PDes2,n0Desc3,n0PDes3,n0Desc4,n0PDes4,n0DescOU,n0PDesOU})  								

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Valida se o Talhao esta em Transito³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lBranco .And. nPBruto>0 
         		lBranco	:=	.f.
        	Endif

        EndDo                     				
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÈ¿
		//³Faz os calculos as impressoes das Variedades do Talhao³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÈÙ
		For __k := 1 to Len(aDdTalhao)
            //Listar Carga em Transito
            If !lBranco
   				nQtdVarie++    		
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Se teve carga na Fazenda³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lFirstFaz
					lFirstFaz	:=	.f.
					@ nLin,001 PSay PadR(Posicione("NN2",2,xFilial('NN2')+cFazenda,"NN2_NOME"),40) 	
					nLin++
				Endif					
				//ÚÄÄÄÄÄÄÄÄÄ¿
				//³Analitico³
				//ÀÄÄÄÄÄÄÄÄÄÙ
				If mv_par09==1
	
					If lFirstTal
						@ nLin,001 PSay PadR(cTalhao,03) 
					Endif	
					
					@ nLin,005 PSay PadR(aDdTalhao[__K,2],20) 					
					@ nLin,030 PSay Transform(aDdTalhao[__K,3],"@E 999,999.99")				
		
					If Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)<>Alltrim(cUm)	//Converte se Necessario	
						@ nLin,041 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aDdTalhao[__K,4]),"@E 9,999,999.99")				
						@ nLin,054 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aDdTalhao[__K,5]),"@E 9,999,999.99")							
						@ nLin,067 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aDdTalhao[__K,6]),"@E 9,999,999.99")				
						nCol	:=	80
						For _c := 1 To 4 
							@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aDdTalhao[__k,(((4+_c)+_c+1))]),"@E 9,999,999.99")				
							nCol	:=	nCol+13 	
							@ nLin,nCol PSay Transform(aDdTalhao[__k,(((4+_c)+_c+2))],"@E 999.99")				
							nCol	:=	nCol+7 				
						Next _c
							@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aDdTalhao[__k,15]),"@E 9,999,999.99")				
							nCol	:=	nCol+13 	
							@ nLin,nCol PSay Transform(aDdTalhao[__k,16],"@E 999.99")									
						@ nLin,180 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aDdTalhao[__K,17]),"@E 9,999,999.99")					
					Else
						@ nLin,041 PSay Transform(aDdTalhao[__K,4],"@E 9,999,999.99")				
						@ nLin,054 PSay Transform(aDdTalhao[__K,5],"@E 9,999,999.99")							
						@ nLin,067 PSay Transform(aDdTalhao[__K,6],"@E 9,999,999.99")				
						nCol	:=	80
						For _c := 1 To 4 
							@ nLin,nCol PSay Transform(aDdTalhao[__k,(((4+_c)+_c+1))],"@E 9,999,999.99")				
							nCol	:=	nCol+13 	
							@ nLin,nCol PSay Transform(aDdTalhao[__k,(((4+_c)+_c+2))],"@E 999.99")				
							nCol	:=	nCol+7 				
						Next _c
							@ nLin,nCol PSay Transform(aDdTalhao[__k,15],"@E 9,999,999.99")				
							nCol	:=	nCol+13 	
							@ nLin,nCol PSay Transform(aDdTalhao[__k,16],"@E 999.99")									
						@ nLin,180 PSay Transform(aDdTalhao[__K,17],"@E 9,999,999.99")					
					Endif
		
					If Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)<>Alltrim(cUm)	//Converte se Necessario	
						@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par11),aDdTalhao[__K,17]),"@E 9,999,999.99")														
		    		ElseIf Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)==Alltrim(cUm)
						@ nLin,194 PSay Transform(aDdTalhao[__K,17],"@E 9,999,999.99")														    		
		    		Endif
	
					If lFirstTal
						lFirstTal	:=	.f.
						@ nLin,206 PSay Transform(nCarga,"@E 9,999,999.99")														    		
						@ nLin,219 PSay PadR(cAbeFech,01) 
					Endif	
					nLin++
	    		Endif	
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Totalizadores³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nTALHec		+=	aDdTalhao[__k,3]	
				&("n"+If(cAbeFech=="N","A","F")+"SHectar")	+=	aDdTalhao[__k,3]
				&("n"+If(cAbeFech=="N","A","F")+"THectar")	+=	aDdTalhao[__k,3]
				nGHectar	+=	aDdTalhao[__k,3]
				nTALPre		+=	(aDdTalhao[__k,3]*aDdTalhao[__k,4])	
				&("n"+If(cAbeFech=="N","A","F")+"SPrevis")	+=	(aDdTalhao[__k,3]*aDdTalhao[__k,4])
				&("n"+If(cAbeFech=="N","A","F")+"TPrevis")	+=	(aDdTalhao[__k,3]*aDdTalhao[__k,4])
				nGPrevis	+=	(aDdTalhao[__k,3]*aDdTalhao[__k,4])
				nTALRea		+=	(aDdTalhao[__k,3]*aDdTalhao[__k,5])		
				&("n"+If(cAbeFech=="N","A","F")+"SRealiz")	+=	(aDdTalhao[__k,3]*aDdTalhao[__k,5])	
				&("n"+If(cAbeFech=="N","A","F")+"TRealiz")	+=	(aDdTalhao[__k,3]*aDdTalhao[__k,5])	
				nGRealiz	+=	(aDdTalhao[__k,3]*aDdTalhao[__k,5])		
				nTALBru		+=	aDdTalhao[__k,6]
				&("n"+If(cAbeFech=="N","A","F")+"SPBruto")	+=	aDdTalhao[__k,6]
				&("n"+If(cAbeFech=="N","A","F")+"TPBruto")	+=	aDdTalhao[__k,6]
				nGPBruto	+=	aDdTalhao[__k,6]
				For _c := 1 to 4					
					&("nTALD"+StrZero(_c,1))	+=	aDdTalhao[__k,(((15+_c)+_c+1))]
					&("nTALP"+StrZero(_c,1))	+=	aDdTalhao[__k,(((15+_c)+_c+2))]
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Verifica se o Talhao esta aberto ou fechado³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					&("n"+If(cAbeFech=="N","A","F")+"SDesc"+StrZero(_c,1))	+=	aDdTalhao[__k,(((15+_c)+_c+1))]
					&("n"+If(cAbeFech=="N","A","F")+"PSDes"+StrZero(_c,1))	+=	aDdTalhao[__k,(((15+_c)+_c+2))]
					&("n"+If(cAbeFech=="N","A","F")+"TDesc"+StrZero(_c,1))	+=	aDdTalhao[__k,(((15+_c)+_c+1))]
					&("n"+If(cAbeFech=="N","A","F")+"PTDes"+StrZero(_c,1))	+=	aDdTalhao[__k,(((15+_c)+_c+2))]
					&("nGDesc"+StrZero(_c,1))	+=	aDdTalhao[__k,(((15+_c)+_c+1))]
					&("nGPDes"+StrZero(_c,1))	+=	aDdTalhao[__k,(((15+_c)+_c+2))]
                Next _c
					nTALDOU						+=	aDdTalhao[__k,26]	
					nTALPOU						+=	aDdTalhao[__k,27]	
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Verifica se o Talhao esta aberto ou fechado³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					&("n"+If(cAbeFech=="N","A","F")+"SDescOU")	+=	aDdTalhao[__k,26]	
					&("n"+If(cAbeFech=="N","A","F")+"PSDesOU")	+=	aDdTalhao[__k,27]	
					&("n"+If(cAbeFech=="N","A","F")+"TDescOU")	+=	aDdTalhao[__k,26]	
					&("n"+If(cAbeFech=="N","A","F")+"PTDesOU")	+=	aDdTalhao[__k,27]	
					nGDescOU	+=	aDdTalhao[__k,26]	
					nGPDesOU	+=	aDdTalhao[__k,27]	                     
				nTALPLi		+=	aDdTalhao[__k,17]
				&("n"+If(cAbeFech=="N","A","F")+"SPLiqui")	+=	aDdTalhao[__k,17]
				&("n"+If(cAbeFech=="N","A","F")+"TPLiqui")	+=	aDdTalhao[__k,17]
				nGPLiqui	+=	aDdTalhao[__k,17]									
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Armazenas a Variedades ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				__c	:=	Ascan(aVarieds,{|x| x[1]==aDdTalhao[__k,1]  })
				If __c>0
					aVarieds[__c,03]	+=	aDdTalhao[__k,3]
					aVarieds[__c,04]	+=	(aDdTalhao[__k,3]*aDdTalhao[__k,4])
					aVarieds[__c,05]	+=	(aDdTalhao[__k,3]*aDdTalhao[__k,5])
					aVarieds[__c,06]	+=	aDdTalhao[__k,6]
					aVarieds[__c,07]	+=	aDdTalhao[__k,7]
					aVarieds[__c,08]	+=	(aDdTalhao[__k,6]*aDdTalhao[__k,8])
					aVarieds[__c,09]	+=	aDdTalhao[__k,9]
					aVarieds[__c,10]	+=	(aDdTalhao[__k,6]*aDdTalhao[__k,10])
					aVarieds[__c,11]	+=	aDdTalhao[__k,11]
					aVarieds[__c,12]	+=	(aDdTalhao[__k,6]*aDdTalhao[__k,12])
					aVarieds[__c,13]	+=	aDdTalhao[__k,13]
					aVarieds[__c,14]	+=	(aDdTalhao[__k,6]*aDdTalhao[__k,14])
					aVarieds[__c,15]	+=	aDdTalhao[__k,15]
					aVarieds[__c,16]	+=	(aDdTalhao[__k,6]*aDdTalhao[__k,16])
					aVarieds[__c,17]	+=	aDdTalhao[__k,17]
				Else
					Aadd(aVarieds,{aDdTalhao[__k,1],aDdTalhao[__k,2],aDdTalhao[__k,3],(aDdTalhao[__k,3]*aDdTalhao[__k,4]),(aDdTalhao[__k,3]*aDdTalhao[__k,5]),aDdTalhao[__k,6],aDdTalhao[__k,7],(aDdTalhao[__k,6]*aDdTalhao[__k,8]),aDdTalhao[__k,9],(aDdTalhao[__k,6]*aDdTalhao[__k,10]),aDdTalhao[__k,11],(aDdTalhao[__k,6]*aDdTalhao[__k,12]),aDdTalhao[__k,13],(aDdTalhao[__k,6]*aDdTalhao[__k,14]),aDdTalhao[__k,15],(aDdTalhao[__k,6]*aDdTalhao[__k,16]),aDdTalhao[__k,17]}) 
				Endif									
			Endif			                     						
		Next __k
				
		&("n"+If(cAbeFech=="N","A","F")+"SCarga")	+=	nCarga		
		&("n"+If(cAbeFech=="N","A","F")+"TCarga")	+=	nCarga
		nGCarga		+=	nCarga		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Sub Totais to Talhao³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//ÚÄÄÄÄÄÄÄÄÄ¿
		//³Analitico³
		//ÀÄÄÄÄÄÄÄÄÄÙ
		If mv_par09==1
			If nQtdVarie>1
				@ nLin,010 PSay PadR("Total Talhao "+Alltrim(cTalhao),20) 					
				@ nLin,030 PSay Transform(nTALHec,"@E 999,999.99")				
				If Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)<>Alltrim(cUm)	//Converte se Necessario	
					@ nLin,041 PSay Transform((Agrx001(Alltrim(cUm),Alltrim(mv_par10),(nTALPre/nTALHec))),"@E 9,999,999.99")				
					@ nLin,054 PSay Transform((Agrx001(Alltrim(cUm),Alltrim(mv_par10),(nTALRea/nTALHec))),"@E 9,999,999.99")							
					@ nLin,067 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nTALBru),"@E 9,999,999.99")				
					nCol	:=	80
					For _c := 1 To 4 
						@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(&("nTALD"+StrZero(_c,1)))),"@E 9,999,999.99")				
						nCol	:=	nCol+13 	
						@ nLin,nCol PSay Transform(((&("nTALP"+StrZero(_c,1)))/nTALBru),"@E 999.99")				
						nCol	:=	nCol+7 				
					Next _c
						@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nTALDOU),"@E 9,999,999.99")				
						nCol	:=	nCol+13 	
						@ nLin,nCol PSay Transform((nTALPOU/nTALBru),"@E 999.99")									
					@ nLin,180 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nTALPLi),"@E 9,999,999.99")					
				Else
					@ nLin,041 PSay Transform((nTALPre/nTALHec),"@E 9,999,999.99")				
					@ nLin,054 PSay Transform((nTALRea/nTALHec),"@E 9,999,999.99")							
					@ nLin,067 PSay Transform(nTALBru,"@E 9,999,999.99")				
					nCol	:=	80
					For _c := 1 To 4 
						@ nLin,nCol PSay Transform((&("nTALD"+StrZero(_c,1))),"@E 9,999,999.99")				
						nCol	:=	nCol+13 	
						@ nLin,nCol PSay Transform(((&("nTALP"+StrZero(_c,1)))/nTALBru),"@E 999.99")				
						nCol	:=	nCol+7 				
					Next _c
						@ nLin,nCol PSay Transform(nTALDOU,"@E 9,999,999.99")				
						nCol	:=	nCol+13 	
						@ nLin,nCol PSay Transform((nTALPOU/nTALBru),"@E 999.99")									
					@ nLin,180 PSay Transform(nTALPLi,"@E 9,999,999.99")					
				Endif
				If Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)<>Alltrim(cUm)	//Converte se Necessario	
					@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par11),nTALPLi),"@E 9,999,999.99")														
	    		ElseIf Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)==Alltrim(cUm)
					@ nLin,194 PSay Transform(nTALPLi,"@E 9,999,999.99")														    		
	    		Endif
				nLin++
	        Endif
        Endif
	EndDo	
	//ÚÄÄÄÄÄÄÄÄÄÄ¿
	//³Sub Totais³
	//ÀÄÄÄÄÄÄÄÄÄÄÙ
	lSubTot 	:=	.f. 
	For __k	:=	1 To 2
		If (&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SCarga"))>0 
			If !lSubTot
				lSubTot	:=	.t.
				nLin++
			Endif
			@ nLin,001 PSay PadR("Total Fazenda "+aAbreFecha[__k]+":",22) 					
			@ nLin,030 PSay Transform(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SHectar"),"@E 999,999.99")				
			If Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)<>Alltrim(cUm)	//Converte se Necessario	
				@ nLin,041 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SPrevis"))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SHectar")))),"@E 9,999,999.99")				
				@ nLin,054 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SRealiz"))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SHectar")))),"@E 9,999,999.99")							
				@ nLin,067 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SPBruto")),"@E 9,999,999.99")				
				nCol	:=	80
				For _c := 1 To 4 
					@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SDesc"+StrZero(_c,1)))),"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform(((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"PSDes"+StrZero(_c,1)))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SPBruto"))),"@E 999.99")				
					nCol	:=	nCol+7 				
				Next _c
					@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SDescOU")),"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform(((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"PSDesOU"))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SPBruto"))),"@E 999.99")									
				@ nLin,180 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SPLiqui")),"@E 9,999,999.99")					
			Else
				@ nLin,041 PSay Transform(((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SPrevis"))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SHectar"))),"@E 9,999,999.99")				
				@ nLin,054 PSay Transform(((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SRealiz"))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SHectar"))),"@E 9,999,999.99")							
				@ nLin,067 PSay Transform(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SPBruto"),"@E 9,999,999.99")				
											
				nCol	:=	80
				For _c := 1 To 4 
					@ nLin,nCol PSay Transform((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SDesc"+StrZero(_c,1))),"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform(((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"PSDes"+StrZero(_c,1)))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SPBruto"))),"@E 999.99")				
					nCol	:=	nCol+7 				
				Next _c
					@ nLin,nCol PSay Transform(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SDescOU"),"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform(((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"PSDesOU"))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SPBruto"))),"@E 999.99")									
				@ nLin,180 PSay Transform(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SPLiqui"),"@E 9,999,999.99")					
			Endif
	
			If Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)<>Alltrim(cUm)	//Converte se Necessario	
				@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par11),&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SPLiqui")),"@E 9,999,999.99")														
			ElseIf Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)==Alltrim(cUm)
				@ nLin,194 PSay Transform(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SPLiqui"),"@E 9,999,999.99")														    		
			Endif
			@ nLin,206 PSay Transform(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"SCarga"),"@E 9,999,999.99")														    		
			nLin++	        
		Endif
		If __k==2 .And. lSubTot
			nLin++
		Endif
	Next __k
EndDo
//ÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Total Geral³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ nLin,000 PSay Replicate("_",limite)
nLin++
If nGCarga>0
	@ nLin,001 PSay PadR("Total Geral:",20) 					
	@ nLin,030 PSay Transform(nGHectar,"@E 999,999.99")					
	If Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)<>Alltrim(cUm)	//Converte se Necessario	
		@ nLin,041 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(nGPrevis/nGHectar)),"@E 9,999,999.99")				
		@ nLin,054 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(nGRealiz/nGHectar)),"@E 9,999,999.99")							
		@ nLin,067 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nGPBruto),"@E 9,999,999.99")				
		nCol	:=	80
		For _c := 1 To 4 
			@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(&("nGDesc"+StrZero(_c,1)))),"@E 9,999,999.99")				
			nCol	:=	nCol+13 	
			@ nLin,nCol PSay Transform(((&("nGPDes"+StrZero(_c,1)))/nGPBruto),"@E 999.99")				
			nCol	:=	nCol+7 				
		Next _c
			@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nGDescOU),"@E 9,999,999.99")				
			nCol	:=	nCol+13 	
			@ nLin,nCol PSay Transform((nGPDesOU/nGPBruto),"@E 999.99")									
		@ nLin,180 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nGPLiqui),"@E 9,999,999.99")					
	Else
		@ nLin,041 PSay Transform((nGPrevis/nGHectar),"@E 9,999,999.99")				
		@ nLin,054 PSay Transform((nGRealiz/nGHectar),"@E 9,999,999.99")							
		@ nLin,067 PSay Transform(nGPBruto,"@E 9,999,999.99")				
		nCol	:=	80
		For _c := 1 To 4 
			@ nLin,nCol PSay Transform((&("nGDesc"+StrZero(_c,1))),"@E 9,999,999.99")				
			nCol	:=	nCol+13 	
			@ nLin,nCol PSay Transform(((&("nGPDes"+StrZero(_c,1)))/nGPBruto),"@E 999.99")				
			nCol	:=	nCol+7 				
		Next _c
			@ nLin,nCol PSay Transform(nGDescOU,"@E 9,999,999.99")				
			nCol	:=	nCol+13 	
			@ nLin,nCol PSay Transform((nGPDesOU/nGPBruto),"@E 999.99")									
		@ nLin,180 PSay Transform(nGPLiqui,"@E 9,999,999.99")					
	Endif	
	If Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)<>Alltrim(cUm)	//Converte se Necessario	
		@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par11),nGPLiqui),"@E 9,999,999.99")														
	ElseIf Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)==Alltrim(cUm)
		@ nLin,194 PSay Transform(nGPLiqui,"@E 9,999,999.99")														    		
	Endif
	@ nLin,206 PSay Transform(nGCarga,"@E 9,999,999.99")														    		
	nLin++
Endif

//ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Total Geral FECHADO/ABERTO³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For __k	:=	1 To 2
	If (&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TCarga"))>0 
		@ nLin,001 PSay PadR("Total Geral "+aAbreFecha[__k]+":",20)
		@ nLin,030 PSay Transform(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"THectar"),"@E 999,999.99")				
		If Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)<>Alltrim(cUm)	//Converte se Necessario	
			@ nLin,041 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TPrevis"))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"THectar")))),"@E 9,999,999.99")				
			@ nLin,054 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TRealiz"))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"THectar")))),"@E 9,999,999.99")							
			@ nLin,067 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TPBruto")),"@E 9,999,999.99")				
			nCol	:=	80
			For _c := 1 To 4 
				@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TDesc"+StrZero(_c,1)))),"@E 9,999,999.99")				
				nCol	:=	nCol+13 	
				@ nLin,nCol PSay Transform(((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"PTDes"+StrZero(_c,1)))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TPBruto"))),"@E 999.99")				
				nCol	:=	nCol+7 				
			Next _c
				@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TDescOU")),"@E 9,999,999.99")				
				nCol	:=	nCol+13 	
				@ nLin,nCol PSay Transform(((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"PTDesOU"))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TPBruto"))),"@E 999.99")									
			@ nLin,180 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TPLiqui")),"@E 9,999,999.99")					
		Else
			@ nLin,041 PSay Transform(((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TPrevis"))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"THectar"))),"@E 9,999,999.99")				
			@ nLin,054 PSay Transform(((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TRealiz"))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"THectar"))),"@E 9,999,999.99")							
			@ nLin,067 PSay Transform(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TPBruto"),"@E 9,999,999.99")				
			nCol	:=	80
			For _c := 1 To 4 
				@ nLin,nCol PSay Transform((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TDesc"+StrZero(_c,1))),"@E 9,999,999.99")				
				nCol	:=	nCol+13 	
				@ nLin,nCol PSay Transform(((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"PTDes"+StrZero(_c,1)))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TPBruto"))),"@E 999.99")				
				nCol	:=	nCol+7 				
			Next _c
				@ nLin,nCol PSay Transform(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TDescOU"),"@E 9,999,999.99")				
				nCol	:=	nCol+13 	
				@ nLin,nCol PSay Transform(((&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"PTDesOU"))/(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TPBruto"))),"@E 999.99")									
			@ nLin,180 PSay Transform(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TPLiqui"),"@E 9,999,999.99")					
		Endif

		If Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)<>Alltrim(cUm)	//Converte se Necessario	
			@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par11),&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TPLiqui")),"@E 9,999,999.99")														
		ElseIf Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)==Alltrim(cUm)
			@ nLin,194 PSay Transform(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TPLiqui"),"@E 9,999,999.99")														    		
		Endif
		@ nLin,206 PSay Transform(&("n"+Upper(Alltrim(SubStr(aAbreFecha[__k],1,1)))+"TCarga"),"@E 9,999,999.99")														    		
		nLin++
	Endif
Next __k
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Total em Transito³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nCargTrans>0
	@ nLin,001 Psay 'Total em Transito :'
	@ nLin,067 PSay Transform(nPesExtim,'@E 9,999,999.99')
	@ nLin,206 PSay Transform(nCargTrans,'@E 9,999,999.99')
	nLin++
Endif	
@ nLin,000 PSay Replicate("_",limite)
nLin++
//ÚÄÄÄÄÄÄÄÄÄ¿
//³Variedade³
//ÀÄÄÄÄÄÄÄÄÄÙ
@ nLin,000 PSay Replicate("_",(limite-14))
nLin++
@ nLin,000 PSay "RESUMO POR VARIEDADE                    |"+PadC(AllTrim(cDescUm),151,'-')+"|"
nLin++
@ nLin,000 PSay Space(06)+SubStr(Cabec2,07,(Len(Alltrim(Cabec2))-20))
nLin++                       
@ nLin,000 PSay Replicate("_",(limite-14))
nLin++                       

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ordena por Descricao da Variedade³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aSort(aVarieds,,,{|x,y| x[2] < y[2]} )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Lista as Variedades ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For __k	:=	1 To Len(aVarieds)
	@ nLin,005 PSay PadR(aVarieds[__k,02],20) 					
	@ nLin,030 PSay Transform(aVarieds[__k,03],"@E 999,999.99")				
	If Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)<>Alltrim(cUm)	//Converte se Necessario	
		@ nLin,041 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(aVarieds[__k,04]/aVarieds[__k,03])),"@E 9,999,999.99")				
		@ nLin,054 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(aVarieds[__k,05]/aVarieds[__k,03])),"@E 9,999,999.99")							
		@ nLin,067 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aVarieds[__k,06]),"@E 9,999,999.99")				
		@ nLin,080 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aVarieds[__k,07]),"@E 9,999,999.99")				
		@ nLin,093 PSay Transform((aVarieds[__k,08]/aVarieds[__k,06]),"@E 999.99")				
		@ nLin,100 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aVarieds[__k,09]),"@E 9,999,999.99")				
		@ nLin,113 PSay Transform((aVarieds[__k,10]/aVarieds[__k,06]),"@E 999.99")				
		@ nLin,120 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aVarieds[__k,11]),"@E 9,999,999.99")				
		@ nLin,133 PSay Transform((aVarieds[__k,12]/aVarieds[__k,06]),"@E 999.99")				
		@ nLin,140 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aVarieds[__k,13]),"@E 9,999,999.99")				
		@ nLin,153 PSay Transform((aVarieds[__k,14]/aVarieds[__k,06]),"@E 999.99")				
		@ nLin,160 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aVarieds[__k,15]),"@E 9,999,999.99")				
		@ nLin,173 PSay Transform((aVarieds[__k,16]/aVarieds[__k,06]),"@E 999.99")				
		@ nLin,180 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),aVarieds[__k,17]),"@E 9,999,999.99")					
	Else
		@ nLin,041 PSay Transform((aVarieds[__k,04]/aVarieds[__k,03]),"@E 9,999,999.99")				
		@ nLin,054 PSay Transform((aVarieds[__k,05]/aVarieds[__k,03]),"@E 9,999,999.99")							
		@ nLin,067 PSay Transform(aVarieds[__k,06],"@E 9,999,999.99")				
		@ nLin,080 PSay Transform(aVarieds[__k,07],"@E 9,999,999.99")				
		@ nLin,093 PSay Transform((aVarieds[__k,08]/aVarieds[__k,06]),"@E 999.99")				
		@ nLin,100 PSay Transform(aVarieds[__k,09],"@E 9,999,999.99")				
		@ nLin,113 PSay Transform((aVarieds[__k,10]/aVarieds[__k,06]),"@E 999.99")				
		@ nLin,120 PSay Transform(aVarieds[__k,11],"@E 9,999,999.99")				
		@ nLin,133 PSay Transform((aVarieds[__k,12]/aVarieds[__k,06]),"@E 999.99")				
		@ nLin,140 PSay Transform(aVarieds[__k,13],"@E 9,999,999.99")				
		@ nLin,153 PSay Transform((aVarieds[__k,14]/aVarieds[__k,06]),"@E 999.99")				
		@ nLin,160 PSay Transform(aVarieds[__k,15],"@E 9,999,999.99")				
		@ nLin,173 PSay Transform((aVarieds[__k,16]/aVarieds[__k,06]),"@E 999.99")				
		@ nLin,180 PSay Transform(aVarieds[__k,17],"@E 9,999,999.99")					
	Endif
	If Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)<>Alltrim(cUm)	//Converte se Necessario	
		@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par11),aVarieds[__k,17]),"@E 9,999,999.99")														
  	ElseIf Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)==Alltrim(cUm)
		@ nLin,194 PSay Transform(aVarieds[__k,17],"@E 9,999,999.99")														    		
  	Endif
    nLin++			
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Totais Variedades³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	nVHectar	+=	aVarieds[__k,03]
	nVPrevis	+=	aVarieds[__k,04]
	nVRealiz	+=	aVarieds[__k,05]
	nVPBruto	+=	aVarieds[__k,06]
	nVDesc1		+=	aVarieds[__k,07]
	nVPDes1		+=	aVarieds[__k,08]
	nVDesc2		+=	aVarieds[__k,09]
	nVPDes2		+=	aVarieds[__k,10]
	nVDesc3		+=	aVarieds[__k,11]
	nVPDes3		+=	aVarieds[__k,12]
	nVDesc4		+=	aVarieds[__k,13]
	nVPDes4		+=	aVarieds[__k,14]
	nVDescOU	+=	aVarieds[__k,15]
	nVPDesOU	+=	aVarieds[__k,16]
	nVPLiqui	+=	aVarieds[__k,17]			
Next __k
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Totaliza Variedades ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nVCarga>0
    nLin++			
	@ nLin,005 PSay PadR("Total Variedade(s):",20) 					
	@ nLin,030 PSay Transform(nVHectar,"@E 999,999.99")				
	If Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)<>Alltrim(cUm)	//Converte se Necessario	
		@ nLin,041 PSay Transform((Agrx001(Alltrim(cUm),Alltrim(mv_par10),(nVPrevis/nVHectar))),"@E 9,999,999.99")				
		@ nLin,054 PSay Transform((Agrx001(Alltrim(cUm),Alltrim(mv_par10),(nVRealiz/nVHectar))),"@E 9,999,999.99")							
		@ nLin,067 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nVPBruto),"@E 9,999,999.99")				
		nCol	:=	80
		For _c := 1 To 4 
			@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(&("nVDesc"+StrZero(_c,1)))),"@E 9,999,999.99")				
			nCol	:=	nCol+13 	
			@ nLin,nCol PSay Transform(((&("nVPDes"+StrZero(_c,1)))/nVPBruto),"@E 999.99")				
			nCol	:=	nCol+7 				
		Next _c
			@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nVDescOU),"@E 9,999,999.99")				
			nCol	:=	nCol+13 	
			@ nLin,nCol PSay Transform((nVPDesOU/nVPBruto),"@E 999.99")									
		@ nLin,180 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nVPLiqui),"@E 9,999,999.99")					
	Else
		@ nLin,041 PSay Transform((nVPrevis/nVHectar),"@E 9,999,999.99")				
		@ nLin,054 PSay Transform((nVRealiz/nVHectar),"@E 9,999,999.99")							
		@ nLin,067 PSay Transform(nVPBruto,"@E 9,999,999.99")				
		nCol	:=	80
		For _c := 1 To 4 
			@ nLin,nCol PSay Transform((&("nVDesc"+StrZero(_c,1))),"@E 9,999,999.99")				
			nCol	:=	nCol+13 	
			@ nLin,nCol PSay Transform(((&("nVPDes"+StrZero(_c,1)))/nVPBruto),"@E 999.99")				
			nCol	:=	nCol+7 				
		Next _c
			@ nLin,nCol PSay Transform(nVDescOU,"@E 9,999,999.99")				
			nCol	:=	nCol+13 	
			@ nLin,nCol PSay Transform((nVPDesOU/nVPBruto),"@E 999.99")									
		@ nLin,180 PSay Transform(nVPLiqui,"@E 9,999,999.99")					
	Endif

	If Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)<>Alltrim(cUm)	//Converte se Necessario	
		@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par11),nVPLiqui),"@E 9,999,999.99")														
	ElseIf Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)==Alltrim(cUm)
		@ nLin,194 PSay Transform(nVPLiqui,"@E 9,999,999.99")														    		
	Endif
Endif		

dbClearFilter()

RestArea(aArea)

Roda()

SET DEVICE TO SCREEN

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return()
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³ AGRR255A ³ Autor ³ Danyel Bernuci        ³ Data ³ 09/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Cria a F_Opcoes de Desconto Classificacao				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ AGRR255                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function AGRR255A()
Local cTitulo   :='Desconto Classificacao'
Local cReadRet  :=''
Local cReturno  :=''
Local aDesconts :=Array(0)
Local nX        := 0
Local cVarAux   := ''
Local cVarAux2  := ''

		cAlias   := Alias()	//Salva a Area Anterior
		cContVar := &(Alltrim(ReadVar())) //Carrega o conteudo da variavel do Get em Questao
		cReadRet := Alltrim(ReadVar()) //Iguala o Nome da variavel ao Nome variavel retorno		

		dbSelectArea('NNH')
		dbSetOrder(1)
		nnh->(dbGotop())
		While nnh->(!Eof())
			aAdd(aDesconts,nnh->nnh_codigo+' - '+Alltrim(nnh->nnh_descri))	
			cReturno += nnh->nnh_codigo
			nnh->(Dbskip())
		EndDo

		If F_Opcoes(@cContVar,cTitulo,aDesconts,cReturno,,,.f.,6,4)	//Chama a Funcao Opcoes
			cVarAux2 := ''
			For nX := 1 To Len(cContVar)
				cVarAux := Substr(cContVar,nX,1)
				If '*' <> cVarAux
					cVarAux2 += cVarAux
				EndIf
			Next nX
			cContVar := cVarAux2

			&cReadRet := cContVar //Devolve o Resutado
		Endif

		&cReadRet	:= cContVar //Devolve o Resutado	

        dbSelectArea(cAlias)

Return()
