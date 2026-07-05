/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIER290.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQIER290   บAutor  ณTelso Carneiro      บ Data ณ  09/06/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio NNC X Fornecedor                 				  บฑฑ
ฑฑบ          ณ (Versao Relatorio Personalizavel)                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function QIER290()
Local oReport

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                             ณ
//ณ mv_par01  // Data da NNC de										 ณ
//ณ mv_par02  // Data da NNC ate									 ณ
//ณ mv_par03  // Fornecedor de           	                 		 ณ
//ณ mv_par04  // Fornecedor ate           	             			 ณ
//ณ mv_par05  // Loja de 	 										 ณ
//ณ mv_par06  // Loja ate                               			 ณ
//ณ mv_par07  // Produto de 										 ณ
//ณ mv_par08  // Produto ate 										 ณ
//ณ mv_par09  // Fechamento/NNC										 ณ
//ณ mv_par10  // Resposta /NNC 										 ณ
//ณ mv_par11  // Considera Entradas? 1)Normal 2)Beneficiamento       ณ
//ณ 								 3)Devolucoes				  	 ณ      
//ณ mv_par12  // Lista Nใo Conformidades ?						     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Pergunte("QER290",.F.)
oReport := ReportDef()
oReport:PrintDialog()

Return     


Static Function ReportDef()
Local wnrel	   := "QIER290"
Local cDesc1   := OemToAnsi(STR0001)	//"Sero relacionadas as Notificacoes de Nao Conformidades associadas a cada Fornecedor."
Local cTitulo  := OemToAnsi(STR0002)	//"Referencia Cruzada : NNC x Fornecedor"
Local cPerg    := "QER290"
Local aTab	   := {}                
Local oQEK
Local oQEM
Local oQEU
Local cTitNNC	:= TitSX3("QEM_NNC")[1]
Local cTitDTNNC	:= Subs(TitSX3("QEM_DTNNC")[1],1,10)
Local cTitProd	:= TitSX3("QE6_PRODUT")[1]
Local cTitDTent	:= Subs(TitSX3("QEK_DTENTR")[1],1,10)
Local cTitLote	:= TitSX3("QEK_LOTE")[1]
Local cTitDTres	:= Subs(TitSX3("QEM_DTRESP")[1],1,10)
Local cTitDTFec	:= Subs(TitSX3("QEM_DTFECH")[1],1,10)
Local cTitCodCli:= AllTrim(TitSx3("A6_CODCLI")[1])
Local cTitFornec:= AllTrim(TitSx3("QEK_FORNEC")[1]) 
Local cTitLojfor:= AllTrim(TitSx3("QEK_LOJFOR")[1])  
Local cTitNONC  := AllTrim(TitSx3("QEU_NUMNC")[1])
Local nTamCls  	:= TamSX3("QEE_DESCPO")[1]
Local nTamPro  	:= TamSx3("QEM_PRODUTO")[1]+TamSX3("QEM_DESPRO")[1]+1
Local nTamFor  	:= TamSx3("QEK_FORNEC")[1]
Local nTamLoj  	:= TamSx3("QEK_LOJFOR")[1]
Local nTamNnc  	:= TamSx3("QEK_NNC")[1]
Local nTamDtn  	:= TamSx3("QEM_DTNNC")[1]
Local nTamDte  	:= TamSx3("QEK_DTENTR")[1]
Local nTamLot  	:= TamSx3("QEK_LOTE")[1]
Local nTamRep  	:= TamSx3("QEM_DTRESP")[1]
Local nTamFec  	:= TamSx3("QEM_DTFECH")[1]
Local aNcont 	:={}
Private cAliasQEK:= "TRB"
Private cAliasQEU:= "QEU"

DEFINE REPORT oReport NAME wnrel TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1)

DEFINE SECTION oQEK OF oReport TITLE TitSX3("QEK_FORNEC")[1] TABLES "TRB"
DEFINE CELL NAME "FORNEC"      OF oQEK ALIAS "TRB" TITLE cTitFornec SIZE nTamFor
DEFINE CELL NAME "LOJFOR"      OF oQEK ALIAS "TRB" TITLE cTitLojfor SIZE nTamLoj
DEFINE CELL NAME "cDESFOR"     OF oQEK ALIAS "TRB" TITLE TITSX3("A1_NOME")[1] SIZE 100     

DEFINE SECTION oQEM OF oQEK TITLE TitSX3("QEM_NNC")[1] TABLES "TRB"
DEFINE CELL NAME "NNC"     	   OF oQEM ALIAS "TRB" TITLE cTitNNC   SIZE nTamNnc
DEFINE CELL NAME "DTNNC"   	   OF oQEM ALIAS "TRB" TITLE cTitDTNNC SIZE nTamDtn BLOCK {|| STOD(TRB->DTNNC) }
DEFINE CELL NAME "PRODUT"      OF oQEM ALIAS "TRB" TITLE cTitProd  SIZE nTamPro BLOCK {|| TRB->PRODUT+"-"+Posicione("QE6",1,xFilial("QE6")+TRB->PRODUT+Inverte(TRB->REVI),"QE6_DESCPO") }
DEFINE CELL NAME "DTENTR"      OF oQEM ALIAS "TRB" TITLE cTitDTent SIZE nTamDte BLOCK {|| STOD(TRB->DTENTR) }
DEFINE CELL NAME "LOTE"        OF oQEM ALIAS "TRB" TITLE cTitLote  SIZE nTamLot
DEFINE CELL NAME "DTRESP"      OF oQEM ALIAS "TRB" TITLE cTitDTres SIZE nTamRep BLOCK {|| STOD(TRB->DTRESP) }
DEFINE CELL NAME "DTFECH"      OF oQEM ALIAS "TRB" TITLE cTitDTFec SIZE nTamFec BLOCK {|| STOD(TRB->DTFECH) }

DEFINE SECTION oQEU OF oQEM TITLE TitSX3("QEU_NAOCON")[1]
DEFINE CELL NAME "QEU_NAOCON"  OF oQEU ALIAS "" TITLE OemToAnsi(STR0010) BLOCK {|| Posicione("SAG",1,xFilial("SAG")+(TRB)->QEU_NAOCON,"AG_DESCPO")}
DEFINE CELL NAME "QEU_NUMNC"   OF oQEU ALIAS "" 
DEFINE CELL NAME "QEU_CLASSE"  OF oQEU ALIAS "" SIZE nTamCls BLOCK {|| Posicione("QEE",1,xFilial("QEE")+(TRB)->QEU_CLASSE,"QEE_DESCPO") }
DEFINE CELL NAME "QEU_DEMIQI"  OF oQEU ALIAS "" BLOCK {|| IF((TRB)->QEU_DEMIQI=="S",(OemToAnsi(STR0017)),OemToAnsi(STR0018)) } //"Sim"###"Nao"
DEFINE CELL NAME "QEE_PONTOS"  OF oQEU ALIAS "" BLOCK {|| Posicione("QEE",1,xFilial("QEE")+(TRB)->QEU_CLASSE,"QEE_PONTOS") }
DEFINE CELL NAME "REINIC"      OF oQEU ALIAS NIL   TITLE OemToAnsi(STR0014) SIZE 10 BLOCK {|| AADD(aNcont,(TRB)->QEU_NAOCON),y:=-1,aEval(aNcont,{|x| IF(x==(TRB)->QEU_NAOCON,y++,"")}), STR(y,0)+ OemToAnsi(STR0016) }//" a."###"Reincidencia"


DEFINE FUNCTION FROM oQEM:Cell("NNC") OF oQEK FUNCTION COUNT 

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrinบAutor  ณTelso Carneiro      บ Data ณ  30/05/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio Personalizavel                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณU_Qier290()                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
                  
Static Function PrintReport(oReport) 
Local oQEK 		   := oReport:Section(1)
Local oQEM		   := oReport:Section(1):Section(1)
Local oQEU 		   := oReport:Section(1):Section(1):Section(1)
Local aNcont       :={}
Local cCond 	   := ""			
Local cKey         := ""
Local nY           := ""
Local cFornec      := ""
Local cForDesc     := "" 
Local nTAMQEK 		:= TamSx3("QEK_NNC")[1]
Local cAliasQEK     := GetNextAlias()
Local cFiltro       := ""


MakeSqlExpr(oReport:uParam)
	
cWhere:="% "
If mv_par11 == 1
	cWhere += "  QEK.QEK_TIPONF IN ('N',' ') AND"
ElseIf mv_par11 == 2
	cWhere += "  QEK.QEK_TIPONF = 'B' AND"			
ElseIf mv_par11 == 3
	cWhere += "  QEK.QEK_TIPONF = 'D' AND"			
EndIf

If mv_par09 == 1
	cWhere += "  QEM.QEM_DTFECH <> '"+ Space(10)+" AND "
ElseIf mv_par09 == 2
	cWhere += "  QEM.QEM_DTFECH = '"+ Space(10)+" AND "
EndIf

If mv_par10 == 1
	cWhere += "  QEM.QEM_DTRESP <> '"+ Space(10)+" AND "
ElseIf mv_par10 == 2
	cWhere += "  QEM.QEM_DTRESP = '"+ Space(10)+" AND "
EndIf             	                                

   	cWhere+=" %"

cFiltro+= cWhere

oQEK:BeginQuery()		
    
	BeginSQL alias "TRB"

	 	SELECT 
		 	QEM.QEM_NNC NNC, QEM.QEM_DTNNC DTNNC, QEK.QEK_PRODUT PRODUT, 
			QEK.QEK_DTENTR DTENTR, QEK.QEK_LOTE LOTE, QEM.QEM_DTRESP DTRESP,
			QEM.QEM_DTFECH DTFECH, QEK.QEK_FORNEC FORNEC, QEK.QEK_LOJFOR LOJFOR, 
			QEK.QEK_NNCINV NNCINV, QEK.QEK_TIPONF TIPONF, QE6.QE6_DESCPO DESCPO, QEK.QEK_REVI REVI
	
		FROM %table:QEK% QEK, %table:QEM% QEM, %table:QE6% QE6
	
		WHERE 
			QEK.QEK_FILIAL  = %xFilial:QEK% AND
			QEM.QEM_FILIAL  = %xFilial:QEM% AND
			QE6.QE6_FILIAL  = %xFilial:QE6% AND 
			QEK.QEK_NNC	<> %Exp:Space(nTAMQEK)% AND
			QEK.QEK_FORNEC Between %Exp:mv_par03%  AND %Exp:mv_par04%  AND 
			QEK.QEK_LOJFOR Between %Exp:mv_par05%  AND %Exp:mv_par06%  AND 
			QEK.QEK_PRODUT Between %Exp:mv_par07%  AND %Exp:mv_par08%  AND 
			QEK.QEK_NNC    = QEM.QEM_NNC AND 							
			QEK.QEK_PRODUT = QE6.QE6_PRODUT AND 
			QEK.QEK_REVI   = QE6.QE6_REVI AND 
			QEM.QEM_DTNNC Between %Exp:Dtos(mv_par01)% AND %Exp:Dtos(mv_par02)%  AND
			%Exp:cFiltro% 	    
			QEK.%notDel% AND
			QEM.%notDel% AND 
			QE6.%notDel% 
			ORDER BY QEK_FORNEC,QEK_LOJFOR,QEK_NNCINV
	EndSql
	oQEK:EndQuery()  


While TRB->(!EOF())
	
	If oReport:Cancel()
		Exit
	EndIf
	
		If cFornec != TRB->FORNEC .Or.	cLojFor != TRB->LOJFOR
			IF !Empty(cFornec)
				oQEK:Finish()
			Endif
			oQEK:Init()
			cFornec  := TRB->FORNEC
			cLojFor  := TRB->LOJFOR
			oQEK:Cell("FORNEC"):SetValue(cFornec)
			oQEK:Cell("LOJFOR"):SetValue(cLojFor)
			
			
			If TRB->TIPONF $ "BD"
				SA1->(dbSetOrder(1))
				If SA1->(dbSeek(xFilial("SA1")+TRB->FORNEC+TRB->LOJFOR))
					cForDesc	:= SA1->A1_NREDUZ
				EndIf
			Else
				SA2->(dbSetOrder(1))
				If SA2->(dbSeek(xFilial("SA2")+TRB->FORNEC+TRB->LOJFOR))
					cForDesc	:= SA2->A2_NREDUZ
				EndIf
			EndIf
			
			oQEK:Cell("cDESFOR"):SetValue(cForDesc)
			
			
			oQEK:PrintLine()
		EndIf
		aRet      := QER290INC(.T.)
		aNConf    := aRet[1]
		nTotNC    := aRet[2]

		oQEM:Init()
		oQEM:Cell("NNC"):SetValue(TRB->NNC)
		oQEM:Cell("DTNNC"):SetValue(STOD(TRB->DTNNC))
		oQEM:Cell("PRODUT"):SetValue(TRB->PRODUT+"-"+Posicione("QE6",1,xFilial("QE6")+TRB->PRODUT+Inverte(TRB->REVI),"QE6_DESCPO") )
		oQEM:Cell("DTENTR"):SetValue(STOD(TRB->DTENTR))
		oQEM:Cell("LOTE"):SetValue(TRB->LOTE)
		oQEM:Cell("DTRESP"):SetValue(STOD(TRB->DTRESP))
		oQEM:Cell("DTFECH"):SetValue(STOD(TRB->DTFECH))
		oQEM:PrintLine()
		
	If mv_par12==1
			oQEU:Init()
			For nY:=1 to Len(aNConf)
				oQEU:Cell("QEU_NAOCON"):SetValue(aNConf[nY,1])
				oQEU:Cell("QEU_NUMNC"):SetValue(aNConf[nY,2])
				oQEU:Cell("QEU_CLASSE"):SetValue(aNConf[nY,3])
				If aNConf[nY,5] == "S"
					oQEU:Cell("QEU_DEMIQI"):SetValue(OemToAnsi(STR0017)) //"Sim"
				Else
					oQEU:Cell("QEU_DEMIQI"):SetValue(OemToAnsi(STR0018)) //"Nao"
				EndIf
				oQEU:Cell("QEE_PONTOS"):SetValue(aNConf[nY,6])
				oQEU:Cell("REINIC"):SetValue(Eval({|| AADD(aNcont,aNConf[nY,1]),y:=-1,aEval(aNcont,{|x| IF(x==aNConf[nY,1],y++,"")}), STR(y,0)+ OemToAnsi(STR0016) }))  //" a."
				oQEU:PrintLine()
			Next nY
			oQEU:Finish()
			
	EndIF
		oQEM:Finish()
		
		TRB->(dbSkip())
EndDo

dbSelectArea("TRB")
dbCloseArea()	

oQEK:Finish()				
dbSelectArea("QEK")
Set Filter To
RetIndex("QEK")
dbSelectArea("QEM")
Set Filter To
RetIndex("QEM")
dbSelectArea("QER")
Set Filter To
RetIndex("QER")


Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQER290INC บAutor  ณCleber Souza        บ Data ณ  07/04/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pesquisa as Nใo Conformidades relacionadas a Notifica็ใo   บฑฑ
ฑฑบ          ณ impressa do relatorio.                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ QIER290                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function QER290INC(lR4)

Local cSeek   := ""  
Local aNConf  := {}
Local nTotNC  := 0   
Local nOcor   := 0  
Local cNConf  := ""
Local cChave  := ""   
Local nPosNc  := 0

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verif. cada resultado da Entrada se possui NC ou se esta fora espec. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("QER")
dbSetOrder(1)
If lR4
	dbSeek(cSeek:=xFilial("QER")+TRB->PRODUT+TRB->REVI+TRB->FORNEC+TRB->LOJFOR+TRB->DTENTR+TRB->LOTE)
Else
	dbSeek(cSeek:=xFilial("QER")+TRB->PRODUT+TRB->REVI+TRB->FORNEC+TRB->LOJFOR+Dtos(TRB->DTENTR)+TRB->LOTE)
Endif
	
While !Eof() .AND. (QER->QER_FILIAL+QER->QER_PRODUT+QER->QER_REVI+QER->QER_FORNEC+QER->QER_LOJFOR+;
	 Dtos(QER->QER_DTENTR)+QER->QER_LOTE) == cSeek
			
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Chave de ligacao com o QEU - Nao Conformidades das Entradas  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cChave := QER->QER_CHAVE
		
	dbSelectArea("QEU")
	dbSetOrder(1)
	If dbSeek(xFilial("QEU")+cChave)
		While !Eof() .AND. xFilial("QEU") == QEU_FILIAL .AND. cChave == QEU_CODMED

			cNConf   := QEU_NAOCON
				
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Monta array com nao conformidades encontradas                ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			SAG->(dbSetOrder(1))
			If SAG->(dbSeek(xFilial("SAG")+cNConf))
				QEE->(dbSetOrder(1))
				If QEE->(dbSeek(xFilial("QEE")+QEU->QEU_CLASSE))  
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณ Ser  Calculado o nr. de ocorrencias encontradas              ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					nOcor := QER290cor(QEU->QEU_NAOCON,TRB->TIPONF)
					
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณ Total de Nใo Conformidades encontradas.						 ณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					nTotNC += QEU->QEU_NUMNC
					
					nPosNc := aScan(aNConf,{|x| x[1] == SAG->AG_DESCPO})  
					If nPosNc > 0 
						aNConf[nPosNc,2] += QEU->QEU_NUMNC
					Else					
			    	   	AADD(aNConf,{SAG->AG_DESCPO,QEU->QEU_NUMNC,QEE->QEE_DESCPO,nOcor,QEU->QEU_DEMIQI,Str(QEE->QEE_PONTOS,2)})
                    EndIf
				EndIf
			Endif           
			dbSelectArea("QEU") 
			dbSetOrder(1)
			DbSkip()
		EndDo
 		nOcor := 0
	EndIF
				
	dbSelectArea("QER")
	dbSetOrder(1)
	dbSkip()

EndDo

Return({aNConf,nTotNC})

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ QER290cor  ณ Autor ณ Cleber Souza        ณ Data ณ 05/07/05 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Calcula a reicidencia da NC para o Produto e Fornecedor    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ QER290cor()                                                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ QIER290	                                                  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function QER290cor(cNConf,cTipoNF)
Local nOcor    := 0
Local dDtLimite
Local cFornec  := TRB->FORNEC
Local cLojFor  := TRB->LOJFOR
Local cProdut  := TRB->PRODUT
Local cCh      := ""
Local nDias	   := GetMv("MV_QDIREIN")
Local aAreaQEK := QEK->(GetArea())
Local aAreaQER := QER->(GetArea())
Local aAreaQEU := QEU->(GetArea())

dbSelectArea("QEK")
dbSetOrder(1)
If dbSeek(xFilial("QEK")+TRB->FORNEC+TRB->LOJFOR+TRB->PRODUT+Inverte(TRB->DTENTR)+Inverte(TRB->LOTE)) 
	dDtLimite := (QEK->QEK_DTENTR-nDias)
	While !QEK->(Eof()) .AND. QEK->QEK_FILIAL == xFilial("QEK") .AND. ;
		QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT == cFornec+cLojFor+cProdut
		
		If cTipoNF == " "
			If !(QEK_TIPONF $ "N ")
				QEK->(dbSkip())
				Loop
			EndIf
		Else
			If !(QEK_TIPONF == cTipoNF)
				QEK->(dbSkip())
				Loop
			EndIf
		EndIf
		
		If (QEK->QEK_DTENTR < dDtLimite)
			Exit
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Seleciona os resultados da Entrada                           ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		QER->(dbSetOrder(1))
		If QER->(dbSeek(xFilial("QER")+QEK->QEK_PRODUT+QEK->QEK_REVI+;
			QEK->QEK_FORNEC+QEK->QEK_LOJFOR+Dtos(QEK->QEK_DTENTR)+QEK->QEK_LOTE))
			
			While !QER->(Eof()) .AND. QER->QER_FILIAL == xFilial("QER") .AND.;
				QER->QER_PRODUT+QER->QER_REVI+QER->QER_FORNEC+QER->QER_LOJFOR+;
				Dtos(QER->QER_DTENTR)+QER->QER_LOTE == QEK->QEK_PRODUT+QEK->QEK_REVI+;
				QEK->QEK_FORNEC+QEK->QEK_LOJFOR+Dtos(QEK->QEK_DTENTR)+QEK->QEK_LOTE
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณ Obtem chave de ligacao da medicao com os outros arquivos     ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				cCh := QER->QER_CHAVE
				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณ Verifica se a medicao tem NC                                 ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				QEU->(dbSetOrder(1))
				QEU->(dbSeek(xFilial("QEU")+cCh))
				While !QEU->(eof()) .AND. QEU->QEU_FILIAL == xFilial("QEU") .AND.;
					QEU->QEU_CODMED == cCh
					If QEU->QEU_NAOCON == cNConf
						nOcor++
					EndIf
					QEU->(dbSkip())
				EndDo
				
				QER->(dbSkip())
			EndDo
		EndIf
		QEK->(dbSkip())
	EndDo
EndIF

//Retorna a area corrente
RestArea(aAreaQEK)
RestArea(aAreaQER)
RestArea(aAreaQEU)

Return(nOcor)
