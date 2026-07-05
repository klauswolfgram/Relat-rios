/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prАtica e de fАcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr425.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 2 //Versao do fonte 
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    Ё MDTR425  Ё Autor Ё Marcio Costa          Ё Data Ё 12.01.00 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁRelatorio das doencas diagnosticadas por Centro de Custo.   Ё╠╠
╠╠Ё          ЁO usuario pode selecionar o codigo da doenca, obtendo como  Ё╠╠ 
╠╠Ё          Ёresultado a relacao de Setores que apresentam determinada   Ё╠╠ 
╠╠Ё          Ёdoenca. Tambem podera selecionar o codigo do Centro de CustoЁ╠╠
╠╠Ё          Ёobtendo a relacao de doencas que podem ter sido causadas porЁ╠╠
╠╠Ё          Ёalguma sircustancia do local de trabalho.                   Ё╠╠ 
╠╠Ё          ЁObs. So sera  considerado  diagnosticos  dos  Funcionarios. Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe e Ё MDTR425void)                                               Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function MDTR425()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
LOCAL wnrel   := "MDTR425"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatorio de apresentacao das doencas por Centro de Custo. Baseado nos"
LOCAL cDesc2  := STR0002 //"diagnostigos emitidos  pelos medicos, para os funcionarios.           "
LOCAL cDesc3  := STR0003 //"Atraves dos parametros podera ser selecionada C.Custo e/ou CID.  "
LOCAL cString := "TMT"

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )  

PRIVATE nomeprog := "MDTR425"
PRIVATE tamanho  := "M"
PRIVATE aReturn  := { STR0004, 1,STR0005, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006   //"CID x Centro de Custo"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cPerg    :=If(!lSigaMdtPS,"MDT425    ","MDT425PS  ")
PRIVATE cabec1, cabec2
Private aVetinr := {} 

cAliasCC := "SI3"   
nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
cDescCC2 := "SI3->I3_DESC"

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	cDescCC2 := "CTT->CTT_DESC01"
Endif   	

If !MDTRESTRI(cPrograma)
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif
/*---------------------------------
//PERGUNTA PADRцO          			|       
|  01  De  Centro de Custo ?       |
|  02  Ate Centro de Custo ?       |
|  03  De  CID ?                   |
|  04  Ate CID ?                   |
|  05  De  Data Diagnost. ?        |
|  06  Ate Data Diagnost. ?    		|
|										|
//PERGUNTAS PRESTADOR DE SERVIгO	|
|  01  De  Cliente ?           		|
|  02  Loja                    		|
|  03  AtИ Cliente ?           		|
|  04  Loja                    		|
|  05  De  Centro de Custo ?   		|
|  06  Ate Centro de Custo ?   		|
|  07  De  CID ?               		|
|  08  Ate CID ?                	|
|  09  De  Data Diagnost. ?    		|
|  10  Ate Data Diagnost. ?    		|
--------------------------------------*/


//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica as perguntas selecionadas                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
pergunte(cPerg,.F.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Envia controle para a funcao SETPRINT                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Devolve variaveis armazenadas (NGRIGHTCLICK)                          Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

RptStatus({|lEnd| R425Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Devolve variaveis armazenadas (NGRIGHTCLICK)                          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
NGRETURNPRM(aNGBEGINPRM)

Return NIL
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤└o    Ё R425Imp  Ё Autor Ё Inacio Luiz Kolling   Ё Data Ё   /06/97 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤└o Ё Chamada do Relat╒rio                                       Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё MDTR425                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function R425Imp(lEnd,wnRel,titulo,tamanho)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0
Local oTempTRB

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis para controle do cursor de progressao do relatorio Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
LOCAL nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis locais exclusivas deste programa                   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

LOCAL cChave           := SPACE(16)
LOCAL lContinua        := .T.
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis tipo Private padrao de todos os relatorios         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Contadores de linha e pagina                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE li := 80 ,m_pag := 1   
Private aVetinr := {}

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis locais exclusivas deste programa                   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
PRIVATE lPrestSX6  := .f.
Private nSizeSI3
nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica se deve comprimir ou nao                            Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nTipo  := IIF(aReturn[4]==1,15,18)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta os Cabecalhos                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

cabec1 := STR0007   //"C.Custo    Nome do Centro de Custo"
cabec2 := Space(11)+STR0008+Space( 26 )+STR0009 //"C.I.D.   Descricao                                            Grupo C.I.D."###"Masc.    Fem.   Total"
                                                                           
/*
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04                                 <Relatorio de Questionario Medico>                               DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************
             1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
C.Custo    Nome do Centro de Custo
           C.I.D.   Descricao                                                                                  Masc.    Fem.   Total
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
          xxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 999.999 999.999 999.999

*/

If lSigaMdtps

	aDBF := {}
	AADD(aDBF,{"CCUSTO","C",nSizeSI3,0}) 
	AADD(aDBF,{"CID"   ,"C",06,0}) 
	AADD(aDBF,{"MASCUL","N",06,0}) 
	AADD(aDBF,{"FEMINI","N",06,0}) 
	AADD(aDBF,{"CLIENT","C",nTa1,0}) 
	AADD(aDBF,{"LOJA"  ,"C",nTa1L,0})
	AADD(aDBF,{"GRPCID","C",04,0}) 

	//Cria TRB
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"CCUSTO","CID"} )
	oTempTRB:Create()

	dbSelectArea("TMT")
	dbSetOrder( 06 )  //TMT_FILIAL+TMT_CC
	dbSeek(xFilial("TMT")+MV_PAR05,.T.)

	SetRegua(LastRec())

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Correr TMT para ler os  Diagnosticos                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

	While !EoF()                                   .AND.;
		  TMT->TMT_FILIAL == xFIlial('TMT')        .AND.;
		  TMT->TMT_CC <= MV_PAR06

		IncRegua()
		
		If TMT->(TMT_CLIENT+TMT_LOJA) < MV_PAR01+MV_PAR02 .OR. TMT->(TMT_CLIENT+TMT_LOJA) > MV_PAR03+MV_PAR04
			dbSelectArea("TMT")
			dbSKIP()
			loop
		Endif

		If TMT->TMT_CID < MV_PAR07 .OR. TMT->TMT_CID > MV_PAR08 .OR. Empty(TMT->TMT_CID)
			dbSelectArea("TMT")
			dbSKIP()
			loop
		Endif

		If TMT->TMT_DTATEN < MV_PAR09 .OR. TMT->TMT_DTATEN > MV_PAR10
			dbSelectArea("TMT")
			dbSKIP()
			loop
		Endif

		dbSelectArea("TM0")
		dbSetOrder(01)
		dbSeek(xFilial("TM0")+TMT->TMT_NUMFIC)

		If Empty(TM0->TM0_MAT)
			dbSelectArea("TMT")
			dbSKIP()
			loop
		Endif

		dbSelectArea("TRB")
		If !dbSeek( Padr( TMT->TMT_CC,nSizeSI3 ) + TMT->TMT_CID )
			TRB->(DbAppend())
			TRB->CCUSTO     := TMT->TMT_CC
			TRB->CID        := TMT->TMT_CID
			TRB->GRPCID     := TMT->TMT_GRPCID
			TRB->CLIENT     := TMT->TMT_CLIENT
			TRB->LOJA       := TMT->TMT_LOJA
		Endif

		If TM0->TM0_SEXO = '1'
			TRB->MASCUL := TRB->MASCUL + 1
		Else
			TRB->FEMINI := TRB->FEMINI + 1
		Endif
		
		//------------------------------------------------------------------
	    // ImplementaГЦo, define que o relatСrio deve considerar, nЦo os 
	    // Cid's do campo TMT_CID, mas tambИm o campo TMT_CID2 e os Cids,
	    // complementares que foram relacionados na tabela TKJ, dessa forma
	    // fica a cargo da funГЦo abaixo realizar a inclusЦo destes Cids na 
	    // TRB, tendo como prИ requisito, estar posicionado no diagnСstico da 
	    // TMT
	    //------------------------------------------------------------------
		MDT425PRC2()
		
		dbSelectArea("TMT")
		dbSKIP()

	End

	dbSelectArea("TRB")
	dbGOTOP()

	While ! eof()
		cCliente := TRB->CLIENT+TRB->LOJA
		lPrint := .t.
		While !EOF() .and. TRB->CLIENT+TRB->LOJA == cCliente
			cCCUSTO := TRB->CCUSTO
			If lPrint     
				li := 80                                  
				Dbselectarea("SA1")              
				Dbsetorder(1)
				Dbseek(xFilial("SA1")+cCliente)       					
				Somalinha()
				@Li,00 PSAY STR0019 + AllTrim(SA1->A1_COD) + "-" + AllTrim(SA1->A1_LOJA) + " - " + Alltrim(SA1->A1_NOME)  //"Cliente/Loja: "
				Somalinha()       	
				lPrint := .f.
			Endif 
			Somalinha()
			@Li,000 PSAY cCCUSTO PICTURE "@!"

			dbSelectArea(cAliasCC)
			dbSetOrder(01)
			dbSeek(xFilial(cAliasCC)+TRB->CCUSTO)

			@Li,022 PSAY &cDescCC2

			Somalinha()

			dbSelectArea("TRB")

			While !EOF() .and. TRB->CLIENT+TRB->LOJA == cCliente .and. TRB->CCUSTO == cCCUSTO

				Somalinha()
				dbSelectArea("TMR")
				dbSetOrder(01)
				dbSeek(xFilial("TMR")+TRB->CID)

				@Li,011 PSAY TRB->CID  PICTURE "@!"
				@Li,020 PSAY Substr( TMR->TMR_DOENCA,1,45 )
				@Li,073 PSAY Substr( TRB->GRPCID,1,04 )

				@Li,109 PSAY TRB->MASCUL              PICTURE "@E 999,999"
				@Li,117 PSAY TRB->FEMINI              PICTURE "@E 999,999"
				@Li,125 PSAY TRB->MASCUL+TRB->FEMINI  PICTURE "@E 999,999"

				dbSelectArea("TRB")
				dbskip()
			End
			SomaLinha()
		End
	End

Else

	aDBF := {}
	AADD(aDBF,{"CCUSTO","C",nSizeSI3,0}) 
	AADD(aDBF,{"CID"   ,"C",06,0}) 
	AADD(aDBF,{"MASCUL","N",06,0}) 
	AADD(aDBF,{"FEMINI","N",06,0})
	AADD(aDBF,{"GRPCID","C",04,0}) 

	//Cria TRB
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"CCUSTO","CID"} )
	oTempTRB:Create()
	
	cCondicao  := "!EOF()"    
	cCondicao2 := "!EOF() .and. TRB->CCUSTO == cCCUSTO"
	If SuperGetMv("MV_NGMDTPS",.F.,"N") = "S"
		lPrestSX6  := .t.
		cCondicao  := "!EOF() .and. Substr(TRB->CCUSTO,1,6) == cCliente" 
		cCondicao2 := "!EOF() .and. Substr(TRB->CCUSTO,1,6) == cCliente .and. TRB->CCUSTO == cCCUSTO"
	Endif	

	dbSelectArea("TMT")
	dbSetOrder(06)
	dbSeek(xFilial("TMT")+MV_PAR01,.T.)

	SetRegua(LastRec())

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Correr TMT para ler os  Diagnosticos                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

	While lContinua                                .And.;
  		  !Eof()                                   .AND.;
		  TMT->TMT_FILIAL == xFIlial('TMT')        .AND.;
		  TMT->TMT_CC <= MV_PAR02

		IncRegua()

		If TMT->TMT_CID < MV_PAR03 .OR. TMT->TMT_CID > MV_PAR04 .OR. Empty(TMT->TMT_CID)
			dbSelectArea("TMT")
			dbSKIP()
			loop
		Endif

		If TMT->TMT_DTATEN < MV_PAR05 .OR. TMT->TMT_DTATEN > MV_PAR06
			dbSelectArea("TMT")
			dbSKIP()
			loop
		Endif

		dbSelectArea("TM0")
		dbSetOrder(01)
		dbSeek(xFilial("TM0")+TMT->TMT_NUMFIC)

		If Empty(TM0->TM0_MAT)
			dbSelectArea("TMT")
			dbSKIP()
			loop
		Endif

		dbSelectArea("TRB")
		If !dbSeek( Padr( TMT->TMT_CC,nSizeSI3 ) + TMT->TMT_CID )
			TRB->( DbAppend() )
			TRB->CCUSTO     := TMT->TMT_CC
			TRB->CID        := TMT->TMT_CID
			TRB->GRPCID     := TMT->TMT_GRPCID
		Endif

		If TM0->TM0_SEXO = '1'
			TRB->MASCUL := TRB->MASCUL + 1
		Else
			TRB->FEMINI := TRB->FEMINI + 1
		Endif

		//-----------------------------------------------------
		// Insere Cids Complementares na TRB
		//-----------------------------------------------------
		MDT425PRC2()
		
		dbSelectArea("TMT")
		dbSKIP()

	End

	dbSelectArea("TRB")
	dbGOTOP()

	While ! eof()
		cCliente := Substr(TRB->CCUSTO,1,6)
		lPrint := .t.
		While &cCondicao
			cCCUSTO := TRB->CCUSTO
			If lPrestSX6 .and. lPrint     
				li := 80                                  
				Dbselectarea("SA1")              
				Dbsetorder(1)
				Dbseek(xFilial("SA1")+cCliente)       					
				Somalinha()
				@Li,00 PSAY STR0011 //"Cliente..:"
				@Li,11 PSay Alltrim(cCliente)+" - "+Alltrim(SA1->A1_NOME) 
				Somalinha()       	
				lPrint := .f.
			Endif 
			Somalinha()
			@Li,000 PSAY cCCUSTO PICTURE "@!"

			dbSelectArea(cAliasCC)
			dbSetOrder(01)
			dbSeek(xFilial(cAliasCC)+TRB->CCUSTO)

			@Li,022 PSAY &cDescCC2

			Somalinha()

			dbSelectArea("TRB")

			While &cCondicao2 //! eof() .and. TRB->CCUSTO == cCCUSTO

				Somalinha()
				dbSelectArea("TMR")
				dbSetOrder(01)
				dbSeek(xFilial("TMR")+TRB->CID)

				@Li,011 PSAY TRB->CID  PICTURE "@!"
				@Li,020 PSAY Substr(TMR->TMR_DOENCA,1,45)
				@Li,073 PSAY Substr( TRB->GRPCID,1,04 )

				@Li,109 PSAY TRB->MASCUL              PICTURE "@E 999,999"
				@Li,117 PSAY TRB->FEMINI              PICTURE "@E 999,999"
				@Li,125 PSAY TRB->MASCUL+TRB->FEMINI  PICTURE "@E 999,999"

				dbSelectArea("TRB")
				dbskip()
			Enddo
			SomaLinha()
		End
	Enddo

Endif
	
//Roda(nCntImpr,cRodaTxt,Tamanho)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Devolve a condicao original do arquivo principal             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
RetIndex("TMT")

Set Filter To

Set device to Screen

If TRB->(RecCount()) == 0
	MsgInfo(STR0020)  //"NЦo hА nada para imprimir no relatСrio."
	oTempTRB:Delete()
	Return .f.
Endif

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()

oTempTRB:Delete()
dbSelectArea("TMT")
dbSetOrder(01)
Return NIL

/*/
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠Ё Fun┤┘o   Ё SomaLinhaЁ Autor Ё Inacio Luiz Kolling   Ё Data Ё   /06/97 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠Ё Descri┤┘oЁ Incrementa Linha e Controla Salto de Pagina                Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё MDTR405                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
/*/
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
        //Li := Li - 1
    EndIf
Return

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT425PRC2
Insere na TRB os Cid's complementares do diagnСstico posicionado.

@author AndrИ Felipe Joriatti
@since 29/11/2012
@version MP11
@param
	    
@return Nil
/*/
//---------------------------------------------------------------------
Static Function MDT425PRC2()

	Local aArea := GetArea()
	
	If !Empty( TMT->TMT_CID2 )
	
		DbSelectArea( "TRB" )
		If !DbSeek( Padr( TMT->TMT_CC,nSizeSI3 ) + TMT->TMT_CID2 )
		
			TRB->( DbAppend() )
			TRB->CCUSTO     := TMT->TMT_CC
			TRB->CID        := TMT->TMT_CID2
			TRB->GRPCID     := TMT->TMT_GRPCI2
			
			If lSigaMdtPs
				TRB->CLIENT     := TMT->TMT_CLIENT
				TRB->LOJA       := TMT->TMT_LOJA
			EndIf

		Endif

		If TM0->TM0_SEXO = '1'
			TRB->MASCUL := TRB->MASCUL + 1
		Else
			TRB->FEMINI := TRB->FEMINI + 1
		Endif

	EndIf

		DbSelectArea( "TKJ" )
		DbSetOrder( 1 ) // TKJ_FILIAL+TKJ_NUMFIC+DTOS(TKJ_DTCONS)+TKJ_HRCONS+TKJ_GRPCID+TKJ_CID
		DbSeek( xFilial( "TKJ" ) + TMT->TMT_NUMFIC + DTOS( TMT->TMT_DTCONS ) + TMT->TMT_HRCONS )
		While !EoF() .And. TKJ->TKJ_FILIAL + TKJ->TKJ_NUMFIC + DTOS( TKJ->TKJ_DTCONS ) + TKJ->TKJ_HRCONS == ;
					xFilial("TKJ") + TMT->TMT_NUMFIC + DTOS( TMT->TMT_DTCONS ) + TMT->TMT_HRCONS

			
			DbSelectArea( "TRB" )
			If !DbSeek( Padr( TMT->TMT_CC,nSizeSI3 ) + TKJ->TKJ_CID )
				TRB->( DbAppend() )
				TRB->CCUSTO     := TMT->TMT_CC
				TRB->CID        := TKJ->TKJ_CID
				TRB->GRPCID     := TKJ->TKJ_GRPCID
				
				If lSigaMdtPs
					TRB->CLIENT     := TMT->TMT_CLIENT
					TRB->LOJA       := TMT->TMT_LOJA
				EndIf
	
			Endif
	
			If TM0->TM0_SEXO = '1'
				TRB->MASCUL := TRB->MASCUL + 1
			Else
				TRB->FEMINI := TRB->FEMINI + 1
			Endif
			
			DbSelectArea( "TKJ" )
			DbSkip()
			
		EndDo
		

	RestArea( aArea )

Return