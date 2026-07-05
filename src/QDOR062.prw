/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QDOR062.CH"
#INCLUDE "REPORT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QDOR062  ³ Autor ³ Leandro S. Sabino     ³ Data ³ 14/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Aviso de Recebimento de Documentos e Registros da Qualidade³±±
±±³          ³ *** UTILIZADO APENAS NA REEMISSAO DE DOCUMENTOS ***        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs:      ³ (Versao Relatorio Personalizavel) 		                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR062	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function QDOR062()
Local oReport

If TRepInUse()
    Pergunte("QDR061",.F.) 
    oReport := ReportDef()
    oReport:PrintDialog()
Else
	U_QDOR062R3() 
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 14/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR062                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport                                             
Local oSection1 ,oSection2,oSection3
Local cTitulo:= OemToAnsi(STR0001) //"PROTOCOLO DE REEMISSAO DOCUMENTOS"
Local cDesc1 := OemToAnsi(STR0002) //"Este programa ir  imprimir o Protocolo de Reemiss„o de Documentos"
Local cDesc2 := OemToAnsi(STR0003) //"referente as copias dos documentos reemitidos conforme  a selecao"
Local cDesc3 := OemToAnsi(STR0004) //"de usuarios/documentos" 


DEFINE REPORT oReport NAME "QDOR062" TITLE cTitulo PARAMETER "QDR061" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2+cDesc3)
oReport:SetLandscape()

DEFINE SECTION oSection1 OF oReport TABLES "QDH" TITLE OemToAnsi(STR0026)
DEFINE CELL NAME "QDH_DOCTO"  OF oSection1 ALIAS "QDH" 
DEFINE CELL NAME "QDH_RV"     OF oSection1 ALIAS "QDH" 
DEFINE CELL NAME "QDH_TITULO" OF oSection1 ALIAS "QDH"

DEFINE SECTION oSection2 OF oSection1 TABLES "QDH" TITLE OemToAnsi(STR0025)
DEFINE CELL NAME "cPROTOCOLO" OF oSection2 ALIAS "QDH" TITLE OemToAnsi(STR0025) SIZE 80 //"Protocolo"
oSection2:Cell("cPROTOCOLO"):SeTLineBREAK(.T.)

DEFINE SECTION oSection3 OF oSection2 TABLES "QDG" TITLE OemToAnsi(STR0027)
DEFINE CELL NAME "cResp"   OF oSection3 ALIAS "" TITLE OemToAnsi(STR0020) SIZE 35 //"RESPONSAVEL"
DEFINE CELL NAME "cTipo"   OF oSection3 ALIAS "" TITLE OemToAnsi(STR0021) SIZE 13 //"TP"
DEFINE CELL NAME "cCopias" OF oSection3 ALIAS "" TITLE OemToAnsi(STR0022) SIZE 25 //"COPIAS"
DEFINE CELL NAME "cData"   OF oSection3 ALIAS "" TITLE OemToAnsi(STR0023) SIZE 10 //"DATA"
DEFINE CELL NAME "cAssin"  OF oSection3 ALIAS "" TITLE OemToAnsi(STR0024) SIZE 15 //"ASSINATURA"
TRPosition():New(oReport:Section(1):Section(1):Section(1),"QDG", 1, {||  TRB->TRB_FILIAL+TRB->TRB_DOCTO+TRB->TRB_RV+TRB->TRB_TIPO+TRB->TRB_FILMAT+TRB->TRB_DEPTO+TRB->TRB_MAT })

Return oReport


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 14/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)       	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR062                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PrintReport( oReport)
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local oSection3  := oReport:Section(1):Section(1):Section(1)
Local cOldDoc	:= ""
Local cOldDepto:= ""
Local cSeek2   := ""
Local aTxtCopia:= { STR0014,STR0015,STR0016,STR0017} //"Eletronicas" ### //"Em Papel" ###"Eletronica/Papel" ### "Nao Recebe"
Local cFilDep  := xFilial("QAD")

DbSelectArea("TRB")
DbGoTop()

While TRB->(!Eof())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Caso nao exista Documento, pula o registro                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If !QDH->(dbSeek(xFilial("QDH")+TRB->TRB_DOCTO+TRB->TRB_RV))
		TRB->(dbSkip())
		Loop
	Endif

	If xFilial("QDH")+TRB->TRB_DOCTO+TRB->TRB_RV <> cOldDoc
		If !Empty(cOldDoc) 
			oSection1:Finish()
			oSection1:Init()	
			oSection1:PrintLine()
		EndIf
		cOldDoc:= xFilial("QDH")+TRB->TRB_DOCTO+QDH->QDH_RV
	EndIf	
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Caso parametrizado, quebra pagina por departamento destino   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If TRB->TRB_DEPTO <> cOldDepto
		If !Empty(cOldDepto) .And. mv_par01 == 1
			oSection1:SetPageBreak(.T.) 
			oSection1:Finish()
			oSection1:Init()	
		Else
			oSection1:Finish()
			oSection1:Init()
		EndIf
        oSection1:PrintLine()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime texto do protocolo                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("QD2")
		DbSetOrder(1)
		If QD2->(DbSeek(xFilial("QD2")+QDH->QDH_CODTP))
			If !Empty(QD2->QD2_PROTOC)
				oSection2:Finish()
				oSection2:Init()
				oSection2:Cell("cPROTOCOLO"):SetValue(MSMM(QD2->QD2_PROTOC))
				oSection2:PrintLine()
			Endif	
        Endif

		cOldDepto:= TRB->TRB_DEPTO
	EndIf	

	If FWModeAccess("QAD") == "E" //!Empty(cFilDep)
		cFilDep:= TRB->TRB_FILMAT
	EndIf

	oReport:SkipLine(1) 
	oReport:PrintText(Upper(OemToAnsi(STR0010))+AllTrim(TRB->TRB_DEPTO)+" - "+QA_NDEPT(TRB->TRB_DEPTO,.T.,cFilDep),oReport:Row(),025) //"Departamento: "
	oReport:SkipLine(1)	
    
	cSeek2:=TRB->TRB_FILIAL+TRB->TRB_DOCTO+TRB->TRB_RV+TRB->TRB_FILMAT+TRB->TRB_DEPTO   
	oSection3:Init()
	
	While TRB->(!Eof()) .And. cSeek2 == TRB->TRB_FILIAL+TRB->TRB_DOCTO+TRB->TRB_RV+TRB->TRB_FILMAT+TRB->TRB_DEPTO
		
		oSection3:Cell("cResp"):SetValue(Substr(QA_NUSR(TRB->TRB_FILMAT,TRB->TRB_MAT,.T.),1,23))
	
		IF(TRB->TRB_TIPO =="D")
			oSection3:Cell("cTipo"):SetValue(OemToAnsi(STR0018))//"Usr"
		Else
			oSection3:Cell("cTipo"):SetValue(OemToAnsi(STR0019))//"Pst"
		Endif
				
		oSection3:Cell("cCopias"):SetValue(StrZero(TRB->TRB_COPIAS,4)+"-"+aTxtCopia[IF(Val(TRB->TRB_TPRCBT)==0,4,Val(TRB->TRB_TPRCBT))])
		oSection3:Cell("cData"):SetValue("___/___/___")
		oSection3:Cell("cAssin"):SetValue(Replicate("_",12))
		oReport:SkipLine(1)
		oSection3:PrintLine()

		TRB->(DbSkip())
	EndDo
	oSection3:Finish()
EndDo

Return (.T.)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QDOR062R3³ Autor ³ Newton R. Ghiraldelli ³ Data ³ 18/05/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Aviso de Recebimento de Documentos e Registros da Qualidade³±±
±±³          ³ *** UTILIZADO APENAS NA REEMISSAO DE DOCUMENTOS ***        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QDOR062R3()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAQDO                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Eduardo S.  ³26/12/01³012341³ Acerto para posicionar corretamente na   ³±±
±±³            ³        ³      ³ filial do docto.                         ³±±
±±³Eduardo S.  ³03/09/02³ ---- ³ Acerto para listar corretamente o texto  ³±±
±±³            ³        ³      ³ do protocolo.                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QDOR062R3()

Local cTitulo:= OemToAnsi(STR0001) //"PROTOCOLO DE REEMISSAO DOCUMENTOS"
Local cDesc1 := OemToAnsi(STR0002) //"Este programa ir  imprimir o Protocolo de Reemiss„o de Documentos"
Local cDesc2 := OemToAnsi(STR0003) //"referente as copias dos documentos reemitidos conforme  a selecao"
Local cDesc3 := OemToAnsi(STR0004) //"de usuarios/documentos" 
Local cString:= "QDH" 
Local wnrel  := "QDOR062"
Local Tamanho:= "P"

Private cPerg   := "QDR061"
Private aReturn := { STR0005,1,STR0006, 2, 2, 1, "",1 } //"Zebrado"###"Administra‡„o"
Private nLastKey:= 0
Private Inclui  := .f.	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01	// Quebra por Departamento 1- Sim 2-Nao           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

wnrel := SetPrint(cString,wnrel,cPerg,ctitulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho)
cTitulo:= If(TYPE("NewHead") <> "U",NewHead,cTitulo)

If nLastKey = 27
   Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
   Return
Endif

RptStatus({|lEnd| QDOR062Imp(@lEnd,ctitulo,wnRel,Tamanho)},ctitulo)

Return .t.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QDOR062Imp  ³ Autor ³ Newton R.Ghiraldelli³ Data ³ 18/05/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Envia para funcao que faz a impressao do relatorio.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³QDOR062Imp(lEnd,ctitulo,wnRel,Tamanho)                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpL1 = Logico definindo finalizacao do relatorio          ³±±
±±³          ³ ExpC1 = Caracter contendo titulo do Relatorio              ³±±
±±³          ³ ExpC2 = Caracter contendo o nome do relatorio              ³±±
±±³          ³ ExpC3 = Caracter contendeo o tamanho do relatorio          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR062                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QDOR062Imp(lEnd,ctitulo,wnRel,Tamanho)

Local cCabec1  := ""
Local cOldDoc	:= ""
Local cOldDepto:= ""
Local cSeek2   := ""

Local aTxtCopia:= { STR0014,STR0015,STR0016,STR0017} //"Eletronicas" ### //"Em Papel" ###"Eletronica/Papel" ### "Nao Recebe"
Local cFilDep  := xFilial("QAD")

Private aDriver := ReadDriver()

Li := 80

DbSelectArea("QDH")
DbSetOrder(1)

//           1         2         3         4         5         6         7         8
//012345678901234567890123456789012345678901234567890123456789012345678901234567890
//RESPONSAVEL                  TP  COPIAS                   DATA      ASSINATURA

cCabec1:= OemToAnsi(STR0008) // "RESPONSAVEL                  TP  COPIAS                   DATA      ASSINATURA"

SetRegua(TRB->(LastRec())) // Total de Elementos da Regua

DbSelectArea("TRB")
DbGoTop()
While TRB->(!Eof())
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Caso nao exista Documento, pula o registro                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If !QDH->(dbSeek(TRB->TRB_FILIAL+TRB->TRB_DOCTO+TRB->TRB_RV))
		TRB->(dbSkip())
		Loop
	Endif

	If TRB->TRB_FILIAL+TRB->TRB_DOCTO+TRB->TRB_RV <> cOldDoc
		cOldDoc:= TRB->TRB_FILIAL+TRB->TRB_DOCTO+QDH->QDH_RV
		Li:= 80
	EndIf	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Caso parametrizado, quebra pagina por departamento destino   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If TRB->TRB_DEPTO <> cOldDepto
		If !Empty(cOldDepto) .And. mv_par01 == 1
			Li:= 80
		Else
			If Li > 54
				Cabec062(@Li,cTitulo)
			EndIf
		EndIf
		cOldDepto:= TRB->TRB_DEPTO
	EndIf	

	If Li > 58
		Cabec062(@Li,cTitulo)
	EndIf

	If lEnd
		Li++
		@ PROW()+1,001 PSAY OemToAnsi(STR0009) //"CANCELADO PELO OPERADOR"
		Exit
	EndIf

	If FWModeAccess("QAD") == "E" //!Empty(cFilDep)
		cFilDep:= TRB->TRB_FILMAT
	EndIf
	@ Li,000 PSay Upper(OemToAnsi(STR0010))+AllTrim(TRB->TRB_DEPTO)+" - "+QA_NDEPT(TRB->TRB_DEPTO,.T.,cFilDep) //"Departamento: "
	Li++
	cSeek2:=TRB->TRB_FILIAL+TRB->TRB_DOCTO+TRB->TRB_RV+TRB->TRB_FILMAT+TRB->TRB_DEPTO
	
	@ Li,000 PSay cCabec1
	Li++
	@ Li,000 PSay __PrtFatLine()  
	Li++
	While TRB->(!Eof()) .And. cSeek2 == TRB->TRB_FILIAL+TRB->TRB_DOCTO+TRB->TRB_RV+TRB->TRB_FILMAT+TRB->TRB_DEPTO
		IncRegua()
		If Li > 58
			Cabec062(@Li,cTitulo)
			@ Li,000 PSay Upper(OemToAnsi(STR0010))+AllTrim(TRB->TRB_DEPTO)+" - "+QA_NDEPT(TRB->TRB_DEPTO,.T.,cFilDep) //"Departamento: "
			Li++
			@ Li,000 PSay cCabec1
			Li++
			@ Li,000 PSay __PrtFatLine()  
			Li++
		EndIf

		If lEnd
			Li++
			@ PROW()+1,001 PSAY OemToAnsi(STR0009) //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
		Li++
		@ Li,000 PSay Substr(QA_NUSR(TRB->TRB_FILMAT,TRB->TRB_MAT,.T.),1,23)
		@ Li,024 PSay IF(TRB->TRB_TIPO =="D",OemToAnsi(STR0018),OemToAnsi(STR0019))	// "Usr" ### "Pst"
		@ Li,028 PSay StrZero(TRB->TRB_COPIAS,4)+"-"+aTxtCopia[IF(Val(TRB->TRB_TPRCBT)==0,4,Val(TRB->TRB_TPRCBT))]
		@ Li,055 PSay "___/___/___"
		@ Li,068 PSay Replicate("_",12)
		Li++
		TRB->(DbSkip())
	EndDo
	@ Li,000 Psay __PrtThinLine()
	Li+=2
EndDo

Set Device To Screen
If aReturn[5] == 1
	Set Printer TO 
	dbCommitAll()
	ourspool(wnrel)
Endif
MS_FLUSH()

Return (.T.)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Cabec062  ³ Autor ³ Newton R. Ghiraldelli ³ Data ³ 18/05/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime dados pertinentes ao cabecalho do programa.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec062(Li)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 = Numerico contendo o numero da Linha de impressao   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR062                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Cabec062(Li,cTitulo)
Local nCnt:=0
Local cArqTexto := " "

Li:= 0
If aReturn[4] == 1  // Comprimido
	@ 000,000 PSAY &(aDriver[1])
Else // Normal
	@ 000,000 PSAY &(aDriver[2])
EndIf

@ Li,000 PSay __PrtLogo()
Li+=3
@ Li,000 PSay __PrtCenter(cTitulo) //"AVISO DE RECEBIMENTO DE DOCUMENTOS E REGISTROS DA QUALIDADE"
Li+=3
@ Li,000 PSay Upper(OemToAnsi(STR0012))+AllTrim(QDH->QDH_DOCTO)+"/"+QDH->QDH_RV	//"Documento: "
Li++
@ Li,000 PSay Upper(OemToAnsi(STR0013))+Substr(Alltrim(QDH->QDH_TITULO),1,70)      //"T¡tulo :"
If !Empty(Substr(Alltrim(QDH->QDH_TITULO),71))
	Li++
	@ Li,009 PSay Substr(Alltrim(QDH->QDH_TITULO),71)
EndIf
Li++

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime texto do protocolo                          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("QD2")
DbSetOrder(1)
If QD2->(DbSeek(xFilial("QD2")+QDH->QDH_CODTP))
	nCnt:= 1
	cArqTexto:= Substr(MSMM(QD2->QD2_PROTOC,80),nCnt,80) 
	If !Empty(cArqTexto)
		Li++
		@Li,00 PSAY cArqTexto 
		Li++
		nCnt:= 81
		While !Empty(Substr(MSMM(QD2->QD2_PROTOC,80),nCnt,80))
			@Li,00 PSAY Substr(MSMM(QD2->QD2_PROTOC,80),nCnt,80)
			Li++
			nCnt:= nCnt + 80
		EndDo
	EndIf
EndIf
Li++

Return
