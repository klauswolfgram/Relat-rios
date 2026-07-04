/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR810.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte
//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR810
Relatorio dos funcionarios que receberam EPI.
O usuario pode selecionar o Funcionario, o EPI e um periodo
obtendo a relacao dos fucinarios que ja receberam os EPI.
O programa inicia com a tabela de EPI,s entregues, obtem
dados do funcionario na tabela de funcionario(SRA).

@author Deivys Joenck
@since 20/09/00
@return NIL
/*/
//---------------------------------------------------------------------
User Function MDTR810()
//---------------------------------------------------------------
// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
//---------------------------------------------------------------
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//---------------------------------------------------------------
// Define Variaveis
//---------------------------------------------------------------
Local wnrel   := "MDTR810"
Local limite  := 230
Local cDesc1  := STR0001 //"Relatorio de apresentacao dos funcionarios que receberam EPI      "
Local cDesc2  := STR0002 //"Atraves dos parametros o usuario pode selecionar Funcionarios que "
Local cDesc3  := STR0003 //"receberam EPI's em um determinado Periodo.                "
Local cString := "TNF"

Private cPerg := "MDT810    "
Private nomeprog := "MDTR810"
Private tamanho  := "G"
Private aReturn  := { STR0004, 1,STR0005, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private titulo   := STR0006 //"EPI's por Funcion rio"
Private ntipo    := 0
Private nLastKey := 0
Private cabec1, cabec2
Private lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

//Variaveis de Tamanho de campos
Private nSizeCod := If((TAMSX3("B1_COD")[1]) < 1,15,(TAMSX3("B1_COD")[1]))
Private nTa1 	:= If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
Private nTa1L 	:= If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
Private nSizeTD := nTa1+nTa1L
Private nTamB1Des:= If((TAMSX3("B1_DESC")[1]) < 1,30,(TAMSX3("B1_DESC")[1]))
Private nSizeSA2 := If((TAMSX3("A2_COD")[1]) < 1,6,(TAMSX3("A2_COD")[1]))
Private nSizeLoj := If((TAMSX3("A2_LOJA")[1]) < 1,6,(TAMSX3("A2_LOJA")[1]))
Private nSizeSRJ := If((TAMSX3("RJ_FUNCAO")[1]) < 1,4,(TAMSX3("RJ_FUNCAO")[1]))
Private nSizeFil:= FwSizeFilial()
Private nSizeSRA := If((TAMSX3("RA_MAT")[1]) < 1,6,(TAMSX3("RA_MAT")[1]))
Private nSizeCTT := If((TAMSX3("CTT_CUSTO")[1]) < 1,15,(TAMSX3("CTT_CUSTO")[1]))

//Alias para o TRB
Private cAliasTRB := GetNextAlias()

//----------------------------------------------------------------
//| Variaveis utilizadas para parametros                         |
//| mv_par01             // De  Funcionario                      |
//| mv_par02             // Ate Funcionario                      |
//| mv_par03             // De  EPI                              |
//| mv_par04             // Ate EPI                              |
//| mv_par05             // De  Data Entrega                     |
//| mv_par06             // Ate Data Entrega                     |
//| mv_par07             // Lista Demitidos                      |
//----------------------------------------------------------------

If lSigaMdtps

	/* Perguntas
	MDT810    ¦01      ¦De Cliente ?
	MDT810    ¦02      ¦Loja
	MDT810    ¦03      ¦Até Cliente ?
	MDT810    ¦04      ¦Loja
	MDT810    ¦05      ¦De  Funcionario ?
	MDT810    ¦06      ¦Ate Funcionario ?
	MDT810    ¦07      ¦De  EPI ?
	MDT810    ¦08      ¦Ate EPI ?
	MDT810    ¦09      ¦De  Data Entrega ?
	MDT810    ¦10      ¦Ate Data Entrega ?
	*/

	cPerg    :=  "MDT810PS  "
Endif

//---------------------------------------------------------------
// Verifica as perguntas selecionadas
//---------------------------------------------------------------
//Trata para Impressão do TReport
If FindFunction("TRepInUse") .And. TRepInUse()
   //-- Interface de impressao
   oReport := ReportDef( AllTrim( cDesc1 ) + Space( 1 ) + AllTrim( cDesc2 ) + Space( 1 ) + AllTrim( cDesc3 ) )
   oReport:SetLandscape()
   oReport:PrintDialog()
Else
pergunte(cPerg,.F.)
//---------------------------------------------------------------
// Envia controle para a funcao SETPRINT
//---------------------------------------------------------------
wnrel:="MDTR810"

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	//---------------------------------------------------------------
	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	//---------------------------------------------------------------
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	//---------------------------------------------------------------
	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	//---------------------------------------------------------------
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

RptStatus({|lEnd| R810Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
EndIf

//---------------------------------------------------------------
// Devolve variaveis armazenadas (NGRIGHTCLICK)
//---------------------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} R810Imp
Chama Relatório

@param lEnd - Cancela a impressão.
@param wnRel - Programa utilizado.
@param titulo - Titulo do relatório.
@param tamanho - Tamanho da impressão.

@author Inacio Luiz Kolling
@since 13/04/2000
@return
/*/
//---------------------------------------------------------------------
Static Function R810Imp(lEnd,wnRel,titulo,tamanho)
Local cRodaTxt := ""
Local nCntImpr := 0
Local i
Local cCLiente := ""

Local aFiliais := {}, cCodFil := ""

Local cArqTrab
Local aDBF
Local oTempTable

//---------------------------------------------------------------
// Contadores de linha e pagina
//---------------------------------------------------------------
Private li := 80 ,m_pag := 1

//---------------------------------------------------------------
// Verifica se deve comprimir ou nao
//---------------------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)

//---------------------------------------------------------------
// Monta os Cabecalhos
//---------------------------------------------------------------
cabec1 := STR0024//"Matricula  Nome Funcionario                                               Sexo  Admissao    Demissão    Idade  C.Custo                Descricao"
cabec2 := STR0026//"      EPI                              Nome do EPI                                                    Dt.Entrega   Qtde.   Fornecedor            Descricao                                  C.A."

/*
***************************************************************************************************************************************************************************************************************************************
0         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
***************************************************************************************************************************************************************************************************************************************
Matricula  Nome Funcionario                                               Sexo  Admissao    Demissão    Idade  C.Custo                Descricao
      EPI                              Nome do EPI                                                    Dt.Entrega   Qtde.   Fornecedor            Descricao                                  C.A.
***************************************************************************************************************************************************************************************************************************************
FUNCAO: 999 - ANALISTA PLENO

999999     123456789012345678901234567890123456789012345678901234567890   XX    99/99/9999  99/99/9999  999    12345678901234567890   1234567890123456789012345678901234567890

      123456789012345678901234567890   123456789012345678901234567890123456789012345678901234567890   99/99/9999  123456   12345678901234567890  1234567890123456789012345678901234567890   123456789012
***************************************************************************************************************************************************************************************************************************************
*/

If lSigaMdtps

	aDBF := {}
	AADD(aDBF,{"MATRICULA","C",nSizeSRA,0})
	AADD(aDBF,{"EPI"      ,"C",nSizeCod,0})
	AADD(aDBF,{"DATAENTR" ,"D",08,0})
	AADD(aDBF,{"QTDENT "  ,"N",06,2	})
	AADD(aDBF,{"FORNEC"   ,"C",nSizeSA2,0})
	AADD(aDBF,{"FUNCAO"   ,"C",nSizeSRJ,0})
	AADD(aDBF,{"CA"       ,"C",12,0})
	AADD(aDBF,{"CLIENT"   ,"C",nTa1,0})
	AADD(aDBF,{"LOJACL"   ,"C",nTa1L,0})

	oTempTable := FWTemporaryTable():New( cAliasTRB, aDBF )
	oTempTable:AddIndex( "1", {"CLIENT","LOJACL","FUNCAO","MATRICULA","DATAENTR","EPI"} )
	oTempTable:Create()

	dbSelectArea("TNF")
	dbSetOrder(08)  //TNF_FILIAL+TNF_CLIENT+TNF_LOJACL+TNF_MAT+TNF_CODEPI+DTOS(TNF_DTENTR)+TNF_HRENTR
	dbSeek(xFilial("TNF")+MV_PAR01+MV_PAR02,.T.)

	SetRegua(LastRec())

	While !Eof()                                   .AND.;
		TNF->TNF_FILIAL == xFIlial("TNF")        .AND.;
		TNF->(TNF_CLIENT+TNF_LOJACL) >= MV_PAR01+MV_PAR02 .AND. TNF->(TNF_CLIENT+TNF_LOJACL) <= MV_PAR03+MV_PAR04

		IncRegua()

		If TNF->TNF_MAT < MV_PAR05 .OR. TNF->TNF_MAT > MV_PAR06
			dbSelectArea("TNF")
			dbSkip()
			loop
		Endif

		If TNF->TNF_CODEPI < MV_PAR07 .OR. TNF->TNF_CODEPI > MV_PAR08
			dbSelectArea("TNF")
			dbSkip()
			loop
		Endif

		If TNF->TNF_DTENTR < MV_PAR09 .OR. TNF->TNF_DTENTR > MV_PAR10
			dbSelectArea("TNF")
			dbSkip()
			loop
		Endif

		If MV_PAR11 = 2
			dbSelectArea("SRA")
			dbSetOrder(1)
			dbSeek(xfilial("SRA")+TNF->TNF_MAT)
			If !Empty(SRA->RA_DEMISSA)
				dbSelectArea("TNF")
				dbSkip()
				loop
			Endif
		Endif

		dbSelectArea("TN3")
		dbSetOrder(3)  //TN3_FILIAL+TN3_FORNEC+TN3_LOJA+TN3_CLIENT+TN3_LOJACL+TN3_CODEPI+TN3_NUMCAP
		dbSeek(xFilial("TN3")+TNF->TNF_FORNEC+TNF->TNF_LOJA+TNF->(TNF_CLIENT+TNF_LOJACL)+TNF->TNF_CODEPI+TNF->TNF_NUMCAP)
		dbSelectArea(cAliasTRB)
		(cAliasTRB)->(DbAppend())
		(cAliasTRB)->MATRICULA := TNF->TNF_MAT
		(cAliasTRB)->EPI       := TNF->TNF_CODEPI
		(cAliasTRB)->DATAENTR  := TNF->TNF_DTENTR
		(cAliasTRB)->QTDENT    := TNF->TNF_QTDENT
		(cAliasTRB)->FORNEC    := TNF->TNF_FORNEC
		If !Empty(TNF->TNF_CODFUN)
			(cAliasTRB)->FUNCAO := TNF->TNF_CODFUN
		Else
			dbSelectArea("SRA")
			dbSetOrder(1)
			dbSeek(xfilial("SRA")+(cAliasTRB)->MATRICULA)
			(cAliasTRB)->FUNCAO :=  SRA->RA_CODFUNC
		Endif
		(cAliasTRB)->CA        := TN3->TN3_NUMCAP
		(cAliasTRB)->CLIENT    := TNF->TNF_CLIENT
		(cAliasTRB)->LOJACL    := TNF->TNF_LOJACL
		dbSelectArea("TNF")
		dbSkip()
	End
	dbSelectArea(cAliasTRB)
	dbGoTop()

	If RecCount()==0
		MsgInfo(STR0014)	//"Não há nada para imprimir no relatório."
		Use
		Return .F.
	Endif

	While !eof()

		If cCliente <> (cAliasTRB)->CLIENT+(cAliasTRB)->LOJACL
			cCliente := (cAliasTRB)->CLIENT+(cAliasTRB)->LOJACL
			Somalinha()
			dbSelectArea("SA1")
			dbSetOrder(1)
			dbSeek(xFilial("SA1")+(cAliasTRB)->CLIENT+(cAliasTRB)->LOJACL)
			@Li,000 pSay STR0013 + Alltrim((cAliasTRB)->CLIENT) + "-" + Alltrim((cAliasTRB)->LOJACL) + " - " + AllTrim(SA1->A1_NOME)  //"Cliente: "
			Somalinha()
		Endif

		cFUNC := (cAliasTRB)->FUNCAO
		Somalinha()
		dbSelectArea("SRJ")
		dbSetOrder(01)
		dbSeek(xFilial("SRJ")+cFUNC)
		@Li,000 pSay STR0027 + Alltrim((cAliasTRB)->FUNCAO) + " - " + Alltrim(SRJ->RJ_DESC) //"FUNÇÃO: "
		Somalinha()
		dbSelectArea(cAliasTRB)
		While !eof() .AND. (cAliasTRB)->FUNCAO == cFUNC .and. cCliente == (cAliasTRB)->CLIENT+(cAliasTRB)->LOJACL
			cMAT  := (cAliasTRB)->MATRICULA
			Somalinha()
			dbSelectArea("SRA")
			dbSetOrder(1)
			dbSeek(xfilial("SRA")+(cAliasTRB)->MATRICULA)
			@Li,000 pSay (cAliasTRB)->MATRICULA
			If !Empty(SRA->RA_NOMECMP) .AND. !Empty(SRA->RA_NOMECMP)
				@Li,011 pSay AllTrim(SRA->RA_NOMECMP)
			Else
				@Li,011 pSay AllTrim(SRA->RA_NOME)
			Endif
			@Li,074 pSay SRA->RA_SEXO
			@Li,080 pSay SRA->RA_ADMISSA Picture "99/99/9999"
			@Li,092 pSay SRA->RA_DEMISSA Picture "99/99/9999"
			@Li,104 pSay If( !Empty(SRA->RA_NASC), YEAR(DATE())-YEAR(SRA->RA_NASC), 0 )
			@Li,111 pSay Alltrim(SRA->RA_CC)

			dbSelectArea("SI3")
			dbSetOrder(01)
			dbSeek(xFilial("SI3",cCodFil)+SRA->RA_CC)
			If !Empty(SI3->I3_DESC)
				@Li,134 pSay Alltrim(SI3->I3_DESC)
			Else
				dbSelectArea("CTT")
				dbSetOrder(01)
				dbSeek(xFilial("CTT",cCodFil)+SRA->RA_CC)
				If !Empty(CTT->CTT_DESC01)
					@Li,134 pSay Alltrim(CTT->CTT_DESC01)
				Endif
			Endif

			dbSelectArea(cAliasTRB)
			While !eof() .AND. (cAliasTRB)->(MATRICULA+FUNCAO+CLIENT+LOJACL) == cMAT+cFUNC+cCliente

				Somalinha()
				@Li,006 pSay (cAliasTRB)->EPI

				dbSelectArea("SB1")
				dbSetOrder(1)
				dbSeek(xfilial("SB1")+(cAliasTRB)->EPI)

				@Li,039 pSay Substr(SB1->B1_DESC,1,60)
				@Li,102 pSay (cAliasTRB)->DATAENTR Picture "99/99/9999"
				@Li,114 pSay (cAliasTRB)->QTDENT Picture "999999"
				@Li,123 pSay SubSTR((cAliasTRB)->FORNEC,1,20)
				dbSelectArea("SA2")
				dbSetOrder(1)
				dbSeek(xFilial("SA2")+(cAliasTRB)->FORNEC)
				If !Empty(SA2->A2_NOME)
					@Li,145 pSay Substr(SA2->A2_NOME,1,30)
				Endif
				@Li,180 pSay Alltrim((cAliasTRB)->CA)

				dbSelectArea(cAliasTRB)
				dbSkip()
				If Eof() .or. ((cAliasTRB)->(CLIENT+LOJACL) != cCliente)
					Somalinha()
					@Li, 000 pSay __PrtThinLine()
				Endif

				dbSelectArea(cAliasTRB)
				dbSkip()
			End
			Somalinha()
		End
	End

Else

	aDBF := {}
	AADD(aDBF,{"MATRICULA","C",nSizeSRA,0})
	AADD(aDBF,{"EPI"      ,"C",nSizeCod,0})
	AADD(aDBF,{"DATAENTR" ,"D",08,0})
	AADD(aDBF,{"QTDENT "  ,"N",06,2	})
	AADD(aDBF,{"FORNEC"   ,"C",nSizeSA2,0})
	AADD(aDBF,{"FUNCAO"   ,"C",nSizeSRJ,0})
	AADD(aDBF,{"CA"       ,"C",12,0})
	AADD(aDBF,{"FILIAL"   ,"C",nSizeFil,0})
	AADD(aDBF,{"NOMFIL"   ,"C",40,0})

	oTempTable := FWTemporaryTable():New( cAliasTRB, aDBF )
	oTempTable:AddIndex( "1", {"FILIAL","FUNCAO","MATRICULA","DATAENTR","EPI"} )
	oTempTable:Create()

	aFiliais := MDTRETFIL("TNF", MV_PAR08, MV_PAR09)

	For i:=1 to Len(aFiliais)
		dbSelectArea("TNF")
		dbSetOrder(03)
		dbSeek(xFilial("TNF",aFiliais[i,1])+MV_PAR01,.T.)

		SetRegua(LastRec())

		While !Eof() .AND. TNF->TNF_FILIAL == xFIlial("TNF",aFiliais[i,1]) .AND. TNF->TNF_MAT <= MV_PAR02

			IncRegua()
			If TNF->TNF_CODEPI < MV_PAR03 .OR. TNF->TNF_CODEPI > MV_PAR04
				dbSelectArea("TNF")
				dbSkip()
				loop
			Endif

			If TNF->TNF_DTENTR < MV_PAR05 .OR. TNF->TNF_DTENTR > MV_PAR06
				dbSelectArea("TNF")
				dbSkip()
				loop
			Endif

			If MV_PAR07 == 2
				dbSelectArea("SRA")
				dbSetOrder(1)
				dbSeek(xFilial("SRA",aFiliais[i,1])+TNF->TNF_MAT)
				If !Empty(SRA->RA_DEMISSA)
					dbSelectArea("TNF")
					dbSkip()
					loop
				Endif
			Endif

			dbSelectArea("TN3")
			dbSetOrder(1)
			dbSeek(xFilial("TN3",aFiliais[i,1])+TNF->TNF_FORNEC+TNF->TNF_LOJA+TNF->TNF_CODEPI+TNF->TNF_NUMCAP)
			dbSelectArea(cAliasTRB)
			RecLock(cAliasTRB, .T.)
			(cAliasTRB)->MATRICULA	:= TNF->TNF_MAT
			(cAliasTRB)->EPI		:= TNF->TNF_CODEPI
			(cAliasTRB)->DATAENTR 	:= TNF->TNF_DTENTR
			(cAliasTRB)->QTDENT   	:= TNF->TNF_QTDENT
			(cAliasTRB)->FORNEC   	:= TNF->TNF_FORNEC
			If !Empty(TNF->TNF_CODFUN)
				(cAliasTRB)->FUNCAO := TNF->TNF_CODFUN
			Else
				dbSelectArea("SRA")
				dbSetOrder(1)
				dbSeek(xfilial("SRA",aFiliais[i,1])+TNF->TNF_MAT)
				(cAliasTRB)->FUNCAO :=  SRA->RA_CODFUNC
			Endif
			(cAliasTRB)->CA      	:= TN3->TN3_NUMCAP
			(cAliasTRB)->FILIAL		:= aFiliais[i,1]
			(cAliasTRB)->NOMFIL		:= aFiliais[i,2]
			MsUnlock(cAliasTRB)
			dbSelectArea("TNF")
			dbSkip()
		End
	Next i

	dbSelectArea(cAliasTRB)
	dbGoTop()

	If RecCount()==0
		MsgInfo(STR0014)	//"Não há nada para imprimir no relatório."
		Use
		Return .F.
	Endif

	While !eof()
		cCodFil := (cAliasTRB)->FILIAL
		If NGSX2MODO("TNF") != "C"
			Somalinha()
			@Li,000 pSay STR0030+": " + Alltrim((cAliasTRB)->FILIAL) + " - " + Alltrim((cAliasTRB)->NOMFIL) //"Filial"
			Somalinha()
			Somalinha()
		Endif
		dbSelectArea(cAliasTRB)
		While !eof() .and. (cAliasTRB)->FILIAL == cCodFil
			cFUNC := (cAliasTRB)->FUNCAO
			Somalinha()
			dbSelectArea("SRJ")
			dbSetOrder(01)
			dbSeek(xFilial("SRJ",cCodFil)+cFUNC)
			@Li,000 pSay STR0027 + Alltrim((cAliasTRB)->FUNCAO) + " - " + Alltrim(SRJ->RJ_DESC) //"FUNÇÃO: "
			Somalinha()
			dbSelectArea(cAliasTRB)
			While !eof() .AND. (cAliasTRB)->FUNCAO == cFUNC .and. (cAliasTRB)->FILIAL == cCodFil
				cMAT  := (cAliasTRB)->MATRICULA
				Somalinha()
				dbSelectArea("SRA")
				dbSetOrder(1)
				dbSeek(xfilial("SRA",cCodFil)+(cAliasTRB)->MATRICULA)
				@Li,000 pSay (cAliasTRB)->MATRICULA
				If !Empty(SRA->RA_NOMECMP) .AND. !Empty(SRA->RA_NOMECMP)
					@Li,011 pSay AllTrim(SRA->RA_NOMECMP)
				Else
					@Li,011 pSay AllTrim(SRA->RA_NOME)
				Endif
				@Li,074 pSay SRA->RA_SEXO
				@Li,080 pSay SRA->RA_ADMISSA Picture "99/99/9999"
				@Li,092 pSay SRA->RA_DEMISSA Picture "99/99/9999"
				@Li,104 pSay If( !Empty(SRA->RA_NASC), YEAR(DATE())-YEAR(SRA->RA_NASC), 0 )
				@Li,111 pSay Alltrim(SRA->RA_CC)

				dbSelectArea("SI3")
				dbSetOrder(01)
				dbSeek(xFilial("SI3",cCodFil)+SRA->RA_CC)
				If !Empty(SI3->I3_DESC)
					@Li,134 pSay Alltrim(SI3->I3_DESC)
				Else
					dbSelectArea("CTT")
					dbSetOrder(01)
					dbSeek(xFilial("CTT",cCodFil)+SRA->RA_CC)
					If !Empty(CTT->CTT_DESC01)
						@Li,134 pSay Alltrim(CTT->CTT_DESC01)
					Endif
				Endif

				dbSelectArea(cAliasTRB)
				While !eof() .AND. (cAliasTRB)->MATRICULA == cMAT .AND. (cAliasTRB)->FUNCAO == cFUNC .and. (cAliasTRB)->FILIAL == cCodFil
					Somalinha()
					@Li,006 pSay (cAliasTRB)->EPI

					dbSelectArea("SB1")
					dbSetOrder(1)
					dbSeek(xfilial("SB1",cCodFil)+(cAliasTRB)->EPI)

					@Li,039 pSay Substr(SB1->B1_DESC,1,60)
					@Li,102 pSay (cAliasTRB)->DATAENTR Picture "99/99/9999"
					@Li,114 pSay (cAliasTRB)->QTDENT Picture "999999"
					@Li,123 pSay SubSTR((cAliasTRB)->FORNEC,1,20)
					dbSelectArea("SA2")
					dbSetOrder(1)
					dbSeek(xFilial("SA2",cCodFil)+(cAliasTRB)->FORNEC)
					If !Empty(SA2->A2_NOME)
						@Li,145 pSay Substr(SA2->A2_NOME,1,30)
					Endif
					@Li,180 pSay Alltrim((cAliasTRB)->CA)

					dbSelectArea(cAliasTRB)
					dbSkip()
					If NGSX2MODO("TNF") != "C" .and. (Eof() .or. (cAliasTRB)->FILIAL != cCodFil)
						Somalinha()
						@Li, 000 pSay __PrtThinLine()
					Endif
				End
				Somalinha()
			End
			Somalinha()
		End
	End
Endif

Roda(nCntImpr,cRodaTxt,Tamanho)

//---------------------------------------------------------------
// Devolve a condicao original do arquivo principal
//---------------------------------------------------------------
RetIndex("TNF")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()

dbSelectArea(cAliasTRB)
use
dbSelectArea("TNF")
dbSetOrder(01)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina

@author Inacio Luiz Kolling
@since   /06/97
@return
/*/
//---------------------------------------------------------------------
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    Endif
Return
//---------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define as secoes impressas no relatorio

@return oReport Objeto Objeto do TReport

@param cDescric Caracter Descrição do relatório

@sample ReportDef( 'Descrição' )

@author Jackson Machado
@since 27/05/2016
/*/
//---------------------------------------------------------------------
Static Function ReportDef( cDescric )

Static oReport
Static oSection0
Static oSection1
Static oSection2
Static oSection3
Static oCell


/*        1         2         3         4         5         6         7         8         9       100       110       120       130       140       150       160       170       180       190       200
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
_________________________________________________________________________________________________________________________________________________________________________________________________________

                                                       										EPI's por Funcionário
_________________________________________________________________________________________________________________________________________________________________________________________________________

Filial     Nome
-------------------------------
xxxxxxxx   xxxxxxxxxxxxxxxxxxxxxx

Função Descrição
-------------------------------
xxxxx  xxxxxxxxxxxxxxxxxxxxxxxxx

Matrícula  Nome Funcionário                                               Sexo  Admissão    Demissão    Idade  C.Custo                Descrição
---------------------------------------------------------------------------------------------------------------------------------------------------
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  x     99/99/9999  99/99/9999     99  xxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxx

EPI                              Nome do EPI                                                    Dt.Entrega   Qtde.   Fornecedor            Descricao                                  C.A.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/9999   999.99  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/9999   999.99  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/9999   999.99  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/9999   999.99  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx

Matrícula  Nome Funcionário                                               Sexo  Admissão    Demissão    Idade  C.Custo                Descrição
---------------------------------------------------------------------------------------------------------------------------------------------------
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  x     99/99/9999  99/99/9999     99  xxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxx

EPI                              Nome do EPI                                                    Dt.Entrega   Qtde.   Fornecedor            Descricao                                  C.A.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/9999   999.99  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/9999   999.99  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/9999   999.99  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99/99/9999   999.99  xxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx
*/


/*---------------------------------------------------------------------
Criacao do componente de impressao

TReport():New
ExpC1 : Nome do relatorio
ExpC2 : Titulo
ExpC3 : Pergunte
ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
ExpC5 : Descricao
---------------------------------------------------------------------*/
oReport := TReport():New( "MDTR810" , OemToAnsi( titulo ) , AllTrim( cPerg ) , { | oReport | ReportPrint( oReport ) } , ;
           					cDescric )

Pergunte( oReport:uParam , .F. )

/*---------------------------------------------------------------------
Criacao da secao utilizada pelo relatorio

TRSection():New
ExpO1 : Objeto TReport que a secao pertence
ExpC2 : Descricao da seçao
ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela
        sera considerada como principal para a seção.
ExpA4 : Array com as Ordens do relatório
ExpL5 : Carrega campos do SX3 como celulas
        Default : False
ExpL6 : Carrega ordens do Sindex
        Default : False
---------------------------------------------------------------------*/
/*---------------------------------------------------------------------
Criacao da celulas da secao do relatorio

TRCell():New
ExpO1 : Objeto TSection que a secao pertence
ExpC2 : Nome da celula do relatório. O SX3 será consultado
ExpC3 : Nome da tabela de referencia da celula
ExpC4 : Titulo da celula
        Default : X3Titulo()
ExpC5 : Picture
        Default : X3_PICTURE
ExpC6 : Tamanho
        Default : X3_TAMANHO
ExpL7 : Informe se o tamanho esta em pixel
        Default : False
ExpB8 : Bloco de código para impressao.
        Default : ExpC2
---------------------------------------------------------------------*/

oReport:SetTotalInLine( .F. )

If lSigaMdtps
	//********************* Secao 0 - Cliente
	oSection0 := TRSection():New( oReport, STR0044, { cAliasTRB } )//"Cliente"
	oCell := TRCell():New( oSection0, "CLIENT" , cAliasTRB , STR0044, "@!", nTa1, 		/*lPixel*/, { | | ( cAliasTRB )->CLIENT } ) //"Cliente"
	oCell := TRCell():New( oSection0, "LOJCLI" , cAliasTRB , STR0011, "@!", nTa1L , 	/*lPixel*/, { | | ( cAliasTRB )->LOJCLI } )	 //"Loja"
	oCell := TRCell():New( oSection0, "NOMCLI" , cAliasTRB , STR0032, "@!", 32 , 		/*lPixel*/, { | | ( cAliasTRB )->NOMCLI } )   //"Nome"
Else
	//********************* Secao 0 - Filial
	oSection0 := TRSection():New( oReport, STR0045, { cAliasTRB } )//"Filial"
	oCell := TRCell():New( oSection0, "FILIAL" , cAliasTRB , STR0045,"@!", nSizeFil, /*lPixel*/, { | | ( cAliasTRB )->FILIAL } ) //"Filial"
	oCell := TRCell():New( oSection0, "NOMFIL" , cAliasTRB , STR0032, "@!", 32 ,	 /*lPixel*/, { | | ( cAliasTRB )->NOMFIL } )	 //"Nome"
Endif

//********************* Secao 1 - Função
oSection1 := TRSection():New( oReport, STR0046, { cAliasTRB } ) //"Função"
oCell := TRCell():New( oSection1, "CODFUN" , cAliasTRB , STR0046, "@!", nSizeSRJ+2 ,	/*lPixel*/, { | | ( cAliasTRB )->CODFUN } ) //"Função"
oCell := TRCell():New( oSection1, "DESFUN" , cAliasTRB , STR0033, "@!", 32 , 		/*lPixel*/, { | | ( cAliasTRB )->DESFUN } ) //"Descrição"

//********************* Secao 2 - Funcionarios
oSection2 := TRSection():New( oReport, STR0047, { cAliasTRB } )//"Funcionários"
oCell := TRCell():New( oSection2, "MATFUN" , cAliasTRB , STR0048, "@!", 			nSizeSRA+5 , 	/*lPixel*/, { | | ( cAliasTRB )->MATFUN } ) //"Matrícula"
oCell := TRCell():New( oSection2, "NOMFUN" , cAliasTRB , STR0032, "@!", 			35 , 		/*lPixel*/, { | | ( cAliasTRB )->NOMFUN } ) //"Nome"
oCell := TRCell():New( oSection2, "SEXFUN" , cAliasTRB , STR0034, "@!", 			05 , 		/*lPixel*/, { | | ( cAliasTRB )->SEXFUN } ) //"Sexo"
oCell := TRCell():New( oSection2, "ADMISS" , cAliasTRB , STR0035, "99/99/9999", 	15 , 		/*lPixel*/, { | | ( cAliasTRB )->ADMISS } ) //"Admissão"
oCell := TRCell():New( oSection2, "DEMISA" , cAliasTRB , STR0036, "99/99/9999", 	15 ,		/*lPixel*/, { | | ( cAliasTRB )->DEMISA } ) //"Demissão"
oCell := TRCell():New( oSection2, "IDADEF" , cAliasTRB , STR0037, "@E 999", 		08 , 		/*lPixel*/, { | | cVAlToChar(( cAliasTRB )->IDADEF) } ) //"Idade"
oCell := TRCell():New( oSection2, "CCUSTO" , cAliasTRB , STR0038, "@!", 			nSizeCTT+5 , 	/*lPixel*/, { | | ( cAliasTRB )->CCUSTO } ) //"C. Custo"
oCell := TRCell():New( oSection2, "DESCCC" , cAliasTRB , STR0033, "@!", 			32 , 		/*lPixel*/, { | | ( cAliasTRB )->DESCCC } ) //"Descrição"

//********************* Secao 3 - EPIs
oSection3 := TRSection():New( oReport, "EPIs", { cAliasTRB } )
oCell := TRCell():New( oSection3, "CODEPI" , cAliasTRB , STR0049, "@!", 			nSizeCod+2 , 	/*lPixel*/, { | | ( cAliasTRB )->CODEPI } )//"EPI"
oCell := TRCell():New( oSection3, "DESEPI" , cAliasTRB , STR0039, "@!", 			35 , 		/*lPixel*/, { | | ( cAliasTRB )->DESEPI } ) //"Nome do EPI"
oCell := TRCell():New( oSection3, "DTENTR" , cAliasTRB , STR0040, "99/99/9999", 	15 , 		/*lPixel*/, { | | ( cAliasTRB )->DTENTR } ) //"Dt.Entrega"
oCell := TRCell():New( oSection3, "QTDENT" , cAliasTRB , STR0041, "@E 999.99", 	06 , 		/*lPixel*/, { | | ( cAliasTRB )->QTDENT } ) //"Qtde."
oCell := TRCell():New( oSection3, "FORNEC" , cAliasTRB , STR0042, "@!", 			nSizeSA2+6 , 	/*lPixel*/, { | | ( cAliasTRB )->FORNEC } ) //"Fornecedor"
oCell := TRCell():New( oSection3, "LOJFOR" , cAliasTRB , STR0011, "@!", 			nSizeLoj+5 , 	/*lPixel*/, { | | ( cAliasTRB )->LOJFOR } ) //"Loja"
oCell := TRCell():New( oSection3, "DESFOR" , cAliasTRB , STR0033, "@!", 			35 , 		/*lPixel*/, { | | ( cAliasTRB )->DESFOR } ) //"Descrição"
oCell := TRCell():New( oSection3, "NUMECA" , cAliasTRB , STR0043, "@!", 			15 , 		/*lPixel*/, { | | ( cAliasTRB )->NUMECA } ) //"C.A."

Return oReport
//---------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o relatorio

@return lRet Lógico Indica se realizou a impressão do relatório

@param oReport Objeto Objeto do TReport

@sample ReportDef( oReport )

@author Jackson Machado
@since 27/05/2016
/*/
//---------------------------------------------------------------------
Static Function ReportPrint(oReport)

Local nFil
Local lRet		:= .T.
Local cArqTrab
Local nOrdTNF	:= 0
Local cSeekTNF	:= ""
Local cWhilTNF	:= ""
Local cFiltro1	:= ""
Local cFiltro2	:= ""
Local cFiltro3	:= ""
Local cFilFix1	:= ""
Local cFilFix2	:= "( cAliasTRB )->CODFUN"
Local cFilFix3	:= "( cAliasTRB )->MATFUN"
Local aDBF 		:= {}
Local aIndex	:= {}
Local aFiliais	:= {}
Local oTempTable

//Alimenta as Sections
Local oSection0 := oReport:Section(1)
Local oSection1 := oReport:Section(2)
Local oSection2 := oReport:Section(3)
Local oSection3 := oReport:Section(4)

Private cFilSrc := ""
//Monta o TRB
If lSigaMdtPs
	aAdd( aDBF , { "CLIENT" , "C" , nTa1	, 0 } )
	aAdd( aDBF , { "LOJCLI" , "C" , nTa1l	, 0 } )
	aAdd( aDBF , { "NOMCLI" , "C" , 30		, 0 } )
Else
	aAdd( aDBF , { "FILIAL" , "C" , nSizeFil 	, 0 } )
	aAdd( aDBF , { "NOMFIL" , "C" , 30			, 0 } )
EndIf
aAdd( aDBF , { "CODFUN" , "C" , nSizeSRJ 	, 0 } )
aAdd( aDBF , { "DESFUN" , "C" , 30			, 0 } )
aAdd( aDBF , { "MATFUN" , "C" , nSizeSRA	, 0 } )
aAdd( aDBF , { "NOMFUN" , "C" , 30			, 0 } )
aAdd( aDBF , { "SEXFUN" , "C" , 01			, 0 } )
aAdd( aDBF , { "ADMISS" , "D" , 08			, 0 } )
aAdd( aDBF , { "DEMISA" , "D" , 08			, 0 } )
aAdd( aDBF , { "IDADEF" , "N" , 03			, 0 } )
aAdd( aDBF , { "CCUSTO" , "C" , nSizeCTT	, 0 } )
aAdd( aDBF , { "DESCCC" , "C" , 30			, 0 } )
aAdd( aDBF , { "CODEPI" , "C" , nSizeCod	, 0 } )
aAdd( aDBF , { "DESEPI" , "C" , 30			, 0 } )
aAdd( aDBF , { "DTENTR" , "D" , 08			, 0 } )
aAdd( aDBF , { "QTDENT" , "N" , 06			, 2 } )
aAdd( aDBF , { "FORNEC" , "C" , nSizeSA2	, 0 } )
aAdd( aDBF , { "LOJFOR" , "C" , nSizeLoj	, 0 } )
aAdd( aDBF , { "DESFOR" , "C" , 30			, 0 } )
aAdd( aDBF , { "NUMECA" , "C" , 12			, 0 } )

oTempTable := FWTemporaryTable():New( cAliasTRB, aDBF )
If lSigaMdtPs
	oTempTable:AddIndex( "1", {"CLIENT","LOJCLI","CODFUN","MATFUN","CODEPI","FORNEC","LOJFOR"} )
Else
	oTempTable:AddIndex( "1", {"FILIAL","CODFUN","MATFUN","CODEPI","FORNEC","LOJFOR"} )
EndIf
oTempTable:Create()

If lSigaMdtPs
	aFiliais := { Space( nSizeFil ) , Space( 30 ) }
	nOrdTNF	 := 08
	cSeekTNF := MV_PAR01+MV_PAR02
	cWhilTNF := "TNF->TNF_FILIAL == xFilial('TNF') .And. TNF->(TNF_CLIENT+TNF_LOJACL) >= '" + MV_PAR01+MV_PAR02 + "' .AND. TNF->(TNF_CLIENT+TNF_LOJACL) <= '" + MV_PAR03+MV_PAR04 + "'"
Else
	aFiliais := MDTRETFIL("TNF", MV_PAR08, MV_PAR09)
	nOrdTNF	 := 03 //TNF_FILIAL+TNF_MAT+TNF_CODEPI+DTOS(TNF_DTENTR)+TNF_HRENTR
	cSeekTNF := MV_PAR01
	cWhilTNF := "TNF->TNF_FILIAL == xFilial('TNF',cFilSrc) .AND. TNF->TNF_MAT <= '" + MV_PAR02 + "'"
EndIf

//Alimenta o TRB
For nFil := 1 To Len( aFiliais )

	cFilSrc := aFiliais[ nFil , 1 ]

	dbSelectArea( "TNF" )
	dbSetOrder( nOrdTNF )
	dbSeek( xFilial( "TNF" , aFiliais[ nFil , 1 ] ) + cSeekTNF, .T. )
	While TNF->( !Eof() ) .And. &( cWhilTNF )
		If lSigaMdtPs
			dbSelectArea( "SRA" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "SRA" ) + TNF->TNF_MAT )
			If TNF->TNF_MAT < MV_PAR05 .OR. TNF->TNF_MAT > MV_PAR06
				dbSelectArea( "TNF" )
				TNF->( dbSkip() )
				Loop
			Endif

			If TNF->TNF_CODEPI < MV_PAR07 .OR. TNF->TNF_CODEPI > MV_PAR08
				dbSelectArea( "TNF" )
				TNF->( dbSkip() )
				Loop
			Endif

			If TNF->TNF_DTENTR < MV_PAR09 .OR. TNF->TNF_DTENTR > MV_PAR10
				dbSelectArea( "TNF" )
				TNF->( dbSkip() )
				Loop
			Endif

			If MV_PAR11 = 2
				If !Empty( SRA->RA_DEMISSA )
					dbSelectArea( "TNF" )
					TNF->( dbSkip() )
					Loop
				Endif
			Endif
			dbSelectArea( "SA1" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "SA1" ) + TNF->TNF_CLIENT + TNF->TNF_LOJACL )
		Else
			dbSelectArea( "SRA" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "SRA" , aFiliais[ nFil , 1 ] ) + TNF->TNF_MAT )
			If TNF->TNF_CODEPI < MV_PAR03 .OR. TNF->TNF_CODEPI > MV_PAR04
				dbSelectArea( "TNF" )
				TNF->( dbSkip() )
				Loop
			Endif

			If TNF->TNF_DTENTR < MV_PAR05 .OR. TNF->TNF_DTENTR > MV_PAR06
				dbSelectArea( "TNF" )
				TNF->( dbSkip() )
				Loop
			Endif

			If MV_PAR07 == 2
				If !Empty( SRA->RA_DEMISSA )
					dbSelectArea( "TNF" )
					TNF->( dbSkip() )
					Loop
				Endif
			Endif
		EndIf
		//Realiza os posicionamentos para alimentar o TRB
		dbSelectArea( "SRJ" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "SRJ" ) + SRA->RA_CODFUNC )

		dbSelectArea( "CTT" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "CTT" ) + SRA->RA_CC )

		dbSelectArea( "SB1" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "SB1" ) + TNF->TNF_CODEPI )

		dbSelectArea( "SA2" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "SA2" ) + TNF->TNF_FORNEC + TNF->TNF_LOJA )
		RecLock( cAliasTRB , .T. )
		If lSigaMdtPs
			( cAliasTRB )->CLIENT := TNF->TNF_CLIENT
			( cAliasTRB )->LOJCLI := TNF->TNF_LOJACL
			( cAliasTRB )->NOMCLI := SA1->A1_NOME
		Else
			( cAliasTRB )->FILIAL := aFiliais[ nFil , 1 ]
			( cAliasTRB )->NOMFIL := aFiliais[ nFil , 2 ]
		EndIf
		( cAliasTRB )->CODFUN := SRA->RA_CODFUNC
		( cAliasTRB )->DESFUN := SRJ->RJ_DESC
		( cAliasTRB )->MATFUN := TNF->TNF_MAT
		( cAliasTRB )->NOMFUN := SRA->RA_NOME
		( cAliasTRB )->SEXFUN := SRA->RA_SEXO
		( cAliasTRB )->ADMISS := SRA->RA_ADMISSA
		( cAliasTRB )->DEMISA := SRA->RA_DEMISSA
		( cAliasTRB )->IDADEF := If( !Empty(SRA->RA_NASC), YEAR(DATE())-YEAR(SRA->RA_NASC), 0 )
		( cAliasTRB )->CCUSTO := SRA->RA_CC
		( cAliasTRB )->DESCCC := CTT->CTT_DESC01
		( cAliasTRB )->CODEPI := TNF->TNF_CODEPI
		( cAliasTRB )->DESEPI := SB1->B1_DESC
		( cAliasTRB )->DTENTR := TNF->TNF_DTENTR
		( cAliasTRB )->QTDENT := TNF->TNF_QTDENT
		( cAliasTRB )->FORNEC := TNF->TNF_FORNEC
		( cAliasTRB )->LOJFOR := TNF->TNF_LOJA
		( cAliasTRB )->DESFOR := SA2->A2_NOME
		( cAliasTRB )->NUMECA := TNF->TNF_NUMCAP
		( cAliasTRB )->( dbSkip() )
		TNF->( dbSkip() )
	End
Next nFil

dbSelectArea( cAliasTRB )
dbSetOrder( 1 )
dbGoTop()
If lSigaMdtps
	cFilFix1 := "( cAliasTRB )->(CLIENT+LOJCLI)"
Else
	cFilFix1 := "( cAliasTRB )->FILIAL"
EndIf

oReport:SetMeter( ( cAliasTRB )->( RecCount() ) )

While !oReport:Cancel() .And.;
		  ( cAliasTRB )->( !Eof() )

	cFiltro1 := &( cFilFix1 )
    oSection0:Init() //-- Filial ou Clientes
    oSection0:PrintLine()

	While !oReport:Cancel() .And. ( cAliasTRB )->( !Eof() ) .And. ;
			&( cFilFix1 ) == cFiltro1

	    cFiltro2 := &( cFilFix2 )
	    oSection1:Init() //-- Função
	    oSection1:PrintLine()

	    While !oReport:Cancel() .AND. ( cAliasTRB )->( !Eof() ) .And. ;
			&( cFilFix2 ) == cFiltro2

	        cFiltro3 := &( cFilFix3 )
		    oSection2:Init() //-- Funcionário
		    oSection2:PrintLine()

		    oSection3:Init() //-- EPIs
			While !oReport:Cancel() .AND. ( cAliasTRB )->( !Eof() ) .And. ;
				&( cFilFix3 ) == cFiltro3

				oReport:IncMeter()
				oSection3:PrintLine()
		    	dbSkip()
		    End
	    	oSection3:Finish()
	    	oSection2:Finish()
	    End

	    oSection1:Finish()
	End

	oSection0:Finish()

End

dbSelectArea( cAliasTRB )
dbGoTop()
If ( cAliasTRB )->( RecCount() ) == 0
	MsgInfo( STR0014 ) //"Não há nada para imprimir no relatório."
	lRet := .F.
Endif

oTempTable:Delete()

Return lRet