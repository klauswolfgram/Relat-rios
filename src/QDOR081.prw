/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QDOR081.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QDOR081   ºAutor  ³Leandro Sabino      º Data ³  26/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao de listagem para Convocacao de Treinamento       º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QDOR081(lTreina)
	Local oReport := ReportDef(lTreina)

	Pergunte("QDR081",.F.)
    oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 13/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR020                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(lTreina)
Local cTitulo	:= OemToAnsi(STR0001) // "CONVOCACAO DE TREINAMENTO"
Local cDesc1 	:= OemToAnsi(STR0002) // "Este programa ira imprimir a convocacao de treinamento "
Local cDesc2 	:= OemToAnsi(STR0003) // "para todos os participantes selecionados, listando o local"
Local cDesc3 	:= OemToAnsi(STR0004) // "a data e o documento do treinamento."Local wnrel  := "QDOR020"
Local oSection1 
Local oSection2 
Local oSection3 

DEFINE REPORT oReport NAME "QDOR081" TITLE cTitulo PARAMETER "QDR081" ACTION {|oReport| PrintReport(oReport,lTreina)} DESCRIPTION (cDesc1+cDesc2+cDesc3)

DEFINE SECTION oSection1 OF oReport TABLES "QD8" TITLE OemToAnsi(STR0019)         
DEFINE CELL NAME "cAdm"   OF oSection1 ALIAS "QD8" TITLE TitSX3("QAA_NOME")[1]	SIZE 40 //BLOCK {||QA_NUSR((cAlias)->QD8_FILMAT,(cAlias)->QD8_MAT,.t.) }
DEFINE CELL NAME "cCargo" OF oSection1 ALIAS "QD8" TITLE OemToAnsi(STR0017)   	SIZE 20 //BLOCK {||QA_NFUNC((cAlias)->QD8_CARGO,.T.,cFilFunc) }
DEFINE CELL NAME "cSetor" OF oSection1 ALIAS "QD8" TITLE OemToAnsi(STR0018)  	SIZE 15 //BLOCK {||QA_NDEPT((cAlias)->QD8_DEPTO,.t.,(cAlias)->QD8_FILMAT)}
                                                          
DEFINE SECTION oSection2 OF oSection1 TABLES "QDA" TITLE OemToAnsi(STR0020)
DEFINE CELL NAME "cCONVOC" OF oSection2 ALIAS "QDA" TITLE OemToAnsi(STR0022) SIZE 120 BLOCK {||MSMM(QDA->QDA_CONVOC)} // "Descricao da Convocacao"
oSection2:Cell("cCONVOC"):SeTLineBREAK(.T.)

DEFINE SECTION oSection3 OF oSection2 TABLES "QDA","QDH" TITLE OemToAnsi(STR0021) // "Treinamento"
DEFINE CELL NAME "QDA_DOCTO"  OF oSection3 ALIAS "QDA"
DEFINE CELL NAME "QDA_RV"     OF oSection3 ALIAS "QDA"
DEFINE CELL NAME "QDH_TITULO" OF oSection3 ALIAS "QDH"
			
Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 26/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR020                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport,lTreina) 
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(1):Section(1):Section(1)
Local lAchouQda := .T.
Local aUsrMat  	:= QA_USUARIO()
Local cMatDep  	:= aUsrMat[4]
Local cMatFil  	:= aUsrMat[2]
Local cFilFunc 	:= xFilial("QAC")
Local cAlias	:= "QD8"
Local cOrder := ""

dbSelectArea("QDH")
dbSetOrder(1)

dbSelectArea("QDA")
dbSetOrder(1)

dbSelectArea("QD8")
dbSetOrder(1)

MakeSqlExpr(oReport:uParam)
oSection1:BeginQuery()

If	Upper(TcGetDb()) $ 'ORACLE'                          
  	 cORDER += "%1,2,3,4,5,6,7%"
Else
	 cORDER += "%QD8_FILIAL,QD8_ANO,QD8_NUMERO,QD8_FILMAT,QD8_DEPTO,QD8_CARGO,QD8_MAT%"
   	Endif

cAlias := GetNextAlias()

BeginSQL Alias cAlias

	SELECT QD8.QD8_FILIAL,QD8.QD8_ANO,QD8.QD8_NUMERO,QD8.QD8_FILMAT,QD8.QD8_DEPTO,QD8.QD8_CARGO,QD8.QD8_MAT,QD8.QD8_SELECA

	FROM %table:QD8% QD8

	WHERE	QD8_FILIAL = %xFilial:QD8% And 	
		    QD8_NUMERO >= %Exp:mv_par01% And QD8_NUMERO <= %Exp:mv_par02% And
		    QD8_ANO >= %Exp:mv_par03% And QD8_ANO <= %Exp:mv_par04% and 
 		    QD8.%notDel%
 		    
	ORDER BY %Exp:cOrder%
	
    EndSql
    
oSection1:EndQuery()
                      
While !oReport:Cancel() .And. (cAlias)->(!Eof())
	
	If QAA->(dbSeek((cAlias)->QD8_FILMAT+(cAlias)->QD8_MAT))	 
		If 	!lTreina .And. QAA->QAA_STATUS == '1' .AND. Empty(QAA->QAA_FIM)
			If QDA->(DbSeek(xFilial("QD8")+(cAlias)->QD8_ANO+(cAlias)->QD8_NUMERO))
				If QDA->QDA_DOCTO >= mv_par05 .And. QDA->QDA_DOCTO <= mv_par07 .And. QDA->QDA_RV >= mv_par06 .And.QDA->QDA_RV <= mv_par08
					lAchouQda := .T.
	
					If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QDA")))
						If !QDA->(&(oReport:Section(1):GetAdvplExp("QDA")))
							lAchouQda := .F.
						Endif
					Endif
				Else
					lAchouQda := .F.
				Endif
			Else
				lAchouQda := .F.
			Endif
		Endif
	
	   	If (cAlias)->QD8_SELECA == "S" .And. lAchouQda
	      	oSection1:Init()
			oSection1:Cell("cAdm"):SetValue({||QA_NUSR((cAlias)->QD8_FILMAT,(cAlias)->QD8_MAT,.t.)})
			oSection1:Cell("cCargo"):SetValue({||QA_NFUNC((cAlias)->QD8_CARGO,.T.,cFilFunc)})
			oSection1:Cell("cSetor"):SetValue({||QA_NDEPT((cAlias)->QD8_DEPTO,.t.,(cAlias)->QD8_FILMAT)})
	      	oSection1:PrintLine()
	   	
	      	oSection2:Init()
	      	oSection2:PrintLine()
	
			oReport:SkipLine(1)	      	
			
		  	If QDH->(DbSeek(xFilial("QDH")+QDA->QDA_DOCTO+QDA->QDA_RV))
	    	  	oSection3:Init()
		      	oSection3:PrintLine()
		  	EndIf
	
			oReport:SkipLine(1) 
			oReport:ThinLine()
			oReport:PrintText(OemToAnsi(STR0008)+Space(1)+QDA->QDA_NUMERO+"/"+QDA->QDA_ANO,oReport:Row(),025) // "TREINAMENTO:"
			oReport:SkipLine(1)	
			
			oReport:PrintText(OemToAnsi(STR0012)+Space(1)+DtoC(QDA->QDA_DTINIC)+" "+(Substr(QDA->QDA_HORAI,1,2)+":"+Substr(QDA->QDA_HORAI,3,2))+" "+OemToAnsi(STR0013)+" "+DTOC(QDA->QDA_DTFIM)+" "+(Substr(QDA->QDA_HORAF,1,2)+":"+Substr(QDA->QDA_HORAF,3,2)),oReport:Row(),025) // "PERIODO DE:" ### "A"
			oReport:SkipLine(1)	
			
			oReport:PrintText(OemToAnsi(STR0011)+Space(1)+QDA->QDA_LOCAL,oReport:Row(),025)  // "LOCAL:"
			oReport:SkipLine(1)	
			
			oReport:PrintText(OemToAnsi(STR0014)+Space(1)+QA_nDept(cMatDep,.t.,cMatFil),oReport:Row(),025)  // "DEPTO EMISSOR:"
			oReport:SkipLine(1)	
	
	      	If !Empty(QDA->QDA_OBS)
				oReport:PrintText(OemToAnsi(STR0015)+Space(1)+AllTrim(QDA->QDA_OBS),oReport:Row(),025) // "OBSERVACAO:"
				oReport:SkipLine(1)	
			EndIf
	
			oReport:ThinLine()
			oReport:SkipLine(1)	
	
	 	EndIf
	
	   	oSection1:SetPageBreak(.T.) 
   	EndIf
   	
   	(cAlias)->(DbSkip())
   	
   	oSection1:Finish()
	oSection2:Finish()
	oSection3:Finish()
   
EndDo

Return NIL

