/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIER190.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

#DEFINE ESPACO_DISPONIVEL 30

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QIER190   ºAutor  ³Telso Carneiro      º Data ³  19/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Referencia Cruzada : NC x Produto 	      				  º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function QIER190()
Local oReport	
        
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("QER190",.F.)
oReport := ReportDef()
oReport:PrintDialog()		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QEK")
Set Filter to
RetIndex("QEK")
dbSetOrder(1)
	
Return     

Static Function ReportDef()
Local wnrel	   	:= "QIER190"
Local cDesc1   	:= OemToAnSi(STR0001)	//"Ser„o relacionadas as Nao Conformidades associadas a cada Produto"
Local cTitulo  	:= OemToAnSi(STR0002)	//"Referencia Cruzada : NC x Produto"
Local cPerg  	:= "QER190"
Local oReport
Local oSection1		 
Local oBreak1 
Local oBreak2
Local nTamForn	:=TamSX3("QEK_FORNEC")[1]+TamSX3("QEK_LOJFOR")[1]
Local nTamProd	:=TamSX3("QEK_PRODUT")[1]+30
Local nTamDten	:=TamSX3("QEK_DTENTR")[1]
Local nTamLote	:=TamSX3("QEK_LOTE")[1]
Local nTamEnsa	:=TamSX3("QER_ENSAIO")[1]
Local nTamDtMe	:=TamSX3("QER_DTMEDI")[1]
Local nTamNaoC	:=TamSX3("QEU_NAOCON")[1]
Local nTamHRme	:=TamSX3("QER_HRMEDI")[1]
Local nTamNumc	:=TamSX3("QEU_NUMNC")[1]
Local nTamDemi	:=TamSX3("QEU_DEMIQI")[1]
		
DEFINE REPORT oReport NAME wnrel TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1)

DEFINE SECTION oSection1 OF oReport TITLE TitSX3("QEK_FORNEC")[1] TABLES "TRB","QEK","QEU"

DEFINE CELL NAME "TRB_FORNEC"      OF oSection1 ALIAS "TRB" TITLE TitSX3("QEK_FORNEC")[1] 	SIZE nTamForn
DEFINE CELL NAME "TRB_PRODUT"      OF oSection1 ALIAS "TRB" TITLE TitSX3("QEK_PRODUT")[1] 	SIZE nTamProd  LINE BREAK
DEFINE CELL NAME "TRB_DTENTR"      OF oSection1 ALIAS "TRB" TITLE Left(TitSX3("QEK_DTENTR")[1],nTamDten) SIZE nTamDten
DEFINE CELL NAME "TRB_LOTE"        OF oSection1 ALIAS "TRB" TITLE TitSX3("QEK_LOTE")[1] 	SIZE nTamLote
DEFINE CELL NAME "TRB_ENSAIO"      OF oSection1 ALIAS "TRB" TITLE TitSX3("QER_ENSAIO")[1] 	SIZE nTamEnsa
DEFINE CELL NAME "TRB_NAOCON"      OF oSection1 ALIAS "TRB" TITLE Left(TitSX3("QEU_NAOCON")[1],nTamNaoC) SIZE nTamNaoC
DEFINE CELL NAME "TRB_DTMEDI"      OF oSection1 ALIAS "TRB" TITLE TitSX3("QER_DTMEDI")[1]  SIZE nTamDtMe
DEFINE CELL NAME "TRB_HRMEDI"      OF oSection1 ALIAS "TRB" TITLE Left(TitSX3("QER_HRMEDI")[1],5)  		SIZE nTamHRme
DEFINE CELL NAME "TRB_NUMNC"       OF oSection1 ALIAS "TRB" TITLE TitSX3("QEU_NUMNC")[1] SIZE nTamNumC Picture "99999
DEFINE CELL NAME "TRB_DEMIQI"      OF oSection1 ALIAS "TRB" TITLE Left(TitSX3("QEU_DEMIQI")[1],12)		SIZE nTamDemi 

DEFINE BREAK oBreak1 OF oSection1 WHEN {|| TRB_FORNEC+TRB_LOJFOR+TRB_PRODUT+IF(VALTYPE(TRB_DTENTR)=="D",DTOS(TRB_DTENTR),TRB_DTENTR)+TRB_LOTE }  TITLE OemToAnsi(STR0013) //"Total de Ncs"
//DEFINE BREAK oBreak2 OF oSection1 WHEN {|| TRB_PRODUT }  TITLE TitSX3("QEK_PRODUT")[1]+"-"+OemToAnsi(STR0013) //"Total de Ncs"

DEFINE FUNCTION oFunc FROM oSection1:Cell("TRB_NUMNC") ;
					OF oSection1 FUNCTION SUM BREAK oBreak1 TITLE OemToAnsi(STR0013)  NO END SECTION //"Total de Ncs"

//DEFINE FUNCTION oFunc FROM oSection1:Cell("TRB_NUMNC") ;
//					OF oSection1 FUNCTION SUM BREAK oBreak2 TITLE TitSX3("QEK_PRODUT")[1]+"-"+OemToAnsi(STR0013)  NO END SECTION //"Total de Ncs"

Return(oReport)

Static Function PrintReport(oReport)
Local cKey   	:= ""
Local cChave 	:= ""
Local aCampos	:= {}	
Local aTam
Local oTempTable	:= NIL
Local cCondAux 	:= " "
Local oQEK 	 	:= oReport:Section(1)
Local cFornec 	:= ""
Local cLojFor 	:= ""
Local cProdut 	:= ""
Local cDtEntr 	:= ""
Local cLote   	:= ""
Local cStrUsado := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona em outros arquivos                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QEL")
dbSetOrder(1)
dbSelectArea("SA2")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta expressao para filtrar as Entradas					 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par07 == 1     
	cCondAux := '.And. (QEK_TIPONF == "N" .Or. QEK_TIPONF == " ")'
ElseIf mv_par07 == 2
	cCondAux := '.And. QEK_TIPONF == "B"'
ElseIf mv_par07 == 3
	cCondAux := '.And. QEK_TIPONF == "D"'
EndIf                                  
//

dbSelectArea("QEK")
cKey  := IndexKey()
cCond := 'QEK_FILIAL == "'+xFilial("QEK")+'"'+cCondAux
cCond += '.And. Dtos(QEK_DTENTR) >= "'+Dtos(mv_par01)+'".And. Dtos(QEK_DTENTR)<="'+Dtos(mv_par02)+'"'
cCond += '.And. QEK_PRODUT >= "'+mv_par03+'".And. QEK_PRODUT <="'+mv_par04+'"'
cCond += '.And. QEK_REVI   >= "'+mv_par05+'".And. QEK_REVI   <="'+mv_par06+'"' 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Realiza os filtros de usuario                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QEK")))
	cCond += '.And. QEK->('+oReport:Section(1):GetAdvplExp("QEK")+')'
EndIf

cNomArq := CriaTrab(NIL,.F.)
IndRegua("QEK",cNomArq,cKey,,cCond,STR0007)		//"Selecionando Registros..."
nIndex := RetIndex("QEK")
dbSetOrder(nIndex+1)
dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Arquivo de Trabalho.                          			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("QEK_FORNEC")
AADD(aCampos,{"TRB_FORNEC",	"C",aTam[1],aTam[2]	})
aTam:=TamSX3("QEK_LOJFOR")
AADD(aCampos,{"TRB_LOJFOR",	"C",aTam[1],aTam[2]	})
aTam:=TamSX3("QEK_PRODUT")
AADD(aCampos,{"TRB_PRODUT",	"C",aTam[1],aTam[2]  })
aTam:=TamSX3("QEK_REVI")
AADD(aCampos,{"TRB_REVI",	"C",aTam[1],aTam[2]	})
aTam:=TamSX3("QEK_DTENTR")
AADD(aCampos,{"TRB_DTENTR", "D",aTam[1],aTam[2]  })
aTam:=TamSX3("QEK_LOTE")
AADD(aCampos,{"TRB_LOTE",	"C",aTam[1],aTam[2]	})
aTam:=TamSX3("QER_ENSAIO")
AADD(aCampos,{"TRB_ENSAIO",	"C",aTam[1],aTam[2]	})
aTam:=TamSX3("QEU_NAOCON")
AADD(aCampos,{"TRB_NAOCON",	"C",aTam[1],aTam[2]	})
aTam:=TamSX3("QER_DTMEDI")
AADD(aCampos,{"TRB_DTMEDI",	"D",aTam[1],aTam[2]	})
aTam:=TamSX3("QER_HRMEDI")
AADD(aCampos,{"TRB_HRMEDI",	"C",aTam[1],aTam[2]	})
aTam:=TamSX3("QEU_NUMNC")
AADD(aCampos,{"TRB_NUMNC",	"N",aTam[1],aTam[2]	})
aTam:=TamSX3("QEU_DEMIQI")
AADD(aCampos,{"TRB_DEMIQI",	"C",aTam[1],aTam[2]	})
	
oTempTable := FWTemporaryTable():New( "TRB" )
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("indice1", {"TRB_FORNEC","TRB_LOJFOR","TRB_PRODUT","TRB_REVI"} )
oTempTable:Create()

While !QEK->(Eof())

	dbSelectArea("QER")
	dbSetOrder(1)
	dbSeek(xFilial("QER")+QEK->QEK_PRODUT+QEK->QEK_REVI+QEK->QEK_FORNEC+;
			QEK->QEK_LOJFOR+Dtos(QEK->QEK_DTENTR)+QEK->QEK_LOTE)
			
	While !QER->(Eof()) .And. QER->QER_FILIAL == xFilial("QER") .And.;
		QER->QER_PRODUT+QER->QER_REVI+QER->QER_FORNEC+QER->QER_LOJFOR+;
		Dtos(QER->QER_DTENTR)+QER->QER_LOTE == QEK->QEK_PRODUT+QEK->QEK_REVI+;
		QEK->QEK_FORNEC+QEK->QEK_LOJFOR+Dtos(QEK->QEK_DTENTR)+QEK->QEK_LOTE
		
		If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QER")))
			If !QER->(&(oReport:Section(1):GetAdvplExp("QER")))
				QER->(dbSkip())
				Loop
			Endif
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Chave de ligacao com o QEU - Nao Conformidade das Entradas   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cChave := QER->QER_CHAVE
		
		dbSelectArea("QEU")	
		QEU->(dbSetOrder(1))
		If dbSeek(xFilial("QEU")+cChave)
		
			While !Eof() .And. xFilial("QEU") == QEU_FILIAL .And. ;
				cChave == QEU_CODMED

				If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QEU")))
					If !QEU->(&(oReport:Section(1):GetAdvplExp("QEU")))
						QEU->(DbSkip())
						loop
					Endif
				Endif				
			
				RecLock("TRB",.T.)
				Replace TRB_FORNEC		With QEK->QEK_FORNEC
				Replace TRB_LOJFOR		With QEK->QEK_LOJFOR
				Replace TRB_PRODUT		With QEK->QEK_PRODUT
				Replace TRB_REVI			With QEK->QEK_REVI
				Replace TRB_DTENTR		With QEK->QEK_DTENTR
				Replace TRB_LOTE			With QEK->QEK_LOTE
				Replace TRB_ENSAIO		With QER->QER_ENSAIO
				Replace TRB_NAOCON		With QEU->QEU_NAOCON
				Replace TRB_DTMEDI		With QER->QER_DTMEDI
				Replace TRB_HRMEDI		With QER->QER_HRMEDI
				Replace TRB_NUMNC			With QEU->QEU_NUMNC
				Replace TRB_DEMIQI		With QEU->QEU_DEMIQI
				MsUnLock()
				dbSelectArea("QEU")
				DbSkip()
				
			EndDo
		EndIf
		
		QER->(dbSkip())
	EndDo
	QEK->(dbSkip())
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QEK")
Set Filter to
RetIndex("QEK")
Ferase(cNomArq+OrdBagExt())
dbSetOrder(1)

dbSelectArea("TRB")
dbGoTop()

oReport:SetMeter(TRB->(RecCount()))

oQEK:Init()
While !EOF()

	oReport:IncMeter()	
	
	If oReport:Cancel()
		Exit
	EndIf		

	If cFornec		  # TRB_FORNEC .Or.;
		cLojFor	 	  # TRB_LOJFOR .Or.;
		cProdut	 	  # TRB_PRODUT .Or.;
		(IF(ValType(cDtEntr)=="D",Dtos(cDtEntr),cDtEntr)) #(IF(ValType(TRB_DTENTR)=="D",Dtos(TRB_DTENTR),TRB_DTENTR)) .Or.;
		cLote   	  #  TRB_LOTE

		oQEK:Cell("TRB_FORNEC"):Show()
		oQEK:Cell("TRB_PRODUT"):Show()
		oQEK:Cell("TRB_DTENTR"):Show()
		oQEK:Cell("TRB_LOTE"):Show()	                           

		cFornec := TRB_FORNEC
		cLojFor := TRB_LOJFOR
		cProdut := TRB_PRODUT
		cDtEntr := TRB_DTENTR
		cLote   := TRB_LOTE	        
	Else
		oQEK:Cell("TRB_FORNEC"):Hide()
		oQEK:Cell("TRB_PRODUT"):Hide()
		oQEK:Cell("TRB_DTENTR"):Hide()
		oQEK:Cell("TRB_LOTE"):Hide()	                           	
    Endif                         

   	QE6->(dbSetOrder(1))
	QE6->(dbSeek(xFilial("QE6")+TRB->TRB_PRODUT))
	cStrUsado :=QE6->QE6_DESCPO 
	
	oQEK:Cell("TRB_FORNEC"):SetValue(TRB_FORNEC+"/"+TRB_LOJFOR)//Fornecedor-Loja
	oQEK:Cell("TRB_PRODUT"):SetValue(TRB_PRODUT+cStrUsado)	//Produto
	oQEK:Cell("TRB_DTENTR"):SetValue(TRB_DTENTR)	//Dtentr
	oQEK:Cell("TRB_LOTE"):SetValue(TRB_LOTE)		//Lote
	oQEK:Cell("TRB_ENSAIO"):SetValue(TRB_ENSAIO)	
	oQEK:Cell("TRB_DTMEDI"):SetValue(TRB_DTMEDI )	
	oQEK:Cell("TRB_HRMEDI"):SetValue(TRB_HRMEDI)	
		
	oQEK:Cell("TRB_NAOCON"):SetValue(TRB_NAOCON)		//N.Conf.
	oQEK:Cell("TRB_NUMNC"):SetValue(TRB_NUMNC)		     //N.NCs.
	oQEK:Cell("TRB_DEMIQI"):SetValue(IF(TRB_DEMIQI=="S",STR0011,STR0012))	//"Sim"###"Nao"
	oQEK:PrintLine()
	
	TRB->(dbSkip())
EndDo
oQEK:Finish()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indice e o arquivo de trabalho                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTempTable:Delete()	

Return(NIL)
