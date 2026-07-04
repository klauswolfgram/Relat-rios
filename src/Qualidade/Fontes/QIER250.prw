/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIER250.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ QIER250	³ Autor ³ Cleber Souza          ³ Data ³ 27/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Follow Up Nao Conformidades            					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_QIER250(     )                                			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGAQIE  												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³       	   ³		³	   ³ 										  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function QIER250()
Local oReport	
Local cPerg     := "QER250" 
Private cGrupos := ""

Pergunte(cPerg,.F.)
oReport := ReportDef()
oReport:PrintDialog()

Return    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ReportDef  ºAutor  ³Cleber Souza        º Data ³  07/17/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicoes do relatorio de Formulas R4.		              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER250                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()

Local cPrograma  :="QIER250"
Local cDesc1     :=STR0001 // "Relatorio de Follow-up de Notificação Não Conformidades"
Local cTitulo    :=STR0002 // "Follow-up de Notificação Não Conformidades"   
Local cPerg      := "QER250"

DEFINE REPORT oReport NAME cPrograma TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1)

DEFINE SECTION oSection1 OF oReport TITLE STR0012 TABLE LINE STYLE 
DEFINE CELL NAME "cGrupo"       OF oSection1  	    SIZE  40  					  	TITLE TitSX3("QEA_GRUPO")[1]

DEFINE SECTION oSection2 OF oReport  TITLE STR0013 TABLE "QE6","QEM","QEK"
DEFINE CELL NAME "TRB_NNC"      OF oSection2	    SIZE  TamSX3("QEM_NNC")[1]    	TITLE TitSX3("QEM_NNC")[1]
DEFINE CELL NAME "TRB_DTNNC"  	OF oSection2    	SIZE  TamSX3("QEM_DTNNC")[1]  	TITLE TitSX3("QEM_DTNNC")[1]
DEFINE CELL NAME "A2_NREDUZ"  	OF oSection2    								  	AUTO SIZE TITLE AllTrim(TitSx3("A2_NREDUZ")[1]) + "/" + AllTrim(TitSx3("A2_LOJA")[1]) LINE BREAK
DEFINE CELL NAME "QE6_DESCPO"  	OF oSection2    									AUTO SIZE								   																
DEFINE CELL NAME "QEK_DTENTR"  	OF oSection2    									AUTO SIZE
DEFINE CELL NAME "QEK_LOTE"  	OF oSection2    									AUTO SIZE
DEFINE CELL NAME "QED_DESCPO"  	OF oSection2    			 					  	AUTO SIZE TITLE AllTrim(TitSx3("QE6_DESCPO")[1]) LINE BREAK
DEFINE CELL NAME "QEM_DTRESP"  	OF oSection2    									AUTO SIZE
DEFINE CELL NAME "QEM_DTFECH"  	OF oSection2    									AUTO SIZE

Return oReport   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReportºAutor  ³Cleber Souza		 º Data ³  07/17/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao relatorio R4.                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER250                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)
      
Local oTempTable	:= NIL
Local oSection1    := oReport:Section(1)
Local oSection2    := oReport:Section(2)
Local cPerg        := "QER250"                                                 
Local cGrupo       := ""
Local cTitulo      := STR0002 // "Follow-up de Notificação Não Conformidades"
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Prepara a selecao dos Grupos (sera feita com o operador   ³
//³  $ na funcao GeraTrab). Considero a faixa da Equipe       ³
//³  passsada e dai vou verificar os grupos. Se o usuario     ³
//³  nao passar nada considera todos os grupos. (Default...)  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QE3")
dbSetOrder(1)
dbSeek(xFilial("QE3")+mv_par11,.T.)
While !Eof() .And. QE3->QE3_GRUPO <= mv_par12
	If QE3->QE3_EQUIPE >= mv_par13 .And. QE3->QE3_EQUIPE <= mv_par14
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se este grupo ja foi incluido passa para o proximo   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !QE3->QE3_GRUPO$cGrupos
		   cGrupos := cGrupos + QE3->QE3_GRUPO
		EndIf
	EndIf
	dbSkip()
EndDo
     
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera arquivo de trabalho						          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !U_GeraTrab(cTitulo,@oTempTable) 
	oTempTable:Delete()
	Return .F.
EndIF	

dbSelectArea("TRB")
dbGoTop()

oReport:SetMeter(RecCount())

While TRB->(!Eof())

	If oReport:Cancel()
		Exit
	EndIf
	oReport:IncMeter()

	If cGrupo <> TRB->TRB_GRUPO
		cGrupo := TRB->TRB_GRUPO
		oSection1:Init()
		If !Empty(TRB->TRB_GRUPO)
			oSection1:Cell("cGrupo"):SetValue(TRB->TRB_GRUPO+" - "+TRB->TRB_DESCRI)    
		Else
			oSection1:Cell("cGrupo"):SetValue(STR0014) //"Produto sem grupo"
		endif
		oSection1:PrintLine()
		oSection1:Finish()   
		
		oSection2:Finish()   
		oSection2:Init()
	EndIf
        
	oSection2:Cell("TRB_NNC"):SetValue(TRB->TRB_NNC)
	oSection2:Cell("TRB_DTNNC"):SetValue(DToC(TRB->TRB_DTNNC))
	oSection2:Cell("A2_NREDUZ"):SetValue(AllTrim(TRB->TRB_NREDUZ) + "/" + TRB->TRB_LOJFOR)
	oSection2:Cell("QE6_DESCPO"):SetValue(Alltrim(TRB->TRB_DESCPO))
	oSection2:Cell("QEK_DTENTR"):SetValue(DToC(TRB->TRB_DTENTR))
	oSection2:Cell("QEK_LOTE"):SetValue(TRB->TRB_LOTE)
	oSection2:Cell("QED_DESCPO"):SetValue(Alltrim(TRB->TRB_DESLAU))
	oSection2:Cell("QEM_DTRESP"):SetValue(DToC(TRB->TRB_DTRESP))
	oSection2:Cell("QEM_DTFECH"):SetValue(DToC(TRB->TRB_DTFECH))
    oSection2:PrintLine()

	TRB->(dbSkip())
                                                 
EndDo
oSection2:Finish()

oTempTable:Delete()

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³GeraTrab  ³ Autor ³ Antonio Aurelio F C   ³ Data ³11/06/1999³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera arquivo de Trabalho 									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ U_GeraTrab()												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function GeraTrab(cTitulo,oTempTable)
Local nCntFor			:= 0
Local aCpo				:= {}
Local aTRB				:= {}
Local cCampo			:= ""
Local nPos				:= 0         
Local cSeek    		:= ""
Local cNiSeri        := ""

cArqTrab := ""
aCpo     := {}

Aadd(aCpo,"QEM_NNC")
Aadd(aCpo,"QEM_DTNNC")
Aadd(aCpo,"A2_NREDUZ")
Aadd(aCpo,"QEK_LOJFOR")
Aadd(aCpo,"QE6_DESCPO")
Aadd(aCpo,"QEK_DTENTR")
Aadd(aCpo,"QEK_LOTE")
Aadd(aCpo,"QEL_DESLAU")
Aadd(aCpo,"QEM_DTRESP")
Aadd(aCpo,"QEM_DTFECH")
Aadd(aCpo,"QEK_GRUPO")
Aadd(aCpo,"QE3_DESCRI")

For nCntFor := 1  To Len(aCpo)
	cCampo := GetSx3Cache(aCpo[nCntFor], "X3_CAMPO")
	If !Empty(cCampo)
		nPos := AT("_",cCampo)
		cCampo := "TRB"+Trim(Substr(cCampo,nPos,Len(cCampo)+1-nPos))
		AADD(aTRB,{cCampo,GetSx3Cache(aCpo[nCntFor], "X3_TIPO"),GetSx3Cache(aCpo[nCntFor], "X3_TAMANHO"),GetSx3Cache(aCpo[nCntFor], "X3_DECIMAL")})
	EndIf
Next

oTempTable := FWTemporaryTable():New( "TRB" )
oTempTable:SetFields( aTRB )
oTempTable:AddIndex("indice1", {"TRB_GRUPO","TRB_NNC"} )
oTempTable:Create()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona os arquivos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QEM")
dbSetOrder(1) // Filial + NNC

dbSeek(xFilial("QEM")+mv_par01,.T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtro o QEM neste Loop e posiciono o QEK com base no QEM            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

While !EOF() .And. QEM->QEM_NNC >= mv_par01 .And. QEM->QEM_NNC <= mv_par02

	If Subs(QEM->QEM_NNC,9,4)+Subs(QEM->QEM_NNC,1,7) < Subs(mv_par01,9,4)+Subs(mv_par01,1,7);
				 .Or. Subs(QEM->QEM_NNC,9,4)+Subs(QEM->QEM_NNC,1,7) > Subs(mv_par02,9,4)+Subs(mv_par02,1,7)
		dbSkip()
		Loop
   EndIf

	If mv_par03 <> CToD("  /  /  ") .And. mv_par04 <> CToD("  /  /  ")
		If QEM->QEM_DTNNC < mv_par03 .Or. QEM->QEM_DTNNC > mv_par04
			dbSkip()
			Loop
		EndIf
	EndIf

	If mv_par05 <> CToD("  /  /  ") .And. mv_par06 <> CToD("  /  /  ")
		If QEM->QEM_DTFECH < mv_par05 .Or. QEM->QEM_DTFECH > mv_par06
			dbSkip()
			Loop
		EndIf
	EndIf

	dbSelectArea("QEK")
	dbSetOrder(5)

	If dbSeek(xFilial("QEK")+Subs(QEM->QEM_NNC,9,4)+Subs(QEM->QEM_NNC,1,7))
		If  QEK->QEK_FORNEC >= mv_par07;
          	 .And. QEK->QEK_FORNEC <= mv_par08	 .And. QEK->QEK_LOJFOR >= mv_par09;
             .And. QEK->QEK_LOJFOR <= mv_par10
                                                                           
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Filtra o Tipo da Entrada								  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par15 == 1                                              
				If !(QEK->QEK_TIPONF == "N" .Or. QEK->QEK_TIPONF == " ")
					dbSelectArea("QEM")
					dbSkip()
					Loop					
                EndIf
			ElseIf mv_par15 == 2        
				If !(QEK->QEK_TIPONF == "B")
					dbSelectArea("QEM")
					dbSkip()
					Loop					
                EndIf
			ElseIf mv_par15 == 3        
				If !(QEK->QEK_TIPONF == "D")
					dbSelectArea("QEM")
					dbSkip()
					Loop					
				EndIF
			EndIf
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Posiciona os Arquivos                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			dbSelectArea("SA2")
			dbSetOrder(1)
			dbSeek(xFilial("SA2")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR)

			dbSelectArea("QE6")
			dbSetOrder(1)
			dbSeek(xFilial("QE6")+QEK->QEK_PRODUT+Inverte(QEK->QEK_REVI))

			dbSelectArea("QE3")
			dbSetOrder(1)
			dbSeek(xFilial("QE3")+QEK->QEK_GRUPO)

			dbSelectArea("QEL")

		    cNiseri:= QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF
			QEL->(dbSetOrder(3))
			cSeek := QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+ cNiseri+QEK->QEK_TIPONF+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE+;
			Space(TamSX3("QEL_LABOR")[1])

			If dbSeek(xFilial("QEL")+cSeek)
				dbSelectArea("QED")
				dbSetOrder(1)
				dbSeek(xFilial("QED")+QEL->QEL_LAUDO)
			EndIf

			RecLock("TRB",.T.)
			TRB->TRB_NNC    := QEM->QEM_NNC
			TRB->TRB_DTNNC  := QEM->QEM_DTNNC
			TRB->TRB_NREDUZ := SA2->A2_NREDUZ
			TRB->TRB_LOJFOR := QEK->QEK_LOJFOR
			TRB->TRB_DESCPO := QE6->QE6_DESCPO
			TRB->TRB_DTENTR := QEK->QEK_DTENTR
			TRB->TRB_LOTE   := QEK->QEK_LOTE
			TRB->TRB_DESLAU := QED->QED_DESCPO
			TRB->TRB_DTRESP := QEM->QEM_DTRESP
			TRB->TRB_DTFECH := QEM->QEM_DTFECH
			TRB->TRB_GRUPO  := QEK->QEK_GRUPO
			TRB->TRB_DESCRI := QE3->QE3_DESCRI
			MsUnLock()

		EndIf
	EndIf
	dbSelectArea("QEM")
	dbSetOrder(1)
	dbSkip()
EndDo

Return .T.
