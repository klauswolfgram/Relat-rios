/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIER200.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TOTVS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QIER200   ºAutor  ³Leandro Sabino      º Data ³  14/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio de Produtos - Uso                                º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±, ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                         
User Function QIER200(cProg,lImpres,nConta,aGravDad,lReport)
	Local cPerg   := Padr("QER200",10)
	Local oReport := Nil

	IF ExistBlock("QER200RE")
		ExecBlock( "QER200RE", .F., .F.,{cProg,lImpres,nConta})
	Else
		If !lReport
			Pergunte(cPerg,.F.)
			If cProg == "QIER220" .Or. cProg == "QIEA200"
				If cProg == "QIEA200"
					mv_par01 := QEK->QEK_FORNEC	//Fornecedor
					mv_par02 := QEK->QEK_LOJFOR	//Loja Fornecedor
					mv_par03 := QEK->QEK_PRODUT	//Produto
					mv_par04 := QEK->QEK_DTENTR	//Da Data de Entrada
					mv_par05 := QEK->QEK_LOTE	//Do Lote
					mv_par06 := Space(TamSX3("QEL_LABOR")[1])			//Do Laborat¢rio
					mv_par07 := Repl("Z",TamSX3("QEL_LABOR")[1])		//At‚ Laborat¢rio
				Else
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Sugere os parametros da Ficha do Produto, de acordo com a Fi ³
					//³ cha de produto selecionada.									 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					mv_par01 := QEK->QEK_FORNEC	//Fornecedor
					mv_par02 := QEK->QEK_LOJFOR	//Loja Fornecedor
					mv_par03 := QEK->QEK_PRODUT	//Produto
					mv_par04 := QEK->QEK_DTENTR//Da Data de Entrada
					mv_par05 := QEK->QEK_LOTE	//Do Lote
					mv_par06 := Space(TamSX3("QEL_LABOR")[1]) //Do Laborat¢rio
					mv_par07 := Repl("Z",TamSX3("QEL_LABOR")[1]) //At‚ Laborat¢rio
					mv_par08 := If(Empty(QEK->QEK_TIPONF).Or.QEK->QEK_TIPONF == "N",1,If(QEK->QEK_TIPONF=="B",2,3)) //Considera entrada
					mv_par09 := "2" //Considera Lote
					mv_par12 := QEK->QEK_NTFISC //Nota Fiscal
					mv_par13 := QEK->QEK_SERINF //Serie NF

				EndIf
			Endif

			oReport := ReportDef(cProg,lImpres,nConta)
			oReport:PrintDialog()
		Else
			If cProg == "QIER220" .Or. cProg == "QIEA200"
				Pergunte(cPerg,.F.)
				If cProg == "QIEA200"
					mv_par01 := QEK->QEK_FORNEC						//Fornecedor
					mv_par02 := QEK->QEK_LOJFOR						//Loja Fornecedor
					mv_par03 := QEK->QEK_PRODUT						//Produto
					mv_par04 := QEK->QEK_DTENTR						//Da Data de Entrada
					mv_par05 := QEK->QEK_LOTE						//Do Lote
					mv_par06 := Space(TamSX3("QEL_LABOR")[1])		//Do Laborat¢rio
					mv_par07 := Repl("Z",TamSX3("QEL_LABOR")[1])	//At‚ Laborat¢rio
				Else
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Sugere os parametros da Ficha do Produto, de acordo com a Fi ³
					//³ cha de produto selecionada.									 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					mv_par01 := QEK->QEK_FORNEC	//Fornecedor
					mv_par02 := QEK->QEK_LOJFOR	//Loja Fornecedor
					mv_par03 := QEK->QEK_PRODUT	//Produto
					mv_par04 := QEK->QEK_DTENTR //Da Data de Entrada
					mv_par05 := QEK->QEK_LOTE	//Do Lote
					mv_par06 := Space(TamSX3("QEL_LABOR")[1]) //Do Laborat¢rio
					mv_par07 := Repl("Z",TamSX3("QEL_LABOR")[1]) //At‚ Laborat¢rio
					mv_par08 := If(Empty(QEK->QEK_TIPONF).Or.QEK->QEK_TIPONF == "N",1, If(QEK->QEK_TIPONF=="B",2,3)) //Considera entrada
					mv_par09 := "2" //Considera Lote
					mv_par12 := QEK->QEK_NTFISC //Nota Fiscal
					mv_par13 := QEK->QEK_SERINF //Serie NF

					aPerg := {}
					Aadd(aPerg,QEK->QEK_FORNEC)
					Aadd(aPerg,QEK->QEK_LOJFOR)
					Aadd(aPerg,QEK->QEK_PRODUT)
					Aadd(aPerg,dToc(QEK->QEK_DTENTR))
					Aadd(aPerg,QEK->QEK_LOTE)
					Aadd(aPerg,Space(TamSX3("QEL_LABOR")[1]))
					Aadd(aPerg,Repl("Z",TamSX3("QEL_LABOR")[1]))
					Aadd(aPerg,If(Empty(QEK->QEK_TIPONF).Or.QEK->QEK_TIPONF == "N","1",If(QEK->QEK_TIPONF=="B","2","3")))
					Aadd(aPerg,"2")
					Aadd(aPerg,QEK->QEK_NTFISC)
					Aadd(aPerg,QEK->QEK_SERINF)

				EndIf
			Endif
			oReport := ReportDef(cProg,lImpres,nConta)
			oReport:PrintDialog()
		Endif
	Endif

Return



/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 14/08/06 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Montar a secao				                              ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Sintaxe   ³ ReportDef()				                                  ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³ Uso      ³ QIER200                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(cProg,lImpres,nConta)
	Local cDesc1    := OemToAnsi(STR0001) //"Neste relat¢rio ser„o relacionados os ensaios a serem realizados em ca-"
	Local cDesc2    := OemToAnsi(STR0002) //"da laborat¢rio, para a valida‡„o da Entrada."
	Local cTitulo   := GetMv("MV_QEFICHP")+STR0003	// " - USO"
	Local oReport   := Nil
	Local oSection1 := Nil
	Local oSection2 := Nil
	Local oSection3 := Nil

	lReport:=.T.

	DEFINE REPORT oReport NAME "QIER200" TITLE cTitulo PARAMETER "QER200" ACTION {|oReport| PrintReport(oReport,cProg,lImpres,nConta)} DESCRIPTION (cDesc1+cDesc2)
	oReport:SetPortrait()

	DEFINE SECTION oSection1 OF oReport TABLES "TRB","QE7","QE8" TITLE STR0041//"Ensaio"
	DEFINE CELL NAME "cENSAIO"  OF oSection1 ALIAS "" SIZE 25 TITLE TitSX3("QE7_ENSAIO")[1]
	DEFINE CELL NAME "cMETODO"  OF oSection1 ALIAS "" SIZE TAMSX3("QE7_METODO")[1] TITLE TitSX3("QE7_METODO")[1]
	DEFINE CELL NAME "cTIPO"    OF oSection1 ALIAS "" SIZE TAMSX3("QE7_TIPO")[1]   TITLE TitSX3("QE7_TIPO")[1]
	DEFINE CELL NAME "cUM"      OF oSection1 ALIAS "" SIZE 15 TITLE STR0011 LINE BREAK//"Un. Med."
	DEFINE CELL NAME "cNominal" OF oSection1 ALIAS "" SIZE TAMSX3("QE7_NOMINA")[1] TITLE STR0012 //"Nominal"
	DEFINE CELL NAME "cLIE"     OF oSection1 ALIAS "" SIZE TAMSX3("QE7_LIE")[1] TITLE STR0013 //"L.I.E."
	DEFINE CELL NAME "cLSE"     OF oSection1 ALIAS "" SIZE TAMSX3("QE7_LSE")[1] TITLE STR0014 //"L.S.E."
	DEFINE CELL NAME "cPl"      OF oSection1 ALIAS "" SIZE 03 TITLE STR0015//"Pl "
	DEFINE CELL NAME "cNIVEL"   OF oSection1 ALIAS "" SIZE TAMSX3("QE7_NIVEL")[1] TITLE TitSX3("QE7_NIVEL")[1]
	DEFINE CELL NAME "cAI"      OF oSection1 ALIAS "" SIZE 05 TITLE STR0016//"A/I"
	DEFINE CELL NAME "cST"      OF oSection1 ALIAS "" SIZE 05 TITLE STR0017//"ST"
	DEFINE CELL NAME "cTEXTO"   OF oSection1 ALIAS "" SIZE 40 TITLE GetSx3Cache("QE8_TEXTO", 'X3_TITULO')
	oSection1:Cell("cENSAIO" ):SeTLineBREAK(.T.)
	oSection1:Cell("cMETODO" ):SeTLineBREAK(.T.)
	oSection1:Cell("cTIPO"   ):SeTLineBREAK(.T.)
	oSection1:Cell("cUM"     ):SeTLineBREAK(.T.)
	oSection1:Cell("cNominal"):SeTLineBREAK(.T.)
	oSection1:Cell("cLIE"    ):SeTLineBREAK(.T.)
	oSection1:Cell("cLSE"    ):SeTLineBREAK(.T.)
	oSection1:Cell("cPl"     ):SeTLineBREAK(.T.)
	oSection1:Cell("cNIVEL"  ):SeTLineBREAK(.T.)
	oSection1:Cell("cAI"     ):SeTLineBREAK(.T.)
	oSection1:Cell("cST"     ):SeTLineBREAK(.T.)
	oSection1:Cell("cTEXTO"  ):SeTLineBREAK(.T.)

	DEFINE SECTION oSection2 OF oSection1 TABLES "QEK" TITLE STR0042//"Ult.Entradas"
	DEFINE CELL NAME "cDTENTR"   OF oSection2 ALIAS "" SIZE TAMSX3("QEK_DTENTR")[1]    TITLE STR0022		//"Data Entrada"
	DEFINE CELL NAME "cLOTE"     OF oSection2 ALIAS "" SIZE TAMSX3("QEK_LOTE")[1]      TITLE STR0023		//"Lote"
	DEFINE CELL NAME "cSkipLote" OF oSection2 ALIAS "" SIZE TAMSX3("QEK_VERIFI")[1]    TITLE STR0024		//"Skip-Lote"
	DEFINE CELL NAME "cLaudo"    OF oSection2 ALIAS "" SIZE TAMSX3("QED_DESCPO")[1]    TITLE STR0025		//"Laudo"
	DEFINE CELL NAME "cDOCENT"   OF oSection2 ALIAS "" SIZE TAMSX3("D1_LOTEFOR")[1]+10 TITLE FWX3Titulo('QEK_DOCENT')//"Lote Fornec."

	DEFINE SECTION oSection3 OF oSection2 TABLES "QF5" TITLE STR0043//"Medicoes"
	DEFINE CELL NAME "cENSAIO"   OF oSection3 ALIAS "" SIZE TAMSX3("QF6_ENSAIO")[1] TITLE STR0028 //"Ensaio"
	DEFINE CELL NAME "cPLAMO"    OF oSection3 ALIAS "" SIZE TAMSX3("QF6_PLAMO")[1]  TITLE STR0029 //"Plano"
	DEFINE CELL NAME "cCodNorma" OF oSection3 ALIAS "" SIZE TAMSX3("QF4_TIPAMO")[1] TITLE STR0039 //"Desc. Plano"
	DEFINE CELL NAME "cUnimed"   OF oSection3 ALIAS "" SIZE TAMSX3("QEK_UNIMED")[1] TITLE STR0031 //"UM"
	DEFINE CELL NAME "cTipo"     OF oSection3 ALIAS "" SIZE TAMSX3("AH_UMRES")[1]   TITLE STR0040 //"Tipo"
	DEFINE CELL NAME "cAmost1"   OF oSection3 ALIAS "" SIZE TAMSX3("QF5_TAMA1")[1]  TITLE "|___________"+CRLF+STR0030 //"Amostragem"
	DEFINE CELL NAME "cAceite1"  OF oSection3 ALIAS "" SIZE TAMSX3("QF5_ACEI1")[1]  TITLE "__Normal__"+CRLF+STR0032 //"Aceite"
	DEFINE CELL NAME "cRejeite1" OF oSection3 ALIAS "" SIZE TAMSX3("QF5_REJEI1")[1] TITLE "__________|"+CRLF+STR0033 //"Rejeite"
	DEFINE CELL NAME "cAmost2"   OF oSection3 ALIAS "" SIZE TAMSX3("QF5_TAMA1")[1]  TITLE "|__________"+CRLF+STR0030 //"Amostragem"
	DEFINE CELL NAME "cAceite2"  OF oSection3 ALIAS "" SIZE TAMSX3("QF5_ACEI1")[1]  TITLE "__Normal__"+CRLF+STR0032 //"Aceite"
	DEFINE CELL NAME "cRejeite2" OF oSection3 ALIAS "" SIZE TAMSX3("QF5_REJEI1")[1] TITLE "___________|"+CRLF+STR0033 //"Rejeite"

Return oReport


/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 14/08/06 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descricao ³ Relatorio da Tabela de Riscos (Referencia)    			  ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³ Uso      ³ QIER200                                                    ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport,cProg,lImpres,nConta)
	Local aEnsaios 	 := {}
	Local aEntrada 	 := {}
	Local aLabEns    := {}
	Local cAmIns     := " "
	Local cCabec     := ""
	Local cCampo     := ""
	Local cChaveQEK1 := ""
	Local cCpo		 := ""
	Local cDescEns 	 := Space(30)
	Local cDescLab   := ""
	Local cFor       := ""
	Local cForn 	 := ""
	Local CGrupo     := ""
	Local cLaborat   := ""
	Local cLaudo     := ""
	Local cLojFor    := ""
	Local cNiseri    := ""
	Local cSeek      := ""
	Local cSkipLote  := ""
	Local cSkTes     := "   "
	Local cTipoEns	 := ''
	Local cUM        := ""
	Local cUnimed    := ""
	Local lFirst     := .F.
	Local lImp		 := .T.
	Local lSkpLot    := .F.
	Local nC         := ""
	Local nColEns    := ""
	Local nCont 	 := ""
	Local nRecQEK    := 0
	Local nRecTRB    := 0
	Local nX         := ""
	Local nY         := ""
	Local oSection1  := oReport:Section(1)
	Local oSection2  := oReport:Section(1):Section(1)
	Local oSection3  := oReport:Section(1):Section(1):Section(1)

	Private aCampos    := {}
	Private cProduto   := ''
	Private oTempTable := NIL

	dbSelectArea("QEK")
	dbSetOrder(1)

	If cProg # "QIEA200"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Localiza a Entrada										       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSetOrder(14)
		lImp := dbSeek(xFilial("QEK")+mv_par01+mv_par02+mv_par03+mv_par12+mv_par13+DTOS(mv_par04)+mv_par05)
	EndIf

	nRecQEK    := Recno()
	cChaveQEK1 := QEK->QEK_PRODUT+Inverte(QEK->QEK_REVI)
	cFor	   := QEK->QEK_FORNEC
	cLojFor	   := QEK->QEK_LOJFOR

//Numero de linhas padrao para Impressao das colunas de medicoes
	mv_par11 := If(mv_par11==0,1,mv_par11)

	If QEK->(!EOF())
		dbSelectArea("QE6")
		dbSetOrder(1)
		dbSeek(xFilial("QE6")+cChaveQEK1)
		IF !Found() .Or. !lImp
			Set Device to Screen
			Help(" ",1,"QE_NAOPRRV",,QEK->QEK_PRODUT+" / "+QEK->QEK_REVI,2,1) // "Produto/Revisao nao cadastrados:
			dbSelectArea("QEK")
			dbSetOrder(1)
			Return(.F.)
		EndIf

		cProduto := QE6->QE6_PRODUT+QE6->QE6_REVI

		dbSelectArea("QE7")
		dbSetOrder(1)
		dbSeek(xFilial("QE7")+cProduto)
		dbSelectArea("QE8")
		dbSetOrder(1)
		dbSeek(xFilial("QE8")+cProduto)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Arquivo de Trabalho. 									 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aTam:=TamSX3("QEK_PRODUT")
		AADD(aCampos,{"PRODUTO",   "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QEK_REVI")
		AADD(aCampos,{"REVI",   "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE7_ENSAIO")
		AADD(aCampos,{"ENSAIO", "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE7_METODO")
		AADD(aCampos,{"METODO", "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE7_TIPO")
		AADD(aCampos,{"TIPO",   "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE7_UNIMED")
		AADD(aCampos,{"UNIMED", "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE7_NOMINA")
		AADD(aCampos,{"NOMINA", "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE7_LIE")
		AADD(aCampos,{"LIE", "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE7_LSE")
		AADD(aCampos,{"LSE","C",aTam[1],aTam[2]})
		aTam:=TamSX3("QF4_PLAMO")
		AADD(aCampos,{"PLAMO",  "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE7_NIVEL")
		AADD(aCampos,{"NIVEL", "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE7_AM_INS")
		AADD(aCampos,{"AM_INS", "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE7_LABOR")
		AADD(aCampos,{"LABOR",  "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE7_SEQLAB")
		AADD(aCampos,{"SEQLAB", "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE7_MINMAX")
		AADD(aCampos,{"MINMAX", "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QE8_TEXTO")
		AADD(aCampos,{"TEXTO",  "C",aTam[1],aTam[2]})
		aTam:=TamSX3("QEK_VERIFI")
		AADD(aCampos,{"Ok","C",aTam[1],aTam[2]})

		oTempTable := FWTemporaryTable():New( "TRB" )
		oTempTable:SetFields( aCampos )
		oTempTable:AddIndex("indice1", {"LABOR","SEQLAB"} )
		oTempTable:Create()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Chamada da Funcao para gerar arquivo de Trabalho			 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		GeraTrab(.T.,oReport)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Identifica o Grupo do Produto								   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		QEA->(dbSetOrder(2))
		QEA->(dbSeek(xFilial("QEA")+QEK->QEK_PRODUT))
		cGrupo := QEA->QEA_GRUPO
		QEA->(dbSetOrder(1))

		TRB->(dbGoTop())

		If TRB->(BOF()) .and. TRB->(EOF())
			HELP(" ",1,"RECNO")
			oTempTable:Delete()
			dbSelectArea("QEA")
			Return(.F.)
		Endif

		While TRB->(!EOF())

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Flag Verifica se j  foi impresso o laboratorio 				 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If TRB->OK == "S"
				dbSelectArea("TRB")
				dbSkip()
				Loop
			EndIf

			If	!Empty(mv_par06) .And. TRB->LABOR < mv_par06 .or.;
					!Empty(mv_par07) .And. TRB->LABOR > mv_par07
				dbSelectArea("TRB")
				dbSkip()
				Loop
			EndIf

			If TRB->LABOR != cLaborat
				cLaborat := TRB->LABOR
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Descricao do Laboratorio									  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(TRB->LABOR)
				cDescLab := Tabela("Q2",TRB->LABOR)
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ ARMAZENA NO ARRAY AS ULTIMAS ENTRADAS 				 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("QEK")
			dbSetOrder(2)
			dbGoto(nRecQEK)
			nCont   := 0
			lSkpLot := .F.
			While QEK_FILIAL+QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT == ;
					xFilial("QEK")+cFor+cLojFor+Substr(cProduto,1,(TamSX3("QEK_PRODUTO")[1])) .and. nCont < 4

				If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QEK")))
					If !QEK->(&(oReport:Section(1):GetAdvplExp("QEK")))
						QEK->(dbSkip())
						Loop
					Endif
				EndIf

				cSkipLote := Iif (QEK_VERIFI <> 2 , STR0019, STR0020) //"NAO"###"SIM"
				cChaveQEL := QEK_FORNEC+QEK_LOJFOR+QEK_PRODUT+DTOS(QEK_DTENTR)+QEK_LOTE+;
					Space(TamSX3("QEL_LABOR")[1])

				dbSelectArea("QEL")

				cNiseri := QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF
				QEL->(dbSetOrder(3))
				cChaveQEL := QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+cNiseri+QEK->QEK_TIPONF+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE+;
					Space(TamSX3("QEL_LABOR")[1])

				If dbSeek(xFilial("QEL")+cChaveQEL)
					QED->(dbSetOrder(1))
					QED->(dbSeek(xFilial("QED")+QEL->QEL_LAUDO))
					cLaudo := QaxIdioma("QED->QED_DESCPO","QED->QED_DESCIN","QED->QED_DESCES")
				Else
					cLaudo := Space(TamSX3("QED_DESCPO")[1])
				EndIf

				dbSelectArea("QEK")
				AADD(aEntrada,{QEK_DTENTR,QEK_LOTE,Upper(cSkipLote),cLaudo,QEK_DOCENT})
				nCont++

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se a Entrada atual esta em regime de Skip-Lote		  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nCont == 1
					If QEK->QEK_VERIFI == 2
						lSkpLot := .T.
					EndIf
				EndIf

				dbSkip()
			Enddo
			dbSelectArea("QEK")
			dbGoTo(nRecQEK)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Dados dos ensaios 						   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aEnsaios := {}
			aLabEns  := {}
			dbSelectArea("TRB")
			nRecTRB := Recno()
			While !EOF() .and. cLaborat == TRB->LABOR
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Verifica o skip-teste										 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cSkTes := "   "
				// Verifica se tem skip-teste definido
				QEH->(dbSetOrder(1))
				If QEH->(dbSeek(xFilial("QEH")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+;
						QEK->QEK_PRODUT+TRB->ENSAIO))
					cSkTes := "CER"
					// Verifica o historico skip-teste individual

					QEY->(dbSetOrder(4))
					If QEY->(dbSeek(xFilial("QEY")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+;
							QEK->QEK_PRODUT+QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF+QEK->QEK_TIPONF+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE+TRB->ENSAIO))
						cSkTes := "INS"
					EndIf

				Else
					cSkTes := "N/A"   // indica que nao foi definido
				EndIf
				If Empty(cSkTes) .Or. cSkTes == "N/A"
					// Verifica o historico skip-teste por grupo

					cNiseri := QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF
					cSeek := xFilial("QEZ")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+cGrupo+cNiseri+QEK->QEK_TIPONF+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE+TRB->ENSAIO
					QEZ->(dbSetOrder(3))

					If QEZ->(dbSeek(cSeek))
						cSkTes := "INS"
					Else
						// Verifica se tem skip-teste definido
						QEI->(dbSetOrder(1))
						If QEI->(dbSeek(xFilial("QEI")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+;
								cGrupo+TRB->ENSAIO))
							cSkTes := "CER"
						Else
							cSkTes := "N/A" //indica que nao foi definido
						EndIf
					EndIf
				EndIf

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se os Ensaios a Inspecionar serao impressos na Fi-  ³
				//³ do Produto conforme selecao do parametro.				     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par10 == 2
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Quando a Entrada atual estiver em regime de Skip-Lote, somen-³
					//³ te serao impressos os ensaios em Skip-Teste.				 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If lSkpLot
						If cSkTes # "INS"
							RecLock("TRB",.F.)
							TRB->OK	 := "S"
							MsUnLock()
							TRB->(dbSkip())
							Loop
						EndIf
					Else
						If (cSkTes # "N/A") .And. (cSkTes # "INS")
							RecLock("TRB",.F.)
							TRB->OK	 := "S"
							MsUnLock()
							TRB->(dbSkip())
							Loop
						EndIf
					EndIf
				EndIf

				RecLock("TRB",.F.)
				TRB->OK	 := "S"
				MsUnLock()
				dbSelectArea("QE1")
				dbSetOrder(1)
				IF dbSeek(xFilial("QE1")+TRB->ENSAIO)
					cDescEns := Substr(QE1_DESCPO,1,30)
					cTipoEns := QE1_CARTA
				Endif

				dbSelectArea("TRB")

				AADD(aEnsaios,{ENSAIO,cTipoEns})

				If cTipoEns <> "TXT"
					SAH->(dbSetOrder(1))
					SAH->(dbgotop())
					If SAH->(dbSeek(xFilial("SAH")+TRB->UNIMED))
						cUM := SAH->AH_UMRES
					Else
						cUM := " "
					EndIf
				EndIf

				If (AM_INS == "1" )
					cAmIns := "AMO"
				ElseIf (AM_INS == "2")
					cAmIns := "INS"
				ElseIf (AM_INS == "3")
					cAmIns := "A/I"
				Else
					cAmIns := " "
				EndIf

				Aadd(aLabEns,{ENSAIO+" "+cDescEns,SubStr(METODO,1,13),TIPO,cTipoEns,cUM,NOMINA,;
					MINMAX,LIE,LSE,	Left(TEXTO,34),Subs(TEXTO,35,34),Subs(TEXTO,69),;
					PLAMO,NIVEL,cAmIns,	cSkTes})

				dbSelectArea("TRB")
				dbSkip()

			Enddo
			dbGoTo(nRecTRB)

			If Len(aLabEns) == 0
				TRB->(dbSkip())
				Loop
			EndIf
			oReport:SkipLine(1)
			oReport:PrintText(AllTrim(TitSX3("QE6_PRODUT")[1])+" - "+AllTrim(TitSX3("QE6_REVI")[1])+Replicate(".",38-(len(Alltrim(TitSx3("QE6_PRODUT")[1]))+len(Alltrim(TitSx3("QE6_REVI")[1]))))+":"+QE6->QE6_PRODUT +" - "+ QE6->QE6_REVI,oReport:Row(),025)
			oReport:SkipLine(1)

			If __LANGUAGE == "PORTUGUESE"
				cCpo := "QE6_DESCPO"
			ElseIf __LANGUAGE == "ENGLISH"
				cCpo := "QE6_DESCIN"
			ElseIf __LANGUAGE == "SPANISH"
				cCpo := "QE6_DESCES"
			Endif

			oReport:PrintText(AllTrim(TitSX3(cCpo)[1])+REPLICATE(".",41-Len(AllTrim(TitSX3(cCpo)[1])))+":"+QE6->&(cCpo),oReport:Row(),025)
			oReport:SkipLine(1)

			oReport:PrintText(AllTrim(TitSX3("QE6_APLIC")[1])+REPLICATE(".",41-Len(AllTrim(TitSX3("QE6_APLIC")[1])))+":"+QE6->QE6_APLIC,oReport:Row(),025)
			oReport:SkipLine(1)

			oReport:PrintText(AllTrim(TitSX3("QE6_CROQUI")[1])+REPLICATE(".",41-Len(AllTrim(TitSX3("QE6_CROQUI")[1])))+":"+QE6->QE6_CROQUI,oReport:Row(),025)
			oReport:SkipLine(1)

			oReport:PrintText(AllTrim(TitSX3("QE6_DTCAD")[1])+"/"+AllTrim(TitSX3("QE6_DTDES")[1])+"/"+AllTrim(TitSX3("QE6_RVDES")[1])+"...:"+Dtoc(QE6->QE6_DTCAD) +"  "+Dtoc(QE6->QE6_DTDES)+"  "+QE6->QE6_RVDES,oReport:Row(),025)
			oReport:SkipLine(1)

			oReport:PrintText(AllTrim(TitSX3("QE6_DTINI")[1])+REPLICATE(".",41-Len(AllTrim(TitSX3("QE6_DTINI")[1])))+":"+Dtoc(QE6->QE6_DTINI),oReport:Row(),025)
			oReport:SkipLine(1)


			If !Empty(QE6->QE6_DOCOBR)
				cCabec := AllTrim(TitSX3("QE6_DOCOBR")[1])+REPLICATE(".",41-Len(AllTrim(TitSX3("QE6_DOCOBR")[1])))+":"

				If(QE6->QE6_DOCOBR=="S")
					cCabec:= cCabec + OemToAnsi(STR0008)   // "Sim"
				Else
					cCabec:= cCabec + OemToAnsi(STR0009)	// "Nao"
				Endif

				oReport:PrintText(cCabec,oReport:Row(),025)
				oReport:SkipLine(1)

			EndIf

			//Descricao do Laboratorio
			oReport:SkipLine(2)
			oReport:PrintText(STR0010 + TRB->LABOR + " - " + cDescLab,oReport:Row(),025) //"LABORATORIO ==> "
			oReport:SkipLine(1)

			oSection1:Init()

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime os Ensaios associados ao Laboratorio				 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For nX := 1 to Len(aLabEns)

				oSection1:CELL("cENSAIO"):SetValue(aLabEns[nX,1])//00
				oSection1:CELL("cMETODO"):SetValue(aLabEns[nX,2])//40
				oSection1:CELL("cTIPO"):SetValue(aLabEns[nX,3])  //53

				If aLabEns[nX,4] <> "TXT"
					oSection1:CELL("cNominal"):SetValue("")
					oSection1:CELL("cLIE"):SetValue("")
					oSection1:CELL("cLSE"):SetValue("")

					oSection1:CELL("cUM"):SetValue(aLabEns[nX,5]) //70
					oSection1:CELL("cNominal"):SetValue(aLabEns[nX,6])//80
					If aLabEns[nX,7] == "1"
						oSection1:CELL("cLIE"):SetValue(aLabEns[nX,8])
						oSection1:CELL("cLSE"):SetValue(aLabEns[nX,9])
					ElseIf aLabEns[nX,7] == "2"
						oSection1:CELL("cLIE"):SetValue(aLabEns[nX,8])
						oSection1:CELL("cLSE"):SetValue("   >>>")
					ElseIf aLabEns[nX,7] == "3"
						oSection1:CELL("cLSE"):SetValue(aLabEns[nX,9])
						oSection1:CELL("cLIE"):SetValue("   <<<")

					EndIf
					oSection1:CELL("cTEXTO"):SetValue("N/A")
				Else
					oSection1:CELL("cUM"):SetValue("N/A")
					oSection1:CELL("cNominal"):SetValue("")
					oSection1:CELL("cLIE"):SetValue("")
					oSection1:CELL("cLSE"):SetValue("")
					oSection1:CELL("cTEXTO"):SetValue(aLabEns[nX,10]+aLabEns[nX,11]+aLabEns[nX,12])
				EndIf

				oSection1:CELL("cPl"):SetValue(aLabEns[nX,13])

				If !Empty(aLabEns[nX,14])
					oSection1:CELL("cNIVEL"):SetValue(Substr(TABELA("Q6",aLabEns[nX,14]),1,10))
				Else
					oSection1:CELL("cNIVEL"):SetValue("")
				Endif

				oSection1:CELL("cAI"):SetValue(aLabEns[nX,15])
				oSection1:CELL("cST"):SetValue(aLabEns[nX,16])
				oSection1:PrintLine()
			Next nX

			oSection1:Finish()

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ IMPRIME MENSAGEM DE NOVAS ESPECIFICACOES 	         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If QEK->QEK_ALTESP
				oReport:SkipLine(1)
				oReport:PrintText("ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ>>   "+Upper(STR0018)+"   <<ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ",oReport:Row(),025) // "Entrada com novas Especificacoes"
				oReport:SkipLine(1)
			EndIf

			//Ultimas Entradas
			oReport:SkipLine(1)
			oReport:PrintText(STR0021,oReport:Row(),025) //Ultimas Entradas
			oSection2:Init()
			For nC:= 1 to Len(aEntrada)
				oSection2:CELL("cDTENTR"):SetValue(aEntrada[nC,1])
				oSection2:CELL("cLOTE"):SetValue(aEntrada[nC,2])
				oSection2:CELL("cSkipLote"):SetValue(aEntrada[nC,3])
				oSection2:CELL("cLaudo"):SetValue(aEntrada[nC,4])
				oSection2:CELL("cDOCENT"):SetValue(aEntrada[nC,5])
				oSection2:PrintLine()
			Next nC

			oSection2:Finish()
			aEntrada:={}

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Posiciona em registros de outros Arquivos p/dados Fornecedor  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SA5")
			dbSetOrder(2)
			dbSeek(xFilial("SA5")+QEK->QEK_PRODUT+QEK->QEK_FORNEC+QEK->QEK_LOJFOR)
			dbSelectArea("QEG")
			dbSetOrder(1)
			dbSeek(xFilial("QEG")+SA5->A5_SITU)

			oReport:SkipLine(1)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Dados do Fornecedor/Cliente           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If __LANGUAGE == "PORTUGUESE"
				cCpo := "QEG_NIVEL"
			ElseIf __LANGUAGE == "ENGLISH"
				cCpo := "QEG_NIVING"
			ElseIf __LANGUAGE == "SPANISH"
				cCpo := "QEG_NIVESP"
			Endif
			If !(mv_par08 = 2 .or. mv_par08 = 3)
				dbSelectArea("SA2")
				dbSetOrder(1)
				dbSeek(xFilial("SA2")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR)
				cForn := AllTrim(TitSX3("QEK_FORNEC")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_FORNEC")[1])))+":"+QEK->QEK_FORNEC+"/"+QEK->QEK_LOJFOR+" - "+SA2->A2_NREDUZ+"   ("+QEG->&(cCpo)+")"
				oReport:PrintText(cForn,oReport:Row(),025)
				oReport:SkipLine(1)
			Else
				dbSelectArea("SA1")
				dbSetOrder(1)
				dbSeek(xFilial("SA1")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR)
				cForn :=AllTrim(TitSX3("A7_CLIENTE")[1])+Replicate(".",23-Len(AllTrim(TitSX3("A7_CLIENTE")[1])))+":"+	QEK->QEK_FORNEC+"/"+QEK->QEK_LOJFOR+" - "+SA1->A1_NREDUZ+"   ("+QEG->&(cCpo)+")"
				oReport:PrintText(cForn,oReport:Row(),025)
				oReport:SkipLine(1)
			EndIf

			oReport:PrintText(AllTrim(TitSX3("A5_CODPRF")[1])+Replicate(".",23-Len(AllTrim(TitSX3("A5_CODPRF")[1])))+":"+SA5->A5_CODPRF,oReport:Row(),025)
			oReport:SkipLine(1)

			oReport:PrintText(AllTrim(TitSX3("QEK_LOTE")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_LOTE")[1])))+":"+QEK->QEK_LOTE,oReport:Row(),025)
			oReport:SkipLine(1)

			oReport:PrintText(AllTrim(TitSX3("QEK_NTFISC")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_NTFISC")[1])))+":"+QEK->QEK_NTFISC,oReport:Row(),025)
			oReport:SkipLine(1)

			SAH->(dbSetOrder(1))
			SAH->(dbgotop())
			SAH->(dbSeek(xFilial("SAH")+QEK->QEK_UNIMED))

			oReport:PrintText(AllTrim(TitSX3("QEK_TAMLOT")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_TAMLOT")[1])))+":"+QEK->QEK_TAMLOT + "  " + SAH->AH_UMRES,oReport:Row(),025)
			oReport:SkipLine(1)

			oReport:PrintText(AllTrim(TitSX3("QEK_DTNFIS")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_DTNFIS")[1])))+":"+Dtoc(QEK->QEK_DTNFIS),oReport:Row(),025)
			oReport:SkipLine(1)

			oReport:PrintText(AllTrim(TitSX3("QEK_DTENTR")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_DTENTR")[1])))+":"+Dtoc(QEK->QEK_DTENTR),oReport:Row(),025)
			oReport:SkipLine(1)

			oReport:PrintText(AllTrim(TitSX3("QEK_PEDIDO")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_PEDIDO")[1])))+":"+QEK->QEK_PEDIDO,oReport:Row(),025)
			oReport:SkipLine(1)

			oReport:PrintText(AllTrim(FWX3Titulo('QEK_DOCENT'))+Replicate(".",23-Len(AllTrim(FWX3Titulo("QEK_DOCENT"))))+":"+QEK->QEK_DOCENT,oReport:Row(),025)
			oReport:SkipLine(1)

			oReport:PrintText(AllTrim(TitSX3("QEK_CERFOR")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_CERFOR")[1])))+":"+QEK->QEK_CERFOR,oReport:Row(),025)
			oReport:SkipLine(1)

			cUniMed:= Iif ( QEK->QEK_UNIMED == QE6->QE6_UNMED1 ,;
				QE6->QE6_UNAMO1 , ;
				Iif (QEK->QEK_UNIMED == QE6->QE6_UNMED2, QE6->QE6_UNAMO2, Space(6) ))

			If !Empty(cUniMed)
				SAH->(dbSetOrder(1))
				SAH->(dbgotop())
				SAH->(dbSeek(xFilial("SAH")+cUniMed))
				cUniMed := SAH->AH_UMRES
			EndIf

			oReport:PrintText(STR0027+QEK->QEK_TAMAMO + "  " + AllTrim(cUnimed),oReport:Row(),025) //"Lote Amostragem........: "
			oReport:SkipLine(1)

			lFirst := .T.
			QF5->(dbSetOrder(1))
			QF5->(dbSeek(xFilial("QF5")+QEK->QEK_CHAVE))
			If QF5->(!Eof())
				While QF5->(!Eof()) .And. QEK->QEK_CHAVE == QF5->QF5_CHAVE
					If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QF5")))
						If !QF5->(&(oReport:Section(1):GetAdvplExp("QF5")))
							QF5->(dbSkip())
							Loop
						Endif
					EndIf

					If Ascan(aEnsaios,{|x|x[1]==QF5->QF5_ENSAIO}) >  0

						If QF5->QF5_TAMA1 > 0

							If lFirst
								QF4->(dbSetOrder(1))
								QF4->(dbSeek(xFilial("QF4")+QF5->QF5_FORNEC+QF5->QF5_LOJFOR+QF5->QF5_PRODUT+QF5->QF5_REVI+QF5->QF5_ENSAIO))
								oSection3:Finish()
								oSection3:Init()
								oSection3:CELL("cAmost1"):SetColSpace(-1)
								oSection3:CELL("cAceite1"):SetColSpace(-1)
								oSection3:CELL("cRejeite1"):SetColSpace(-1)
								oSection3:CELL("cAmost2"):SetColSpace(-1)
								oSection3:CELL("cAceite2"):SetColSpace(-1)
								oSection3:CELL("cRejeite2"):SetColSpace(-1)
								lFirst := .F.
							EndIf

							If QEK->QEK_TIPONF $ "BßD"
								QF6->(dbSetOrder(1))
								QF6->(dbSeek(xFilial("QF6")+QF5->QF5_FORNEC+QF5->QF5_LOJFOR+QF5->QF5_PRODUT+QF5->QF5_REVI+QF5->QF5_ENSAIO))
								oSection3:CELL("cENSAIO"):SetValue(QF6->QF6_ENSAIO)
								oSection3:CELL("cPLAMO"):SetValue(QF6->QF6_PLAMO)
							Else
								QF4->(dbSetOrder(1))
								QF4->(dbSeek(xFilial("QF4")+QF5->QF5_FORNEC+QF5->QF5_LOJFOR+QF5->QF5_PRODUT+QF5->QF5_REVI+QF5->QF5_ENSAIO))

								oSection3:CELL("cENSAIO"):SetValue(QF4->QF4_ENSAIO)
								oSection3:CELL("cPLAMO"):SetValue(QF4->QF4_PLAMO)
								
							EndIf

							cCodNorma := QA_Plano(QF4->QF4_TIPAMO)
							oSection3:CELL("cCodNorma"):SetValue(cCodNorma)
							oSection3:CELL("cUnimed"):SetValue(AllTrim(cUnimed))

							If QF4->QF4_PLAMO == "PI"
								aAmostra := QEP_RetAmostra(QF4->QF4_TIPAMO,QF4->QF4_PLAMO,QF4->QF4_NIVEL,QF4->QF4_NQA,QEK->QEK_TAMAMO,"QEK_TAMAMO")

								For nY:=1 to Len(aAmostra)
									If nY > 1
										oSection3:CELL("cENSAIO"):SetValue("")
										oSection3:CELL("cPLAMO"):SetValue("")
										oSection3:CELL("cCodNorma"):SetValue("")
										oSection3:CELL("cUnimed"):SetValue("")
									Endif
									oSection3:CELL("cTipo"):SetValue(aAmostra[nY,7])
									oSection3:CELL("cAmost1"):SetValue(aAmostra[nY,3])
									oSection3:CELL("cAceite1"):SetValue(aAmostra[nY,1])
									oSection3:CELL("cRejeite1"):SetValue(aAmostra[nY,2])
									oSection3:CELL("cAmost2"):SetValue(aAmostra[nY,6])
									oSection3:CELL("cAceite2"):SetValue(aAmostra[nY,4])
									oSection3:CELL("cRejeite2"):SetValue(aAmostra[nY,5])
									oSection3:PrintLine()
								Next nY
							Else
								oSection3:CELL("cAmost1"):SetValue(QF5->QF5_TAMA1)
								oSection3:CELL("cAceite1"):SetValue(QF5->QF5_ACEI1)
								oSection3:CELL("cRejeite1"):SetValue(QF5->QF5_REJEI1)
								oSection3:CELL("cAmost2"):SetValue(QF5->QF5_TAMA2)
								oSection3:CELL("cAceite2"):SetValue(QF5->QF5_ACEI2)
								oSection3:CELL("cRejeite2"):SetValue(QF5->QF5_REJEI2)
								oSection3:PrintLine()
							EndIf
						Endif
					EndIf
					QF5->(dbSkip())
				EndDo
			EndIf

			oReport:SkipLine(1)
			cCampo:= AllTrim(TitSX3("QER_RASTRE")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QER_RASTRE")[1])))+":"+"__________________"+"                     "+AllTrim(TitSX3("QEL_DTENLA")[1])+Replicate(".",19-Len(AllTrim(TitSX3("QEL_DTENLA")[1])))+":"+"__________________"
			oReport:PrintText(cCampo,oReport:Row(),025)
			oReport:SkipLine(2)

			oReport:PrintText("|---------------------------------------------------------------------------------------------------------------------------------|",oReport:Row(),025)
			oReport:SkipLine(1)
			oReport:PrintText("|                | "+Left(TitSX3("QET_INSTR")[1],9)+"  |"+STR0034+"|"+STR0035+"|",oReport:Row(),025)//"     Ensaiador     "###"                                     M E D I C O E S                           "
			oReport:SkipLine(1)
			oReport:PrintText("|----------------+------------+-------------------+---------------+---------------+---------------+---------------+---------------|",oReport:Row(),025)
			oReport:SkipLine(1)
			For nCont := 1 to Len(aEnsaios)
				//Imprime n linhas p/ as medicoes
				For nColEns := 1 to mv_par11

					If aEnsaios[nCont,2] <> "TXT"
						oReport:PrintText("| " + aEnsaios[nCont,1] + "       |            |                   |               |               |               |               |               |",oReport:Row(),025)
						oReport:SkipLine(1)
						oReport:PrintText("|----------------+------------+-------------------+---------------+---------------+---------------+---------------+---------------|",oReport:Row(),025)
						oReport:SkipLine(1)
					Else
						oReport:PrintText("| " + aEnsaios[nCont,1] + "       |            |                   |                                                                               |",oReport:Row(),025)
						oReport:SkipLine(1)
						oReport:PrintText("|---------------------------------------------------------------------------------------------------------------------------------|",oReport:Row(),025)
						oReport:SkipLine(1)
					EndIf

				Next nColEns
			Next nCont

			oReport:SkipLine(2)
			oReport:PrintText(STR0036+"________________________",oReport:Row(),025)
			oReport:SkipLine(1)


			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Converte a chave passada como param. p/ chave do texto		 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cChave := QE6->QE6_CHAVE
			cEspeci:="QIEA010 "
			dbSelectArea("QA2")
			QA2->(dbSetOrder(1))
			dbSeek(xFilial("QA2")+cEspeci+cChave)
			Do While !EOF() .and. QA2->QA2_FILIAL+QA2->QA2_ESPEC+QA2->QA2_CHAVE ==;
					xFilial("QA2")+cEspeci+cChave
				oReport:PrintText(StrTran(QA2_TEXTO,"\13\10",""),oReport:Row(),025)
				oReport:SkipLine(1)
				dbSkip()
			Enddo
			If nConta <> NIL
				nConta++
			Endif

			dbSelectArea("TRB")
			dbSkip()

		EndDo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Apaga indice e o arquivo de trabalho                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oTempTable:Delete()
	Else
		MessageDlg(STR0044)//"Não existe entrada cadastrada para o produto selecionado"
	Endif

Return

/*/
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³Fun‡„o	 ³GeraTrab	³ Autor ³ Marcelo Pimentel 	    ³Data  ³11.03.98  ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
	±±³Descri‡…o ³Gera arquivo de Trabalho 									  ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³ Uso		 ³ GeraTrab()												  ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static FuncTion GeraTrab(lR4, oReport)
	Local cCondR47 			:= ''
	Default lR4  			:= .F.
	Default oReport			:= Nil

	If lR4
		If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QE7")))
			cCondR47 := oReport:Section(1):GetAdvplExp("QE7")
		EndIf

		If !Empty(cCondR47)
			While QE7->(!Eof()) .And. xFilial("QE7")==QE7->QE7_FILIAL .And. QE7->(QE7_PRODUTO+QE7_REVI) == cProduto .And. QE7->(&(cCondR47))
				RecLock("TRB",.T.)
				TRB->PRODUTO	:= QEK->QEK_PRODUT
				TRB->REVI		:= QEK->QEK_REVI
				TRB->ENSAIO 	:= QE7->QE7_ENSAIO
				TRB->METODO 	:= QE7->QE7_METODO
				TRB->TIPO		:= QE7->QE7_TIPO
				TRB->UNIMED 	:= QE7->QE7_UNIMED
				TRB->NOMINA 	:= QE7->QE7_NOMINA
				TRB->LIE 		:= QE7->QE7_LIE
				TRB->LSE 		:= QE7->QE7_LSE
				TRB->PLAMO		:= QE7->QE7_PLAMO
				TRB->NIVEL  	:= QE7->QE7_NIVEL
				TRB->AM_INS 	:= QE7->QE7_AM_INS
				TRB->LABOR		:= QE7->QE7_LABOR
				TRB->SEQLAB 	:= QE7->QE7_SEQLAB
				TRB->MINMAX 	:= QE7->QE7_MINMAX
				MsUnlock()
				dbSelectArea("QE7")
				dbSkip()
			Enddo
		Else
			While QE7->(!Eof()) .And. xFilial("QE7")==QE7->QE7_FILIAL .And. QE7->(QE7_PRODUTO+QE7_REVI) == cProduto
				RecLock("TRB",.T.)
				TRB->PRODUTO	:= QEK->QEK_PRODUT
				TRB->REVI		:= QEK->QEK_REVI
				TRB->ENSAIO 	:= QE7->QE7_ENSAIO
				TRB->METODO 	:= QE7->QE7_METODO
				TRB->TIPO		:= QE7->QE7_TIPO
				TRB->UNIMED 	:= QE7->QE7_UNIMED
				TRB->NOMINA 	:= QE7->QE7_NOMINA
				TRB->LIE 		:= QE7->QE7_LIE
				TRB->LSE 		:= QE7->QE7_LSE
				TRB->PLAMO		:= QE7->QE7_PLAMO
				TRB->NIVEL  	:= QE7->QE7_NIVEL
				TRB->AM_INS 	:= QE7->QE7_AM_INS
				TRB->LABOR		:= QE7->QE7_LABOR
				TRB->SEQLAB 	:= QE7->QE7_SEQLAB
				TRB->MINMAX 	:= QE7->QE7_MINMAX
				MsUnlock()
				dbSelectArea("QE7")
				dbSkip()
			Enddo
		Endif
	Else
		While QE7->(!Eof()) .And. xFilial("QE7")==QE7->QE7_FILIAL .And. QE7->(QE7_PRODUTO+QE7_REVI) == cProduto
			RecLock("TRB",.T.)
			TRB->PRODUTO	:= QEK->QEK_PRODUT
			TRB->REVI		:= QEK->QEK_REVI
			TRB->ENSAIO 	:= QE7->QE7_ENSAIO
			TRB->METODO 	:= QE7->QE7_METODO
			TRB->TIPO		:= QE7->QE7_TIPO
			TRB->UNIMED 	:= QE7->QE7_UNIMED
			TRB->NOMINA 	:= QE7->QE7_NOMINA
			TRB->LIE 		:= QE7->QE7_LIE
			TRB->LSE 		:= QE7->QE7_LSE
			TRB->PLAMO		:= QE7->QE7_PLAMO
			TRB->NIVEL  	:= QE7->QE7_NIVEL
			TRB->AM_INS 	:= QE7->QE7_AM_INS
			TRB->LABOR		:= QE7->QE7_LABOR
			TRB->SEQLAB 	:= QE7->QE7_SEQLAB
			TRB->MINMAX 	:= QE7->QE7_MINMAX
			MsUnlock()
			dbSelectArea("QE7")
			dbSkip()
		Enddo
	Endif

	dbSelectArea("QE8")
	While !Eof() .And. xFilial("QE8")==QE8->QE8_FILIAL .And. QE8->(QE8_PRODUTO+QE8_REVI) == cProduto

		If lR4
			If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QE8")))
				If !QE8->(&(oReport:Section(1):GetAdvplExp("QE8")))
					QE8->(dbSkip())
					Loop
				Endif
			EndIf
		Endif

		RecLock("TRB",.T.)
		TRB->PRODUTO := QEK->QEK_PRODUT
		TRB->REVI    := QEK->QEK_REVI
		TRB->ENSAIO  := QE8->QE8_ENSAIO
		TRB->METODO  := QE8->QE8_METODO
		TRB->TIPO    := QE8->QE8_TIPO
		TRB->TEXTO   := QE8->QE8_TEXTO
		TRB->PLAMO   := QE8->QE8_PLAMO
		TRB->NIVEL   := QE8->QE8_NIVEL
		TRB->AM_INS  := QE8->QE8_AM_INS
		TRB->LABOR   := QE8->QE8_LABOR
		TRB->SEQLAB  := QE8->QE8_SEQLAB
		MsUnlock()
		dbSelectArea("QE8")
		dbSkip()
	Enddo
Return .T.
