/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIER180.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

#DEFINE ESPACO_DISPONIVEL 30

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQIER180   บAutor  ณTelso Carneiro      บ Data ณ  19/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Referncia Cruzada : Nฦo Conformidade X Fornecedor 	      บฑฑ
ฑฑบ          ณ (Versao Relatorio Personalizavel)                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function QIER180()
Local oReport	


Pergunte("QER180",.F.)
oReport := ReportDef()
oReport:PrintDialog()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Restaura a Integridade dos dados                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("QEK")
Set Filter to
RetIndex("QEK")
dbSetOrder(1)

Return     

Static Function ReportDef()
Local wnrel	   	:= "QIER180"                                        	
Local cDesc1   	:= OemToAnSi(STR0001)	//"Sero relacionadas as Nao Conformidades associadas a cada Fornecedor."
Local cTitulo  	:= OemToAnSi(STR0002)	//"Referencia Cruzada : NC x Fornecedor"
Local cPerg  	:= "QER180"
Local oReport
Local oSection1		 
Local oBreak1 
Local oBreak2
Local nTamForn	:=TamSX3("QEK_FORNEC")[1]+TamSX3("QEK_LOJFOR")[1]+TamSx3("A2_NREDUZ")[1]+15
Local nTamProd	:=TamSX3("QEK_PRODUT")[1]+5
Local nTamLote	:=TamSX3("QEK_LOTE")[1]+5
Local nTamDoce	:=TamSX3("QEK_NTFISC")[1]+5
Local nTamNaoC	:=TamSX3("QEU_NAOCON")[1]+5
Local nTamHRme	:=TamSX3("QER_HRMEDI")[1]+5
Local nTamNumc	:=TamSX3("QEU_NUMNC")[1]+5
Local nTamDemi	:=TamSX3("QEU_DEMIQI")[1]+5
		
DEFINE REPORT oReport NAME wnrel TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1)

DEFINE SECTION oSection1 OF oReport TITLE SubStr(OemToAnsi(STR0002),22,20) TABLES "TRB","QEK","QER","QEU"
DEFINE CELL NAME "TRB_FORNEC"      OF oSection1 ALIAS "TRB" TITLE TitSX3("QEK_FORNEC")[1] 	SIZE nTamForn
DEFINE CELL NAME "TRB_PRODUT"      OF oSection1 ALIAS "TRB" TITLE TitSX3("QEK_PRODUT")[1] 	SIZE nTamProd
DEFINE CELL NAME "TRB_DTENTR"      OF oSection1 ALIAS "TRB" TITLE TitSX3("QEK_DTENTR")[1]  SIZE 15  
DEFINE CELL NAME "TRB_LOTE"        OF oSection1 ALIAS "TRB" TITLE TitSX3("QEK_LOTE")[1] 	SIZE nTamLote
DEFINE CELL NAME "TRB_NTFISC"      OF oSection1 ALIAS "TRB" TITLE TitSX3("QEK_NTFISC")[1] 	SIZE nTamDoce
DEFINE CELL NAME "TRB_NAOCON"      OF oSection1 ALIAS "TRB" TITLE Left(TitSX3("QEU_NAOCON")[1],nTamNaoC) SIZE nTamNaoC
DEFINE CELL NAME "TRB_DTMEDI"      OF oSection1 ALIAS "TRB" TITLE TitSX3("QER_DTMEDI")[1]   SIZE 15  
DEFINE CELL NAME "TRB_HRMEDI"      OF oSection1 ALIAS "TRB" TITLE Left(TitSX3("QER_HRMEDI")[1],5)  		SIZE nTamHRme
DEFINE CELL NAME "TRB_NUMNC"       OF oSection1 ALIAS "TRB" TITLE TitSX3("QEU_NUMNC")[1] 	SIZE nTamNumC Picture "99999"
DEFINE CELL NAME "TRB_DEMIQI"      OF oSection1 ALIAS "TRB" TITLE Left(TitSX3("QEU_DEMIQI")[1],12)		SIZE nTamDemi 

DEFINE BREAK oBreak1 OF oSection1 WHEN {|| TRB->TRB_FORNEC+TRB->TRB_LOJFOR+TRB->TRB_PRODUT+IF(VALTYPE(TRB->TRB_DTENTR)=="D",DTOS(TRB->TRB_DTENTR),TRB->TRB_DTENTR)+TRB->TRB_LOTE}  TITLE OemToAnsi(STR0015) //"Total de Ncs"
oBreak1:SetPageBreak(.F.)

DEFINE FUNCTION oFunc FROM oSection1:Cell("TRB_NUMNC") ;
					OF oSection1 FUNCTION SUM BREAK oBreak1 NO END SECTION NO END REPORT  //"Total de Ncs"

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrintReporบAutor  ณDenis Martins       บ Data ณ             บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCriado                                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ QIER180                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PrintReport(oReport)
Local cKey   	:= ""
Local cCondAux 	:= " "
Local oQEK 	 	:= oReport:Section(1)
Local cFornec 	:= ""
Local cLojFor 	:= ""
Local cProdut 	:= ""
Local cDtEntr 	:= ""
Local cLote   	:= ""
Local cStrUsado := ""
Local nTotGNc	:= 0

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a expressao para filtrar as Entradas                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If mv_par05 == 1
	cCondAux := '.And. (QEK_TIPONF == "N" .Or. QEK_TIPONF == " ")'
ElseIf mv_par05 == 2
	cCondAux := '.And. QEK_TIPONF == "B"'
ElseIf mv_par05 == 3
	cCondAux := '.And. QEK_TIPONF == "D"'
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Posiciona em outros arquivos                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("QEL")
dbSetOrder(1)
dbSelectArea("SA2")
dbSetOrder(1)
dbSelectArea("QEK")

MakeSqlExpr(oReport:uParam) 
 
cQuery:="% "
If mv_par05 == 1
	cQuery += " AND QEK.QEK_TIPONF IN ( 'N', ' ') "	
Elseif mv_par05 == 2
	cQuery += " AND QEK.QEK_TIPONF = 'B' "			
Elseif mv_par05 == 3
	cQuery += " AND QEK.QEK_TIPONF = 'D' "			
Endif       
cQuery+=" %"    
        
BEGIN REPORT QUERY oQEK
	BeginSql Alias "TRB"		    
		SELECT QEK.QEK_TIPONF TRB_TIPONF, QEK.QEK_FORNEC TRB_FORNEC, QEK.QEK_LOJFOR TRB_LOJFOR, QEK.QEK_PRODUT TRB_PRODUT,
		       QEK.QEK_DTENTR TRB_DTENTR, QEK.QEK_LOTE TRB_LOTE,     QEK.QEK_NTFISC TRB_NTFISC,
		       QEU.QEU_NAOCON TRB_NAOCON, QEU.QEU_NUMNC TRB_NUMNC,   QEU.QEU_DEMIQI TRB_DEMIQI,
		       QEU.QEU_CODMED TRB_CODMED, QER.QER_DTMEDI TRB_DTMEDI, QER.QER_HRMEDI TRB_HRMEDI
		FROM  %table:QEK% QEK, 	%table:QER% QER, %table:QEU% QEU
	
		WHERE QEK.QEK_FILIAL = %xFilial:QEK%  AND
		      QER.QER_FILIAL = %xFilial:QER% AND
		      QEU.QEU_FILIAL = %xFilial:QEU% AND
		      QEK.QEK_DTENTR BETWEEN %exp:Dtos(mv_par01)% AND %exp:Dtos(mv_par02)% AND
		      QEK.QEK_FORNEC BETWEEN %exp:mv_par03% AND %exp:mv_par04% AND
		      QEU.QEU_CODMED = QER.QER_CHAVE  AND
		      QER.QER_PRODUT = QEK.QEK_PRODUT AND
		      QER.QER_REVI   = QEK.QEK_REVI	  AND
		      QER.QER_FORNEC = QEK.QEK_FORNEC AND
		      QER.QER_LOJFOR = QEK.QEK_LOJFOR AND
		      QER.QER_LOTE   = QEK.QEK_LOTE	  AND
		      QEK.%notdel% AND QER.%notdel%   AND QER.%notdel% AND QEU.%notdel%
		      %exp:cQuery%
		      ORDER BY QEK_FORNEC,QEK_LOJFOR,QEK_PRODUT,QEU_CODMED,QEU_NAOCON
	EndSql
END REPORT QUERY oQEK
	
dbSelectArea("TRB")
dbGoTop()

oReport:SetMeter(TRB->(RecCount()))

oQEK:Init()
While !EOF()

	oReport:IncMeter()	
	
	If oReport:Cancel()
		Exit
	EndIf		
	
	If (cFornec					# TRB_FORNEC	.Or.;
		cLojFor					# TRB_LOJFOR 	.Or.;
		cProdut	  		   		# TRB_PRODUT 	.Or.;
		Dtos(Ctod(cDtEntr)) 	# TRB_DTENTR	.Or.;
		cLote					# TRB_LOTE 		.Or.;
		cNota   				# TRB_NTFISC         )

		cFornec := TRB_FORNEC           
		cLojFor := TRB_LOJFOR
		cProdut := TRB_PRODUT
		cDtEntr := TRB_DTENTR
		cLote   := TRB_LOTE	        
		cNota   := TRB_NTFISC
		
		IF ValType(cDtEntr)=="C" .and. !Empty(cDtEntr)
			cDtEntr := SUBSTR(cDtEntr,7,2)+"/"+SUBSTR(cDtEntr,5,2)+"/"+SUBSTR(cDtEntr,1,4)
    	Endif

		oQEK:Cell("TRB_DTENTR"):SetValue(cDtEntr)
		oQEK:Cell("TRB_FORNEC"):Show()
		oQEK:Cell("TRB_PRODUT"):Show()
		oQEK:Cell("TRB_DTENTR"):Show()
		oQEK:Cell("TRB_LOTE"):Show()	                           
		oQEK:Cell("TRB_NTFISC"):Show()
	Else
		oQEK:Cell("TRB_FORNEC"):Hide()
		oQEK:Cell("TRB_PRODUT"):Hide()
		oQEK:Cell("TRB_DTENTR"):Hide()
		oQEK:Cell("TRB_LOTE"):Hide()
		oQEK:Cell("TRB_NTFISC"):Hide()
    Endif                         

	cFornec := TRB->TRB_FORNEC
	cLojFor := TRB->TRB_LOJFOR
	cProdut := TRB->TRB_PRODUT
	cDtEntr := TRB->TRB_DTENTR
	cLote   := TRB->TRB_LOTE	        
	cNota   := TRB->TRB_NTFISC
	nTotGNc += TRB->TRB_NUMNC

    cNaoConfo := TRB->TRB_NAOCON

	If	SA2->(dbSeek(xFilial("SA2")+TRB->TRB_FORNEC+TRB->TRB_LOJFOR)) .AND. TRB->TRB_TIPONF == 'N'
		cStrUsado := "-"+AllTrim(SA2->A2_NREDUZ)
	Elseif SA1->(dbSeek(xFilial("SA1")+TRB->TRB_FORNEC+TRB->TRB_LOJFOR)) .AND. ( TRB->TRB_TIPONF $ "B/D" ) 
		cStrUsado := "-"+AllTrim(SA1->A1_NREDUZ)
	Else
		cStrUsado := "" // Se nฦo encontra nฦo imprime nada.
	EndIf


	IF ValType(cDtEntr)=="C" .and. !Empty(cDtEntr)
		cDtEntr := SUBSTR(cDtEntr,7,2)+"/"+SUBSTR(cDtEntr,5,2)+"/"+SUBSTR(cDtEntr,1,4)
	Else
		cDtEntr := TRB->TRB_DTMEDI			
   	Endif

	If Valtype(TRB->TRB_DTMEDI) == "C" .and. !Empty(TRB->TRB_DTMEDI)	
		cDatMed := SUBSTR(TRB->TRB_DTMEDI,7,2)+"/"+SUBSTR(TRB->TRB_DTMEDI,5,2)+"/"+SUBSTR(TRB->TRB_DTMEDI,1,4)	
	Else
		cDatMed := TRB->TRB_DTMEDI		
	Endif

	oQEK:Cell("TRB_FORNEC"):SetValue(TRB->TRB_FORNEC+"/"+TRB->TRB_LOJFOR+cStrUsado)	//Fornecedor-Loja
	oQEK:Cell("TRB_PRODUT"):SetValue(TRB->TRB_PRODUT)	//Produto
	oQEK:Cell("TRB_DTENTR"):SetValue(cDtEntr)	//Dtentr
	oQEK:Cell("TRB_LOTE"):SetValue(TRB->TRB_LOTE)		//Lote
	oQEK:Cell("TRB_NTFISC"):SetValue(TRB->TRB_NTFISC)	
	oQEK:Cell("TRB_DTMEDI"):SetValue(cDatMed)	
	oQEK:Cell("TRB_HRMEDI"):SetValue(TRB->TRB_HRMEDI)	
		
	oQEK:Cell("TRB_NAOCON"):SetValue(TRB->TRB_NAOCON)		//N.Conf.
	oQEK:Cell("TRB_NUMNC"):SetValue(TRB->TRB_NUMNC)		     //N.NCs. TRB_NUMNC
	oQEK:Cell("TRB_DEMIQI"):SetValue(IF(TRB->TRB_DEMIQI=="S",STR0011,STR0012))	//"Sim"###"Nao"
	oQEK:PrintLine()
	
	TRB->(dbSkip())
EndDo
oQEK:Finish()
oReport:PrintText(STR0016 + Alltrim(Str(nTotGNc))) //"Total Geral de NCs : "

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Apaga indice e o arquivo de trabalho                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("TRB")
dbCloseArea()
	
Return(NIL)

