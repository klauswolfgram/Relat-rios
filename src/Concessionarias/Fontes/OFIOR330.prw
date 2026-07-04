/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#Include "OFIOR330.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณOFIOR330  บ Autor ณ Ricardo Farinelli  บ Data ณ  12/06/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de Tabela de Servicos.                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function OFIOR330()
Local oReport
Private cPerg   := "OFR330"
Private cModVei := ""
Private cTpFab  := ""
Private cTpCon  := ""
If FindFunction("TRepInUse") .And. TRepInUse()
	//	ValidPerg()
	pergunte("OFR330",.F.)
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	Return OFR330R3() // Executa versใo anterior do fonte
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ ReportDefณ Autor ณ ANDRE                 ณ Data ณ 23/02/06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Relatorio usando o TReport                                 ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()

Local oReport
Local oSection1
Local oCell

oReport := TReport():New("OFIOR330",OemToAnsi(STR0021),"OFR330",{|oReport| OFIR330IMP(,,,oReport,oSection1,.T.)}) //Tabela de servico

oSection1 := TRSection():New(oReport,OemToAnsi(STR0021),{"VO6","VO7","VVX","VOS"}) 				//Tabela de servico
oSection1:lReadOnly := .T.

TRCell():New(oSection1,"VO6_CODMAR","VO6",STR0022,"@!",TamSx3("VO6_CODMAR")[1])					//Mar
TRCell():New(oSection1,"",,STR0023,"@!",TamSx3("VO7_MODVEI")[1],,{|| cModVei })					//Mod Veiculo
TRCell():New(oSection1,"VO6_SEGMOD","VO6",STR0024,"@!",TamSx3("VO6_SEGMOD")[1])					//Segmento
TRCell():New(oSection1,"VVX_DESSEG","VVX",STR0025,"@!",15,,{|| Substr(VVX->VVX_DESSEG,1,15) })	//Descricao
TRCell():New(oSection1,"VO6_GRUSER","VO6",STR0026,"@!",TamSx3("VO6_GRUSER")[1]) 	 				//Gp
TRCell():New(oSection1,"VOS_DESGRU","VOS",STR0025,"@!",15,,{|| Substr(VOS->VOS_DESGRU,1,15) })	//Descrica
TRCell():New(oSection1,"VO6_CODSER","VO6",STR0028,"@!",TamSx3("VO6_CODSER")[1])					//Cod Servico
TRCell():New(oSection1,"VO6_DESSER","VO6",STR0025,"@!",15,,{|| Substr(VO6->VO6_DESSER,1,15) })	//Descricao
TRCell():New(oSection1,"",,RetTitle("VO6_TEMFAB"),"@!",13,,{|| cTpFab })
TRCell():New(oSection1,"",,RetTitle("VO6_TEMCON"),"@!",13,,{|| cTpCon })
TRCell():New(oSection1,"VO6_AGRSER","VO6",STR0027,"@!",TamSx3("VO6_AGRSER")[1],,{|| If( VO6->VO6_AGRSER == "S",STR0014,STR0015) })//Agr

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณOFR330R3  บAutor  ณFabio               บ Data ณ  06/20/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressao                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function OFR330R3()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local aOrd           := {}
Local cDesc1         := STR0001 // //"Este programa tem como objetivo imprimir a tabela"
Local cDesc2         := STR0002 // //"de Servicos conforme os parametros selecionados. "
Local cDesc3         := ""
Local cPict          := ""
Local imprime        := .T.
Local wnrel          := "OFIOR330"
Local cString        := "VO6"
Private titulo       := STR0003 // //"Tabela de Servicos"
Private nLin         := 80
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private Cabec1       := STR0004 // //"[Marca] [Modelo----------------------] [Segmento-------------------------------] [Grupo Servico------------------] [Cod. Servico-] [Descricao-------------------] [Padrao] [Conces] [Revisao]"
Private Cabec2       := ""
Private nTipo        := 18
Private aReturn      := {STR0005, 1,STR0006 , 1, 2, 1, "", 1} //### //"Zebrado"###"Administracao"
Private nLastKey     := 0
Private cPerg        := "OFR330"
//Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private lEnd         := .F.

dbSelectArea("VO7")
dbSetOrder(1)

dbSelectArea("VO6")
dbSetOrder(2)

pergunte(cPerg,.F.)

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

RptStatus({|lEnd| OFIR330IMP(@lEnd,wnrel,cString)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณOFIR330IMPบ Autor ณ Ricardo Farinelli  บ Data ณ  12/06/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar para a impressao do relatorio de tabela de บฑฑ
ฑฑบ          ณ servicos.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function OFIR330IMP(lEnd,wnrel,cString,oReport,oSection1,lReport)

Local cCondicao      := ""
Local cIndice        := ""
Local cChave         := ""
Local nIndice 		 := 0

Private cTipo  := ""
Private lAbortPrint  := .F.

Default lReport := .f.

If Type("aReturn") # "U"
	nTipo := If(aReturn[4]==1,15,18)
EndIf

cIndice := CriaTrab(nil,.F.)

If !Empty(MV_PAR01)
	cCondicao += "VO6_CODMAR=='"+MV_PAR01+"' "
Endif

If !Empty(MV_PAR03)
	cCondicao += Iif(cCondicao=="","VO6_GRUSER=='"+MV_PAR03+"' "," .and. VO6_GRUSER=='"+MV_PAR03+"' ")
Endif

cChave := "VO6_FILIAL+VO6_CODMAR+VO6_GRUSER+VO6_CODSER"

If cCondicao == ""
	cCondicao:= ".T."
endif

IndRegua(Substr(cChave,1,3),cIndice,cChave,,cCondicao,STR0007) //"Aguarde Selecionando Registro para Impressao"

DbSelectArea("VO6")
nIndice := RetIndex("VO6")
#IFNDEF TOP
	dbSetIndex(cIndice+ordBagExt())
#ENDIF
dbSetOrder(nIndice+1)

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Marca - especificar uma marca, ou branco para todas                                        ณ
//ณMV_PAR02 = Modelo - especificar um modelo, ou branco para todos                                       ณ
//ณMV_PAR03 = Grupo -  especificar um grupo, ou branco para todos                                        ณ
//ณMV_PAR04 = Considera = 1 - Tempo de Fabrica, ou, 2 - Concessionaria, ou , 3 - Ambos                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/

DbselectArea("VO6")

If !lReport
	SetRegua(RecCount())
Else
	oReport:SetMeter(VO6->(LastRec()))
EndIf

If Type("Titulo") # "U"
	Titulo += STR0007+Iif(!Empty(MV_PAR01),Alltrim(MV_PAR01),STR0008) 				//" Marca: "### //"Todas "
	Titulo += STR0009+Iif(!Empty(MV_PAR02),Alltrim(MV_PAR02),STR0009)  				//" Modelo: "### //"Todos "
	Titulo += STR0011+Iif(!Empty(MV_PAR03),Alltrim(MV_PAR03),STR0009) 		 		//" Grupo Srv: "### //"Todos "
	Titulo += STR0012+Iif(MV_PAR04==1,STR0010,Iif(MV_PAR04==2,STR0011,STR0012)) 		//" Tempo: "######### //"Fabrica"###"Conces."###"Ambos"
EndIf         
// Ou seleciona todas as opcoes ou imprime apenas a escolhida.

DbSelectArea("VO6")
DbSeek(xFilial("VO6"))
Do While !VO6->(Eof())
	
	If lAbortPrint .Or. lEnd
		If !lReport
			@nLin,00 PSAY STR0013 // //"*** CANCELADO PELO OPERADOR ***"
		EndIf
		Exit
	Endif
	
	If !lReport
		If nLin > 58
			Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
			nLin := 8
		Endif
	Endif
	
	VOS->(Dbsetorder(1))
	VOS->(Dbseek(xFilial("VOS")+VO6->VO6_CODMAR+VO6->VO6_GRUSER))
	
	VO7->(DbsetOrder(1))
	VO7->(dbSeek(xFilial("VO7")+VO6->VO6_CODMAR+VO6->VO6_CODSER))
	If !VO7->(Eof())
		
		Do While !VO7->(Eof()) .and. VO7->(VO7_FILIAL+VO7_CODMAR+VO7_CODSER)==xFilial("VO7")+VO6->(VO6_CODMAR+VO6_CODSER)

			If !Empty(MV_PAR02)
				If VO7->VO7_MODVEI <> MV_PAR02
					VO7->(dbskip())
				 	Loop
				EndIf
			Endif

			VVX->(DbsetOrder(1))
			VVX->(Dbseek(xFilial("VVX")+VO7->(VO7_CODMAR+VO7_SEGMOD)))
			
			If !lReport
				
				@ nLin,003 PSAY VO6->VO6_CODMAR
				@ nLin,009 PSAY VO7->VO7_MODVEI
				@ nLin,040 PSAY VO7->VO7_SEGMOD+" "+VVX->VVX_DESSEG
				@ nLin,082 PSAY VO6->VO6_GRUSER+" "+Substr(VOS->VOS_DESGRU,1,25)
				@ nLin,116 PSAY VO6->VO6_CODSER
				@ nLin,132 PSAY Substr(VO6->VO6_DESSER,1,30)
				If MV_PAR04==1 .or. MV_PAR04==3
					@ nLin,163 PSAY Transform(VO7->VO7_TEMFAB,"@R 999:99")
				Endif
				If MV_PAR04>=2
					@ nLin,172 PSAY Transform(VO7->VO7_TEMCON,"@R 999:99")
				Endif
				@ nLin,183 PSAY Iif(VO6->VO6_AGRSER=="S",STR0014,STR0015) //### //"Sim"###"Nao"
				nLin++
				
				If nLin > 58
					Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
					nLin := 8
				Endif
				
			Else
				
				oReport:IncMeter()
				If oReport:Cancel()
					Exit
				EndIf
				
				cModVei := VO7->VO7_MODVEI
				cTpFab  := Transform(VO7->VO7_TEMFAB,"@R 999:99")
				cTpCon  := Transform(VO7->VO7_TEMCON,"@R 999:99")
			
				oReport:Section(1):Init()
				oReport:Section(1):PrintLine()
				
			Endif
			VO7->(dbskip())
		Enddo

	Else

		If !Empty(MV_PAR02)
			If VO6->VO6_MODVEI <> MV_PAR02
				VO6->(Dbskip())
			 	Loop
			EndIf
		Endif

		VVX->(DbsetOrder(1))
		VVX->(Dbseek(xFilial("VVX")+VO6->(VO6_CODMAR+VO6_SEGMOD)))
		
		If !lReport
			
			@ nLin,003 PSAY VO6->VO6_CODMAR
			@ nLin,009 PSAY VO6->VO6_MODVEI
			@ nLin,040 PSAY VO6->VO6_SEGMOD+" "+VVX->VVX_DESSEG
			@ nLin,082 PSAY VO6->VO6_GRUSER+" "+Substr(VOS->VOS_DESGRU,1,25)
			@ nLin,116 PSAY VO6->VO6_CODSER
			@ nLin,132 PSAY Substr(VO6->VO6_DESSER,1,30)
			If MV_PAR04==1 .or. MV_PAR04==3
				@ nLin,163 PSAY Transform(VO6->VO6_TEMFAB,"@R 999:99")
			Endif
			If MV_PAR04>=2
				@ nLin,172 PSAY Transform(VO6->VO6_TEMCON,"@R 999:99")
			Endif
			@ nLin,183 PSAY Iif(VO6->VO6_AGRSER=="S",STR0014,STR0015) //### //"Sim"###"Nao"
			nLin++
			
		Else
			
			oReport:IncMeter()
			If oReport:Cancel()
				Exit
			EndIf
			
			cModVei := VO6->VO6_MODVEI
			cTpFab  := Transform(VO6->VO6_TEMFAB,"@R 999:99")
			cTpCon  := Transform(VO6->VO6_TEMCON,"@R 999:99")
			
			oReport:Section(1):Init()
			oReport:Section(1):PrintLine()
			
		Endif
	Endif
	
	If !lReport
		IncRegua()
	EndIf
	
	VO6->(Dbskip())
	
Enddo

If !lReport
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Finaliza a execucao do relatorio...                                 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	SET DEVICE TO SCREEN
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif
	
	MS_FLUSH()
	
Else
	
	oSection1:Finish()
	
EndIf

DbSelectArea("VO6")
RetIndex()

#IFNDEF TOP
	If File(cIndice+OrdBagExt())
		fErase(cIndice+OrdBagExt())
	Endif
#ENDIF

Return