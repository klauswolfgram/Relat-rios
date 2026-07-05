/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr855.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR855
Listar todos os funcionarios da empresa, classificados por Centro de Custo e por Funcao

@type function

@source MDTR855.prw

@author Giorgio Fortunato
@since 27/03/2002

@sample U_MDTR855() 

@return Null, Sempre nulo 
/*/
//---------------------------------------------------------------------
User Function MDTR855()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR855"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatorio de Funcionarios por Centro de Custo e Funcao"
LOCAL cDesc2  := " "
LOCAL cDesc3  := " "
LOCAL cString := "SRA"

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

PRIVATE nomeprog := "MDTR855"
PRIVATE tamanho  := "M"
PRIVATE aReturn  := { STR0002, 1,STR0003, 1, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0004 //"Funcionarios por Centro de Custo e Funcao"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cPerg    := If(!lSigaMdtPS,"MDT855    ","MDT855PS  ")
PRIVATE cabec1, cabec2
Private nSizeSI3
nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
PRIVATE nSizeSRJ := If((TAMSX3("RJ_FUNCAO")[1]) < 1,4,(TAMSX3("RJ_FUNCAO")[1]))

Private cF3CC  := "SI3001"

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cF3CC  := "CTT001"
Endif

/*------------------------------
//PADRÃO							|
| De  Centro de Custo ?			|
| Ate Centro de Custo ?			|
| Considerar Funcionario ?		|
| De Categoria ?					|
| Ate Categoria ?					|
| 									|
//PRESTADOR						|
| De Cliente ?					|
| Loja								|
| Até Cliente ?					|
| Loja								|
| De  Centro de Custo ?			|
| Ate Centro de Custo ?			|
| Considerar Funcionario ?		|
| De Categoria ?					|
| Ate Categoria ?					|
--------------------------------*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel:="MDTR855"

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

RptStatus({|lEnd| R855Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL  
//---------------------------------------------------------------------
/*/{Protheus.doc} R855Imp
Chamada do Relat¢rio

@type function

@source MDTR855.prw

@author Giorgio Fortunato
@since 27/03/2002

@param lEnd, Lógico, Controle de Encerramento do Relatório
@param wnRel, Caracter, Código do Relatório
@param titulo, Caracter, Título do Relatório
@param tamanho, Caracter, Tamanho do Relatório

@sample R855Imp( @lEnd , "MDTR855" , "Título" , "M" ) 

@return Null, Sempre nulo 
/*/
//---------------------------------------------------------------------
Static Function R855Imp(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0
Local oTempTable
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis para controle do cursor de progressao do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL cChave           := SPACE(16)
LOCAL lContinua        := .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis tipo Private padrao de todos os relatorios         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li := 80 ,m_pag := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// PRIVATE

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cabec1 := STR0013 //"     Codigo/Nome Funcao                       Matricula   Nome do Funcionario             Categoria       Data Admissao"
If lSigaMdtps
	If Mv_par07 == 1 .or. Mv_par07 == 3
		cabec1 := STR0014 //"     Codigo/Nome Funcao                       Matricula   Nome do Funcionario             Categoria       Data Admissao  Demissao"
	Endif
Else
	If Mv_par03 == 1 .or. Mv_par03 == 3
		cabec1 := STR0014 //"     Codigo/Nome Funcao                       Matricula   Nome do Funcionario             Categoria       Data Admissao  Demissao"
	Endif
Endif

cabec2 := ""

/*
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************

          1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(Padrao)                                 Funcionarios por Centro de Custo e Funcao                                 (Padrao)
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
     Codigo/Nome Funcao                       Matricula   Nome do Funcionario             Categoria       Data Admissao
     Codigo/Nome Funcao                       Matricula   Nome do Funcionario             Categoria       Data Admissao  Demissao
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

   Centro de Custo.: XXXXXXXXXXXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
     XXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXX      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  M               99/99/9999     99/99/9999
     XXXXXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXX      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  S               99/99/9999
     XXXXXXXXXXXXXX - XXXXXXXXXXXXXXXXXXXXXX  XXXXXX      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  D               99/99/9999
     XXXXXXXXXXXXXX - XXXXXXXXXXXXXXXXXXXXXX  XXXXXX      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                  99/99/9999

   Total de Funcionarios.: 999

Total de Funcionarios.: 999
*/                         
PRIVATE lMV_NGMDTPS := .f.
PRIVATE cCliente    := ""
PRIVATE cCondicao   := "!Eof()"
PRIVATE lPrint := .t.

If SuperGetMv("MV_NGMDTPS",.F.,"N") == "S"
	lMV_NGMDTPS := .t.
	cCondicao   += " .AND. cCliente == Substr(TRB->CCUSTO,1,6)"
Endif      

If lSigaMdtps
	cCondicao := "!Eof() .AND. cCliente == Substr(TRB->CCUSTO,1,"+StrZero(nSizeTD,2)+")"
Endif

aDBF := {}
AADD(aDBF,{ "MATRICUL" , "C" ,06, 0 })
AADD(aDBF,{ "NOME"     , "C" ,30, 0 })
AADD(aDBF,{ "CCUSTO"   , "C" ,nSizeSI3, 0 })
AADD(aDBF,{ "DES_CC"   , "C" ,20, 0 })
AADD(aDBF,{ "DT_ADMIS" , "D" ,08, 0 })
AADD(aDBF,{ "DT_DEMIS" , "D" ,08, 0 })
AADD(aDBF,{ "FUNCAO"   , "C" ,nSizeSRJ, 0 })
AADD(aDBF,{ "DES_FUNC" , "C" ,20, 0 })
AADD(aDBF,{ "CATFUNC"  , "C" ,01, 0 })

oTempTable := FWTemporaryTable():New( "TRB", aDBF )
oTempTable:AddIndex( "1", {"CCUSTO","FUNCAO","MATRICUL","DT_ADMIS"} )
oTempTable:Create()

cAlias := "SI3"   
cDescr := "SI3->I3_DESC"
If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAlias := "CTT"
	cDescr := "CTT->CTT_DESC01"
Endif

dbSelectArea("SRA")
dbSetOrder(01)
dbSeek(xFilial("SRA"))


SetRegua(LastRec())

If lSigaMdtps

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿                
	//³ Carregar TRB com dados do SRA de maneira ordenada por    |
	//³ Centro de Custo                                          |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	While !Eof() .AND. SRA->RA_FILIAL = xFilial('SRA')
	
		 IF SRA->RA_CC < MV_PAR05 .or. SRA->RA_CC > MV_PAR06
			dbSelectArea("SRA")
			dbSkip()
			Loop
		 ENDIF
		 
		 IF SubSTR(SRA->RA_CC,1,nTa1+nTa1L) < (MV_PAR01+MV_PAR02) .or. SubSTR(SRA->RA_CC,1,nTa1+nTa1L) > MV_PAR03+MV_PAR04
			dbSelectArea("SRA")
			dbSkip()
			Loop
		 ENDIF
		 
		 IF SRA->RA_CATFUNC < MV_PAR08 .or. SRA->RA_CATFUNC > MV_PAR09
			dbSelectArea("SRA")
			dbSkip()
			Loop
		 ENDIF
		 IF SRA->RA_SITFOLH != "A" .and. MV_PAR07 == 4
			dbSelectArea("SRA")
			dbSkip()
			Loop
		 ENDIF
		 IF SRA->RA_SITFOLH != "D" .and. MV_PAR07 == 3
			dbSelectArea("SRA")
			dbSkip()
			Loop
		 ENDIF
		 IF SRA->RA_SITFOLH == "D" .and. MV_PAR07 == 2
			dbSelectArea("SRA")
			dbSkip()
			Loop
		 ENDIF
	
		 TRB->(DbAppend())
		 TRB->MATRICUL := SRA->RA_MAT
		 TRB->NOME     := SRA->RA_NOME
		 TRB->CCUSTO   := SRA->RA_CC
		 TRB->FUNCAO   := SRA->RA_CODFUNC
		 TRB->CATFUNC  := SRA->RA_CATFUNC
		 TRB->DT_ADMIS := SRA->RA_ADMISSA
		 TRB->DT_DEMIS := SRA->RA_DEMISSA
	
		 dbSelectArea(cAlias)
		 dbSetOrder(01)
		 IF dbSeek(xFilial(cAlias)+TRB->CCUSTO,.T.)
			TRB->DES_CC := Substr(&cDescr,1,20)
		 ENDIF
	
		 dbSelectArea("SRJ")
		 dbSetOrder(01)
		 IF dbSeek(xFilial("SRJ")+TRB->FUNCAO,.T.)
			TRB->DES_FUNC := SRJ->RJ_DESC
		 ENDIF
	
		 dbSelectArea("SRA")
		 dbSetOrder(01)
		 DBSkip()   
	
	End

	dbSelectArea("TRB")
	dbGotop()
	If RecCount()==0
		MsgInfo(STR0018)	//"Não há nada para imprimir no relatório."
		Use 
		Return Nil
	EndIf 
	
	SetRegua(LastRec())
	
	nTot_Mat  := 0            // Numero de Matriculas listadas
	nTot_Cli  := 0            // Numero de Matriculas listadas
	nTot_MCC  := 0            // Numero de Matriculas listadas por Centro de Custo
	cCC_Atu   := TRB->CCUSTO  // Centro de Custo atual para listagem
	cFunc_Atu := TRB->FUNCAO  // Funcao atual para listagem
	lNew_CC   := .T.
	
	Do While !Eof()
		nTot_Cli := 0                          
		lPrint_cabec := .t.	
		cCliente := Substr(TRB->CCUSTO,1,nSizeTD)
		While &cCondicao
	  
			nTot_MCC := 0
			If lPrint_cabec
				Printcabec855()
				lPrint_cabec := .f.
			Endif	
			SomaLinha()
			@li,003 PSay STR0008 //"Centro de Custo.:"
			@li,021 PSay Alltrim(TRB->CCUSTO)+" - "+TRB->DES_CC
			SomaLinha()
			SomaLinha()
	
			lNew_CC := .T.
	
			Do While !Eof() .and. cCC_Atu = TRB->CCUSTO
	
				nTot_MCC ++
	
				IF TRB->FUNCAO <> cFunc_Atu .or. lNew_CC
				  cFunc_Atu := TRB->FUNCAO
				  @li,005 PSay Substr(Alltrim(TRB->FUNCAO)+" - "+Alltrim(TRB->DES_FUNC),1,38)
				ENDIF
	
				lNew_CC := .F.
	
				@li,046 PSay TRB->MATRICUL
				@li,058 PSay TRB->NOME
				@li,090 PSay TRB->CATFUNC
				@li,106 PSay TRB->DT_ADMIS
				If Mv_par07 == 1 .or. Mv_par07 == 3
				   @li,122 PSay TRB->DT_DEMIS
				Endif
				SomaLinha()
	
				DBSkip()
	
			ENDDO
	
			lNew_CC := .T.
			cCC_Atu := TRB->CCUSTO
	
			SomaLinha()
			@li,003 PSay STR0009 //"Total de Funcionarios do Centro de Custo.:"
			@li,046 PSay nTot_MCC
			SomaLinha()
	
			nTot_Mat += nTot_MCC
			nTot_Cli += nTot_MCC
		End                                
		SomaLinha()
		@li,003 PSay STR0011 //"Total de Funcionarios do Cliente.:"
		@li,038 PSay nTot_Cli
		SomaLinha()
	Enddo

Else

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿                
	//³ Carregar TRB com dados do SRA de maneira ordenada por    |
	//³ Centro de Custo                                          |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	While !Eof() .AND. SRA->RA_FILIAL = xFilial('SRA')
	
		 IF SRA->RA_CC < MV_PAR01 .or. SRA->RA_CC > MV_PAR02
			dbSelectArea("SRA")
			dbSkip()
			Loop
		 ENDIF
		 IF SRA->RA_CATFUNC < MV_PAR04 .or. SRA->RA_CATFUNC > MV_PAR05
			dbSelectArea("SRA")
			dbSkip()
			Loop
		 ENDIF
		 IF SRA->RA_SITFOLH != "A" .and. MV_PAR03 == 4
			dbSelectArea("SRA")
			dbSkip()
			Loop
		 ENDIF
		 IF SRA->RA_SITFOLH != "D" .and. MV_PAR03 == 3
			dbSelectArea("SRA")
			dbSkip()
			Loop
		 ENDIF
		 IF SRA->RA_SITFOLH == "D" .and. MV_PAR03 == 2
			dbSelectArea("SRA")
			dbSkip()
			Loop
		 ENDIF
	
		 TRB->(DbAppend())
		 TRB->MATRICUL := SRA->RA_MAT
		 TRB->NOME     := SRA->RA_NOME
		 TRB->CCUSTO   := SRA->RA_CC
		 TRB->FUNCAO   := SRA->RA_CODFUNC
		 TRB->CATFUNC  := SRA->RA_CATFUNC
		 TRB->DT_ADMIS := SRA->RA_ADMISSA
		 TRB->DT_DEMIS := SRA->RA_DEMISSA
	
		 dbSelectArea(cAlias)
		 dbSetOrder(01)
		 IF dbSeek(xFilial(cAlias)+TRB->CCUSTO,.T.)
			TRB->DES_CC := Substr(&cDescr,1,20)
		 ENDIF
	
		 dbSelectArea("SRJ")
		 dbSetOrder(01)
		 IF dbSeek(xFilial("SRJ")+TRB->FUNCAO,.T.)
			TRB->DES_FUNC := SRJ->RJ_DESC
		 ENDIF
	
		 dbSelectArea("SRA")
		 dbSetOrder(01)
		 DBSkip()   
	
	End
	
	dbSelectArea("TRB")
	dbGotop()
	If RecCount()==0
		MsgInfo(STR0018)	//"Não há nada para imprimir no relatório."
		Use 
		Return Nil
	EndIf 	
	SetRegua(LastRec())
	
	nTot_Mat  := 0            // Numero de Matriculas listadas
	nTot_Cli  := 0            // Numero de Matriculas listadas
	nTot_MCC  := 0            // Numero de Matriculas listadas por Centro de Custo
	cCC_Atu   := TRB->CCUSTO  // Centro de Custo atual para listagem
	cFunc_Atu := TRB->FUNCAO  // Funcao atual para listagem
	lNew_CC   := .T.
	
	Do While !Eof()
		nTot_Cli := 0                          
		lPrint_cabec := .t.	
		cCliente := Substr(TRB->CCUSTO,1,6)
		While &cCondicao
	  
			nTot_MCC := 0
			If lPrint_cabec .and. lMV_NGMDTPS
				Printcabec855()
				lPrint_cabec := .f.
			Endif	
			SomaLinha()
			@li,003 PSay STR0008 //"Centro de Custo.:"
			@li,021 PSay Alltrim(TRB->CCUSTO)+" - "+TRB->DES_CC
			SomaLinha()
			SomaLinha()
	
			lNew_CC := .T.
	
			Do While !Eof() .and. cCC_Atu = TRB->CCUSTO
	
				nTot_MCC ++
	
				IF TRB->FUNCAO <> cFunc_Atu .or. lNew_CC
				  cFunc_Atu := TRB->FUNCAO
				  @li,005 PSay Substr(Alltrim(TRB->FUNCAO)+" - "+Alltrim(TRB->DES_FUNC),1,38)
				ENDIF
	
				lNew_CC := .F.
	
				@li,046 PSay TRB->MATRICUL
				@li,058 PSay TRB->NOME
				@li,090 PSay TRB->CATFUNC
				@li,106 PSay TRB->DT_ADMIS
				If Mv_par03 == 1 .or. Mv_par03 == 3
				   @li,122 PSay TRB->DT_DEMIS
				Endif
				SomaLinha()
	
				DBSkip()
	
			ENDDO
	
			lNew_CC := .T.
			cCC_Atu := TRB->CCUSTO
	
			SomaLinha()
			@li,003 PSay STR0009 //"Total de Funcionarios do Centro de Custo.:"
			@li,046 PSay nTot_MCC
			SomaLinha()
	
			nTot_Mat += nTot_MCC
			nTot_Cli += nTot_MCC
		End                                
		If lMV_NGMDTPS
			SomaLinha()
			@li,003 PSay STR0011 //"Total de Funcionarios do Cliente.:"
			@li,038 PSay nTot_Cli
			SomaLinha()
		Endif   
	Enddo	

Endif

SomaLinha()
@li,003 PSay STR0010 //"Total de Funcionarios.:"
@li,027 PSay nTot_Mat

DbselectARea("TRB")
USE

Roda(nCntImpr,cRodaTxt,Tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("SRA")

Set Filter To

Set device to Screen

If aReturn[5] = 1
        Set Printer To
        dbCommitAll()
        OurSpool(wnrel)
Endif
//SET CENTURY ON
MS_FLUSH()

dbSelectArea("SRA")
dbSetOrder(01)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha
Incrementa Linha e Controla Salto de Pagina

@type function

@source MDTR855.prw

@author Giorgio Fortunato
@since 27/03/2002

@sample Somalinha() 

@return Null, Sempre nulo 
/*/
//---------------------------------------------------------------------
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf
Return
//---------------------------------------------------------------------
/*/{Protheus.doc} Printcabec855
Realiza a impressão do cabeçalho (Cliente) para Prestador de Serviço

@type function

@source MDTR855.prw

@author Denis Hyroshi de Souza
@since 15/01/2003

@sample Printcabec855() 

@return Null, Sempre nulo 
/*/
//---------------------------------------------------------------------
Static Function Printcabec855()
If lMV_NGMDTPS .or. lSigaMdtps
	Dbselectarea("SA1")
	Dbsetorder(1)
	Dbseek(xFilial("SA1")+cCliente)
	If lPrint 
       	Somalinha()
       	lPrint := .f.
	Else
       	Li := 80
       	Somalinha()
	Endif
	@Li,000 Psay STR0012+cCliente+If(Empty(SA1->A1_NOME),""," - "+SA1->A1_NOME) //"Cliente..: "
	Somalinha()
	Dbselectarea("TRB")
Endif             
Return
//---------------------------------------------------------------------
/*/{Protheus.doc} ValCatR855
Validacao da pergunta Ate Categoria

@type function

@source MDTR855.prw

@author Denis Hyroshi de Souza
@since 15/01/2003

@sample U_ValCatR855() 

@return Null, Sempre nulo 
/*/
//---------------------------------------------------------------------
User Function ValCatR855()
If lSigaMdtps
	Return (if(mv_par09 == 'Z',.t.,ExistCpo('SX5','28'+ mv_par09)) .and. mv_par09 >= mv_par08)
Else
	Return (if(mv_par05 == 'Z',.t.,ExistCpo('SX5','28'+ mv_par05)) .and. mv_par05 >= mv_par04)
Endif
Return