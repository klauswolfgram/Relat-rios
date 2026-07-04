/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIER300.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TOTVS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QIER300  ³ Autor ³ Cicero Odilio Cruz    ³ Data ³04/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Indices Acumulados por Fornecedor - Total		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_QIER300(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Siga Quality - Celerina                            		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³ 			                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                          
User Function QIER300()
Local   oReport	    := Nil

Private cDir 		:= GetMv("MV_QDIRGRA")
Private cAliasQEV   := 'QEV'
Private cAliasQEW   := 'QEW'
Private cPerg 		:= "QER300"                    
Private lExistChart := FindFunction("QIEMGRAFIC") .AND. GetBuild() >= "7.00.170117A" //controle se executa o grafico modelo novo ou por DLL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01 = Do Fornecedor        							 ³
//³ mv_par02 = Ate o Fornecedor       							 ³
//³ mv_par03 = Do Ano    										 ³
//³ mv_par04 = Do Mes    										 ³
//³ mv_par05 = Idioma 1 = Portugues								 ³
//³                   2 = Ingles	                             ³
//³                   3 = Espanhol	                             ³
//³ mv_par06 = Imprime Grafico									 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se o diretorio do grafico e um  diretorio Local ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par06 == 1
	If !QA_VerQDir(cDir)  
		Return
	Endif
EndIf  

oReport := ReportDef()
oReport:PrintDialog()

Return   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³ Cicero Cruz        º Data ³  04/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicoes do relatorio de Formulas R4.		              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER300                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()

Local cPrograma  :='QIER300'
Local cTitulo  := OemToAnsi(STR0001) //"Fornecedor - Total"
Local cDesc1   := OemToAnsi(STR0002) //"Emissao dos Indices Acumulados por Mes"
Local cDesc2   := OemToAnsi(STR0003) //"Ira imprimir os Indices Acumulados por Fornecedor, de acordo"
Local cDesc3   := OemToAnsi(STR0004) //"com a configuracao do usuario."

DEFINE REPORT oReport NAME cPrograma TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2+cDesc3) LANDSCAPE

DEFINE SECTION oSection1 OF oReport LINE STYLE TITLE  If(mv_par05==1,"Fornecedor",If(mv_par05==2,"Supplier","Proveedor")) 

DEFINE CELL NAME "L1" OF oSection1 	SIZE  50 TITLE  If(mv_par05==1,"Fornecedor",If(mv_par05==2,"Supplier","Proveedor"))   CELL BREAK
DEFINE CELL NAME "L2" OF oSection1 	SIZE  20 TITLE  If(mv_par05==1,"Mes/Ano",If(mv_par05==2,"Month/Year","Mes/A¤o"))
DEFINE SECTION oSection2 OF oReport TITLE If(mv_par05==1,"Mes/Ano",If(mv_par05==2,"Month/Year","Mes/A¤o"))

DEFINE CELL oC1 NAME "C1" OF oSection2 	SIZE  50 TITLE  If(mv_par05==1,"Mes/Ano",If(mv_par05==2,"Month/Year","Mes/A¤o")) AUTO SIZE
DEFINE CELL oC2 NAME "C2" OF oSection2 	SIZE  10 TITLE  "V1" 		   	AUTO SIZE ALIGN RIGHT
DEFINE CELL oC3 NAME "C3" OF oSection2 	SIZE  10 TITLE  "V2" 			AUTO SIZE
DEFINE CELL oC4 NAME "C4" OF oSection2 	SIZE  10 TITLE  "V3" 			AUTO SIZE
DEFINE CELL oC5 NAME "C5" OF oSection2 	SIZE  10 TITLE  "V4" 			AUTO SIZE
DEFINE CELL oC6 NAME "C6" OF oSection2 	SIZE  10 TITLE  "V5" 			AUTO SIZE
DEFINE CELL oC7 NAME "C7" OF oSection2 	SIZE  10 TITLE  "V6" 	 		AUTO SIZE
DEFINE CELL oC8 NAME "C8" OF oSection2 	SIZE  10 TITLE  STR0022         AUTO SIZE ALIGN RIGHT // "TOTAL/MEDIA"

DEFINE CELL HEADER BORDER OF oSection2 EDGE_ALL WEIGHT 1   
DEFINE CELL        BORDER OF oSection2 EDGE_ALL WEIGHT 1

DEFINE BREAK oBreak1 OF oSection1 WHEN {|| &(cAliasQEV+"->QEV_FORNEC") } // TITLE OemToAnsi(STR0024) //"Sub-Total: "
oBreak1:SetPageBreak(.T.)
oSection1:SetEdit(.F.)
oSection2:SetEdit(.F.)
              
Return oReport 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PrintReport ºAutor  ³ Cicero Cruz	    º Data ³  31/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao relatorio R4.                                       º±±
±±º          ³                                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER300                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)
Local aAnoMes    := {}
Local aDadosInd  := {}   
Local aDescricao := {}
Local aDetalhe   := {}
Local aFatIQP    := {}
Local aTotMed    := {}
Local cAnoFim    := ''
Local cAnoIni    := ''
Local cArqBMP    := ''
Local cArqPNG    := ""
Local cArqSPC    := ''
Local cCategoria := ''
Local cDescForn  := ''
Local cDesFat    := ''
Local cFornece   := ''
Local cImgGraf   := ""
Local cMesFim    := ''
Local cMesIni    := ''
Local lImpGraf   := .F.
Local lImprime   := .F.
Local lQuebraPag := .F.
Local nC         := 0
Local nColuna    := 0
Local nIni       := 0
Local nMesAcu    := IIf(GetNewPar("MV_QMESACU",6)>0,GetNewPar("MV_QMESACU",6),6) //Obtem o numero de meses para o calculo do acumulado
Local nPos       := 0
Local nW         := 0
Local nX         := 0
Local nY         := 0
Local oQIEXFunAx := NIL
Local oQLGrafico := GraficosQualidadeX():New()
Local oSection1  := oReport:Section(1)  
Local oSection2  := oReport:Section(2)  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Colunas utilizadas no Relatorio								 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd(aDescricao,STR0007) //"Entregas no Periodo                "
Aadd(aDescricao,STR0008) //"No. Entregas demeritadas no Periodo"
Aadd(aDescricao,STR0009) //"No. Entregas Inspecionadas         " 
Aadd(aDescricao,STR0010) //"No. Entregas em Skip-Lote          "
Aadd(aDescricao,STR0011) //"Qtde. Inspecionada                 "
Aadd(aDescricao,STR0012) //"Qtde. em Skip-Lote                 "
Aadd(aDescricao,STR0013) //"Qtde. Rejeitada                    "
Aadd(aDescricao,STR0014) //"Resultados das Entregas (IQP)      "
Aadd(aDescricao,STR0015) //"Fator de Criticidade               "
Aadd(aDescricao,STR0016) //"Sistema da Qualidade (IQS)         "
Aadd(aDescricao,STR0017) //"Indice de Qualidade do Item (IQI)  "
Aadd(aDescricao,STR0018) //"Pontualidade (IPO)                 "
Aadd(aDescricao,STR0019) //"PPM                                "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retroage (n meses) para a Impressao do Relatorio			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAnoMes := QER300AnoMes(mv_par03,mv_par04,nMesAcu)
cAnoIni := aAnoMes[1] 
cMesIni := aAnoMes[2]
cAnoFim := aAnoMes[3]
cMesFim := aAnoMes[4]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Preenche os Fatores do IQP no Array aFatIQP          		 ³
//³ [x,1] = Codigo do Fator                             		 ³
//³ [x,2] = Descricao do Fator (PORT/ING/ESP)            		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QED")
dbSetOrder(1)
DBSeek(xFilial("QED"))
While !Eof() .And. xFilial("QED") == QED_FILIAL
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Nao considera laudo com categoria Liberado Urgente no relato-³
	//³ rio porque na geracao, ja considerou como Aprovado Total.    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If QED_CATEG <> "4"                 
		cDesFat := If(mv_par05==1,QED->QED_DESCPO,;
				If(mv_par05==2,QED->QED_DESCIN,QED->QED_DESCES))
    	Aadd(aFatIQP,{QED_CODFAT,cDesFat,0,SuperVal(QED_FATOR)})
	EndIf
	dbSkip()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se o fatores de IQP estao definidos				 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
If Len(aFatIQP) == 0
	Help(" ",1,"QENAOIQP")	//Nao existem fatores do IQP cadastrados
	Return(NIL)
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:BeginQuery()	

cChave := "% QEV_FILIAL,QEV_FORNEC,QEV_ANO,QEV_MES %"

cAliasQEV := GetNextAlias()

BeginSql Alias cAliasQEV

SELECT *
 	FROM %table:QEV% QEV 	
	WHERE QEV.QEV_FILIAL  = %xFilial:QEV% AND 
		  QEV.QEV_FORNEC BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
	      (QEV.QEV_ANO || QEV.QEV_MES) BETWEEN %Exp:(cAnoIni+cMesIni)% AND %Exp:(cAnoFim+cMesFim)% AND         
	      QEV.QEV_LOTENT > 0 AND
	      QEV.%notDel%  		 
	ORDER BY %Exp:cChave%  
 			
EndSql   
oSection1:EndQuery() 

cAliasQEW := GetNextAlias() 

BeginSql Alias cAliasQEW

SELECT *
 	FROM %table:QEW% QEW 	
	WHERE QEW.QEW_FILIAL = %xFilial:QEW% AND 
		  QEW.QEW_FORNEC BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
	      (QEW.QEW_ANO || QEW.QEW_MES) BETWEEN %Exp:(cAnoIni+cMesIni)% AND %Exp:(cAnoFim+cMesFim)% AND         
	      QEW.%notDel%  		 
	ORDER BY %Order:QEW%  
 			
EndSql			


While (cAliasQEV)->(!Eof())
	
	aDadosInd := {{},{}}
	aTotMed   := Afill(Array(Len(aFatIQP)+13),0)
	
	//Inicia os Totalizadores das Medias
	nMedIQP    := 0
	nMedIQI    := 0
	nMedIPO    := 0
	nSomAcu    := 0
	nQtdRejAcu := 0
	lImprime   := .F. //indica se o Relatorio sera impresso
	
	cFornece   := &(cAliasQEV+"->QEV_FORNEC")
	cCategoria := " "

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calculo do IQS                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SA2->(dbSetOrder(1))
	SA2->(DBSeek(xFilial("SA2")+cFornece))
	cDescForn  := SA2->A2_NOME
	If SA2->A2_FATAVA==0 .And. Empty(SA2->A2_DTAVA)
		nIQS := 999.99
	Else
		nIQS := SA2->A2_FATAVA
	EndIf     
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra os Indices Acumulados por Fornecedor					 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While &(cAliasQEV+"->QEV_FORNEC") == cFornece .And. !&(cAliasQEV)->(Eof())
		
		Aadd(aDadosInd[1],&(cAliasQEV+"->QEV_ANO")+&(cAliasQEV+"->QEV_MES"))
		Aadd(aDadosInd[2],Afill(Array(Len(aFatIQP)+13),0))
		
		//Filtra os Indices Acumulados por Fornecedor+Mes+Ano
		cAno := &(cAliasQEV+"->QEV_ANO")
		cMes := &(cAliasQEV+"->QEV_MES")

		dbSelectArea(cAliasQEW)
		DBGotop()
		While &(cAliasQEW)->(!Eof()) 
			If 	&(cAliasQEW+"->QEW_FORNEC") == cFornece .And. &(cAliasQEW+"->QEW_ANO") == cAno .And.;
				&(cAliasQEW+"->QEW_MES") == cMes 
				nPos := Ascan(aFatIQP,{|x|x[1]==(cAliasQEW)->QEW_LAUDO})
				If nPos > 0
					aDadosInd[2,Len(aDadosInd[1]),nPos] += (cAliasQEW)->QEW_QTDLAU
				EndIf
			EndIf	
			&(cAliasQEW)->(dbSkip())
		EndDo
		
		nQtdEnt    := 0
		nLotDem    := 0
		nLotIns    := 0
		nLotSkp    := 0
		nQtdIns    := 0
		nQtdSkp    := 0
		nQtdRej    := 0
		nTotIQD    := 0
		nTotIQS    := 0
		nTotIPO    := 0
		nDivIQD    := 0
		nDivIPO    := 0
		
		//Filtra os Indices por Fornecedor+Mes+Ano (QEV)
		dbSelectArea(cAliasQEV)
		While &(cAliasQEV+"->QEV_FORNEC") == cFornece .And. &(cAliasQEV+"->QEV_ANO") == cAno .And.;
			&(cAliasQEV+"->QEV_MES") == cMes .And. &(cAliasQEV)->(!Eof())
			
			nQtdEnt += &(cAliasQEV+"->QEV_LOTENT") //Entregas no Periodo
			nLotDem += &(cAliasQEV+"->QEV_LOTDEM") //No. Entregas demeritadas no Periodo
			nLotIns += &(cAliasQEV+"->QEV_LOTINS") //No. Entregas Inspecionadas
			nLotSkp += &(cAliasQEV+"->QEV_LOTSKP") //No. Entregas em Skip-Lote
			nQtdIns += &(cAliasQEV+"->QEV_QTDINS") //Qtde. Inspecionada
			nQtdSkp += &(cAliasQEV+"->QEV_QTDSKP") //Qtde. em Skip-lote
			nQtdRej += &(cAliasQEV+"->QEV_QTDREJ") //Qtde. Rejeitada
			
			nTotIQD += If(&(cAliasQEV+"->QEV_IQD") <> 999.99,&(cAliasQEV+"->QEV_IQD"),0) //IQD
			nTotIPO += If(&(cAliasQEV+"->QEV_IPO") <> 999.99,&(cAliasQEV+"->QEV_IPO"),0) //IPO
			
			&(cAliasQEV)->(dbSkip())
			
			nDivIQD += If((cAliasQEV)->QEV_IQD <> 999.99,1,0)
			nDivIPO += If((cAliasQEV)->QEV_IPO <> 999.99,1,0)
			
			lImpGraf :=	If(mv_par06==1,.T.,lImpGraf)
			
		EndDo
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calculo do PPM     											 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPPM := 0
		If nQtdIns > 0
			nSoma := (nQtdIns + nQtdSkp)
			nPPM  := (nQtdRej / nSoma) * 1000000
			
			//Acumula o PPM Total
			nSomAcu    += nSoma
			nQtdRejAcu += nQtdRej
		EndIf
		
		nIni := Len(aFatIQP)
		
		aDadosInd[2,Len(aDadosInd[1]),nIni+01] := nQtdEnt
		aDadosInd[2,Len(aDadosInd[1]),nIni+02] := nLotDem
		aDadosInd[2,Len(aDadosInd[1]),nIni+03] := nLotIns
		aDadosInd[2,Len(aDadosInd[1]),nIni+04] := nLotSkp
		aDadosInd[2,Len(aDadosInd[1]),nIni+05] := nQtdIns
		aDadosInd[2,Len(aDadosInd[1]),nIni+06] := nQtdSkp
		aDadosInd[2,Len(aDadosInd[1]),nIni+07] := nQtdRej
		
		//Totalizadores das Medias
		nMedIQP ++ //IQP
		nMedIQI ++ //IQI
		nMedIPO ++ //IPO
		
		nTotIQD := (nTotIQD/nDivIQD)
		
		//Obtem o IA (Indice de Aceitacao)
		nSoma := 0
		nAux  := 0
		For nX := 1 To Len(aFatIQP)
			nAux  += (aFatIQP[nX,4] * aDadosInd[2,Len(aDadosInd[1]),nX] )
			nSoma += aDadosInd[2,Len(aDadosInd[1]),nX]
		Next nX
		nIA := If(nSoma<>0,(nAux/nSoma)*100,0)
		
		//Obtem o Fator K, de acordo com o IA
		QEJ->(DBSetOrder(1))
		QEJ->(DBSeek(xFilial("QEJ")+"1"+Str(nIA,6,2),.T.))
		nK   := SuperVal(QEJ->QEJ_FATOR)
		nIQP := (100-nK)-nTotIQD
		nIQP := If(nIQP<0,0,nIQP)
		
		//Calculo do IQI por Tabela
		QEJ->(DBSetOrder(1))
		If nIQS <> 999.99
			//Obtem o Fator FC, de acordo com o IQS
			QEJ->(DBSeek(xFilial("QEJ")+"2"+Str(nIQS,6,2),.T.))
			nFC := SuperVal(QEJ->QEJ_FATOR)
		Else
			//Obtem o Fator FC para quando nao tiver a nota do IQS (999.99)
			If QEJ->(DBSeek(xFilial("QEJ")+"2"+Str(nIQS,6,2)))
				nFC := SuperVal(QEJ->QEJ_FATOR)
			Else
				//IQP por tabela Completa, assume 1
				nFC := 1
			EndIf
		EndIf
		nIQI := (nIQP*nFC)
		
		aDadosInd[2,Len(aDadosInd[1]),nIni+08] := nIQP					        //Calculo
		aDadosInd[2,Len(aDadosInd[1]),nIni+09] := nTotIQD						//Media e nao Recalcula
		aDadosInd[2,Len(aDadosInd[1]),nIni+10] := If(nIQS==999.99,"N/A",nIQS)	//Nao calcula, obtem a nota do IQS a partir do Fornecedor
		aDadosInd[2,Len(aDadosInd[1]),nIni+11] := nIQI   						//Calculo
		aDadosInd[2,Len(aDadosInd[1]),nIni+12] := (nTotIPO/nDivIPO) 			//Media e nao Recalcula
		aDadosInd[2,Len(aDadosInd[1]),nIni+13] := Transform(nPPM, "@E 999,999,999,999.99")					    //PPM
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Total/Media													 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nX := 1 to nIni
			aTotMed[nX] += aDadosInd[2,Len(aDadosInd[1]),nX] //Total pela Soma
		Next nX
		
		aTotMed[nIni+01] += nQtdEnt //Entradas no Periodo
		aTotMed[nIni+02] += nLotDem //Entradas demeritadas no Periodo
		aTotMed[nIni+03] += nLotIns //Entradas Inspecionadas
		aTotMed[nIni+04] += nLotSkp //Entradas em Skip-Lote
		aTotMed[nIni+05] += nQtdIns //Quantidade Inspecionada
		aTotMed[nIni+06] += nQtdSkp //Quantidade em Skip-Lote
		aTotMed[nIni+07] += nQtdRej //Quantidade Rejeitada
		
		aTotMed[nIni+08] += aDadosInd[2,Len(aDadosInd[1]),nIni+08] //IQP pela Media
		aTotMed[nIni+09] += aDadosInd[2,Len(aDadosInd[1]),nIni+09] //Fator de Criticidade pela Soma
		aTotMed[nIni+10] += 0                                      //IQS nao calcula o Total/Media
		aTotMed[nIni+11] += aDadosInd[2,Len(aDadosInd[1]),nIni+11] //IQI pela Media
		aTotMed[nIni+12] += aDadosInd[2,Len(aDadosInd[1]),nIni+12] //IPO pela Media
		
	
	EndDo
	
	//Ajusta as colunas do Relatorio
	If Len(aDadosInd[1]) < 6
		While Len(aDadosInd[1]) < 6
			Aadd(aDadosInd[1]," ")
			Aadd(aDadosInd[2],Afill(Array(Len(aFatIQP)+13)," "))
		EndDo
	EndIf
	
	nPPMTot := (nQtdRejAcu / nSomAcu) * 1000000 //Calculo do PPM Total/Media
	
	aTotMed[nIni+08] := (aTotMed[nIni+08] / nMedIQP)
	aTotMed[nIni+11] := (aTotMed[nIni+11] / nMedIQI)
	aTotMed[nIni+12] := (aTotMed[nIni+12] / nMedIPO)
	aTotMed[nIni+13] := Transform(nPPMTot, "@E 999,999,999,999.99")
	
	Aadd(aDadosInd[1],STR0022) //"TOTAL/MEDIA"
	Aadd(aDadosInd[2],Afill(Array(Len(aFatIQP)+13),0))
	For nX := 1 to Len(aTotMed)
		aDadosInd[2,Len(aDadosInd[1]),nX] := aTotMed[nX]
	Next nX
	
	//Posiciona QEG (Sit. Produto X Fornecedor) no valor mais próximo do IQF encontrado e retorna a classificao atual.
	If FINDCLASS( "QIEXFunAuxClass" )
		oQIEXFunAx := QIEXFunAuxClass():New()
		cCategoria := oQIEXFunAx:PosicionaNaQEGeRetornaCategoriaMaisProximaDoIQFEncontrado(aTotMed[nIni+11], nIQS, mv_par05)
	EndIf

	oSection1:Init()		
	
	oSection1:Cell("L1"):cPicture  := "" // Erro na lib que estava preenchida com @E 999,999,999.99
	oSection1:Cell("L1"):cTitle := If(mv_par05==1,"Fornecedor   ",If(mv_par05==2,"Supplier     ","Proveedor    "))
	oSection1:Cell("L1"):SetValue(": "+AllTrim(cFornece)+" - "+cDescForn)
	
	oSection1:Cell("L2"):cPicture := "" // Erro na lib que estava preenchida com @E 999,999,999.99
	oSection1:Cell("L2"):cTitle := If(mv_par05==1,"Mes / Ano    ",If(mv_par05==2,"Month/Year   ","Mes / A¤o   ")) 
	oSection1:Cell("L2"):SetValue(" : "+StrZero(mv_par04,2)+" / "+Str(mv_par03,4))
	
	oSection1:PrintLine()

	lQuebraPag := If(Len(aDadosInd[1]) > 7,.T.,.F.)
	
	oSection2:Init()    
	oReport:SkipLine()
	oReport:PrintText("IQI :"+Str(aTotMed[nIni+11],6,2)+' - '+cCategoria,oReport:Row(),025)
    oReport:SkipLine()

   	oSection2:Cell("C2"):cTitle := if(Empty(aDadosInd[1][1]),"",PadC(Right(aDadosInd[1][1],2)+"/"+Left(Right(aDadosInd[1][1],4),2),10))
   	oSection2:Cell("C3"):cTitle := if(Empty(aDadosInd[1][2]),"",PadC(Right(aDadosInd[1][2],2)+"/"+Left(Right(aDadosInd[1][2],4),2),10))
   	oSection2:Cell("C4"):cTitle := if(Empty(aDadosInd[1][3]),"",PadC(Right(aDadosInd[1][3],2)+"/"+Left(Right(aDadosInd[1][3],4),2),10))
   	oSection2:Cell("C5"):cTitle := if(Empty(aDadosInd[1][4]),"",PadC(Right(aDadosInd[1][4],2)+"/"+Left(Right(aDadosInd[1][4],4),2),10))
   	oSection2:Cell("C6"):cTitle := if(Empty(aDadosInd[1][5]),"",PadC(Right(aDadosInd[1][5],2)+"/"+Left(Right(aDadosInd[1][5],4),2),10))
   	oSection2:Cell("C7"):cTitle := if(Empty(aDadosInd[1][6]),"",PadC(Right(aDadosInd[1][6],2)+"/"+Left(Right(aDadosInd[1][6],4),2),10))

	If lQuebraPag
	   	oSection2:Cell("C8"):cTitle := if(Empty(aDadosInd[1][7]),"",PadC(Right(aDadosInd[1][7],2)+"/"+Left(Right(aDadosInd[1][7],4),2),10))
    EndIf
   
	For nColuna := 1 to Len(aDadosInd[1])

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Reimprime o cabecalho quando o numero de colunas a serem impressas ³
		//³ for superior a seis												   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lQuebraPag .And. nColuna > 7
			oSection1:Init()
			
			oSection1:Cell("L1"):cPicture  := "" // Erro na lib que estava preenchida com @E 999,999,999.99
			oSection1:Cell("L1"):cTitle := If(mv_par05==1,"Fornecedor   ",If(mv_par05==2,"Supplier     ","Proveedor    "))
			oSection1:Cell("L1"):SetValue(": "+AllTrim(cFornece)+" - "+cDescForn)
						
			oSection1:Cell("L2"):cPicture := "" // Erro na lib que estava preenchida com @E 999,999,999.99
			oSection1:Cell("L2"):cTitle := If(mv_par05==1,"Mes / Ano    ",If(mv_par05==2,"Month/Year   ","Mes / A¤o   ")) 
			oSection1:Cell("L2"):SetValue(" : "+StrZero(mv_par04,2)+" / "+Str(mv_par03,4))
			
			oSection1:PrintLine()
						
			oSection2:Init()    
			oReport:SkipLine()
			oReport:PrintText("IQI :"+Str(aTotMed[nIni+11],6,2)+' - '+cCategoria,oReport:Row(),025)
		    oReport:SkipLine()

			For nX := 1 To 6		
				If nColuna+nX > Len(aDadosInd[1]) .Or. Empty(aDadosInd[1][nColuna+nX])
					oSection2:Cell("C"+AllTrim(Str(nX+1))):cTitle := ""
				Else
					oSection2:Cell("C"+AllTrim(Str(nX+1))):cTitle := PadC(Right(aDadosInd[1][(nColuna-1)+nX],2)+"/"+Left(Right(aDadosInd[1][(nColuna-1)+nX],4),2),10)
				EndIf
			Next
			
			If nColuna + 6 >= Len(aDadosInd[1])
			   	oSection2:Cell("C8"):cTitle := STR0022
		   	Else
		   		oSection2:Cell("C8"):cTitle := PadC(Right(aDadosInd[1][nColuna+6],2)+"/"+Left(Right(aDadosInd[1][nColuna+6],4),2),10)
		    EndIf
		EndIf
		
		For nX := 1 to 7
			If nX+(nColuna-1) == Len(aDadosInd[1])
				For nC := (nColuna-1)+nX to (nColuna-1)+7
					If nC == (nColuna-1)+7
						Aadd(aDetalhe,aDadosInd[1,Len(aDadosInd[1])])
					Else
						Aadd(aDetalhe," ")
					EndIf
				Next nC
			ElseIf nX+(nColuna-1) < Len(aDadosInd[1])
				If !Empty(aDadosInd[1,nX+(nColuna-1)])
					Aadd(aDetalhe,"   "+SubStr(aDadosInd[1,nX+(nColuna-1)],5,2)+'/'+SubStr(aDadosInd[1,nX+(nColuna-1)],3,2))
				Else
					Aadd(aDetalhe," ")
				EndIf
			EndIf
		Next nX

		For nY := 1 to Len(aDadosInd[2,1])
			
			aDetalhe := {}
			If nY <= Len(aFatIQP)
				Aadd(aDetalhe,aFatIQP[nY,2])
			Else
				Aadd(aDetalhe,aDescricao[nY-Len(aFatIQP)])
			EndIf
			
			For nW := 1 to 7
				If nW+(nColuna-1) <= Len(aDadosInd[2])
					If nW+(nColuna-1) == Len(aDadosInd[2])
						For nC := (nColuna-1)+nW to (nColuna-1)+7
							If nC == (nColuna-1)+7
								Aadd(aDetalhe,aDadosInd[2,nW+(nColuna-1),nY])
							Else
								Aadd(aDetalhe," ")
							EndIf
						Next nC
						Exit
					Else
						Aadd(aDetalhe,aDadosInd[2,nW+(nColuna-1),nY])
					EndIF
				Else
					Aadd(aDetalhe," ")
				EndIf
			Next nW

            If  nY >= 14 .AND. nY < 18
                If !Empty(aDetalhe[2]) .AND. ValType(aDetalhe[2]) == "N"
                	oSection2:Cell("C2"):cPicture := "@E 999.99" 
                Else
					oSection2:Cell("C2"):cPicture := ""                 	
                EndIf
                If !Empty(aDetalhe[3])
	                oSection2:Cell("C3"):cPicture := "@E 999.99" 
                Else
					oSection2:Cell("C3"):cPicture := "" 
                EndIf
                If !Empty(aDetalhe[4])
    	            oSection2:Cell("C4"):cPicture := "@E 999.99" 
                Else
					oSection2:Cell("C4"):cPicture := "" 
                EndIf
                If !Empty(aDetalhe[5])
        	        oSection2:Cell("C5"):cPicture := "@E 999.99" 
                Else
					oSection2:Cell("C5"):cPicture := "" 
                EndIf
                If !Empty(aDetalhe[6])
            	    oSection2:Cell("C6"):cPicture := "@E 999.99"
                Else
					oSection2:Cell("C6"):cPicture := "" 
                EndIf
                If !Empty(aDetalhe[7])
                	oSection2:Cell("C7"):cPicture := "@E 999.99"
                Else
					oSection2:Cell("C7"):cPicture := "" 
                EndIf
                If !Empty(aDetalhe[8]) 
	                oSection2:Cell("C8"):cPicture := "@E 999.99"
                Else
					oSection2:Cell("C8"):cPicture := "" 
                EndIf
            Else
              	oSection2:Cell("C1"):cPicture := "" 
			   	oSection2:Cell("C2"):cPicture := "" 
			   	oSection2:Cell("C3"):cPicture := "" 
			   	oSection2:Cell("C4"):cPicture := "" 
			   	oSection2:Cell("C5"):cPicture := "" 
			   	oSection2:Cell("C6"):cPicture := "" 
			   	oSection2:Cell("C7"):cPicture := ""
			   	oSection2:Cell("C8"):cPicture := ""
            EndIf
			
        	oSection2:Cell("C1"):SetValue(UPPER(aDetalhe[1]))
        	oSection2:Cell("C2"):SetValue(aDetalhe[2])
        	oSection2:Cell("C3"):SetValue(aDetalhe[3])
        	oSection2:Cell("C4"):SetValue(aDetalhe[4])
        	oSection2:Cell("C5"):SetValue(aDetalhe[5])
        	oSection2:Cell("C6"):SetValue(aDetalhe[6])
        	oSection2:Cell("C7"):SetValue(aDetalhe[7])
        	oSection2:Cell("C8"):SetValue(aDetalhe[8]) 
       		oSection2:PrintLine()
			
		Next nY

		nColuna += 6
		
		If lQuebraPag .And. nColuna > 1
			oSection2:Finish()
			oReport:EndPage()
		EndIf

	Next

	oSection2:Finish() 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Realiza a Impressao do Grafico atraves da QACHART			 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lImpGraf
		lImpGraf := .F.
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Gera o Nome do arquivo do Grafico							 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nX := 1 to 99999
			cArqSPC := "QIE" + StrZero(nX,4) + ".SPC"
			cArqBMP := "QIE" + StrZero(nX,4) + ".BMP"
			If !File(Alltrim(cDir)+cArqSPC)
				Exit
			EndIf
		Next nX

		IF lExistChart //controle se executa o grafico modelo novo ou por DLL
			For nX := 1 to 99999
				cArqPNG := "QIE" + StrZero(nX,4) + ".PNG"
				If !File(oQLGrafico:retorna_Local_Imagens_Graficos()+cArqPNG)
					Exit
				EndIf
			Next nX
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta o Cabecalho a ser enviado para a QACHART.DLL			 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aCabec := {}
		Qer300MSPC(aDadosInd,cArqSPC,cDir,aCabec, ,cArqPNG)

		oReport:EndPage()

		If lExistChart //controle se executa o grafico modelo novo ou por DLL
			cImgGraf := oQLGrafico:retorna_Local_Imagens_Graficos()+cArqPNG
			//Imprime o grafico no relatorio
				  //SayBitmap( < nLinha>, < nCol>, < cBitmap>, [ nWidth], [ nHeight] )
			oReport:SayBitmap(360, 500, cImgGraf, 667 * 3, (550 * 3) - 30)
		Else
			cImgGraf := cDir+cArqBMP
			oReport:SayBitmap ( 360, 500, cImgGraf, 2200, 1600)
		EndIf  

	EndIf
EndDo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QER300AnoMes³Autor³ Paulo Emidio de Barros³ Data ³04/04/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula o Mes+Ano retroagido para Impressao do Relatorio	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER300													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±± 
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QER300AnoMes(nAnoFim,nMesFim,nQtdMesAcu)
Local aAnoMes    := {}
Local cAnoIni    := ''
Local cAnoFim    := ''
Local cMesIni    := ''
Local cMesFim    := ''
Local nQtdAnoMes := 1
Local aRetorno   := Array(4)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calculo dos Meses Acumulados definidos pelo MV_QMESACU        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAnoMes    := Afill(Array(nQtdMesAcu),'')
cAnoIni    := StrZero(nAnoFim,4)
cAnoFim	   := StrZero(nAnoFim,4)
cMesIni    := StrZero(nMesFim,2)
cMesFim	   := StrZero(nMesFim,2)
aAnoMes[1] := cAnoFim+StrZero(Val(cMesFim),2)

If nQtdMesAcu > 1
	While .T.
		cMesIni := StrZero(Val(cMesIni)-1,2)
		If cMesIni == "00"
			cAnoIni := StrZero(Val(cAnoIni)-1,4)
			cMesIni := "12"
		EndIf
		nQtdAnoMes++
		aAnoMes[nQtdAnoMes] := cAnoIni+cMesIni
		If nQtdAnoMes == nQtdMesAcu
			Exit
		EndIf
	EndDo           
Endif

aSort(aAnoMes)  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve o Ano+Mes retroagido 								 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aRetorno[1] := Left(aAnoMes[1],4)           //Ano Inicial
aRetorno[2] := Right(aAnoMes[1],2)          //Mes Inicial
aRetorno[3] := Left(aAnoMes[nQtdMesAcu],4)  //Ano Final
aRetorno[4] := Right(aAnoMes[nQtdMesAcu],2) //Mes Final

Return(aRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³QER300MSPC³ Autor ³ Paulo Emidio de Barros³ Data ³04/04/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gera arquivo (SPC) para gerar o grafico					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ QER300MSPC()          									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QIER300   												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                                             
Static Function QER300MSPC(aIQI,cArqSPC,cDir,aCabec, lR4, cArqPNG)
Local aValores	:= {}
Local aDad64	:= {}
Local lRetGraf  := .F.
Local nX        := 0
Local cSenhas	:= "1"
Default lR4 := .F.

Aadd(aValores,"QACHART.DLL - BARRA")
Aadd(aValores,"[TITULO]")
Aadd(aValores,"Fornecedor - Total ")
Aadd(aValores,"[TITULOX]")
Aadd(aValores,"Mes")	
Aadd(aValores,"[TITULOY]")
Aadd(aValores,"IQI")	
Aadd(aValores,"[INICIO DE DADOS]")

For nX := 1 to Len(aIQI[2])             
	If !Empty(aIQI[1,nX])
		xValor := aIQI[2,nX,Len(aIQI[2,nX])-2]
		If Valtype(xValor) == "N"	
			xValor := StrTran(AllTrim(Str(xValor)),'.',',')	
		Else 
			xValor := '0'
		EndIf	                          
		If nX == Len(aIQI[2])             
			Aadd(aValores,aIQI[1,nX]+";"+xValor)	
		Else
			Aadd(aValores,SubStr(aIQI[1,nX],5,2)+"/"+SubStr(aIQI[1,nX],1,4)+";"+xValor)
		EndIf

		Aadd(aDad64,{ xValor, fMesAno(aIQI[1,nX]) })	

	EndIf
Next nX
Aadd(aValores,"[FIM DE DADOS]")
Aadd(aValores,"[INICIO DO CABECALHO]")
For nX := 1 to Len(aCabec) 
	Aadd(aValores,aCabec[nX])
Next nX                    
Aadd(aValores,"[FIM DO CABECALHO]")

Aadd(aValores,"[LANGUAGE]")
Aadd(aValores,Upper(__Language) )

IF lExistChart //controle se executa o grafico modelo novo ou por DLL
	//fGeraGraf(aDad64, cArqPNG)
	QIEMGRAFIC(aDad64, 6,/* aMedicoes */, {"Fornecedor - Total"}, ,cDir, cArqPNG)
Else
                       
	lRetGraf := GeraTxt32(aValores,cArqSPC, cDir)

	If lRetGraf             
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega a DLL para Impressao do Grafico					     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		CallDll32("ShowChart",cArqSPC,"7",cDir,"7",If(!Empty(cSenhas),Encript(Alltrim(cSenhas),0),"PADRAO"),If(lR4,"TRUE","FALSE"))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Deleta o Arquivo SPC                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fErase(Alltrim(cDir)+cArqSPC)
	EndIf      
EndIf      
Return(NIL)            


/*/{Protheus.doc} fMesAno
Converte ano e mes numerais para o formato mes abreviado - ano numeral
@type  Static Function
@author Rafael Kleesatdt da Cruz
@since 03/04/2020
@version 1.0
@param cAnoMes, caractere, ano e mes no formato numeral ex: "202004"
@return cMesAno, caractere, mes e ano no formato mes abreviado - ano numeral ex: "Abr - 2020"
@example
(examples)
@see (links_or_references)
/*/
Static Function fMesAno(cAnoMes)
Local cMesAno := cAnoMes
Local aMesAbrev := {"Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"}

If Len(cAnoMes) == 6
	cMesAno := aMesAbrev[SuperVal(substr(cAnoMes,5,2))] + "-" + substr(cAnoMes,1,4)
EndIf
	
Return cMesAno
