/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

Static oArqTemp := Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³ AGRR285  ³ Autor ³ Danyel Bernuci        ³ Data ³ 09/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Relação de Romaneios de Entrada				              ³±±
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

User Function AGRR285()
	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Relacao de Romaneios de Entrada."
	Local cPict          := ""
	Local titulo         := "Relacao de Romaneios de Entrada"
	Local nLin           := 220
	Local Cabec1         := ""
	Local Cabec2         := ""
	Local imprime        := .t.

	Private aOrd        := {'Cliente+Armazem+Romaneio','Cliente+Armazem+Data','Cliente+Armazem+Apontamento','Cliente+Armazem+Ticket'}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private limite      := 200
	Private tamanho     := "G"
	Private nomeprog    := 'AGRR285'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR285"
	Private wnrel       := "AGRR285"
	Private cAliasTMP   := "TMP"

	Private cString := "NPO"

	dbSelectArea("NPO")
	dbSetOrder(1)

	Pergunte(cPerg,.F.)

	wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.f.,aOrd,.t.,Tamanho,,.t.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	Endif

	nTipo := If(aReturn[4]==1,15,18)

	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

	AGRDLTPTB(oArqTemp)

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
±±³ Uso      ³ AGRR285                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
	Local 	aArea   	:= GetArea()
	Local 	nOrdem 		:= aReturn[8]
	Local 	cFiltro 	:= ""
	Local	cFiltUser	:=	aReturn[7]
	Local	aStruct		:=	npo->(dbStruct())
	Local	__k
	Local	aTpDesp		:=	{}
	Local	cUm			:=	Alltrim(Posicione("SB1",1,xFilial("SB1")+Alltrim(Posicione('NN1',1,xFilial('NN1')+Alltrim(mv_par01),'NN1_CODPRO')),"B1_UM"))
	Local	cDescUm		:=	Posicione('SAH',1,xFilial('SAH')+If(Len(Alltrim(mv_par12))==0,cUm,Alltrim(mv_par12)),"AH_DESCPO")
	Local	nPBruto		:=	0
	Local	nPLiqui		:=	0
	Local	nSPBruto	:=	0
	Local	nSPLiqui	:=	0
	Local	nSRomane	:=	0
	Local	nTPBruto	:=	0
	Local	nTPLiqui	:=	0
	Local	nTRomane	:=	0
	Local	nGPBruto	:=	0
	Local	nGPLiqui	:=	0
	Local	nGRomane	:=	0
	Local	nDescOU		:=	0
	Local	nPDesOU		:=	0
	Local	nSDescOU	:=	0
	Local	nPSDesOU 	:= 	0
	Local	nTDescOU	:=	0
	Local	nPTDesOU 	:= 	0
	Local	nGDescOU	:=	0	
	Local	nGPDesOU	:=	0	

	Private	nDesc1		:=	0
	Private	nPDes1		:=	0
	Private	nDesc2		:=	0
	Private	nPDes2		:=	0
	Private	nDesc3		:=	0
	Private	nPDes3		:=	0
	Private	nDesc4		:=	0
	Private	nPDes4		:=	0
	Private	nSDesc1		:=	0
	Private	nPSDes1 	:= 	0
	Private	nSDesc2		:=	0
	Private	nPSDes2 	:= 	0
	Private	nSDesc3		:=	0
	Private	nPSDes3 	:= 	0
	Private	nSDesc4		:=	0
	Private	nPSDes4 	:= 	0
	Private	nTDesc1		:=	0
	Private	nPTDes1 	:= 	0
	Private	nTDesc2		:=	0
	Private	nPTDes2 	:= 	0
	Private	nTDesc3		:=	0
	Private	nPTDes3 	:= 	0
	Private	nTDesc4		:=	0
	Private	nPTDes4 	:= 	0
	Private	nGDesc1		:=	0	
	Private	nGPDes1		:=	0	
	Private	nGDesc2		:=	0	
	Private	nGPDes2		:=	0	
	Private	nGDesc3		:=	0	
	Private	nGPDes3		:=	0	
	Private	nGDesc4		:=	0	
	Private	nGPDes4		:=	0	

	//Variaveis para arquivos temporarios
	Private cArqTMP := ""
	Private cIndTMP := ""
	Private cChvTMP := ""
	Private aArqTMP := {}

	titulo	:= 	Alltrim(titulo)+" no Periodo de "+Dtoc(mv_par02)+" a "+Dtoc(mv_par03)

	#IFDEF TOP

	cQuery	:=	"Select  "   
	cQuery	+=	" 	NPO.NPO_FILIAL,"
	cQuery	+=	"   NPO.NPO_CODIGO,"
	cQuery	+=	"   NPO.NPO_TIPO  ,"		
	cQuery	+=	"   NPO.NPO_CODAPO,"
	cQuery	+=	"   NPO.NPO_FAZ   ,"
	cQuery	+=	"   NPO.NPO_TALHAO,"
	cQuery	+=	"   NPO.NPO_DATA  ,"
	cQuery	+=	"   NPO.NPO_SAFRA ,"
	cQuery	+=	"   NPO.NPO_ARM   ,"
	cQuery	+=	"   NPO.NPO_CODCLI,"
	cQuery	+=	"   NPO.NPO_LOJCLI,"
	cQuery	+=	"   NPO.NPO_CODTRA,"
	cQuery	+=	"   NPO.NPO_CODEQU,"
	cQuery	+=	"   NPO.NPO_CODMOT,"
	cQuery	+=	"  	NPO.NPO_CODPRO,"
	cQuery	+=	"   NPO.NPO_UM    ,"
	cQuery	+=	"   NPO.NPO_TICKET,"
	cQuery	+=	"   NPO.NPO_LAUDO ,"
	cQuery	+=	"   NPO.NPO_CODTAB,"
	cQuery	+=	"   NPO.NPO_PSBRUT,"
	cQuery	+=	"   NPO.NPO_PSTARA,"
	cQuery	+=	"   NPO.NPO_PSSUBT,"
	cQuery	+=	"   NPO.NPO_PSDESC,"
	cQuery	+=	"   NPO.NPO_PSLIQU,"
	cQuery	+=	"   NPO.NPO_PSEXTR,"
	cQuery	+=	"   NPO.NPO_PSREAL,"
	cQuery	+=	"   NPO.NPO_OBS   ,"
	cQuery	+=	"   NPA.NPA_NFSSER,"
	cQuery	+=	"   NPA.NPA_NFSNUM,"
	cQuery	+=	"   SA1.A1_NOME   ,"
	cQuery	+=	"   NNR.NNR_DESCRI,"
	cQuery	+=	"   NNB.NNB_PLACA "  

	cQuery	+=	" From "+RetSqlName("NPO")+"  NPO, "+RetSqlName("SA1")+"  SA1, "
	cQuery  +=           RetSqlName("NNB")+"  NNB, "+RetSqlName("NPA")+"  NPA, "
	cQuery  +=           RetSqlName("NNR")+"  NNR "
	cQuery	+=	"Where NPO.NPO_CODCLI = SA1.A1_COD         And "
	cQuery	+=	"      NPO.NPO_LOJCLI = SA1.A1_LOJA        And "
	cQuery	+=	"      NPO.NPO_CODEQU = NNB.NNB_CODIGO     And "
	cQuery	+=	"      NPO.NPO_ARM    = NNR.NNR_CODIGO     And "
	cQuery	+=	"      NPO.NPO_CODAPO = NPA.NPA_CODIGO     And "
	cQuery	+=	"      NPO.NPO_SAFRA  = '"+mv_par01+"' And "
	cQuery	+=	"      NPO.NPO_DATA   Between '"+Dtos(mv_par02)+"' And '"+Dtos(mv_par03)+"' And "
	cQuery	+=	"      NPO.NPO_CODCLI Between '"+mv_par04+      "' And '"+mv_par05+       "' And "     
	cQuery	+=	"      NPO.NPO_ARM    Between '"+mv_par06+      "' And '"+mv_par07+       "' And "
	cQuery	+=	"      NPO.NPO_FAZ    Between '"+mv_par08+      "' And '"+mv_par09+       "' And "
	cQuery	+=	"      NPO.NPO_TALHAO Between '"+mv_par10+      "' And '"+mv_par11+       "' And "
	//Considera Filiais
	If mv_par15==1
		cQuery	+=    "NPO.NPO_FILIAL Between '"+mv_par16+      "' And '"+mv_par17+       "' And "	
		cQuery	+=	  "NPA.NPA_FILIAL Between '"+mv_par16+      "' And '"+mv_par17+       "' And "
	Else
		cQuery	+=	"NPO.NPO_FILIAL = '"+xFilial('NPO')+"' And "	
		cQuery	+=	"NPA.NPA_FILIAL = '"+xFilial('NPA')+"' And "
	Endif    
	cQuery	+=	"NPO.NPO_LOJCLI Between '"+mv_par18+"' And '"+mv_par19+"' And "    
	cQuery	+=	"NPO.D_E_L_E_T_<>'*' And "
	cQuery	+=	"SA1.D_E_L_E_T_<>'*' And "
	cQuery	+=	"NNB.D_E_L_E_T_<>'*' And "
	cQuery	+=	"NPA.D_E_L_E_T_<>'*' And "
	cQuery	+=	"NNR.D_E_L_E_T_<>'*'"    

	If nOrdem == 1
		cQuery	+=	"Order By A1_NOME,NNR_DESCRI,NPO_CODIGO"
	ElseIf nOrdem == 2
		cQuery	+=	"Order By A1_NOME,NNR_DESCRI,NPO_DATA"
	ElseIf nordem == 3
		cQuery	+=	"Order By A1_NOME,NNR_DESCRI,NPO_CODAPO"	
	Else
		cQuery	+=	"Order By A1_NOME,NNR_DESCRI,NPO_TICKET"	
	EndIf

	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasTMP,.T.,.T.)

	For __k := 1 to Len(aStruct)
		If aStruct[__k,2]<>'C'
			TCSetField('TMP',aStruct[__k,1],aStruct[__k,2],aStruct[__k,3],aStruct[__k,4])
		Endif
	Next __k

	#ELSE

	cFiltro := "NPO_SAFRA=MV_PAR01  .And. "
	cFiltro += "NPO_DATA >= MV_PAR02 .And. "
	cFiltro += "NPO_DATA <= MV_PAR03  .And. "
	cFiltro += "NPO_CODCLI >= MV_PAR04 .And. "
	cFiltro += "NPO_CODCLI <= MV_PAR05 .And. "
	cFiltro += "NPO_ARM >= MV_PAR06 .And. "
	cFiltro += "NPO_ARM <= MV_PAR07 .And. "
	cFiltro += "NPO_FAZ >= MV_PAR08 .And. "
	cFiltro += "NPO_FAZ <= MV_PAR09 .And. "
	//Considera Filiais
	If mv_par15==1
		cFiltro += "NPO_FILIAL >= MV_PAR16 .And. "
		cFiltro += "NPO_FILIAL <= MV_PAR17 .And. "
		cFiltro += "NPA_FILIAL >= MV_PAR16 .And. "
		cFiltro += "NPA_FILIAL <= MV_PAR17 .And. "
	Else
		cFiltro += "NPO_FILIAL == '"+xFilial('NPO')+" .And. "
		cFiltro += "NPA_FILIAL == '"+xFilial('NPA')+" .And. "
	Endif
	cFiltro += "NPO_TALHAO >= MV_PAR10 .And."
	cFiltro += "NPO_TALHAO <= MV_PAR11"
	cFiltro += "NPO_LOJCLI >= MV_PAR18 .And."
	cFiltro += "NPO_LOJCLI <= MV_PAR19"

	dbSelectArea(cString)
	dbSetFilter( {|| &cFiltro }, cFiltro )

	aAdd(aArqTMP,{"NPO_FILIAL","C",002,00})
	aAdd(aArqTMP,{"NPO_CODIGO","C",006,00})
	aAdd(aArqTMP,{"NPO_TIPO  ","C",001,00})			
	aAdd(aArqTMP,{"NPO_CODAPO","C",006,00})
	aAdd(aArqTMP,{"NPO_FAZ"   ,"C",006,00})
	aAdd(aArqTMP,{"NPO_TALHAO","C",006,00})
	aAdd(aArqTMP,{"NPO_DATA	 ","D",008,00})
	aAdd(aArqTMP,{"NPO_SAFRA ","C",006,00})
	aAdd(aArqTMP,{"NPO_ARM   ","C",002,00})
	aAdd(aArqTMP,{"NPO_CODCLI","C",006,00}) 
	aAdd(aArqTMP,{"NPO_LOJCLI","C",002,00})
	aAdd(aArqTMP,{"NPO_CODTRA","C",006,00})
	aAdd(aArqTMP,{"NPO_CODEQU","C",006,00})
	aAdd(aArqTMP,{"NPO_CODMOT","C",006,00})
	aAdd(aArqTMP,{"NPO_CODPRO","C",015,00})
	aAdd(aArqTMP,{"NPO_UM    ","C",002,00})
	aAdd(aArqTMP,{"NPO_TICKET","C",010,00})
	aAdd(aArqTMP,{"NPO_LAUDO ","C",010,00})
	aAdd(aArqTMP,{"NPO_CODTAB","C",006,00})
	aAdd(aArqTMP,{"NPO_PSBRUT","N",014,02})
	aAdd(aArqTMP,{"NPO_PSTARA","N",014,02})
	aAdd(aArqTMP,{"NPO_PSSUBT","N",014,02})
	aAdd(aArqTMP,{"NPO_PSDESC","N",014,02})
	aAdd(aArqTMP,{"NPO_PSLIQU","N",014,02})
	aAdd(aArqTMP,{"NPO_PSEXTR","N",014,02})
	aAdd(aArqTMP,{"NPO_PSREAL","N",014,02})
	aAdd(aArqTMP,{"NPO_OBS   ","C",080,00})
	aAdd(aArqTMP,{"NPA_NFSSER","C",003,00})
	aAdd(aArqTMP,{"NPA_NFSNUM","C",006,00})
	aAdd(aArqTMP,{"A1_NOME"   ,"C",050,00})
	aAdd(aArqTMP,{"NNR_DESCRI","C",020,00})
	aAdd(aArqTMP,{"NNB_PLACA" ,"C",008,00})

	//Cria tabela temporária
	If nOrdem == 1
		cChvTMP := "A1_NOME+NNR_DESCRI+NPO_CODIGO"
	ElseIf nOrdem == 2 
		cChvTMP := "A1_NOME+NNR_DESCRI+NPO_DATA"
	ElseIf nOrder == 3
		cChvTMP := "A1_NOME+NNR_DESCRI+NPO_CODAPO"
	Else
		cChvTMP := "A1_NOME+NNR_DESCRI+NPO_TICKET"
	EndIf

	cAliasTMP  := GetNextAlias()
	oArqTemp := AGRCRTPTB(cAliasTMP, {aArqTMP, {{"", cChvTMP }}} ) 

	DbSelectArea("NPO")
	npo->(DbGoTop())
	While npo->(!Eof()) 

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("NPO")
		If !(Len(Alltrim(cFiltUser))==0).And.!(&cFiltUser)
			npo->(dbSkip())
			Loop
		EndIf

		cSerie			:=	Space(03)
		cNota			:=	Space(06)

		DbSelectArea("NPA")
		DbSetOrder(1)
		If DbSeek(If(Len(Alltrim(xFilial("NPA")))==0,xFilial("NPA"),npo->npo_filial)+npo->npo_codapo)
			cSerie			:=	npa->npa_nfsser
			cNota			:=	npa->npa_nfsnum
		Endif

		DbSelectArea(cAliasTMP)	
		If RecLock(cAliasTMP,.t.)
			Replace (cAliasTMP)->npo_filial	With	npo->npo_filial
			Replace (cAliasTMP)->npo_codigo	With	npo->npo_codigo
			Replace (cAliasTMP)->npo_tipo  	With	npo->npo_tipo
			Replace (cAliasTMP)->npo_codapo	With	npo->npo_codapo
			Replace (cAliasTMP)->npo_data	With	npo->npo_data
			Replace (cAliasTMP)->npo_safra 	With	npo->npo_safra
			Replace (cAliasTMP)->npo_faz 	With	npo->npo_faz
			Replace (cAliasTMP)->npo_talhao	With	npo->npo_talhao
			Replace (cAliasTMP)->npo_arm   	With	npo->npo_arm
			Replace (cAliasTMP)->npo_codcli With	npo->npo_codcli
			Replace (cAliasTMP)->npo_lojcli	With	npo->npo_lojcli
			Replace (cAliasTMP)->npo_codtra	With	npo->npo_codtra
			Replace (cAliasTMP)->npo_codequ	With	npo->npo_codequ
			Replace (cAliasTMP)->nnb_placa	With   	Posicione("NNB",1,If(Len(Alltrim(xFilial("NNB")))==0,xFilial("NNB"),npo->npo_filial)+npo->npo_codequ,"NNB_PLACA")
			Replace (cAliasTMP)->npo_codmot	With	npo->npo_codmot
			Replace (cAliasTMP)->npo_codpro	With	npo->npo_codpro
			Replace (cAliasTMP)->npo_um    	With	npo->npo_um
			Replace (cAliasTMP)->npo_ticket	With	npo->npo_ticket
			Replace (cAliasTMP)->npo_laudo 	With	npo->npo_laudo
			Replace (cAliasTMP)->npo_codtab	With	npo->npo_codtab
			Replace (cAliasTMP)->npo_psbrut	With	npo->npo_psbrut
			Replace (cAliasTMP)->npo_pstara	With	npo->npo_pstara
			Replace (cAliasTMP)->npo_pssubt	With	npo->npo_pssubt
			Replace (cAliasTMP)->npo_psdesc	With	npo->npo_psdesc
			Replace (cAliasTMP)->npo_psliqu	With	npo->npo_psliqu
			Replace (cAliasTMP)->npo_psextr	With	npo->npo_psextr
			Replace (cAliasTMP)->npo_psreal	With	npo->npo_psreal
			Replace (cAliasTMP)->npo_OBS   	With	npo->npo_obs
			Replace (cAliasTMP)->npa_nfsser	With	cSerie
			Replace (cAliasTMP)->npa_nfsnum With	cNota
			Replace (cAliasTMP)->a1_nome	With	SubStr(Posicione("SA1",1,If(Len(Alltrim(xFilial("SA1")))==0,xFilial("SA1"),npo->npo_filial)+npo->npo_codcli+npo->npo_lojcli,"A1_NOME"),1,50)
			Replace (cAliasTMP)->nnr_descri	With	SubStr(Posicione("NNR",1,If(Len(Alltrim(xFilial("NNR")))==0,xFilial("NNR"),npo->npo_filial)+npo->npo_arm,"NNR_DESCRI"),1,20)
			MsUnLock(cAliasTMP)
		EndIf                                	

		dbSelectArea("NPO")
		npo->(dbSkip())
	EndDo
	#ENDIF

	//          0         0         0         0         0         0         0         0         0         1         1         1         1
	//          1         2         3         4         5         6         7         8         9         0         1         2         3
	//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	//     Armazem        NºRoma  NºApto   Serie  NºNota Fz Tl.  Placa        Data    |       Bruto
	Cabec1 := "Cliente                                                                         |"+PadC(Alltrim(Upper(cDescUm)),125,"-")+"|"
	Cabec2 := "     Armazem        NºRoma  NºApto   Serie  NºNota Fz Tl.  Placa        Data    |       Bruto"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Cria o Cabecalho de acordo com os tipos de descontos escolhidos³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For __k := 1 To Len(mv_par14) Step 6
		DbSelectArea("NNH")
		DbSetOrder(1)
		If DbSeek(xFilial("NNH")+SubStr(mv_par14,__k,6))
			Cabec2 +=	Space(13-Len(Alltrim((Upper(SubStr(nnh->nnh_descri,1,1))+Lower(SubStr(nnh->nnh_descri,2,11))))))+Alltrim((Upper(SubStr(nnh->nnh_descri,1,1))+Lower(SubStr(nnh->nnh_descri,2,11))))+Space(03)+"%"+Upper(SubStr(nnh->nnh_descri,1,1))+Lower(SubStr(nnh->nnh_descri,2,2))		
			Aadd(aTpDesp,nnh->nnh_codigo)
		Endif
	Next __k 
	For __k := (Len(aTpDesp)+1) To 4	
		Cabec2	+=	" Xxxxxxxxxxxx   %Xxx" 	
	Next __k
	Cabec2 +="       Outros   %Out Peso Liquido| "+If(Len(Alltrim(mv_par13))==0,"P.Liq./SEGUM","P.Liquido/"+Alltrim(mv_par13))

	DbSelectArea(cAliasTMP)
	SetRegua((cAliasTMP)->(RecCount()))
	(cAliasTMP)->(Dbgotop())
	While (cAliasTMP)->(!Eof())

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea(cAliasTMP)
		If !(Len(Alltrim(cFiltUser))==0).And.!(&cFiltUser)
			(cAliasTMP)->(dbSkip())
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

		cCliente	:=	(cAliasTMP)->a1_nome		

		@nLin,001 Psay PadR(cCliente,40) 
		nLin++

		nTDesc1		:=	0
		nPTDes1 	:= 	0
		nTDesc2		:=	0
		nPTDes2 	:= 	0
		nTDesc3		:=	0
		nPTDes3 	:= 	0
		nTDesc4		:=	0
		nPTDes4 	:= 	0
		nTDescOU	:=	0
		nPTDesOU 	:= 	0
		nTRomane	:=	0

		nTPBruto	:=	0
		nTPLiqui	:=	0


		While (cAliasTMP)->(!Eof()) .And. (cAliasTMP)->a1_nome==cCliente		

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Avalia filtro do usuario                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea('TMP')
			If !(Len(Alltrim(cFiltUser))==0).And.!(&cFiltUser)
				(cAliasTMP)->(dbSkip())
				Loop
			EndIf		

			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             

			cArmazem	:=	(cAliasTMP)->nnr_descri

			@nLin,005 Psay PadR(cArmazem,20) 
			nLin++

			nSDesc1		:=	0
			nPSDes1 	:= 	0
			nSDesc2		:=	0
			nPSDes2 	:= 	0
			nSDesc3		:=	0
			nPSDes3 	:= 	0
			nSDesc4		:=	0
			nPSDes4 	:= 	0
			nSDescOU	:=	0
			nPSDesOU 	:= 	0
			nSRomane	:=	0

			nSPBruto	:=	0
			nSPLiqui	:=	0

			While (cAliasTMP)->(!Eof()) .And. (cAliasTMP)->a1_nome==cCliente .And. (cAliasTMP)->nnr_descri==cArmazem		

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Avalia filtro do usuario                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectArea(cAliasTMP)
				If !(Len(Alltrim(cFiltUser))==0).And.!(&cFiltUser)
					(cAliasTMP)->(dbSkip())
					Loop
				EndIf		

				IncRegua(cCliente)

				nSRomane++            
				nTRomane++            
				nGRomane++            

				nPBruto	:=	(cAliasTMP)->npo_pssubt
				nDesc1	:=	0
				nPDes1	:=	0
				nDesc2	:=	0
				nPDes2	:=	0
				nDesc3	:=	0
				nPDes3	:=	0
				nDesc4	:=	0
				nPDes4	:=	0
				nDescOU	:=	0
				nPDesOU	:=	0
				nPLiqui	:=	(cAliasTMP)->npo_psreal	

				@nLin,020 Psay PadR((cAliasTMP)->npo_codigo,06) 
				@nLin,028 Psay PadR((cAliasTMP)->npo_codapo,06) 
				@nLin,037 Psay PadR((cAliasTMP)->npa_nfsser,03) 
				@nLin,044 Psay PadR((cAliasTMP)->npa_nfsnum,06)
				//@nLin,051 PSay PadR((cAliasTMP)->npo_ticket,06)
				@nLin, 51 PSay PadR((cAliasTMP)->npo_faz,02)
				@nLin, 54 PSay PadR((cAliasTMP)->npo_talhao, 03)
				@nLin,058 Psay PadR((cAliasTMP)->nnb_placa,08) 
				@nLin,070 Psay PadR(Dtoc((cAliasTMP)->npo_data),10) 

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Procura nos Itens Romaneio Relacionado ao Apontamento³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectArea("NPP")
				DbSetOrder(1)
				If DbSeek(If(Len(Alltrim(xFilial("NPP")))==0,xFilial("NPP"),(cAliasTMP)->npo_filial)+(cAliasTMP)->npo_codigo) 
					While npp->(!Eof()) .And. npp->npp_filial==(cAliasTMP)->npo_filial .And. npp->npp_codigo==(cAliasTMP)->npo_codigo
						__k	:=	aScan(aTpDesp,Alltrim(npp->npp_coddes))
						If __k>0
							&("nDesc"+StrZero(__k,1))	+=	npp->npp_pesdes	
							&("nPDes"+StrZero(__k,1))	+=	(nPBruto*npp->npp_perdes)											
							&("nSDesc"+StrZero(__k,1))	+=	npp->npp_pesdes	
							&("nPSDes"+StrZero(__k,1))	+=	(nPBruto*npp->npp_perdes)
							&("nTDesc"+StrZero(__k,1))	+=	npp->npp_pesdes	
							&("nPTDes"+StrZero(__k,1))	+=	(nPBruto*npp->npp_perdes)
							&("nGDesc"+StrZero(__k,1))	+=	npp->npp_pesdes	
							&("nGPDes"+StrZero(__k,1))	+=	(nPBruto*npp->npp_perdes)
						Else
							nDescOU		+=	npp->npp_pesdes	
							nPDesOU		+=	(nPBruto*npp->npp_perdes)											
							nSDescOU	+=	npp->npp_pesdes	
							nPSDesOU	+=	(nPBruto*npp->npp_perdes)
							nTDescOU	+=	npp->npp_pesdes	
							nPTDesOU	+=	(nPBruto*npp->npp_perdes)
							nGDescOU	+=	npp->npp_pesdes	
							nGPDesOU	+=	(nPBruto*npp->npp_perdes)
						Endif					
						npp->(dbSkip())
					EndDo
				Endif

				For __k	:= 1 to 4
					&("nPDes"+StrZero(__k,1))	:=	 ((&("nPDes"+StrZero(__k,1)))/nPBruto)						
				Next __k

				nPDesOU		:=	(nPDesOU/nPBruto)						

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Totalizadores³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
				nSPBruto	+=	nPBruto	
				nSPLiqui	+=	nPLiqui
				nTPBruto	+=	nPBruto	
				nTPLiqui	+=	nPLiqui
				nGPBruto	+=	nPBruto	
				nGPLiqui	+=	nPLiqui

				If Len(Alltrim(mv_par12))>0 .And. Alltrim(mv_par12)<>Alltrim(cUm)	//Converte se Necessario	
					@ nLin,081 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),nPBruto),"@E 9,999,999.99")				
					nCol	:=	94
					For __k := 1 To 4 
						@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),(&("nDesc"+StrZero(__k,1)))),"@E 9,999,999.99")				
						nCol	:=	nCol+13 	
						@ nLin,nCol PSay Transform((&("nPDes"+StrZero(__k,1))),"@E 999.99")				
						nCol	:=	nCol+7 				
					Next __k
					@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),nDescOU),"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform(nPDesOU,"@E 999.99")									
					@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),nPLiqui),"@E 9,999,999.99")					
				Else
					@ nLin,081 PSay Transform(nPBruto,"@E 9,999,999.99")				
					nCol	:=	94
					For __k := 1 To 4 
						@ nLin,nCol PSay Transform((&("nDesc"+StrZero(__k,1))),"@E 9,999,999.99")				
						nCol	:=	nCol+13 	
						@ nLin,nCol PSay Transform((&("nPDes"+StrZero(__k,1))),"@E 999.99")				
						nCol	:=	nCol+7 				
					Next __k
					@ nLin,nCol PSay Transform(nDescOU,"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform(nPDesOU,"@E 999.99")									
					@ nLin,194 PSay Transform(nPLiqui,"@E 9,999,999.99")					
				Endif

				If Len(Alltrim(mv_par13))>0 .And. Alltrim(mv_par13)<>Alltrim(cUm)	//Converte se Necessario	
					@ nLin,208 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par13),nPLiqui),"@E 9,999,999.99")														
				ElseIf Len(Alltrim(mv_par13))>0 .And. Alltrim(mv_par13)==Alltrim(cUm)
					@ nLin,208 PSay Transform(nPLiqui,"@E 9,999,999.99")														    		
				Endif					

				nLin++

				If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             

				(cAliasTMP)->(dbSkip())
			EndDo 

			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             

			If nSRomane>1	
				nLin++	
				@nLin,043 Psay PadR("Total Armazem ---->"+Space(06-Len(Alltrim(Str(nSRomane))))+Alltrim(Str(nSRomane)),25) 
				If Len(Alltrim(mv_par12))>0 .And. Alltrim(mv_par12)<>Alltrim(cUm)	//Converte se Necessario	
					@ nLin,081 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),nSPBruto),"@E 9,999,999.99")				
					nCol	:=	94
					For __k := 1 To 4 
						@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),(&("nSDesc"+StrZero(__k,1)))),"@E 9,999,999.99")				
						nCol	:=	nCol+13 	
						@ nLin,nCol PSay Transform(((&("nPSDes"+StrZero(__k,1)))/nSPBruto),"@E 999.99")				
						nCol	:=	nCol+7 				
					Next __k
					@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),nSDescOU),"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform((nPSDesOU/nSPBruto),"@E 999.99")									
					@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),nSPLiqui),"@E 9,999,999.99")					
				Else
					@ nLin,081 PSay Transform(nSPBruto,"@E 9,999,999.99")				
					nCol	:=	94
					For __k := 1 To 4 
						@ nLin,nCol PSay Transform((&("nSDesc"+StrZero(__k,1))),"@E 9,999,999.99")				
						nCol	:=	nCol+13 	
						@ nLin,nCol PSay Transform(((&("nPSDes"+StrZero(__k,1)))/nSPBruto),"@E 999.99")				
						nCol	:=	nCol+7 				
					Next __k
					@ nLin,nCol PSay Transform(nSDescOU,"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform((nPSDesOU/nSPBruto),"@E 999.99")									
					@ nLin,194 PSay Transform(nSPLiqui,"@E 9,999,999.99")					
				Endif

				If Len(Alltrim(mv_par13))>0 .And. Alltrim(mv_par13)<>Alltrim(cUm)	//Converte se Necessario	
					@ nLin,208 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par13),nSPLiqui),"@E 9,999,999.99")														
				ElseIf Len(Alltrim(mv_par13))>0 .And. Alltrim(mv_par13)==Alltrim(cUm)
					@ nLin,208 PSay Transform(nSPLiqui,"@E 9,999,999.99")														    		
				Endif					
				nLin++		
			Endif

		EndDo

		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif             

		If nTRomane>1	
			nLin++
			@nLin,043 Psay PadR("Total Cliente ---->"+Space(06-Len(Alltrim(Str(nTRomane))))+Alltrim(Str(nTRomane)),25) 
			If Len(Alltrim(mv_par12))>0 .And. Alltrim(mv_par12)<>Alltrim(cUm)	//Converte se Necessario	
				@ nLin,081 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),nTPBruto),"@E 9,999,999.99")				
				nCol	:=	94
				For __k := 1 To 4 
					@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),(&("nTDesc"+StrZero(__k,1)))),"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform(((&("nPTDes"+StrZero(__k,1)))/nSPBruto),"@E 999.99")				
					nCol	:=	nCol+7 				
				Next __k
				@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),nTDescOU),"@E 9,999,999.99")				
				nCol	:=	nCol+13 	
				@ nLin,nCol PSay Transform((nPTDesOU/nTPBruto),"@E 999.99")									
				@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),nTPLiqui),"@E 9,999,999.99")					
			Else
				@ nLin,081 PSay Transform(nTPBruto,"@E 9,999,999.99")				
				nCol	:=	94
				For __k := 1 To 4 
					@ nLin,nCol PSay Transform((&("nTDesc"+StrZero(__k,1))),"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform(((&("nPTDes"+StrZero(__k,1)))/nTPBruto),"@E 999.99")				
					nCol	:=	nCol+7 				
				Next __k
				@ nLin,nCol PSay Transform(nTDescOU,"@E 9,999,999.99")				
				nCol	:=	nCol+13 	
				@ nLin,nCol PSay Transform((nPTDesOU/nTPBruto),"@E 999.99")									
				@ nLin,194 PSay Transform(nTPLiqui,"@E 9,999,999.99")					
			Endif

			If Len(Alltrim(mv_par13))>0 .And. Alltrim(mv_par13)<>Alltrim(cUm)	//Converte se Necessario	
				@ nLin,208 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par13),nTPLiqui),"@E 9,999,999.99")														
			ElseIf Len(Alltrim(mv_par13))>0 .And. Alltrim(mv_par13)==Alltrim(cUm)
				@ nLin,208 PSay Transform(nTPLiqui,"@E 9,999,999.99")														    		
			Endif					
			nLin++
		Endif	
	EndDo
	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		If nLin < 80
			Roda()
		EndIf
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	Endif              
	If nGRomane>1	
		nLin++
		@nLin,043 Psay PadR("Total Geral   ---->"+Space(06-Len(Alltrim(Str(nGRomane))))+Alltrim(Str(nGRomane)),25) 
		If Len(Alltrim(mv_par12))>0 .And. Alltrim(mv_par12)<>Alltrim(cUm)	//Converte se Necessario	
			@ nLin,081 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),nGPBruto),"@E 9,999,999.99")				
			nCol	:=	94
			For __k := 1 To 4 
				@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),(&("nGDesc"+StrZero(__k,1)))),"@E 9,999,999.99")				
				nCol	:=	nCol+13 	
				@ nLin,nCol PSay Transform(((&("nGPDes"+StrZero(__k,1)))/nGPBruto),"@E 999.99")				
				nCol	:=	nCol+7 				
			Next __k
			@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),nGDescOU),"@E 9,999,999.99")				
			nCol	:=	nCol+13 	
			@ nLin,nCol PSay Transform((nGPDesOU/nGPBruto),"@E 999.99")									
			@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par12),nGPLiqui),"@E 9,999,999.99")					
		Else
			@ nLin,081 PSay Transform(nGPBruto,"@E 9,999,999.99")				
			nCol	:=	94
			For __k := 1 To 4 
				@ nLin,nCol PSay Transform((&("nGDesc"+StrZero(__k,1))),"@E 9,999,999.99")				
				nCol	:=	nCol+13 	
				@ nLin,nCol PSay Transform(((&("nGPDes"+StrZero(__k,1)))/nGPBruto),"@E 999.99")				
				nCol	:=	nCol+7 				
			Next __k
			@ nLin,nCol PSay Transform(nGDescOU,"@E 9,999,999.99")				
			nCol	:=	nCol+13 	
			@ nLin,nCol PSay Transform((nGPDesOU/nGPBruto),"@E 999.99")									
			@ nLin,194 PSay Transform(nGPLiqui,"@E 9,999,999.99")					
		Endif

		If Len(Alltrim(mv_par13))>0 .And. Alltrim(mv_par13)<>Alltrim(cUm)	//Converte se Necessario	
			@ nLin,208 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par13),nGPLiqui),"@E 9,999,999.99")														
		ElseIf Len(Alltrim(mv_par13))>0 .And. Alltrim(mv_par13)==Alltrim(cUm)
			@ nLin,208 PSay Transform(nGPLiqui,"@E 9,999,999.99")														    		
		Endif					
	Endif

	#IFNDEF TOP
	npo->(dbClearFilter())

	#ENDIF

	(cAliasTMP)->(dbCloseArea())

	RestArea(aArea)

	Roda()

	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return

