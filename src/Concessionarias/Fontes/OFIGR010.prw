/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ษออออออออหออออออออป
// บ Versao บ 08     บ
// ศออออออออสออออออออผ
#INCLUDE "OFIGR010.ch"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณOFIGR010  บ Autor ณ Valdir F. Silva    บ Data ณ  03/07/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de reclamacoes (Scania)                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function OFIGR010()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local aOrd           := {}
Local cDesc1         := STR0001 //"Este programa tem como objetivo imprimir a relacao de "
Local cDesc2         := STR0002 //"Relatorios de reclamacoes"
Local cDesc3         := ""
Local cPict          := ""
Local imprime        := .T.
Local wnrel          := "OFIGR010"
Local cString        := "VG8"
Local cIndice        := ""
Local cChave         := ""
Local cCondicao      := ""
Local nIndice 		   := 0
Local cMontadora     := ""

Private titulo       := STR0003 //"Relatorio de reclamacoes"
Private nLin         := 80
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 220
Private tamanho      := "G"
Private Cabec1       := STR0004 //"[Nro Osv-][Dt.Abe] [Ch.I] [Chassi do Veiculo------] [Modelo----------------------] [Descricao do Modelo-----------] [Cod Pro] [Proprietario------------------------]"
Private Cabec2       := STR0005 //"          [Ano] [Nro RR] [Rec] [CdGar] [T] [R] [NF 1--] [NF 2--] [Ser] [GS] [Cod Servico---] [Grp-] [Cod da Peca----------------] [Def] [SerConjun] [TipCon] [CodCam] [TesCam] [Km Pick] [KmGui-] "
Private nTipo        := 15
Private aReturn      := {STR0006, 1,STR0007, 1, 2, 1, "", 1} //"Zebrado"###"Administracao"
Private nLastKey     := 0
Private cPerg        := "OFG010"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01

//ValidPerg()

pergunte(cPerg,.F.)

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

cMontadora := Fg_Marca("SCANIA",,.F.) // Traz o codigo de montadora padrao da Volkswagem
cIndice    := CriaTrab(nil,.F.)
VG8->(DbSetOrder(1)) // por numero de OS

cCondicao += "VG8->VG8_CODMAR=='"+cMontadora+"'"

If MV_PAR03 == 2
	cCondicao += ".and. VG8->VG8_EXCLUI = 'S'"
EndIf

If !Empty(MV_PAR01)
	cCondicao += ".and. DTOS(VG8->VG8_ABEGAR)>='"+DTOS(MV_PAR01)+"'"
Endif

If !Empty(MV_PAR02)
	cCondicao += ".and. DTOS(VG8->VG8_ABEGAR) <='"+DTOS(MV_PAR02)+"'"
Endif

// Foi incluso uma chave condicional porque nao existe no arquivo a ser lido, uma chave
// que identifique primeiro pecas e depois servicos

cChave := "VG8_FILIAL+VG8_CODMAR+VG8_NUMOSV"

IndRegua("VG8",cIndice,cChave,,cCondicao,STR0008) //"Aguarde Selecionando Registro para Impressao"

DbSelectArea("VG8")
nIndice := RetIndex("VG8")
#IFNDEF TOP
	dbSetIndex(cIndice+ordBagExt())
#ENDIF
dbSetOrder(nIndice+1)

RptStatus({|lEnd| U_OFIG010IMP(@lEnd,wnrel,cString)},Titulo)

DbSelectArea("VG8")
RetIndex()

#IFNDEF TOP
	If File(cIndice+OrdBagExt())
		fErase(cIndice+OrdBagExt())
	Endif
#ENDIF

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณOFIG010IMPบ Autor ณ Valdir F. Silva    บ Data ณ  03/07/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar para a impressao do relatorio              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function OFIG010IMP(lEnd,wnrel,cString)

Local nTotSrv  := 0 // Total vlr servico da os
Local nTotPec  := 0 // Total vlr pecas   da os
Local nTotSrvG := 0 // Total vlr servico geral
Local nTotPecG := 0 // Total vlr pecas geral
Local lImpPec  := .F. , lImpSrv  := .F.
Local nTotQtdP := 0 // Total qtde pecas da os
Local nTotQtdH := 0 // Total qtde horas da os
Local nTotOS   := 0 // Total por OS
Local nLinObs  := 0
/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Data Inicial - Data de inicio ou branco para desde o comeco                                ณ
//ณMV_PAR02 = Data Final - Data final para o escopo do relatorio                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/
SB1->(DbSetOrder(1))
VO6->(Dbsetorder(1))

DbselectArea("VG8")

SetRegua(RecCount())

Titulo +=STR0009+dToc(MV_PAR01) //" de "
Titulo +=STR0010+dToc(MV_PAR02) //" a "

DbSeek(xFilial("VG8"))
Do While VG8->VG8_FILIAL == xFilial("VG8") .and. !VG8->(Eof())
	
	If lAbortPrint .or. lEnd
		@nLin,00 PSAY STR0011 //"*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif

   DbSelectArea("VG6")
	DbSetOrder(5)
	If (Empty(VG8->VG8_NUMRRC) .Or. Empty(VG8->VG8_ANORRC)) ;
		.And. !Dbseek(xFilial("VG6")+VG8->VG8_CODMAR+VG8->VG8_NUMOSV+VG8->VG8_ANORRC+VG8->VG8_NUMRRC)
		IncRegua()
		DbSelectArea("VG8")
		DbSkip()           
		Loop
	EndIf
	
	If nLin > 58
		Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
		nLin := 9
	Endif
	
	VV1->(DbSetOrder(1))
	VV1->(Dbseek(xFilial("VV1")+VG8->VG8_CHAINT))
	VV2->(DbSetOrder(1))
	VV2->(DbSeek(xFilial("VV2")+VV1->VV1_CODMAR+VV1->VV1_MODVEI+VV1->VV1_SEGMOD))
	SA1->(DbSetOrder(1))
	SA1->(DbSeek(xFilial("SA1")+VV1->VV1_PROATU+VV1->VV1_LJPATU))

	//Primeira linha do Cabec
	@ nLin,001 PSAY VG8->VG8_NUMOSV+" "+transform(VG8->VG8_ABEGAR,"@D")+" "+VG8->VG8_CHAINT+" "+VV1->VV1_CHASSI+" "+VV1->VV1_MODVEI+" "+VV2->VV2_DESMOD+" "+SA1->A1_COD+"-"+SA1->A1_LOJA+" "+SA1->A1_NOME
	nLin++

	//Segunda linha do Cabec	
//           10    16       25    31      39  43  47       56       65    71   76               93     100                           130   136         148      157      166      175       185
//           01234 67890123 56789 1234567 901 345 78901234 67890123 56789 1234 6789012345678901 345678 01234567890123456789012345678 01234 67890123456 89012345 78901234 67890123 567890123 56789012
//"          [Ano] [Nro RR] [Rec] [CdGar] [T] [R] [NF 1--] [NF 2--] [Ser] [GS] [Cod Servico---] [Grp-] [Cod da Peca----------------] [Def] [SerConjun] [TipCon] [CodCam] [TesCam] [Km Pick] [KmGui-] "
  
	@ nLin,010 PSAY VG8->VG8_ANORRC+" "+VG8->VG8_NUMRRC+" "+VG8->VG8_CODREC+" "+VG8->VG8_CODGAR+" "+VG8->VG8_TRANSM+" "+VG8->VG8_RECONS+" "+;
	VG8->VG8_NF1REM+" "+VG8->VG8_NF2REM+" "+VG8->VG8_SERNFI+" "+VG8->VG8_GRUSER+" "+VG8->VG8_CODSER+" "+VG8->VG8_GRUITE+" "+VG8->VG8_ITECAU+" "+;
	VG8->VG8_CODDEF+" "+Transform(VG8->VG8_SERCON,"@E 999999999")+" "+VG8->VG8_TIPCON+" "+Transform(VG8->VG8_CODCAM,"@E 999999")+" "+Transform(VG8->VG8_TESCPO,"@E 999999")+" "+;
	Transform(VG8->VG8_KILPIC,"@E 999999")+" "+Transform(VG8->VG8_KILGUI,"@E 999999")
	nLin++


//	@ nLin,001 PSAY STR0012+Left(VG8->VG8_MOTREC,141) //'Motivo -> '
	@ nLin,004 PSAY STR0020  

   DbSelectArea("SYP")
   DbSeek(xFilial("SYP")+VG8->VG8_OBSMEM )
           
	nLinObs := 3
   Do While !Eof() .And. SYP->YP_CHAVE == VG8->VG8_OBSMEM .And. SYP->YP_FILIAL == xFilial("SYP")
      
		//If nLinObs <= 1
//			nLinObs += 1
//		Else  
//			If nLinObs < 3
//				nLin++
//			EndIf	
//			nLinObs := 1   
//			@ nLin,004 PSAY " "
//		EndIf

      @ nLin,015 PSAY RTrim(Stuff(SYP->YP_TEXTO, If( (nPos:=At("\13\10",SYP->YP_TEXTO))<=0 ,80,nPos) ,6,Space(6)))
      nLin++
      
      DbSkip()

   EndDo
	nLin++	
	
	If nLin > 58
		Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
		nLin := 9
	Endif
	
	nTotPec := 0
	nTotQtdP:= 0
	lImpPec := .F.
	
   DbSelectArea("VG6")
	DbSetOrder(2)
	Dbseek(xFilial("VG6")+VG8->VG8_CODMAR+VG8->VG8_NUMOSV)
	
	Do While VG6->(VG6_FILIAL+VG6_CODMAR+VG6_NUMOSV) == VG8->(VG8_FILIAL+VG8_CODMAR+VG8_NUMOSV) .and. !VG6->(Eof())

		If !( VG6->VG6_NUMRRC == VG8->VG8_NUMRRC .And. VG6->VG6_ANORRC == VG8->VG8_ANORRC )
			DbSelectArea("VG6")
			DbSkip()
			Loop		
		EndIf
		
		If (!Empty(VG6->VG6_CODITE).Or.!Empty(VG6->VG6_PECINT))
		
			If !lImpPec
				@ nLin,004 PSAY STR0008 //"[Gr] [Codigo da Peca-----------] [Descricao---------] [Qtde] [Valor---] [Esp]"
				nLin++
				lImpPec := .T.
				nLin++
				If nLin > 58
					Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
					nLin := 9
				Endif
			Endif
			SB1->(Dbseek(xFilial("SB1")+VG6->VG6_PECINT))

			@ nLin,004 PSAY VG6->VG6_GRUITE+" "+VG6->VG6_CODITE+" "+Substr(SB1->B1_DESC,1,20)+" "+Transform(VG6->VG6_QTDITE,"@E 999999")+" "+Transform(VG6->VG6_VALITE,"@E 999,999.99")+" "+VG6->VG6_ITEEXT
			nLin++

			If nLin > 58
				Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
				nLin := 9
			Endif
			nTotPec +=  VG6->VG6_VALITE
			nTotPecG+=  VG6->VG6_VALITE
			nTotQtdP+=  VG6->VG6_QTDITE

		EndIf

		VG6->(Dbskip())

	Enddo
	
	If lImpPec

		@ nLin,046 PSAY STR0018+" "+Transform(nTotQtdP,"@E 999999")+" "+Transform(nTotPec, "@E 999,999.99")
		nLin++

		If nLin > 58
			Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
			nLin := 9
		Endif
	Endif

	nTotSrv := 0
	nTotQtdH:= 0
	lImpSrv := .F.

   DbSelectArea("VG6")
	DbSetOrder(1)
	Dbseek(xFilial("VG6")+VG8->VG8_CODMAR+VG8->VG8_NUMOSV)

	Do While VG6->(VG6_FILIAL+VG6_CODMAR+VG6_NUMOSV) == VG8->(VG8_FILIAL+VG8_CODMAR+VG8_NUMOSV) .and. !VG6->(Eof())

		If !( VG6->VG6_NUMRRC == VG8->VG8_NUMRRC .And. VG6->VG6_ANORRC == VG8->VG8_ANORRC )
			DbSelectArea("VG6")
			DbSkip()
			Loop		
		EndIf

		If (!Empty(VG6->VG6_CODSER).Or.!Empty(VG6->VG6_SERINT))
		
			VO6->(Dbseek(xFilial("VO6")+VG6->VG6_SERINT))
			If !lImpSrv
				@ nLin,004 PSAY STR0014 //"[Gr] [Codigo do Servico--------] [Descricao---------] [Tmp-] [Valor---] [Esp]"
				nLin++
				If nLin > 58
					Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
					nLin := 9
				Endif
				lImpSrv := .T.
			Endif

			@ nLin,004 PSAY VO6->VO6_GRUSER+" "+VO6->VO6_CODSER+" "+VO6->VO6_DESABR+" "+Transform(VO6->VO6_TEMFAB,"@E 999:99")+" "+Transform(VG6->VG6_VALSER,"@E 999,999.99")+" "+VG6->VG6_SEREXT
			nLin++

			If nLin > 58
				Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
				nLin := 9
			Endif
			nTotSrv   += VG6->VG6_VALSER
			nTotSrvG  += VG6->VG6_VALSER
			nTotQtdH  += VO6->VO6_TEMFAB

		EndIf
		
		VG6->(Dbskip())

	Enddo
	
	If lImpSrv

		@ nLin,046 PSAY STR0018+" "+Transform(nTotQtdH,"@E 999:99")+" "+Transform(nTotSrv, "@E 999,999.99")
		nLin++

		If nLin > 58
			Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
			nLin := 9
		Endif
	Endif

	nTotOS += ntotPec
	lImppec := .F.
	lImpSrv := .F.
	
	nTotOS += nTotSrv
	@ nLin,039 PSAY STR0015+Transform(nTotOS,"@E 99,999,999,999.99") //"Total da OS.: "
	nLin++
	@ nLin++,045 PSAY ""
	If nLin > 58
		Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
		nLin := 9
	Endif
	nTotOs := 0

	IncRegua()
	DbSelectArea("VG8")
	DbSkip()
Enddo         

@ nLin,004 PSAY STR0016+Transform(nTotPecG,"@E 9,999,999.99")+Space(20)+STR0019+Transform(nTotSrvG,"@E 9,999,999.99")+Space(20)+STR0017+Transform(nTotSrvG+nTotPecG,"@E 999,999,999.99") //"Total Pecas: "###" Total: "###" Total Servicos: "      
nLin++
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

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVALIDPERG บ Autor ณ Valdir F. Silva    บ Data ณ  03/07/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Verifica a existencia das perguntas criando-as caso seja   บฑฑ
ฑฑบ          ณ necessario (caso nao existam).                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
/*
Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01",STR0015,"","","mv_ch1","D", 03,0,0,"G",          "","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""}) //"Data Inicial      ?"
aAdd(aRegs,{cPerg,"02",STR0016,"","","mv_ch2","D", 30,0,0,"G",          "","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""}) //"Data Final        ?"
Aadd(aRegs,{cPerg,"03",STR0017,"","","mv_ch3","N", 01,0,0,"C","NaoVazio()","mv_par03",STR0018,"","","","",STR0019,"","","","","","","","","","","","","","","","","","","",""}) //"Tipo Relatorio    ?"###"Todas as RR"###"Somente as Excluidas"

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

dbSelectArea(_sAlias)

Return
*/
