/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIER230.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³QIER230   ³ Autor ³ Cleber Souza          ³ Data ³ 11/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Relatorio de produtos - conferencia                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQie                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			   ³        ³	   ³								          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function QIER230() 

Private cTexto   := MemoRead("QER230.TXT")
Private cPerg 	 := "QER230"

If QER230Text(@cTexto)
	oReport := ReportDef()
	oReport:PrintDialog()	
EndIF

Return      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ReportDef  ºAutor  ³Cleber Souza        º Data ³  11/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicoes do relatorio de Formulas R4.		              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER230                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef(cTexto)

Local cPrograma  := "QIER230"
Local cDesc1  	 := OemToAnsi(STR0001)	//"Neste relatorio serao relacionados os ensaios, as características do produto"
Local cDesc2     := OemToAnsi(STR0002)	//"Alem do texto livre digitado na tela anterior."
Local cTitulo	 := GetMv("MV_QEFICHP")+STR0003	// " - Conferencia"

DEFINE REPORT oReport NAME cPrograma TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)LANDSCAPE

DEFINE SECTION oSection1 OF oReport TITLE TitSx3("QE6_PRODUT")[1] LINE STYLE TABLES "QE6" PAGE BREAK  
DEFINE CELL NAME "QE6_PRODUT"  OF oSection1 TITLE  AllTrim(TitSx3("QE6_PRODUT")[1])+AllTrim(TitSx3("QE6_REVI")[1]) SIZE TamSx3("QE6_PRODUT")[1]+TamSx3("QE6_REVI")[1]+4 CELL BREAK
DEFINE CELL NAME "QE6_DESCPO"  OF oSection1 CELL BREAK
DEFINE CELL NAME "QE6_APLIC"   OF oSection1 CELL BREAK
DEFINE CELL NAME "QE6_CROQUI"  OF oSection1 CELL BREAK
DEFINE CELL NAME "cDatas"      OF oSection1 SIZE TamSx3("QE6_DTCAD")[1]+TamSx3("QE6_DTDES")[1]+TamSx3("QE6_RVDES")[1]+20   TITLE  AllTrim(TitSx3("QE6_DTCAD")[1])+"/"+AllTrim(TitSx3("QE6_DTDES")[1])+"/"+AllTrim(TitSx3("QE6_RVDES")[1]) CELL BREAK 
DEFINE CELL NAME "QE6_DTINI"   OF oSection1 CELL BREAK
DEFINE CELL NAME "QE6_DOCOBR"  OF oSection1 CELL BREAK

DEFINE SECTION oSection2 OF oReport TITLE STR0026 LINE STYLE //"LABORATORIO"  
DEFINE CELL NAME "LABORATORIO"  OF oSection2 SIZE 200  TITLE  STR0026	LINE BREAK	 //"LABORATORIO"

DEFINE SECTION oSection3 OF oReport TITLE TitSx3("QE7_ENSAIO")[1] TABLES "QE7","QE8"
DEFINE CELL NAME "QE7_ENSAIO"   OF oSection3 SIZE TamSx3("QE1_ENSAIO")[1]+TamSx3("QE1_DESCPO")[1]	 
DEFINE CELL NAME "QE7_METODO"   OF oSection3 	 
DEFINE CELL NAME "QE7_TIPO"     OF oSection3 	 
DEFINE CELL NAME "QE7_UNIMED"   OF oSection3 	 
DEFINE CELL NAME "QE8_DESENS"   OF oSection3 	 
DEFINE CELL NAME "QE7_NOMINA"   OF oSection3 	 
DEFINE CELL NAME "QE7_LIE"      OF oSection3 	 
DEFINE CELL NAME "QE7_LSE"      OF oSection3 	 
DEFINE CELL NAME "QE7_NIVEL"    OF oSection3 	 
DEFINE CELL NAME "AI"		    OF oSection3 TITLE STR0015 	SIZE 4 

DEFINE SECTION oSection4 OF oReport LINE STYLE TITLE STR0027
DEFINE CELL NAME "METODO"	    OF oSection4 TITLE STR0027 SIZE 187 LINE BREAK  //"Metodo"

DEFINE SECTION oSection5 OF oReport TITLE STR0028
DEFINE CELL NAME "TXTESP"	    OF oSection5 TITLE STR0028 SIZE 187 LINE BREAK  //"Texto da Especificação"

DEFINE SECTION oSection6 OF oReport TITLE STR0029  
DEFINE CELL NAME "TXTUSU"	    OF oSection6 TITLE STR0029 SIZE 187 LINE BREAK  //"Texto do Usuario"
oSection6:Cell("TXTUSU"):SeTLineBREAK(.T.)

Return(oReport) 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReportºAutor  ³Cleber Souza		 º Data ³  11/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao relatorio R4.                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER230                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)

Local cUltRevi 		:= ""
Local aTam			:= {}
Local aCampos		:= {}
Local oTempTable	:=	NIL
Local lImprimiu		:= .F.
Local cLaborat		:= " "
Local cDescLab		:= " "
Local cDescEns		:= Space(30)
Local cTipoEns		:= " "
Local cAmIns		:= " " 
Local cTexto        := " "
Local lRet          := .T.
Local oSection1     := oReport:Section(1)
Local oSection2     := oReport:Section(2)
Local oSection3     := oReport:Section(3)
Local oSection4     := oReport:Section(4)
Local oSection5     := oReport:Section(5)
Local oSection6     := oReport:Section(6)
Local cCpo			:= ""
Local ImprProd      := ""
Local ImprLab       := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Arquivo de Trabalho para ordenar os ensaios ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("QEK_PRODUTO")
AADD(aCampos,{"PRODUTO",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QEK_REVI")
AADD(aCampos,{"REVI",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE7_ENSAIO")
AADD(aCampos,{"ENSAIO",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE7_METODO")
AADD(aCampos,{"METODO",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE7_TIPO")
AADD(aCampos,{"TIPO",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE7_UNIMED")
AADD(aCampos,{"UNIMED",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE7_NOMINA")
AADD(aCampos,{"NOMINA",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE7_LIE")
AADD(aCampos,{"LIE",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE7_LSE")
AADD(aCampos,{"LSE","C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE7_NIVEL")
AADD(aCampos,{"NIVEL",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE7_AM_INS")
AADD(aCampos,{"AM_INS",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE7_LABOR")
AADD(aCampos,{"LABOR",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE7_SEQLAB")
AADD(aCampos,{"SEQLAB",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE7_MINMAX")
AADD(aCampos,{"MINMAX",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QE8_TEXTO")
AADD(aCampos,{"TEXTO",	"C",aTam[1],aTam[2]	})

aTam:=TamSX3("QEK_VERIFI")
AADD(aCampos,{"Ok","C",aTam[1],aTam[2]})

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de trabalho ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTempTable := FWTemporaryTable():New( "TRB" )
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("indice1", {"PRODUTO","REVI","LABOR","SEQLAB"} )
oTempTable:Create()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona os Produtos ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QE6")
dbSetOrder(1)
If !Empty(mv_par01)	
	dbSeek(xFilial("QE6")+mv_par01)
Else
	dbGotop()	// Todos ate o mv_par02
Endif

While !Eof() .And. QE6->QE6_PRODUT >= mv_par01 .And. QE6->QE6_PRODUT <=	mv_par02
	If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QE6")))
		If !QE6->(&(oReport:Section(1):GetAdvplExp("QE6")))
			QE6->(dbSkip())
			Loop
		Endif
	EndIf
	
	If oReport:Cancel()
		Exit
	EndIf
	oReport:IncMeter()	
	
	cUltRevi := QA_UltRevEsp(QE6->QE6_PRODUT,dDataBase,.F.,,"QIE")
	
	// Cria temporario com os ensaios do Produto
	GeraTrab(QE6->QE6_PRODUT,cUltRevi)
	
	dbSelectArea("TRB")
	TRB->(dbGoTop())
	oReport:SetMeter(RecCount())
	
	If !Eof()
		If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("TRB")))
			If !TRB->(&(oReport:Section(1):GetAdvplExp("TRB")))
				TRB->(dbSkip())
				Loop
			Endif
		EndIf
		lImprimiu := .T.       
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ DADOS DO PRODUTO ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection1:Init()    
		oSection1:Cell("QE6_PRODUT"):SetValue(Alltrim(QE6->QE6_PRODUT) + " - " + QE6->QE6_REVI)

		If __LANGUAGE == "PORTUGUESE"
			cCpo := "QE6_DESCPO"
		ElseIf __LANGUAGE == "ENGLISH"
			cCpo := "QE6_DESCIN"
		ElseIf __LANGUAGE == "SPANISH"
			cCpo := "QE6_DESCES"
		Endif
		oSection1:Cell("QE6_DESCPO"):SetValue(QE6->&(cCpo))
		oSection1:Cell("QE6_DESCPO"):cTitle := TitSX3(cCpo)[1]

		oSection1:Cell("QE6_APLIC"):SetValue(QE6->QE6_APLIC)
		oSection1:Cell("QE6_CROQUI"):SetValue(QE6->QE6_CROQUI)
		oSection1:Cell("cDatas"):SetValue(DTOC(QE6->QE6_DTCAD)+"  "+DTOC(QE6->QE6_DTDES)+"  "+QE6->QE6_RVDES)
		oSection1:Cell("QE6_DTINI"):SetValue(DTOC(QE6->QE6_DTINI))
		If !Empty(QE6->QE6_DOCOBR)
			oSection1:Cell("QE6_DOCOBR"):SetValue(Iif(QE6->QE6_DOCOBR=="S",OemToAnsi(STR0008),;	// "Sim"
			OemToAnsi(STR0009)))	// "Nao"
    	Else
    		oSection1:HIDE()	
    	EndIf
		oSection1:PrintLine()
        oSection1:Finish()
		lRet := .T.
	Else
		lRet := .F.
	EndIf
	
	While TRB->(!EOF())
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Dados Do Ensaio Pertencentes Ao Laboratorio	³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ImprLab <> TRB->LABOR .Or. ImprProd<>TRB->PRODUTO
			cLaborat := TRB->LABOR
			cDescLab := Tabela("Q2",TRB->LABOR)

			oReport:SkipLine()
			oSection2:Init()    
			oSection2:Cell("LABORATORIO"):SetValue(TRB->LABOR + " - " + cDescLab)
			oSection2:PrintLine()
        	oSection2:Finish()
			ImprLab:=TRB->LABOR
			ImprProd:=TRB->PRODUTO
		
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Dados dos ensaios ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("QE1")
		dbSetOrder(1)
		If	dbSeek(xFilial("QE1")+TRB->ENSAIO)
			cDescEns := Substr(QE1_DESCPO,1,30)
			cTipoEns := QE1_CARTA
		Endif
		
		dbSelectArea("TRB")
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Ensaios 			 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oSection3:Init()    
		oSection3:Cell("QE7_ENSAIO"):SetValue(Alltrim(TRB->ENSAIO) + " " + cDescEns)
		oSection3:Cell("QE7_METODO"):SetValue(TRB->METODO)
		oSection3:Cell("QE7_TIPO"):SetValue(TRB->TIPO)
		
		If cTipoEns <> "TXT"
			If oReport:nDevice == 4 .and. oReport:NEXCELPRINTTYPE == 3 //Impressão de Excel em formato de tabela
			//Ao usar o formato tabela, não podemos ocultar campos, trata-se de uma limitação deste formato.
			oSection3:Cell("QE8_DESENS"):ENABLE()
			oSection3:Cell("QE7_UNIMED"):ENABLE()
			oSection3:Cell("QE7_NOMINA"):ENABLE()
			oSection3:Cell("QE7_LIE"):ENABLE()
			oSection3:Cell("QE7_LSE"):ENABLE()
			Else
			oSection3:Cell("QE8_DESENS"):DISABLE()
			oSection3:Cell("QE7_UNIMED"):ENABLE()
			oSection3:Cell("QE7_NOMINA"):ENABLE()
			oSection3:Cell("QE7_LIE"):ENABLE()
			oSection3:Cell("QE7_LSE"):ENABLE()
			Endif
				
			SAH->(dbSetOrder(1))
			SAH->(dbSeek(xFilial("SAH")+TRB->UNIMED))
			oSection3:Cell("QE7_UNIMED"):SetValue(SAH->AH_UMRES)
			oSection3:Cell("QE7_NOMINA"):SetValue(TRB->NOMINA)

			If TRB->MINMAX == "1"
				oSection3:Cell("QE7_LIE"):SetValue(TRB->LIE)
				oSection3:Cell("QE7_LSE"):SetValue(TRB->LSE)
			ElseIf TRB->MINMAX == "2"
				oSection3:Cell("QE7_LIE"):SetValue(TRB->LIE)
				oSection3:Cell("QE7_LSE"):SetValue(">>>")
			ElseIf TRB->MINMAX == "3"
				oSection3:Cell("QE7_LIE"):SetValue("<<<")
				oSection3:Cell("QE7_LSE"):SetValue(TRB->LSE)
			EndIf
			
		Else
			If oReport:nDevice == 4 .and. oReport:NEXCELPRINTTYPE == 3 //Impressão de Excel em formato de tabela
			//Ao usar o formato tabela, não podemos ocultar campos, trata-se de uma limitação deste formato.
			oSection3:Cell("QE7_UNIMED"):ENABLE()
			oSection3:Cell("QE7_NOMINA"):ENABLE()
			oSection3:Cell("QE7_LIE"):ENABLE()
			oSection3:Cell("QE7_LSE"):ENABLE()
			oSection3:Cell("QE8_DESENS"):ENABLE()
			oSection3:Cell("QE8_DESENS"):SetValue(TRB->TEXTO)
			Else
			oSection3:Cell("QE7_UNIMED"):DISABLE()
			oSection3:Cell("QE7_NOMINA"):DISABLE()
			oSection3:Cell("QE7_LIE"):DISABLE()
			oSection3:Cell("QE7_LSE"):DISABLE()
			oSection3:Cell("QE8_DESENS"):ENABLE()
			oSection3:Cell("QE8_DESENS"):SetValue(TRB->TEXTO)
			EndIf
				
		Endif
		
		If !Empty(NIVEL)
			oSection3:Cell("QE7_NIVEL"):SetValue(Substr(TABELA("Q6",NIVEL),1,10))
		Endif
		Do Case
			Case ( AM_INS == "1" )
				cAmIns := "AMO"
			Case ( AM_INS == "2" )
				cAmIns := "INS"
			Case ( AM_INS == "3" )
				cAmIns := "A/I"
		Endcase
		oSection3:Cell("AI"):SetValue(cAmIns) 
		oSection3:PrintLine()
        oSection3:Finish()
        
		cTexto := QA_RecTxt( QE1->QE1_CHAVE, "QIEA020 ")
	    If !Empty(cTexto)
		    oSection4:Init()
			oSection4:Cell("METODO"):SetValue(cTexto) 
			oSection4:PrintLine()
   	   		oSection4:Finish()
        EndIf
        
		dbSelectArea("TRB")
		dbSkip()
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o texto da Especificação 	  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lRet .And. !Empty(QE6->QE6_CHAVE)
		cTexto := QA_RecTxt( QE6->QE6_CHAVE, "QIEA010 ")
	    If !Empty(cTexto)
		    oSection5:Init()
			oSection5:Cell("TXTESP"):SetValue(cTexto) 
			oSection5:PrintLine()
   			oSection5:Finish()
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o texto do usuario ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lRet .And. File("QER230.TXT")	
	    oSection6:Init()
		cTexto:=MemoRead("QER230.TXT") 
		oSection6:Cell("TXTUSU"):SetValue(cTexto) 
		oSection6:PrintLine()
   		oSection6:Finish()
	EndIf

	cProdAtu := QE6->QE6_PRODUT
	dbSelectArea("QE6")
	While cProdAtu == QE6->QE6_PRODUT .And. !Eof()
		dbSkip()
	Enddo
	
EndDo

If !lImprimiu
	MsgStop(STR0020,STR0021) //"Nao foi encontrado nenhum produto para o intervalo digitado. Confira os codigos de produtos"###"Atencao"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga o arquivo de trabalho ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTempTable:Delete()
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³GeraTrab  ³ Autor ³ Fernando Godoy        ³ Data ³ 3/29/1999³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Gera o arquivo de trabalho                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1 - Produto                                             ³±±
±±³          ³ExpC2 - Revisao                                             ³±±
±±³          ³ExpC3 - Arquivo de Trabalho                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nil                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³QIER230                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FuncTion GeraTrab(cProd,cRevi)

// Limpa arquivo de trabalho para carregar os ensaios corretamente: DMANQUALI-2790
TRB->(__DbZap())

// Monta ensaios do Produto atual	
dbSelectArea("QE7")
dbSetOrder(1)
If dbSeek(xFilial("QE7")+cProd+cRevi)
	While !Eof() .And. xFilial("QE7") == QE7->QE7_FILIAL .And.;
		QE7->QE7_PRODUT+QE7->QE7_REVI == cProd+cRevi
		RecLock("TRB",.T.)
		Replace PRODUTO	With QE7->QE7_PRODUT
		Replace REVI   	With QE7->QE7_REVI
		Replace ENSAIO 	With QE7->QE7_ENSAIO
		Replace METODO 	With QE7->QE7_METODO
		Replace TIPO	With QE7->QE7_TIPO
		Replace UNIMED	With QE7->QE7_UNIMED
		Replace NOMINA	With QE7->QE7_NOMINA
		Replace LIE		With QE7->QE7_LIE
		Replace LSE		With QE7->QE7_LSE
		Replace NIVEL	With QE7->QE7_NIVEL
		Replace AM_INS 	With QE7->QE7_AM_INS
		Replace LABOR	With QE7->QE7_LABOR
		Replace SEQLAB	With QE7->QE7_SEQLAB
		Replace MINMAX  With QE7->QE7_MINMAX
		MsUnlock()

		dbSelectArea("QE7")
		dbSkip()
	EndDo
Endif

dbSelectArea("QE8")
dbSetOrder(1)
If dbSeek(xFilial("QE8")+cProd+cRevi)
	While !Eof() .And. xFilial("QE8") == QE8->QE8_FILIAL .And.;
		QE8->QE8_PRODUT+QE8->QE8_REVI == cProd+cRevi			
		RecLock("TRB",.T.)
		Replace PRODUTO	With QE8->QE8_PRODUT
		Replace REVI   	With QE8->QE8_REVI
		Replace ENSAIO 	With QE8->QE8_ENSAIO
		Replace METODO 	With QE8->QE8_METODO
		Replace TIPO		With QE8->QE8_TIPO
		Replace TEXTO 		With QE8->QE8_TEXTO
		Replace NIVEL	 	With QE8->QE8_NIVEL
		Replace AM_INS 	With QE8->QE8_AM_INS
		Replace LABOR	 	With QE8->QE8_LABOR
		Replace SEQLAB	 	With QE8->QE8_SEQLAB
		MsUnlock()
			
		dbSelectArea("QE8")
		dbSkip()
	Enddo
Endif

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³R230GetTxt³ Autor ³ Fernando Godoy        ³ Data ³ 3/30/1999³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Obtem o texto para impressao                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nil                                                         ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpC1 - String com o Texto                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³Dialog de parametrizacao                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R230GetTxt()
Local oDlgGet2
Local lEdit 	:= .T.
Local oTexto
Local cTexto 	:= ""
Local cGet		:= STR0022 //"Digite o texto abaixo"
Local oMonoAs	:= TFont():New("Courier New",6,0)
Local cNomeArq := "X"
Local lRet		:= .T.
Local lOk		:= .F.           
Local oGet

nHdl:=MSFCREATE(cNomeArq,0)

If nHdl <= -1
	HELP(" ",1,"NODIRCQ")
	lRet := .F.
Else
	If File(cNomeArq)
		FCLOSE(nHdl)
		FERASE(cNomeArq)
	Endif
Endif

If lRet
	cNomeArq := "QER230.TXT"
	
	cTexto := MemoRead(cNomeArq)
	
	DEFINE MSDIALOG oDlgGet2 FROM	62,100 TO 345,610 TITLE STR0023 PIXEL OF GetWndDefault() //"Texto da ficha de produtos"
		@ 003, 004 TO 027, 250 LABEL "" 	OF oDlgGet2 PIXEL
		@ 040, 004 TO 110, 250				OF oDlgGet2 PIXEL
		
		@ 013, 010 MSGET oGet VAR cGet SIZE 235, 010 OF oDlgGet2 PIXEL
		oGet:lReadOnly := .t.
		@ 050, 010 GET oTexto VAR cTexto MEMO NO VSCROLL WHEN lEdit SIZE 235, 051 OF oDlgGet2 PIXEL
		
		oTexto:oFont := oMonoAs
		
		DEFINE SBUTTON FROM 120,190 TYPE 1 ACTION (lOk := .T.,oDlgGet2:End()) ENABLE OF oDlgGet2
		DEFINE SBUTTON FROM 120,220 TYPE 2 ACTION (lOk := .F.,oDlgGet2:End()) ENABLE OF oDlgGet2
	
	ACTIVATE MSDIALOG oDlgGet2 CENTERED
	
	If lOk
		MemoWrit( cNomeArq,cTexto )
	EndIf
Endif

Release Font oMonoAs

Return cTexto

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QER230TextºAutor  ³Cleber Souza        º Data ³  08/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de pesquisa do texto da conferencia.                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER230                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QER230Text(cTexto)

Local oDlg
Local lRet

DEFINE MSDIALOG oDlg TITLE GetMv("MV_QEFICHP")+STR0003 FROM  165,115 TO 300,525 PIXEL OF oMainWnd //"Ficha de produtos - conferencia"

	@ 03, 10 TO 43, 195 LABEL "" OF oDlg  PIXEL
	@ 10, 15 SAY STR0019 SIZE 180, 8 OF oDlg PIXEL //"Clique em parametros para digitar o texto da ficha de produtos"
	DEFINE SBUTTON FROM 50, 112 TYPE 5 ACTION cTexto := U_R230GetTxt() ENABLE OF oDlg
	DEFINE SBUTTON FROM 50, 141 TYPE 1 ACTION (lRet:=.T.,oDlg:End()) ENABLE OF oDlg
	DEFINE SBUTTON FROM 50, 170 TYPE 2 ACTION (lRet:=.F.,oDlg:End()) ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg
                    
Return lRet
