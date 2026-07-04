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
±±³Funçào    ³ AGRR287  ³ Autor ³ Danyel Bernuci        ³ Data ³ 15/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Relacao de Acerto de Frete  					              ³±±
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

User Function AGRR287()

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relacao para Acerto de Frete."
Local titulo         := "Relacao de Acertos de Frete"
Local nLin           := 220
Local Cabec1         := ""
Local Cabec2         := ""

Private aOrd        := {"Data+Armazem+Ticket","Transportadora+Equipamento+Motorista","Fazenda+Data+Armazem"}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := 'AGRR287'
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private cPerg       := "AGR287"
Private wnrel       := "AGRR287"
Private cAliasTMP   := "TMP"

Private cString 	:= "NPO"

DbSelectArea("NPO")
DbSetOrder(1)

Pergunte(cPerg,.f.)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.f.,aOrd,.f.,Tamanho,,.t.)

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
±±³Funçào    ³RunReport ³ Autor ³ Danyel Bernuci        ³ Data ³ 15/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ³±±
±±³			 ³ monta a janela com a regua de processamento.				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ AGRR287                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local 	aArea   	:= 	GetArea()
Local 	nOrdem      :=	aReturn[8]                    
Local	cFiltUser	:=	aReturn[7]
Local	aStruct		:=	npo->(dbStruct())
Local   __k         :=  0
Local	nPsbrut		:=	0
Local	nPstara		:=	0
Local	nPssubt	 	:=	0
Local	nPssSeg		:=	0
Local	nPsbrut0	:=	0
Local	nPstara0	:=	0
Local	nPssubt0 	:=	0
Local	nQtdReg0	:=	0
Local	nPssSeg0	:=	0
Local	nPsbrut1	:=	0
Local	nPstara1	:=	0
Local	nPssubt1 	:=	0
Local	nPssSeg1	:=	0
Local	nQtdReg1	:=	0
Local	nPsbrut2	:=	0
Local	nPstara2	:=	0
Local	nPssubt2 	:=	0
Local	nPssSeg2	:=	0
Local	nQtdReg2	:=	0
Local	nPsbrut3	:=	0
Local	nPstara3	:=	0
Local	nPssubt3 	:=	0
Local	nPssSeg3	:=	0
Local	nQtdReg3	:=	0
Local   nTotCarga   :=  0

//Variaveis para arquivos temporarios
Private	cCond1	:=	""
Private	cCond2	:=	""
Private	cCond3	:=	""
Private	cWhile1	:=	""
Private cWhile2 :=	""
Private	cWhile3 :=	""

Private cArqTMP := 	""
Private cIndTMP := 	""
Private cChvTMP := 	""
Private aArqTMP := 	{}

titulo	:= 	Alltrim(titulo)+" no Periodo de "+Dtoc(mv_par01)+" a "+Dtoc(mv_par02)


#IFDEF TOP

	cQuery	:=	"Select "
	cQuery	+=	"NPO_PSBRUT,"
	cQuery	+=	"NPO_PSTARA,"
	cQuery	+=	"NPO_PSSUBT,"
	cQuery	+=	"NPO_DATA,"
	cQuery	+=	"NPO_SAFRA,"
	cQuery	+=	"NPO_TALHAO,"
	cQuery	+=	"NPO_CODIGO,"
	cQuery	+=	"NPO_TICKET,"
	cQuery  +=  "NPO_ARM,"
	cQuery  +=  "NPO_FAZ,"
	cQuery  +=  "NPO_CODTRA,"
	cQuery  +=  "NPO_CODMOT,"
	cQuery  +=  "NPO_CODPRO," 
	cQuery  +=  "NPO_FILIAL,"
	cQuery	+=	"NNR_DESCRI,"
	cQuery	+=	"NN2_NOME,"
	cQuery	+=	"NNB_PLACA,"
	cQuery	+=	"A4_NOME,"
	cQuery	+=	"NNA_NOME "
	
	cQuery	+=	"From "+RetSqlName("NPO")+" "
	
	cQuery	+=	"LEFT JOIN "+RetSqlName("NNB")+" ON NPO_CODEQU=NNB_CODIGO AND "+RetSqlName("NNB")+".D_E_L_E_T_<>'*' "
	cQuery	+=	"LEFT JOIN "+RetSqlName("NNA")+" ON NPO_CODMOT=NNA_CODIGO AND "+RetSqlName("NNA")+".D_E_L_E_T_<>'*' "
	cQuery	+=	"LEFT JOIN "+RetSqlName("NNR")+" ON NPO_ARM   =NNR_CODIGO And "+RetSqlName("NNR")+".D_E_L_E_T_<>'*' "
	cQuery	+=	"LEFT JOIN "+RetSqlName("SA4")+" ON NPO_CODTRA=A4_COD     And "+RetSqlName("SA4")+".D_E_L_E_T_<>'*' "
	cQuery	+=	"LEFT JOIN "+RetSqlName("NN2")+" ON NPO_FAZ   =NN2_CODIGO And "+RetSqlName("NN2")+".D_E_L_E_T_<>'*' "

	cQuery	+=	"Where "	
	cQuery	+=	"NPO_DATA Between   '"+Dtos(mv_par01)+"' And '"+Dtos(mv_par02)+"' And "
	cQuery	+=	"NPO_CODTRA Between '"+mv_par03+"' And '"+mv_par04+"' And "
	cQuery	+=	"NPO_CODEQU Between '"+mv_par05+"' And '"+mv_par06+"' And "
	cQuery	+=	"NPO_CODMOT Between '"+mv_par07+"' And '"+mv_par08+"' And "
	cQuery	+=	"NPO_ARM Between    '"+mv_par11+"' And '"+mv_par12+"' And "
	cQuery	+=	"NPO_FAZ Between    '"+mv_par13+"' And '"+mv_par14+"' And "
	cQuery	+=	"NPO_CODPRO Between '"+mv_par15+"' And '"+mv_par16+"' And "	
	
	//Considera Filias
	If mv_par17==1
		cQuery	+=	"NPO_FILIAL Between '"+mv_par18+"' And '"+mv_par19+"' "	
	Else
		cQuery	+=	"NPO_FILIAL='"+xFilial("NPO")+"' "
	Endif

	If nOrdem==1
		cQuery 	+=	"Order By NPO_DATA,NNR_DESCRI,NPO_TICKET"
    ElseIf nOrdem==2
		cQuery 	+= 	"Order By A4_NOME,NNB_PLACA,NNA_NOME"
	Else
		cQuery 	+=	"Order By NPO_FAZ,NPO_DATA,NNR_DESCRI"
    Endif

	DbUseArea(.T.,'TOPCONN',TCGenQry(,,cQuery),cAliasTMP,.t.,.t.)  

	For __k := 1 to Len(aStruct)
		If aStruct[__k,2]<>'C'
			TCSetField('TMP',aStruct[__k,1],aStruct[__k,2],aStruct[__k,3],aStruct[__k,4])
		Endif
	Next __k

#ELSE

	cFiltro := "NPO_DATA >= MV_PAR01 .And. "
	cFiltro += "NPO_DATA <= MV_PAR02 .And. "
	cFiltro += "NPO_CODTRA >= MV_PAR03 .And. "
	cFiltro += "NPO_CODTRA <= MV_PAR04 .And. "
	cFiltro += "NPO_CODEQU >= MV_PAR05 .And. "
	cFiltro += "NPO_CODEQU <= MV_PAR06 .And. "
	cFiltro += "NPO_ARM >= MV_PAR11 .And. "
	cFiltro += "NPO_ARM <= MV_PAR12 .And. "
	cFiltro += "NPO_FAZ >= MV_PAR13 .And. "
	cFiltro += "NPO_FAZ <= MV_PAR14 .And. "
	cFiltro += "NPO_CODPRO >= MV_PAR15 .And. "
	cFiltro += "NPO_CODPRO <= MV_PAR16 .And. "
	//Considera Filias
	If mv_par17==1
		cFiltro += "NPO_FILIAL >= MV_PAR18 .And. "
		cFiltro += "NPO_FILIAL <= MV_PAR19 .And. "
	Else
		cFiltro += "NPO_FILIAL == '"+xFilial('NPO')+"' .And. "
	Endif
	cFiltro += "NPO_CODMOT >= MV_PAR07 .And. "
	cFiltro += "NPO_CODMOT <= MV_PAR08"
		
	dbSelectArea(cString)
	dbSetFilter( {|| &cFiltro }, cFiltro )
	
	aAdd(aArqTMP,{"NPO_FILIAL","C",002,00})
	aAdd(aArqTMP,{"NPO_CODIGO","C",006,00})
	aAdd(aArqTMP,{"NPO_TIPO  ","C",001,00})			
	aAdd(aArqTMP,{"NPO_CODAPO","C",006,00})
	aAdd(aArqTMP,{"NPO_FAZ"   ,"C",006,00})
	aAdd(aArqTMP,{"NN2_NOME"  ,"C",030,00})
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
	aAdd(aArqTMP,{"NNR_DESCRI","C",020,00})
	aAdd(aArqTMP,{"NNB_PLACA" ,"C",008,00})
	aAdd(aArqTMP,{"NNA_NOME"  ,"C",040,00})
	aAdd(aArqTMP,{"A4_NOME"   ,"C",040,00})
	
	//Cria tabela temporária
    If nOrdem==1
		cChvTMP := "Dtos(NPO_DATA)+NNR_DESCRI+NPO_TICKET"
	ElseIf nOrdem==2
		cChvTMP := "A4_NOME+NNB_PLACA+NNA_NOME"	
	Else
		cChvTMP := "NPO_FAZ+Dtos(NPO_DATA)+NNR_DESCRI"
	Endif	
	
    cAliasTMP  := GetNextAlias()
    oArqTemp := AGRCRTPTB(cAliasTMP, {aArqTMP, {{"", cChvTMP }}} )
	
	DbSelectArea("NPO")
	npo->(DbGoTop())
	While npo->(!Eof())
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !(Len(Alltrim(cFiltUser))==0).And.!(&cFiltUser)
			npo->(dbSkip())
			Loop
		EndIf		
				
		DbSelectArea(cAliasTMP)	
		If RecLock(cAliasTMP,.t.)
			Replace (cAliasTMP)->npo_filial	With	npo->npo_filial		
			Replace (cAliasTMP)->npo_codigo	With	npo->npo_codigo		
			Replace (cAliasTMP)->npo_tipo  	With	npo->npo_tipo	
			Replace (cAliasTMP)->npo_codapo	With	npo->npo_codapo	
			Replace (cAliasTMP)->npo_faz	With	npo->npo_faz
			Replace (cAliasTMP)->npo_talhao	With	npo->npo_talhao
			Replace (cAliasTMP)->npo_data	With	npo->npo_data	
			Replace (cAliasTMP)->npo_safra 	With	npo->npo_safra	
			Replace (cAliasTMP)->npo_arm   	With	npo->npo_arm	
			Replace (cAliasTMP)->npo_codcli With	npo->npo_codcli	
			Replace (cAliasTMP)->npo_lojcli	With	npo->npo_lojcli	
			Replace (cAliasTMP)->npo_codtra	With	npo->npo_codtra	
			Replace (cAliasTMP)->npo_codequ	With	npo->npo_codequ
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
			Replace (cAliasTMP)->nnr_descri	With	SubStr(Posicione("NNR",1,xFilial("NNR")+npo->npo_arm,"NNR_DESCRI"),1,20)
			Replace (cAliasTMP)->nnb_placa	With   	SubStr(Posicione("NNB",1,xFilial("NNB")+npo->npo_codequ,"NNB_PLACA"),1,08)
			Replace (cAliasTMP)->nna_nome	With   	SubStr(Posicione("NNA",1,xFilial("NNA")+npo->npo_codmot,"NNA_NOME"),1,40)
			Replace (cAliasTMP)->a4_nome	With   	SubStr(Posicione("SA4",1,xFilial("SA4")+npo->npo_codtra,"A4_NOME"),1,40)			
			Replace (cAliasTMP)->nn2_nome	With   	SubStr(Posicione("NN2",2,xFilial("NN2")+npo->npo_faz,"NN2_NOME"),1,30)			
			MsUnLock(cAliasTMP)
		EndIf                                		
		DbSelectArea("NPO")
		npo->(dbSkip())
	EndDo
#ENDIF
	
/*                                                                                                  1         1         1         1         1         1         1         1         1         1         2         2
          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Data     NºRom. Armazem                 Nº Ticket  Fazenda              Tl Transportadora                        Placa    Motorista                                  Peso Bruto      Peso Tara   Peso Liq./U1   Peso Liq./U2
XX/XX/XX XXXXXX XX-XXXXXXXXXXXXXXXXXXXX XXXXXXXXXX XX-XXXXXXXXXXXXXXXXX XX XXXXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXX-XXXX XXXXXX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXX,XXX,XXX.XX XXX,XXX,XXX.XX XXX,XXX,XXX.XX XXX,XXX,XXX.XX
*/

Cabec1 := "Data     NºRom. Armazem                 Nº Ticket  Fazenda              Tl Transportadora                        Placa    Motorista                                  Peso Bruto      Peso Tara   Peso Liq./"+If(Len(Alltrim(mv_par09))==0,"U1",Alltrim(mv_par09))+"   Peso Liq./"+If(Len(Alltrim(mv_par10))==0,"U2",Alltrim(mv_par10))
Cabec2 := ""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as Condicoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If nOrdem==1
	cCond1	:=	"Dtos((cAliasTMP)->npo_data)==Dtos(cWhile1)"
	cCond2	:=	"(cAliasTMP)->nnr_descri==cWhile2"
	cCond3	:=	".t."
ElseIf nOrdem==2
	cCond1	:=	"(cAliasTMP)->a4_nome==cWhile1"
	cCond2	:=	"(cAliasTMP)->nnb_placa==cWhile2"
	cCond3	:=	"(cAliasTMP)->nna_nome==cWhile3"
Else
	cCond1	:=	"(cAliasTMP)->npo_faz==cWhile1"
	cCond2	:=	".t."
	cCond3	:=	".t."
Endif

DbSelectArea(cAliasTMP)
SetRegua((cAliasTMP)->(RecCount()))
(cAliasTMP)->(Dbgotop())
While (cAliasTMP)->(!Eof())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Avalia filtro do usuario                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

	If nOrdem==1
		cWhile1	:=	(cAliasTMP)->npo_data
	ElseIf nOrdem==2
		cWhile1	:=	(cAliasTMP)->a4_nome
	Else
		cWhile1	:=	(cAliasTMP)->npo_faz
	Endif

	nPsbrut1	:=	0
	nPstara1	:=	0
	nPssubt1 	:=	0
	nPssSeg1 	:=	0
	nQtdReg1	:=	0
	   	
	While (cAliasTMP)->(!Eof()) .And. &cCond1 

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !(Len(Alltrim(cFiltUser))==0).And.!(&cFiltUser)
			(cAliasTMP)->(dbSkip())
			Loop
		EndIf		


		If nOrdem==1
			cWhile2	:=	(cAliasTMP)->nnr_descri
		ElseIf nOrdem==2
			cWhile2	:=	(cAliasTMP)->nnb_placa
		Else
			cWhile2	:=	(cAliasTMP)->npo_data
		Endif

		nPsbrut2	:=	0
		nPstara2	:=	0
		nPssubt2 	:=	0
		nPssSeg2 	:=	0
		nQtdReg2	:=	0
		   		
   		While (cAliasTMP)->(!Eof()) .And. &cCond1 .And. &cCond2

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Avalia filtro do usuario                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !(Len(Alltrim(cFiltUser))==0).And.!(&cFiltUser)
				(cAliasTMP)->(dbSkip())
				Loop
			EndIf		
			
			If nOrdem==2
				cWhile3	:=	(cAliasTMP)->nna_nome
			Endif

			nPsbrut3	:=	0
			nPstara3	:=	0
			nPssubt3 	:=	0
			nPssSeg3 	:=	0
			nQtdReg3	:=	0
	        
   			While (cAliasTMP)->(!Eof()) .And. &cCond1 .And. &cCond2 .And. &cCond3 

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Avalia filtro do usuario                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !(Len(Alltrim(cFiltUser))==0).And.!(&cFiltUser)
					(cAliasTMP)->(dbSkip())
					Loop
				EndIf		
		
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Verifica o Produto Relacionado ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectArea("NN1")
				DbSetOrder(1)
				If DbSeek(If(Len(Alltrim(xFilial("NN1")))==0,xFilial("NN1"),(cAliasTMP)->npo_filial)+(cAliasTMP)->npo_safra)				
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Verifica a Unidade de Medida para Conveter se Necessario³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					DbSelectArea("SB1")
					DbSetOrder(1)
					If DbSeek(If(Len(Alltrim(xFilial("SB1")))==0,xFilial("SB1"),(cAliasTMP)->npo_filial)+nn1->nn1_codpro)						

						nQtdReg3++
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Converte a Primeira Unidade de Medida se Necessario ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ						
						If Len(Alltrim(mv_par09))>0 .And. Alltrim(mv_par09)<>Alltrim(sb1->b1_um)
							nPsbrut		:=	Agrx001(Alltrim(sb1->b1_um),Alltrim(mv_par09),(cAliasTMP)->npo_psbrut)
							nPstara		:=	Agrx001(Alltrim(sb1->b1_um),Alltrim(mv_par09),(cAliasTMP)->npo_pstara)
							nPssubt	 	:=	Agrx001(Alltrim(sb1->b1_um),Alltrim(mv_par09),(cAliasTMP)->npo_pssubt)
		                Else
							nPsbrut		:=	(cAliasTMP)->npo_psbrut
							nPstara		:=	(cAliasTMP)->npo_pstara
							nPssubt	 	:=	(cAliasTMP)->npo_pssubt		                
		                Endif              
		                		                
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Converte a Segunda Unidade de Medida se Necessario  ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)<>Alltrim(sb1->b1_um)
							nPssSeg	 	:=	Agrx001(Alltrim(sb1->b1_um),Alltrim(mv_par10),(cAliasTMP)->npo_pssubt)
                        ElseIf Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)==Alltrim(sb1->b1_um)
							nPssSeg	 	:=	(cAliasTMP)->npo_pssubt                        
                        Else
							nPssSeg	 	:=	0                        
                        Endif   
                        
						IncRegua(cWhile1)
						
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

						@nLin,000 Psay PadR(Dtoc((cAliasTMP)->npo_data),08)
						@nLin,009 Psay PadR((cAliasTMP)->npo_codigo,06)
						@nLin,016 Psay PadR(AllTrim((cAliasTMP)->npo_arm)+'-'+(cAliasTMP)->nnr_descri,23)
						@nLin,040 Psay PadR((cAliasTMP)->npo_ticket,10)  
						@nLin,051 Psay PadR((cAliasTMP)->npo_faz+'-'+(cAliasTMP)->nn2_nome,20)
						@nLin,072 PSay PadR((cAliasTMP)->npo_talhao,3)
						@nLin,075 Psay PadR((cAliasTMP)->npo_codtra+'-'+(cAliasTMP)->a4_nome,27)  
						@nLin,113 Psay PadR((cAliasTMP)->nnb_placa,08)  
						@nLin,122 Psay PadR((cAliasTMP)->npo_codmot+'-'+(cAliasTMP)->nna_nome,37)
						@nLin,161 PSay Transform(nPsbrut,"@E 999,999,999.99")
						@nLin,176 PSay Transform(nPstara,"@E 999,999,999.99")
						@nLin,191 PSay Transform(nPssubt,"@E 999,999,999.99")
						@nLin,206 PSay Transform(nPssSeg,"@E 999,999,999.99")
						nLin++
						nTotCarga++
					Endif					
				Endif	             				
				nPsbrut3	+=	nPsbrut
				nPstara3	+=	nPstara
				nPssubt3 	+=	nPssubt
				nPssSeg3 	+=	nPssSeg    				
				(cAliasTMP)->(dbSkip())				
            EndDo			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Totaliza por motorista³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nOrdem==2 .And. nQtdReg3>1                    
				nLin++

			   	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			      	If nLin < 80
				  		Roda()
				  	EndIf
			      	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			      	nLin := 9
			   	Endif             															

				@nLin,113 Psay PadR("Total Motorista ---> ",40)
				@nLin,161 PSay Transform(nPsbrut3,"@E 999,999,999.99")					
				@nLin,176 PSay Transform(nPstara3,"@E 999,999,999.99")					
				@nLin,191 PSay Transform(nPssubt3,"@E 999,999,999.99")					
				@nLin,206 PSay Transform(nPssSeg3,"@E 999,999,999.99")					
				nLin += 1
			Endif			
			nPsbrut2	+=	nPsbrut3
			nPstara2	+=	nPstara3
			nPssubt2 	+=	nPssubt3
			nPssSeg2 	+=	nPssSeg3    				                       			
			nQtdReg2++
		EndDo 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Totaliza Condicao 2   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nQtdReg2>1                    
			nLin++

		   	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		      	If nLin < 80
			  		Roda()
			  	EndIf
		      	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		      	nLin := 9
		   	Endif             															

			If nOrdem==1
				@nLin,113 Psay PadR("Total "+Alltrim(SubStr(cWhile2,1,25))+" ---> ",40)
			ElseIf nOrdem==2
				@nLin,113 Psay PadR("Total Transportadora ---> ",40)
			Else
				@nLin,113 Psay PadR("Total Data ("+Alltrim(SubStr(If(nOrdem==3,Dtoc(cWhile2),cWhile2),1,25))+") ---> ",40)
			EndIf
			@nLin,161 PSay Transform(nPsbrut2,"@E 999,999,999.99")					
			@nLin,176 PSay Transform(nPstara2,"@E 999,999,999.99")					
			@nLin,191 PSay Transform(nPssubt2,"@E 999,999,999.99")					
			@nLin,206 PSay Transform(nPssSeg2,"@E 999,999,999.99")					
			nLin += 2
		Endif
		nPsbrut1	+=	nPsbrut2
		nPstara1	+=	nPstara2
		nPssubt1 	+=	nPssubt2
		nPssSeg1 	+=	nPssSeg2    				                       	
		nQtdReg1++	
	EndDo
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Totaliza Condicao 1   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nQtdReg1>0
		nLin++

	   	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	      	If nLin < 80
		  		Roda()
		  	EndIf
	      	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	      	nLin := 9
	   	Endif             															

		If nOrdem == 1
			@nLin,113 Psay PadR("Total Data ("+Alltrim(SubStr(If(nOrdem==1,Dtoc(cWhile1),cWhile1),1,25))+") ---> ",40)
		ElseIf nOrdem == 2
			@nLin,113 Psay PadR("Total Transportadora ---> ",40)  
		Else
			@nLin,113 Psay PadR("Total Fazenda ---> ",40)  
		EndIf
		@nLin,161 PSay Transform(nPsbrut1,"@E 999,999,999.99")					
		@nLin,176 PSay Transform(nPstara1,"@E 999,999,999.99")					
		@nLin,191 PSay Transform(nPssubt1,"@E 999,999,999.99")					
		@nLin,206 PSay Transform(nPssSeg1,"@E 999,999,999.99")					
		nLin += 2
	Endif	
	nPsbrut0	+=	nPsbrut1
	nPstara0	+=	nPstara1
	nPssubt0 	+=	nPssubt1
	nPssSeg0 	+=	nPssSeg1    				                       		
	nQtdReg0++	
EndDo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Totaliza Geral  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nQtdReg0>1
	nLin++

   	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      	If nLin < 80
	  		Roda()
	  	EndIf
      	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      	nLin := 9
   	Endif

	@nLin,113 Psay PadR("Total Geral ("+Transform(nTotCarga,'@E 9999') +") ---> ",40)  
	@nLin,161 PSay Transform(nPsbrut0,"@E 999,999,999.99")					
	@nLin,176 PSay Transform(nPstara0,"@E 999,999,999.99")					
	@nLin,191 PSay Transform(nPssubt0,"@E 999,999,999.99")					
	@nLin,206 PSay Transform(nPssSeg0,"@E 999,999,999.99")					
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
