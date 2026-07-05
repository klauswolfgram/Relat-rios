/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 17     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#INCLUDE "ofior190.ch"

Static XPAR01 := "", XPAR02 := "", XPAR03 := "", XPAR04 := "", XPAR05 := "", XPAR06 := "", XPAR07 := "", XPAR08 := ""
Static XPAR09 := "", XPAR10 := "", XPAR11 := "", XPAR12 := "", XPAR13 := "", XPAR14 := "", XPAR15 := "", XPAR16 := ""
Static XPAR17 := "", XPAR18 := "", XPAR19 := "", XPAR20 := "", XPAR21 := "", XPAR22 := "", XPAR23 := "", XPAR24 := "", XPAR25 := "",XPAR26 := ""

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ OFIOR190 ³ Autor ³  Fabio                ³ Data ³ 09/02/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Analise Tempo da Oficina                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ (Veiculos)                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function OFIOR190

PRIVATE aReturn  := { OemToAnsi(STR0001), 1,OemToAnsi(STR0002), 2, 2, 2,,1 } //"Vendedor"###"Nome"
Private cAlias ,cNomRel , cPerg , cTitulo, cDesc1, cDesc2 , cDesc3, aOrdem , lHabil := .f. , wnRel , NomeRel
Private cAliasVO4 := "SQLVO4"
Private cAliasVSC := "SQLVSC"
Private cAliasVAI := "SQLVAI"
Private cAliasVV1 := "SQLVV1"
Private cAliasVV2 := "SQLVV2"
Private cAliasVO1 := "SQLVO1"
Private cAliasVO2 := "SQLVO2"

cAlias := "VO1"
cNomRel:= "OFIOR190"
cPerg := "OFR190"
cTitulo:= STR0003 //"Analise Tempo da Oficina"
cDesc1 := STR0003 //"Analise Tempo da Oficina"
cDesc2 := cDesc3 := ""
aOrdem := {STR0004} //"Numero da OS"
lHabil := .f.
lTSProb := .f.
wnRel  := cTamanho:= "M"
cTipo := ""


NomeRel:= SetPrint(cAlias,cNomRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,lHabil,,,cTamanho)

If nlastkey == 27
	Return
EndIf

Pergunte("OFR190",.f.)

XPAR01 := MV_PAR01
XPAR02 := MV_PAR02

XPAR03 := MV_PAR03
XPAR03 += MV_PAR04

XPAR04 := MV_PAR05
XPAR05 := MV_PAR06
XPAR06 := MV_PAR07
XPAR07 := MV_PAR08
XPAR08 := MV_PAR09
XPAR09 := MV_PAR10
XPAR10 := MV_PAR11
XPAR11 := MV_PAR12
XPAR12 := MV_PAR13
XPAR13 := MV_PAR14
XPAR14 := MV_PAR15
XPAR15 := MV_PAR16
XPAR16 := MV_PAR17
XPAR17 := MV_PAR18
XPAR18 := MV_PAR19
XPAR19 := MV_PAR20
XPAR20 := MV_PAR21
XPAR21 := MV_PAR22
XPAR22 := MV_PAR23
XPAR23 := MV_PAR24
XPAR24 := MV_PAR25
XPAR25 := MV_PAR26
XPAR26 := MV_PAR27 //ONIBUS;CAMINHAO OU AMBOS
XPAR27 := MV_PAR28
XPAR28 := MV_PAR29
XPAR29 := MV_PAR30

cTitulo:= STR0003  + " - " //+ XPAR26      //"Analise Tempo da Oficina"


VV1->(dbsetorder(1))
VV2->(dbsetorder(1))
VO2->(dbsetorder(2))

SetDefault(aReturn,cAlias)

RptStatus( { |lEnd| FS_IMPOR190(@lEnd,wnRel,'VO1') } , cTitulo )

If aReturn[5] == 1
	
	OurSpool( cNomRel )
	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_IMPOR17ºAutor  ³Fabio               º Data ³  12/27/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime relatorio                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_IMPOR190()

Local bLinha := {|nSoma,cMecFun| FS_LINHA( nSoma , cMecFun ) }
Local aVetCampos := {} , cCodPro , cXString := "" , cSomaPass := "" , cMecFun := "M"
Local cArqTra , cArqInd1 , cArqInd2 , cArqInd3 , cArqVO4 , nIndVO4 := 0 , cChave , nBarra := 0 , nCol := 0 , nRegTrb := 0, ix1 := 0
Local nATO21 := 0 , nATO22 := 0, nATO23 := 0, dDatTra , nTemDis := 0, nRecNo := 0
Local aVetWrk := {}
Private nLin := 1 , lAbortPrint := .f.

Set Printer to &NomeRel
Set Printer On
Set device to Printer

&& Cria Arquivo de Trabalho
aAdd(aVetCampos,{ "TRB_MECFUN" , "C" , 1 , 0 })  && Mecanica ou Funilaria
aAdd(aVetCampos,{ "TRB_DATABE" , "D" , 8 , 0 })  && Data da Abertura
aAdd(aVetCampos,{ "TRB_TTOTAL" , "C" , 1 , 0 })  && Linha do total
aAdd(aVetCampos,{ "TRB_CODPRO" , "C" , 6 , 0 })  && Codigo do Produtivo
aAdd(aVetCampos,{ "TRB_NUMOSV" , "C" , 8 , 0 })  && Numero da Ordem de Servico
aAdd(aVetCampos,{ "TRB_ATO01"  , "N" , 12, 0 })  && CR/CF
aAdd(aVetCampos,{ "TRB_ATO02"  , "N" , 12, 0 })  && GR/GF
aAdd(aVetCampos,{ "TRB_ATO03"  , "N" , 12, 0 })  && CM/CP
aAdd(aVetCampos,{ "TRB_ATO04"  , "N" , 12, 0 })  && GM/GP
aAdd(aVetCampos,{ "TRB_ATO05"  , "N" , 12, 0 })  && IV
aAdd(aVetCampos,{ "TRB_ATO06"  , "N" , 12, 0 })  && IU
aAdd(aVetCampos,{ "TRB_ATO07"  , "N" , 12, 0 })  && IP
aAdd(aVetCampos,{ "TRB_ATO08"  , "N" , 12, 0 })  && IA
aAdd(aVetCampos,{ "TRB_ATO09"  , "N" , 12, 0 })  && PO
aAdd(aVetCampos,{ "TRB_ATO10"  , "N" , 12, 0 })  && TP
aAdd(aVetCampos,{ "TRB_ATO11"  , "N" , 12, 0 })  && GO
aAdd(aVetCampos,{ "TRB_ATO12"  , "N" , 12, 0 })  && AR
aAdd(aVetCampos,{ "TRB_ATO13"  , "N" , 12, 0 })  && FE
aAdd(aVetCampos,{ "TRB_ATO14"  , "N" , 12, 0 })  && TRE
aAdd(aVetCampos,{ "TRB_ATO15"  , "N" , 12, 0 })  && ANR
aAdd(aVetCampos,{ "TRB_ATO16"  , "N" , 12, 0 })  && CR/CF
aAdd(aVetCampos,{ "TRB_ATO17"  , "N" , 12, 0 })  && GR/GF
aAdd(aVetCampos,{ "TRB_ATO18"  , "N" , 12, 0 })  && CM/CP
aAdd(aVetCampos,{ "TRB_ATO19"  , "N" , 12, 0 })  && GM/GP
aAdd(aVetCampos,{ "TRB_ATO20"  , "N" , 12, 0 })  && HE
aAdd(aVetCampos,{ "TRB_ATO21"  , "N" , 12, 0 })  && Tempo Disponivel
aAdd(aVetCampos,{ "TRB_ATO22"  , "N" , 12, 0 })  && Total Remunerado
aAdd(aVetCampos,{ "TRB_ATO23"  , "N" , 12, 0 })  && Tempo Normal
aAdd(aVetCampos,{ "TRB_ATO24"  , "N" , 12, 0 })  && Interno SG/SC
aAdd(aVetCampos,{ "TRB_ATO25"  , "N" , 12, 0 })  && Tempo Trabalhado
aAdd(aVetCampos,{ "TRB_QMEC"   , "N" , 6 , 0 })  && Quantidade de Mecanicos dia.
aAdd(aVetCampos,{ "TRB_QPIN"   , "N" , 6 , 0 })  && Quantidade de Pintores dia.
aAdd(aVetCampos,{ "TRB_TPDESL" , "N" ,12 , 0 })  && Tempo de Deslocamento
aAdd(aVetCampos,{ "TRB_DESLOC", "N" ,12 , 0 })  && Tempo de Deslocamento
aAdd(aVetCampos,{ "TRB_INTREP" , "N" ,12 , 0 })  && Interno reparo.
aAdd(aVetCampos,{ "TRB_TIPSER" , "C" , 3 , 0 })  && Tipo de servico.

cArqInd1 := CriaTrab(NIL, .F.)
cArqInd2 := CriaTrab(NIL, .F.)
oObjTempTable := OFDMSTempTable():New()
oObjTempTable:cAlias := "TRB"
oObjTempTable:aVetCampos := aVetCampos
oObjTempTable:AddIndex(cArqInd1, {"TRB_MECFUN","TRB_TTOTAL","TRB_DATABE","TRB_CODPRO","TRB_NUMOSV"} )
oObjTempTable:AddIndex(cArqInd2, {"TRB_MECFUN","TRB_TTOTAL","TRB_CODPRO","TRB_DATABE","TRB_NUMOSV"} )
oObjTempTable:CreateTable()

&& Levantamento dos dados

//********** Levanta os tempos disponivel dos produtivos **************************
//
// caso o seek acima nao tenha posicionado na data exata, precisamos conferir o que os
// tecnicos estavam fazendo no periodo compreendido entre a data do parametro e a
// primeira data do seek
//
SetRegua( XPAR21-XPAR20 )

For dDatTra := XPAR20 to XPAR21
	
	SX5->(DbSeek(xFilial("SX5")+"63"))
	
	lRet := .f.
	While !Eof() .and. SX5->X5_TABELA == "63" .and. lRet = .f.// Feriados
		if !Empty(substr(SX5->X5_DESCRI,7,1))
			cDia  := strzero(day(dDatTra),2)
			cMes  := strzero(Month(dDatTra),2)
			cAno  := strzero(val(substr(dtoc(dDatTra),7,2)),2)
			cAno1 := strzero(year(dDatTra),4)
			if cDia+"/"+cMes+"/"+cAno $ SX5->X5_DESCRI .or. cDia+"/"+cMes+"/"+cAno1 $ SX5->X5_DESCRI
				lRet := .t. //dDatTra++
			Endif
		Else
			if ( ( strzero(day(dDatTra),2)+"/"+strzero(Month(dDatTra),2) ) == left(SX5->X5_DESCRI,5) )
				lRet := .t. //dDatTra++
			Endif
		Endif
		DbSelectArea("SX5")
		DbSkip()
	EndDo
	
	If lRet
		loop
	EndIf
	
	//
	// Percorre o cadastro de tecnicos
	//
	cQuery := "SELECT VAI.VAI_FUNPRO,VAI.VAI_CODTEC,VAI.VAI_FUNCAO "
	cQuery += "FROM "
	cQuery += RetSqlName( "VAI" ) + " VAI "
	cQuery += "WHERE "
//	cQuery += "VAI.VAI_FILIAL='"+ xFilial("VAI")+ "' AND VAI.VAI_DATDEM = '        ' AND VAI.VAI_DATDEM <= '"+dtos(dDatTra)+"' AND "
	cQuery += "VAI.VAI_FILIAL='"+ xFilial("VAI")+ "' AND (VAI.VAI_DATDEM = '        ' OR VAI.VAI_DATDEM >= '"+dtos(dDatTra)+"' ) AND "
	cQuery += "VAI.D_E_L_E_T_=' ' "
	
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVAI, .T., .T. )
	
	Do While !( cAliasVAI )->( Eof() )
		// se o sujeito foi demitido passa para o proximo - Filtro feito na query
		// se o sujeito for produtivo
		If ( cAliasVAI )->VAI_FUNPRO == "1"
			
			nTemDis := FG_CALTEM(( cAliasVAI )->VAI_CODTEC,dDatTra,"0")
			If nTemDis != 0
				FS_GRATRAB("        ", dDatTra , ( cAliasVAI )->VAI_CODTEC , "   " , nTemDis , 0 , 0 , "X" ,,, )
			EndIf
			
		EndIf
		DbSelectArea(cAliasVAI)
		( cAliasVAI )->(DbSkip())
	EndDo
	( cAliasVAI )->( dbCloseArea() )
	
	IncRegua()
Next
//*****************************************************

//************************** Levanta tempos trabalhados
/*cQuery := "SELECT VO4.VO4_NOSNUM,VO4.VO4_DATINI,VO4.VO4_CODPRO,VO4.VO4_TIPSER,VO4.VO4_TEMTRA,VO4.VO4_HOREXT,VO1.VO1_NUMOSV,VO4.VO4_TEMPAD,VO4.VO4_DATINI,VO1.VO1_NUMOSV,VO1.VO1_CHAINT,VO4.VO4_TEMAUS,VO4.VO4_TIPAUS,VO4.VO4_TIPTEM "
cQuery += "FROM "
cQuery += RetSqlName( "VO4" ) + " VO4 , "+RetSqlName( "VO2" ) + " VO2 , "+RetSqlName( "VO1" ) + " VO1 "
cQuery += "WHERE "
cQuery += "VO4.VO4_FILIAL='"+ xFilial("VO4")+ "' AND VO4.VO4_NOSNUM = VO2.VO2_NOSNUM AND VO2.VO2_NUMOSV = VO1.VO1_NUMOSV AND VO4.VO4_DATINI >= '"+dtos(XPAR20)+"' AND VO4.VO4_DATINI <= '"+dtos(XPAR21)+"' AND VO4.VO4_CODPRO <> '      ' AND VO4.VO4_DATCAN = '        ' AND "
cQuery += "VO4.D_E_L_E_T_=' ' AND VO2.D_E_L_E_T_=' ' AND VO1.D_E_L_E_T_=' ' ORDER BY VO4.VO4_DATINI,VO4.VO4_CODPRO"

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVO4, .T., .T. )
*/

cQuery := "SELECT VO4.VO4_NOSNUM,VO4.VO4_DATINI,VO4.VO4_CODPRO,VO4.VO4_TIPSER,VO4.VO4_TEMTRA,VO4.VO4_HOREXT,VO4.VO4_TEMPAD,VO4.VO4_DATINI,VO4.VO4_TEMAUS,VO4.VO4_TIPAUS,VO4.VO4_TIPTEM "
cQuery += "FROM "
cQuery += RetSqlName( "VO4" ) + " VO4 "
cQuery += "WHERE "
cQuery += "VO4.VO4_FILIAL='"+ xFilial("VO4")+ "' AND VO4.VO4_DATINI >= '"+dtos(XPAR20)+"' AND VO4.VO4_DATINI <= '"+dtos(XPAR21)+"' AND VO4.VO4_CODPRO <> '      ' AND VO4.VO4_DATCAN = '        ' AND "
cQuery += "VO4.D_E_L_E_T_=' ' ORDER BY VO4.VO4_DATINI,VO4.VO4_CODPRO"

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVO4, .T., .T. )

SetRegua(( cAliasVO4 )->( RecCount() ))

Do While !( cAliasVO4 )->( Eof() )
	
	//  Nao Deletar
	//           If !empty(XPAR26)
	//              If VAI->VAI_CODTEC != XPAR26
	//                 dbSkip()
	//                 Loop
	//              EndIf
	//           EndIf
	if !Empty(mv_par33)
		dbSelectArea("VO1")
		dbSetOrder(1)
		dbSeek(xFilial("VO1")+(cAliasVO4)->VO4_NOSNUM)
		dbSelectArea("VO1")
		dbSetOrder(1)
		dbSeek(xFilial("VO1")+VO1->VO1_CHAINT)
		if !(VV1->VV1_CODMAR $ mv_par33)
			dbSelectArea(cAliasVO4)
			(cAliasVO4)->(dbSkip())
			Loop
		Endif
	Endif
	If Empty(( cAliasVO4 )->VO4_TIPAUS)  // Quando e tempo normal trabalhado
		
		If Select(cAliasVO2) > 0
			( cAliasVO2 )->( DbCloseArea() )
		EndIf
		cQuery := "SELECT VO2.VO2_NUMOSV "
		cQuery += "FROM "+RetSqlName( "VO2" ) + " VO2 "
		cQuery += "WHERE "
		cQuery += "VO2.VO2_FILIAL='"+ xFilial("VO2")+ "' AND VO2.VO2_NOSNUM = '"+(cAliasVO4)->VO4_NOSNUM+"' AND "
		cQuery += "VO2.D_E_L_E_T_=' ' ORDER BY VO2.VO2_NUMOSV"
		
		dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVO2, .T., .T. )
		
		If Select(cAliasVO1) > 0
			( cAliasVO1 )->( DbCloseArea() )
		EndIf
		cQuery := "SELECT VO1.VO1_NUMOSV,VO1.VO1_CHAINT "
		cQuery += "FROM "+RetSqlName( "VO1" ) + " VO1 "
		cQuery += "WHERE "
		cQuery += "VO1.VO1_FILIAL='"+ xFilial("VO1")+ "' AND VO1.VO1_NUMOSV = '"+(cAliasVO2)->VO2_NUMOSV+"' AND "
		cQuery += "VO1.D_E_L_E_T_=' ' ORDER BY VO1.VO1_NUMOSV"
		
		dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVO1, .T., .T. )
		
		If Select(cAliasVV1) > 0
			( cAliasVV1 )->( DbCloseArea() )
		EndIf
		cQuery := "SELECT VV1.VV1_CODMAR, VV1.VV1_MODVEI, VV1.VV1_SEGMOD "
		cQuery += "FROM " + RetSqlName( "VV1" ) + " VV1 "
		cQuery += "WHERE VV1.VV1_FILIAL = '"+xFilial("VV1")+"' AND VV1.D_E_L_E_T_=' ' AND "
		cQuery += "VV1.VV1_CHAINT='"+( cAliasVO1 )->VO1_CHAINT+"'"
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cAliasVV1 , .F., .T. )
		
		If Select(cAliasVV2) > 0
			( cAliasVV2 )->( DbCloseArea() )
		EndIf
		cQuery := "SELECT VV2.VV2_CODMAR,VV2.VV2_MODVEI,VV2.VV2_SEGMOD,VV2.VV2_TIPVEI "
		cQuery += "FROM " + RetSqlName( "VV2" ) + " VV2 "
		cQuery += "WHERE VV2.VV2_FILIAL = '"+xFilial("VV2")+"' AND VV2.D_E_L_E_T_=' ' AND "
		//	cQuery += "VV2.VV2_CODMAR='"+( cAliasVV1 )->VV1_CODMAR+"' AND VV2.VV2_MODVEI='"+( cAliasVV1 )->VV1_MODVEI+"' AND VV2.VV2_SEGMOD='"+( cAliasVV1 )->VV1_SEGMOD+"'"
		cQuery += "VV2.VV2_CODMAR='"+( cAliasVV1 )->VV1_CODMAR+"' AND VV2.VV2_MODVEI='"+( cAliasVV1 )->VV1_MODVEI+"'"
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cAliasVV2 , .F., .T. )
		
		If mv_par27 = 1 .and. !( cAliasVV2 )->VV2_TIPVEI $ mv_par30 //Somente Veic. Passeio
			DbSelectArea(cAliasVO4)
			( cAliasVO4 )->(DbSkip())
			loop
			
		ElseIf mv_par27 = 2 .and. !( cAliasVV2 )->VV2_TIPVEI $ mv_par28 .and. !( cAliasVV2 )->VV2_TIPVEI $ mv_par29 //Caminhoes/Onibus
			DbSelectArea(cAliasVO4)
			( cAliasVO4 )->(DbSkip())
			loop
			
		ElseIf mv_par27 = 3 .and. !( cAliasVV2 )->VV2_TIPVEI $ mv_par28 //Somente Caminhoes
			DbSelectArea(cAliasVO4)
			( cAliasVO4 )->(DbSkip())
			loop
			
		ElseIf mv_par27 = 4 .and. !( cAliasVV2 )->VV2_TIPVEI $ mv_par29 //Somente Onibus
			DbSelectArea(cAliasVO4)
			( cAliasVO4 )->(DbSkip())
			loop
			
		ElseIf Empty(( cAliasVV2 )->VV2_TIPVEI)
			DbSelectArea(cAliasVO4)
			( cAliasVO4 )->(DbSkip())
			loop
		EndIf
		
		&& Grava arquivo de trabalho
		FS_GRATRAB( ( cAliasVO1 )->VO1_NUMOSV , stod(( cAliasVO4 )->VO4_DATINI) , ( cAliasVO4 )->VO4_CODPRO , ( cAliasVO4 )->VO4_TIPSER , ( cAliasVO4 )->VO4_TEMTRA , ( cAliasVO4 )->VO4_HOREXT , 0 , , ( cAliasVO4 )->VO4_TIPTEM )
		
	Else               // Quando e tempo ausencia
		
		FS_GRATRAB( Space(Len(VO1->VO1_NUMOSV)) , stod(( cAliasVO4 )->VO4_DATINI) , ( cAliasVO4 )->VO4_CODPRO , ( cAliasVO4 )->VO4_TIPSER , ( cAliasVO4 )->VO4_TEMAUS , ( cAliasVO4 )->VO4_HOREXT , 0 , ( cAliasVO4 )->VO4_TIPAUS )
		
	EndIf
	
	IncRegua()
	
	If lAbortPrint
		
		//      Exit
		Cancel
		
	EndIf
	
	DbSelectArea(cAliasVO4)
	( cAliasVO4 )->(DbSkip())
	
EndDo
If Select(cAliasVO1) > 0
	( cAliasVO1 )->( dbCloseArea() )
EndIf
If Select(cAliasVO2)	> 0
	( cAliasVO2 )->( dbCloseArea() )
EndIf
If Select(cAliasVO4)	> 0
	( cAliasVO4 )->( dbCloseArea() )
EndIf
If Select(cAliasVV1)	> 0
	( cAliasVV1 )->( dbCloseArea() )
EndIf
If Select(cAliasVV2)	> 0
	( cAliasVV2 )->( dbCloseArea() )
EndIf

cQuery := "SELECT VSC.VSC_NUMOSV,VSC.VSC_TIPTEM,VSC.VSC_CODSER,VSC.VSC_DATVEN,VSC.VSC_CODPRO,VSC.VSC_TIPSER,VSC.VSC_TEMVEN,VSC.VSC_TIPTEM "
cQuery += "FROM "
cQuery += RetSqlName( "VSC" ) + " VSC "
cQuery += "WHERE "
cQuery += "VSC.VSC_FILIAL='"+ xFilial("VSC")+ "' AND VSC.VSC_DATVEN >= '"+dtos(XPAR20)+"' AND VSC.VSC_DATVEN <= '"+dtos(XPAR21)+"' AND "
cQuery += "VSC.D_E_L_E_T_=' ' "

dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVSC, .T., .T. )

Do While !( cAliasVSC )->( Eof() )
	
	//  Nao deletar
	//           If !empty(XPAR26)
	//              If VSC->VSC_CODPRO != XPAR26
	//                 dbSkip()
	//                 Loop
	//              EndIf
	//           EndIf
	
	If Select(cAliasVO1) > 0
		( cAliasVO1 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT VO1.VO1_NUMOSV,VO1.VO1_CHAINT "
	cQuery += "FROM "+RetSqlName( "VO1" ) + " VO1 "
	cQuery += "WHERE "
	cQuery += "VO1.VO1_FILIAL='"+ xFilial("VO1")+ "' AND VO1.VO1_NUMOSV = '"+(cAliasVSC)->VSC_NUMOSV+"' AND "
	cQuery += "VO1.D_E_L_E_T_=' ' ORDER BY VO1.VO1_NUMOSV"
	
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVO1, .T., .T. )
	
	If Select(cAliasVV1) > 0
		( cAliasVV1 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT VV1.VV1_CODMAR, VV1.VV1_MODVEI, VV1.VV1_SEGMOD "
	cQuery += "FROM " + RetSqlName( "VV1" ) + " VV1 "
	cQuery += "WHERE VV1.VV1_FILIAL = '"+xFilial("VV1")+"' AND VV1.D_E_L_E_T_=' ' AND "
	cQuery += "VV1.VV1_CHAINT='"+( cAliasVO1 )->VO1_CHAINT+"'"
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cAliasVV1 , .F., .T. )
	
	If Select(cAliasVV2) > 0
		( cAliasVV2 )->( DbCloseArea() )
	EndIf
	cQuery := "SELECT VV2.VV2_CODMAR,VV2.VV2_MODVEI,VV2.VV2_SEGMOD,VV2.VV2_TIPVEI "
	cQuery += "FROM " + RetSqlName( "VV2" ) + " VV2 "
	cQuery += "WHERE VV2.VV2_FILIAL = '"+xFilial("VV2")+"' AND VV2.D_E_L_E_T_=' ' AND "
	//	cQuery += "VV2.VV2_CODMAR='"+( cAliasVV1 )->VV1_CODMAR+"' AND VV2.VV2_MODVEI='"+( cAliasVV1 )->VV1_MODVEI+"' AND VV2.VV2_SEGMOD='"+( cAliasVV1 )->VV1_SEGMOD+"'"
	cQuery += "VV2.VV2_CODMAR='"+( cAliasVV1 )->VV1_CODMAR+"' AND VV2.VV2_MODVEI='"+( cAliasVV1 )->VV1_MODVEI+"'"
	dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cAliasVV2 , .F., .T. )
	
	if !Empty(mv_par33)
		if !(( cAliasVV1 )->VV1_CODMAR $ mv_par33)
			dbSelectArea(cAliasVSC)
			(cAliasVSC)->(dbSkip())
			Loop
		Endif
	Endif
	If mv_par27 = 1 .and. !( cAliasVV2 )->VV2_TIPVEI $ mv_par30 //Somente Veic. Passeio
		DbSelectArea(cAliasVSC)
		( cAliasVSC )->(DbSkip())
		loop
		
	ElseIf mv_par27 = 2 .and. !( cAliasVV2 )->VV2_TIPVEI $ mv_par28 .and. !( cAliasVV2 )->VV2_TIPVEI $ mv_par29 //Caminhoes/Onibus
		DbSelectArea(cAliasVSC)
		( cAliasVSC )->(DbSkip())
		loop
		
	ElseIf mv_par27 = 3 .and. !( cAliasVV2 )->VV2_TIPVEI $ mv_par28 //Somente Caminhoes
		DbSelectArea(cAliasVSC)
		( cAliasVSC )->(DbSkip())
		loop
		
	ElseIf mv_par27 = 4 .and. !( cAliasVV2 )->VV2_TIPVEI $ mv_par29 //Somente Onibus
		DbSelectArea(cAliasVSC)
		( cAliasVSC )->(DbSkip())
		loop
		
	ElseIf Empty(( cAliasVV2 )->VV2_TIPVEI)
		DbSelectArea(cAliasVSC)
		( cAliasVSC )->(DbSkip())
		loop
	EndIf
	
	If aScan(aVetWrk, ( cAliasVSC )->VSC_NUMOSV+( cAliasVSC )->VSC_TIPTEM+( cAliasVSC )->VSC_CODSER ) == 0
		aAdd(aVetWrk, ( cAliasVSC )->VSC_NUMOSV+( cAliasVSC )->VSC_TIPTEM+( cAliasVSC )->VSC_CODSER)
		FS_GRATRAB(( cAliasVSC )->VSC_NUMOSV , stod(( cAliasVSC )->VSC_DATVEN) , ( cAliasVSC )->VSC_CODPRO , ( cAliasVSC )->VSC_TIPSER , 0 , "" , ( cAliasVSC )->VSC_TEMVEN , "" , ( cAliasVSC )->VSC_TIPTEM , .T. )
	EndIf
	
	DbSelectArea(cAliasVSC)
	( cAliasVSC )->(DbSkip())
EndDo
( cAliasVSC )->( dbCloseArea() )
                                               

If Select(cAliasVO1) > 0
	( cAliasVO1 )->( dbCloseArea() )
EndIf
If Select(cAliasVV1)	> 0
	( cAliasVV1 )->( dbCloseArea() )
EndIf
If Select(cAliasVV2)	> 0
	( cAliasVV2 )->( dbCloseArea() )
EndIf

FS_CALTOT()

&& Impressao

DbSelectArea("TRB")
//DbSetOrder( XPAR23 + 2 )
DbSetOrder(XPAR23)
DbGoTop()

nBarra  := 0
nLin    := 1

cMecFun := TRB->TRB_MECFUN
                                   

Do While !Eof()
	
	If TRB->TRB_TTOTAL == "2"
		dbSkip()
		Loop
	EndIf
	
	If TRB->TRB_MECFUN # cMecFun
		
		cMecFun := TRB->TRB_MECFUN
		nLin := 1
		
	EndIf

	Do Case
		Case TRB->TRB_TTOTAL == "0"

			@ Eval( bLinha , 1 , cMecFun ),00 PSAY ""
			@ Eval( bLinha , 0 , cMecFun ),00 PSAY STR0006 //"Total"
			@ Eval( bLinha , 1 , cMecFun ),10 PSAY Transform(TRB->TRB_ATO01,"@EZR 9999:99")+" "  +;
			Transform(TRB->TRB_ATO02,"@EZR 9999:99")+" " +;
			Transform(TRB->TRB_ATO03,"@EZR 9999:99")  +" " +;
			Transform(TRB->TRB_ATO04,"@EZR 9999:99")+" "  +;
			Transform(TRB->TRB_DESLOC,"@EZR 999:99")+" "  +;
			Transform(TRB->TRB_ATO05,"@EZR 9999:99")+"  " +;
			Transform(TRB->TRB_INTREP,"@EZR 999:99")+"  " +;
			Transform(TRB->TRB_ATO06,"@EZR 999:99")  +" "  +;
			Transform(TRB->TRB_ATO07,"@EZR 999:99")+" "  +;
			Transform(TRB->TRB_ATO08,"@EZR 999:99")  +" "  +;
			Transform(TRB->TRB_ATO09,"@EZR 9999:99")+" "  +;
			Transform(TRB->TRB_ATO10,"@EZR 9999:99")+" "  +;
			Transform(TRB->TRB_ATO11,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO21,"@EZR 99999:99")+" " +;
			Transform(TRB->TRB_ATO12,"@EZR 999:99")  +" " +;
			Transform(TRB->TRB_ATO13,"@EZR 999:99")+" "+;
			Transform(TRB->TRB_ATO14,"@EZR 9999:99")+" " +;
			Transform(TRB->TRB_ATO22,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO15,"@EZR 99999:99")+" "  +; 
			Transform(TRB->TRB_ATO20,"@EZR 9999:99")+" "+;
			Transform(TRB->TRB_ATO23,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO16,"@EZR 9999:99")  +" " +;
			Transform(TRB->TRB_ATO17,"@EZR 999:99")  +" "  +;
			Transform(TRB->TRB_ATO18,"@EZR 9999:99")  +" "  +;
			Transform(TRB->TRB_ATO19,"@EZR 9999:99")  +" " +;
			Transform(TRB->TRB_TPDESL,"@EZR 999:99") +" "  +;
			Transform(TRB->TRB_ATO24,"@EZR 999:99")    

			
			//      Case TRB->TRB_TTOTAL == "1" .and. XPAR22 < 3
		Case TRB->TRB_TTOTAL == "1" .and. XPAR22 == 1
			
			@ Eval( bLinha , 0 , cMecFun ),00 PSAY If( XPAR23 == 2 , TRB->TRB_CODPRO , Dtoc( TRB->TRB_DATABE ) )
			@ Eval( bLinha , 0 , cMecFun ),11 PSAY If( XPAR23 == 2 , Space(6) , Transform(If(cMecFun=='P',TRB->TRB_QPIN,TRB->TRB_QMEC), "999999" ) )
			@ Eval( bLinha , 1 , cMecFun ),11 PSAY Transform(TRB->TRB_ATO01,"@EZR 9999:99")+" "  +;
			Transform(TRB->TRB_ATO02,"@EZR 9999:99")+" " +;
			Transform(TRB->TRB_ATO03,"@EZR 9999:99")  +" " +;
			Transform(TRB->TRB_ATO04,"@EZR 9999:99")+" "  +;
			Transform(TRB->TRB_DESLOC,"@EZR 999:99")+" "  +;
			Transform(TRB->TRB_ATO05,"@EZR 9999:99")+"  " +;
			Transform(TRB->TRB_INTREP,"@EZR 999:99")+"  " +;
			Transform(TRB->TRB_ATO06,"@EZR 999:99")  +" "  +;
			Transform(TRB->TRB_ATO07,"@EZR 999:99")+" "  +;
			Transform(TRB->TRB_ATO08,"@EZR 999:99")  +" "  +;
			Transform(TRB->TRB_ATO09,"@EZR 9999:99")+" "  +;
			Transform(TRB->TRB_ATO10,"@EZR 9999:99")+" "  +;
			Transform(TRB->TRB_ATO11,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO21,"@EZR 99999:99")+" " +;
			Transform(TRB->TRB_ATO12,"@EZR 999:99")  +" " +;
			Transform(TRB->TRB_ATO13,"@EZR 999:99")+" "+;           
			Transform(TRB->TRB_ATO14,"@EZR 9999:99")+" " +;
			Transform(TRB->TRB_ATO22,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO15,"@EZR 99999:99")+" "  +;        
			Transform(TRB->TRB_ATO20,"@EZR 9999:99")+" "  +;
			Transform(TRB->TRB_ATO23,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO16,"@EZR 9999:99")  +" " +;
			Transform(TRB->TRB_ATO17,"@EZR 999:99")  +" "  +;
			Transform(TRB->TRB_ATO18,"@EZR 9999:99")  +" "  +;
			Transform(TRB->TRB_ATO19,"@EZR 9999:99")  +" " +;
			Transform(TRB->TRB_TPDESL,"@EZR 999:99")+" "  +;
			Transform(TRB->TRB_ATO24,"@EZR 999:99")


			/*
			Case TRB->TRB_TTOTAL == "2" .and. XPAR22 < 2
			@ Eval( bLinha , 0 , cMecFun ),00 PSAY If( XPAR23 == 2 , TRB->TRB_CODPRO , Dtoc( TRB->TRB_DATABE ) )+ " " + TRB->TRB_NUMOSV
			@ Eval( bLinha , 1 , cMecFun ),15 PSAY Transform(TRB->TRB_ATO01,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO02,"@EZR 99999:99")+" " +;
			Transform(TRB->TRB_ATO03,"@EZR 999:99")  +" " +;
			Transform(TRB->TRB_ATO04,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO05,"@EZR 99999:99")+"  " +;
			Transform(TRB->TRB_ATO06,"@EZR 999:99")  +" "  +;
			Transform(TRB->TRB_ATO07,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO08,"@EZR 999:99")  +" "  +;
			Transform(TRB->TRB_ATO09,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO10,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO11,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO21,"@EZR 99999:99")+"  " +;
			Transform(TRB->TRB_ATO12,"@EZR 999:99")  +"  " +;
			Transform(TRB->TRB_ATO13,"@EZR 99999:99")+"   "+;
			Transform(TRB->TRB_ATO14,"@EZR 99999:99")+"  " +;
			Transform(TRB->TRB_ATO22,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO15,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO20,"@EZR 99999:99")      +;
			Transform(TRB->TRB_ATO23,"@EZR 99999:99")+" "  +;
			Transform(TRB->TRB_ATO16,"@EZR 999:99")  +"  " +;
			Transform(TRB->TRB_ATO17,"@EZR 999:99")  +" "  +;
			Transform(TRB->TRB_ATO18,"@EZR 999:99")  +" "  +;
			Transform(TRB->TRB_ATO19,"@EZR 999:99")  +"  " +;
			Transform(TRB->TRB_ATO24,"@EZR 999:99" )
			*/
	EndCase
	
	If TRB->TRB_TTOTAL == "0"
		@ Eval( bLinha , 1 , cMecFun ),00 PSAY ""
	EndIf
	
	DbSelectArea("TRB")
	DbSkip()
	
EndDO

//Imprime legenda da montadora
FS_LEGENDA()

Eject

Set Printer to
Set device to Screen

MS_FLUSH()

oObjTempTable:CloseTable()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_GRATRABºAutor  ³Fabio               º Data ³  12/27/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava arquivo de trabalho                                   º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ cNumOsv  - Numero da Ordem de Servico                      ³±±
±±           ³ dDataAbe - Data da Ocorrencia                              ³±±
±±           ³ cCodPro  - Código do Produtivo                             ³±±
±±           ³ cTipSer  - Tipo de Serviço                                 ³±±
±±           ³ cTempo   - Tempo do Registro (Disponível/Trabalhado)       ³±±
±±           ³ cTipHr   - Tipo de Hora (Normal/Extra)                     ³±±
±±           ³ cTemPad  - Tempo Padrão                                    ³±±
±±           ³ cTipAus  - Tipo de Ausência                                ³±±
±±           ³ cTipTem  - Tipo de Tempo                                   ³±±
±±           ³ lTpoCob  - .T. Apura Tempo Vendido /                       ³±±
±±           ³            .F. Não Apura Tempo Vendido                     ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_GRATRAB( cNumOsv , dDataAbe , cCodPro , cTipSer , nTempo , cTipHr , nTemPad , cTipAus , cTipTem , lTpoCob )

Local nTo := 0 , nVar := 0 , cMecFun := "", nHorDis := 0

lTpoCob := If(lTpoCob == Nil, .f. , lTpoCob )

If cTipTem != Nil
	dbSelectArea("VOI")
	dbSetOrder(1)
	dbSeek(xFilial("VOI")+cTipTem)
EndIf

If cCodPro != Nil
	dbSelectArea("VAI")
	dbSetOrder(1)
	dbSeek(xFilial("VAI")+cCodPro)
	
	Do Case
		Case Alltrim(VAI->VAI_FUNCAO) $ XPAR24
			cMecFun := "M"
		Case Alltrim(VAI->VAI_FUNCAO) $ XPAR25
			cMecFun := "P"
		Otherwise
			cMecFun := "X"
	EndCase
EndIf

If lTpoCob
	
	Do Case
		Case cTipSer $ XPAR01 .or.  cTipSer $ XPAR16
			nVar := 16
		Case cTipSer $ XPAR02 .or.  cTipSer $ XPAR17
			nVar := 17
		Case cTipSer $ XPAR03 .or. cTipSer $ XPAR18
			nVar := 18
		Case cTipSer $ XPAR04
			nVar := 19
		Case cTipSer $ XPAR05 .or. cTipSer $ XPAR06 .or. cTipSer $ XPAR07 .or. cTipSer $ XPAR08 .or. cTipSer $ XPAR09 .or. cTipSer $ XPAR10
			nVar := 24
		OtherWise
			nVar := 16
	EndCase
	
Else
	
	For nVar := 1 to 19
		If cTipSer $ &( "XPAR" + StrZero( nVar , 2 ) )
			Exit
		EndIf
	Next
	if nVar==20 .and. !lTSProb
		MsgInfo(STR0054 + cTipSer + STR0055)
		lTSProb := .t.
	endif
	If nVar > 15 .and. nVar < 20
		nVar -= 15
	EndIf
	
EndIf

nHorDis := FG_CALTEM(cCodPro,dDataAbe,"0")

DbSelectArea("TRB")

If XPAR23 == 1  // Por Dia
	DbSetOrder( 1 )
	//   DbSeek( cMecFun + "2" + Dtos( dDataAbe ) + cCodPro + cNumOsv )
	DbSeek( cMecFun + "2" + Dtos( dDataAbe ) + cCodPro )
Else              // Por Mecânico
	DbSetOrder( 2 )
	//   DbSeek( cMecFun + "2" + cCodPro + Dtos( dDataAbe ) + cNumOsv )
	DbSeek( cMecFun + "2" + cCodPro + Dtos( dDataAbe ) )
EndIf

RecLock( "TRB" , !Found() )
TRB->TRB_MECFUN := cMecFun
TRB->TRB_TTOTAL := "2"
TRB->TRB_DATABE := dDataAbe
TRB->TRB_CODPRO := cCodPro
TRB->TRB_NUMOSV := cNumOsv
TRB->TRB_TIPSER := cTipSer

If cMecFun == "M"
	TRB->TRB_QMEC  := 1
ElseIf cMecFun == "P"
	TRB->TRB_QPIN  := 1
EndIf

IF VO4->VO4_DATINI >= xpar20 .AND. VO4->VO4_DATINI <= xpar21
	if VO4->Vo4_HOREXT =="O" .and. !Empty(TRB->TRB_NUMOSV)
		TRB->TRB_ATO25 += INT(FS_VLSERTP(VO4->VO4_DATINI,VO4->VO4_HORINI,VO4->VO4_DATFIN,VO4->VO4_HORFIN,30))    // Horas Trabalhadas
	endif
ENDIF

If !Empty(cTipAus)
	
	Do Case
		Case AllTrim(cTipAus) == "0"
			TRB->TRB_ATO12 += nTempo
			TRB->TRB_ATO21 := nHorDis - (TRB->TRB_ATO12 + TRB->TRB_ATO13 + TRB->TRB_ATO14 + TRB->TRB_ATO15)
			TRB->TRB_ATO22 := nHorDis
			TRB->TRB_ATO23 := (TRB->TRB_ATO22 + TRB->TRB_ATO15) - TRB->TRB_ATO20
		Case AllTrim(cTipAus) == "1"
			TRB->TRB_ATO15 += nTempo
			TRB->TRB_ATO21 := nHorDis - (TRB->TRB_ATO12 + TRB->TRB_ATO13 + TRB->TRB_ATO14 + TRB->TRB_ATO15)
			TRB->TRB_ATO22 := nHorDis
			TRB->TRB_ATO23 := (TRB->TRB_ATO22 + TRB->TRB_ATO15) - TRB->TRB_ATO20
		Case AllTrim(cTipAus) == "2"
			TRB->TRB_ATO13 += nTempo
			TRB->TRB_ATO21 := nHorDis - (TRB->TRB_ATO12 + TRB->TRB_ATO13 + TRB->TRB_ATO14 + TRB->TRB_ATO15)
			TRB->TRB_ATO22 := nHorDis
			TRB->TRB_ATO23 := (TRB->TRB_ATO22 + TRB->TRB_ATO15) - TRB->TRB_ATO20
		Case AllTrim(cTipAus) == "3"
			TRB->TRB_ATO14 += nTempo
			TRB->TRB_ATO21 := nHorDis - (TRB->TRB_ATO12 + TRB->TRB_ATO13 + TRB->TRB_ATO14 + TRB->TRB_ATO15)
			TRB->TRB_ATO22 := nHorDis
			TRB->TRB_ATO23 := (TRB->TRB_ATO22 + TRB->TRB_ATO15) - TRB->TRB_ATO20
		Case AllTrim(cTipAus) == "X"
			TRB->TRB_ATO10 += nTempo
			TRB->TRB_ATO21 += nTempo
			TRB->TRB_ATO22 += nTempo
			TRB->TRB_ATO23 += nTempo
	EndCase
	
Else
	
	If cTipHr # "E"   && Quando nao e hora extra
		lachou := 0
		If nVar==16 .or. nVar==17 .or. nVar==18 .or. nVar==19 .or. nVar==24
			If VOI->VOI_SITTPO == "3"
				TRB->TRB_ATO24 += nTemPad
			Else
				if !Empty(MV_PAR31)
					if cTipSer $ MV_PAR31
						TRB->TRB_TPDESL += nTemPad
						lachou := 1
					Endif
				Endif
				if !Empty(MV_PAR32)
					if cTipSer $ MV_PAR32
						TRB->TRB_INTREP += nTemPad
						lachou := 1
					Endif
				Endif
				if lachou == 0
					&( "TRB->TRB_ATO" + StrZero(nVar,2)) += nTemPad
				Endif
			EndIf
		Else
			lachou := 0
			if !Empty(MV_PAR31)
				if cTipSer $ MV_PAR31
					TRB->TRB_DESLOC += nTempo
					lachou := 1
				Endif
			Endif
			if !Empty(MV_PAR32)
				if cTipSer $ MV_PAR32
					TRB->TRB_INTREP += nTempo
					lachou := 1
				Endif
			Endif
			if lachou == 0
				&( "TRB->TRB_ATO" + StrZero(nVar,2)) += nTempo
			Endif
			TRB->TRB_ATO21 := TRB->TRB_ATO21 - (TRB->TRB_ATO12 + TRB->TRB_ATO13 + TRB->TRB_ATO14)
			TRB->TRB_ATO23 := (TRB->TRB_ATO22 + TRB->TRB_ATO15) - TRB->TRB_ATO20
			/*         TRB->TRB_ATO10 := TRB->TRB_ATO21 - (TRB->TRB_ATO01+TRB->TRB_ATO02+TRB->TRB_ATO03+;
			TRB->TRB_ATO04+TRB->TRB_ATO05+TRB->TRB_ATO06+;
			TRB->TRB_ATO07+TRB->TRB_ATO08+TRB->TRB_ATO09+;
			TRB->TRB_ATO11)
			*/
			
		EndIf
		
	Else
		
		TRB->TRB_ATO20 += nTempo
		
		TRB->TRB_ATO21 := TRB->TRB_ATO21 - (TRB->TRB_ATO12 + TRB->TRB_ATO13 + TRB->TRB_ATO14)
		TRB->TRB_ATO23 := (TRB->TRB_ATO22 + TRB->TRB_ATO15) - TRB->TRB_ATO20
		/*      TRB->TRB_ATO10 := TRB->TRB_ATO21 - (TRB->TRB_ATO01+TRB->TRB_ATO02+TRB->TRB_ATO03+;
		TRB->TRB_ATO04+TRB->TRB_ATO05+TRB->TRB_ATO06+;
		TRB->TRB_ATO07+TRB->TRB_ATO08+TRB->TRB_ATO09+;
		TRB->TRB_ATO11)
		*/
	EndIf
	
EndIf

TRB->TRB_ATO10 := TRB->TRB_ATO21 - (TRB->TRB_ATO01+TRB->TRB_ATO02+TRB->TRB_ATO03+;
TRB->TRB_ATO04+TRB->TRB_ATO05+TRB->TRB_INTREP+TRB->TRB_ATO06+;
TRB->TRB_ATO07+TRB->TRB_ATO08+TRB->TRB_ATO09+;
TRB->TRB_ATO11)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_OR190VAºAutor  ³Fabio               º Data ³  12/28/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Valida                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_OR190VALID()

Local nVal := 0 , nValVar := 0
                           

If Substr( ReadVar() , 7 , 2 ) >= "01" .And. Substr( ReadVar() , 7 , 2 ) <= "20"
	
	if Substr( ReadVar() , 7 , 2 ) >= "13" .And. Substr( ReadVar() , 7 , 2 ) <= "16"
		DBSelectArea("SX5")
		DBSetOrder(1)
		If Empty( &( ReadVar() ) )
			Help("  ",1,"VCPOEMP")
			
		EndIf
		
		If !DbSeek( xFilial("SX5") + "TA" + Alltrim(Substr( &( ReadVar() ) , nVal , 3 )) )
			Help("  ",1,"VPARNVALID")
			Return( .f. )
		EndIf
		
		
	else
		For nVal := 1 to Len( &( ReadVar() ) ) Step 4
			
			If Empty( &( ReadVar() ) )
				Help("  ",1,"VCPOEMP")
				Exit
			EndIf
			
			If Empty( Substr( &( ReadVar() ) , nVal , 3 ) )
				Exit
			EndIf
			
			&& Tipo de servico
			
			DbSelectArea("VOK")
			DbSetOrder( 1 )
			
			If !DbSeek( xFilial("VOK") + Substr( &( ReadVar() ) , nVal , 3 ) )
				Help("  ",1,"VPARNVALID")
				Return( .f. )
			EndIf
			/*
			For nValVar := 1 to 19
			
			If "XPAR"+StrZero( nValVar ,2) # ReadVar() .And. Substr( &( ReadVar() ) , nVal , 3 ) $ &( "XPAR"+StrZero( nValVar ,2) )
			Help("  ",1,"VPARNVALID")
			Return( .f. )
			EndIf
			
			Next
			*/
			
		Next
		
	endif
EndIf

Return( .t. )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_OR190VAºAutor  ³Fabio               º Data ³  12/28/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Valida                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_OR1901VALID()

Local nVal := 0 , nValVar := 0

If Substr( ReadVar() , 7 , 2 ) > "23" .And. Substr( ReadVar() , 7 , 2 ) < "26"
	
	For nVal := 1 to Len( &( ReadVar() ) ) Step 6
		
		If Empty( &( ReadVar() ) )
			Help("  ",1,"VCPOEMP")
			Exit
		EndIf
		If Empty( Substr( &( ReadVar() ) , nVal , 4 ) )
			Exit
		EndIf
		
		&& Tabela de Funcoes
		
		DbSelectArea("SRJ")
		DbSetOrder( 1 )
		If !DbSeek( xFilial("SRJ") + Substr( &( ReadVar() ) , nVal , 5 ) )
			Help("  ",1,"VPARNVALID")
			Return( .f. )
		EndIf
		
		For nValVar := 24 to 25
			If "XPAR"+StrZero( nValVar ,2) # ReadVar() .And. Substr( &( ReadVar() ) , nVal , 5 ) $ &( "XPAR"+StrZero( nValVar ,2) )
				Help("  ",1,"VPARNVALID")
				Return( .f. )
			EndIf
		Next
		
	Next
	
EndIf

Return( .t. )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_OR190CAºAutor  ³Fabio               º Data ³  12/28/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cabecalho                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_LINHA( nSoma , cTipImp )

Local nReturn := 0

If nLin >= 66
	
	nLin := 1
	
EndIf

If nLin == 1
	
	&& Impressao do relatorio
	cbTxt    := Space(10)
	cbCont   := 0
	cString  := "VO1"
	Li       := 80
	m_Pag    := 1
	
	wnRel    := "OFIOR190"
	
	//	cTitulo:= "Analise Tempo da Oficina - A.T.O - " + If( XPAR14 == 2 , "Caminhoes/Onibus" , "Veiculos de Passeio" )
	cTitulo:= STR0007 //"Analise Tempo da Oficina - A.T.O - "
	cabec1 := ""
	cabec2 := ""
	nomeprog:="OFIOR190"
	tamanho:="G"
	nCaracter:=15
	nTotal := 0
	
	nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	@ nLin++,1 PSAY Repl("*",221)
	
	@ nLin++,1 PSAY Repl("-",4)+STR0008 + Repl("-",2) + STR0009 + Repl("-",39) + STR0010 + Repl("-",65) + STR0011 + Repl("-",14) + STR0012 + Repl("-",10) //" Data "###" QTD "###"T E M P O  R E M U N E R A D O "###" AUSENC.   HORAS    TEMPO "###" TEMPO COBRADO "
	@ nLin++,1 PSAY Space(06) + STR0013 + Repl("-",8) + STR0014 + Repl("-",12) + " " + Repl("-",7) + STR0015 + Repl("-",13) + " " + Repl("-",9) + STR0016 + Repl("-",10) + " " + STR0017 + Space(02) + STR0018 +"     "+ Repl("-",15) + STR0019 + Repl("-",9) + " " + STR0020 //"PRD "###"PRODUTIVO CLIENTE"###"PRODUTIVO INTERNO"###"OFICINA"###"TEMPO  AUSENC.    FERIAS"###"TREIN.     TOTAL  NAO.REM  SUPLEM.  NORMAL "###"CLIENTE"###"INTERNO"
	
	If cTipImp == "M"   && Mecanica
		
		@ nLin++,1 PSAY Space(12) + Repl("-",5) + STR0021 + Repl("-",4)+ " " + Repl("-",4) + STR0022 + Repl("-",6) + space(6) + STR0023 + Space(21) + STR0024 + Space(33) + STR0021 + Space(08) + STR0022 + Space(09) + STR0025 //"REVISAO"###"MECANICA"###"  VENDAS  USADOS   PECAS  ADMIN.  P/OFIC.   PERDIDO GAR.OFC DISPON.   REM. "###"REM."###"REVISAO"###"MECANICA"###"SG/SC"
		@ nLin++,1 PSAY Space(14) + STR0026 + Space(6) + STR0027 + Space(6) + STR0028 + Space(6) + STR0029 + Space(5) + STR0051 + space (5) + STR0030 + Space(5) + STR0053 + space(6) + STR0031 + Space(5) + STR0032 + Space(5) + STR0033 + Space(6) + STR0034 + Space(6) + STR0035 + Space(7) + STR0036 + Space(14) + STR0037 + Space(5) + STR0038 + Space(05) + STR0039 + Space(41) + STR0026 + Space(5) + STR0027 + Space(6) + STR0028 + Space(6) + STR0029 + space(5)+STR0051  //"CR"###"GR"###"CM"###"GM"###"IV"###"IU"###"IP"###"IA"###"PO"###"TP"###"GO"###"AR"###"PE"###"TRE"###"CR"###"GR"###"CM"###"GM"
		
	Else                 && Pintura/Funilaria
		
		@ nLin++,1 PSAY Space(10) + Repl("-",4) + STR0040 + Repl("-",3)+ " " + Repl("-",5) + STR0041 + Repl("-",8) + space(5) + STR0023 + Space(21) + STR0024 + Space(28) + STR0021 + Space(09) + STR0022 + Space(09) + STR0025 //"FUNILARIA"###"PINTURA"###"  VENDAS  USADOS   PECAS  ADMIN.  P/OFIC.   PERDIDO GAR.OFC DISPON.   REM. "###"REM."###"REVISAO"###"MECANICA"###"SG/SC"
		@ nLin++,1 PSAY Space(14) + STR0042 + Space(7) + STR0043 + Space(5) + STR0044 + Space(6) + STR0045 + Space(5) + STR0051 + Space(4) + STR0030 + Space(5) +  STR0053 + space(5) + STR0031 + Space(7) + STR0032 + Space(5) + STR0033 + Space(6) + STR0034 + Space(6) + STR0035 + Space(6) + STR0036 + Space(16) + STR0037 + Space(7) + STR0038 + Space(04) + STR0039 + Space(41) + STR0042 + Space(6) + STR0043 + Space(4) + STR0044 + Space(4) + STR0045 + space(4)+STR0051  //"CF"###"GF"###"CP"###"GP"###"IV"###"IU"###"IP"###"IA"###"PO"###"TP"###"GO"###"AR"###"PE"###"TRE"###"CF"###"GF"###"CP"###"GP"
		
	EndIf
	
	@ nLin++,1 PSAY Repl("-",221)
	
EndIf

nReturn := nLin
nLin    += nSoma

Return( nReturn )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_CALTOTºAutor  ³Emilton              º Data ³  18/03/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Calcula totais do arquivo de trabalho                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function FS_CALTOT()

Local nAto01 := 0, nAto02 := 0, nAto03 := 0, nAto04 := 0, nAto05 := 0, nAto06 := 0
Local nAto07 := 0, nAto08 := 0, nAto09 := 0, nAto10 := 0, nAto11 := 0, nAto12 := 0
Local nAto13 := 0, nAto14 := 0, nAto15 := 0, nAto16 := 0, nAto17 := 0, nAto18 := 0
Local nAto19 := 0, nAto20 := 0, nAto21 := 0, nAto22 := 0, nAto23 := 0, nAto24 := 0
Local nQMec  := 0, nQPin  := 0
Local ix2_ := 0, cMecFun := "", nRecAtu := 0, cCodPro := "", lFound := .f.
Local aVetDat := {}
Local nTPDesl := 0 
Local nDesloc := 0
Local nIntRep := 0

DbSelectArea("TRB")
DbSetOrder( XPAR23 )
DbGoTop()

While !eof()
	
	If Empty(TRB->TRB_CODPRO) .and. TRB->TRB_TTOTAL == "2"
		dbSkip()
		Loop
	EndIf
	
	If TRB->TRB_TTOTAL == "2"
		
		cMecFun := TRB->TRB_MECFUN
		cCodPro := TRB->TRB_CODPRO
		dDataAbe:= TRB->TRB_DATABE
		
		nAto01 := TRB->TRB_ATO01
		nAto02 := TRB->TRB_ATO02
		nAto03 := TRB->TRB_ATO03
		nAto04 := TRB->TRB_ATO04
		nAto05 := TRB->TRB_ATO05
        nTPDesl := TRB->TRB_TPDESL
        nDesloc := TRB->TRB_DESLOC
        nIntRep := TRB->TRB_INTREP
		nAto06 := TRB->TRB_ATO06
		nAto07 := TRB->TRB_ATO07
		nAto08 := TRB->TRB_ATO08
		nAto09 := TRB->TRB_ATO09
		nAto10 := TRB->TRB_ATO10
		nAto11 := TRB->TRB_ATO11
		nAto12 := TRB->TRB_ATO12
		nAto13 := TRB->TRB_ATO13
		nAto14 := TRB->TRB_ATO14
		nAto15 := TRB->TRB_ATO15
		nAto16 := TRB->TRB_ATO16
		nAto17 := TRB->TRB_ATO17
		nAto18 := TRB->TRB_ATO18
		nAto19 := TRB->TRB_ATO19
		nAto20 := TRB->TRB_ATO20
		nAto21 := TRB->TRB_ATO21
		nAto22 := TRB->TRB_ATO22
		nAto23 := TRB->TRB_ATO23
		nAto24 := TRB->TRB_ATO24
		nAto25 := TRB->TRB_ATO25
		nQMec  := TRB->TRB_QMEC
		nQPin  := TRB->TRB_QPIN
		nRecAtu := RecNo()
		
		If XPAR23 == 1  // Por Dia
			DbSetOrder( 1 )
			DbSeek( cMecFun + "1" + Dtos( dDataAbe ))
		Else              // Por Mecânico
			DbSetOrder( 2 )
			DbSeek( cMecFun + "1" + cCodPro)
		EndIf
		
		ix2_ := aScan(aVetDat,cMecFun+cCodPro+DtoS(dDataAbe))
		If ix2_ == 0
			aAdd(aVetDat,cMecFun+cCodPro+DtoS(dDataAbe))
		EndIf
		
		lFound := Found()
		RecLock( "TRB" , !lFound )
		TRB->TRB_MECFUN := cMecFun
		TRB->TRB_TTOTAL := "1"
		If XPAR23 == 1
			TRB->TRB_DATABE := dDataAbe
		Else
			TRB->TRB_CODPRO := cCodPro
		EndIf
		TRB->TRB_NUMOSV := ""
		
		TRB->TRB_ATO01 += nAto01
		TRB->TRB_ATO02 += nAto02
		TRB->TRB_ATO03 += nAto03
		TRB->TRB_ATO04 += nAto04
		TRB->TRB_ATO05 += nAto05
        TRB->TRB_DESLOC += nDesloc
        TRB->TRB_TPDESL += nTPDesl
        TRB->TRB_INTREP += nIntRep
		TRB->TRB_ATO06 += nAto06
		TRB->TRB_ATO07 += nAto07
		TRB->TRB_ATO08 += nAto08
		TRB->TRB_ATO09 += nAto09
		//      nTemDis := FG_CALTEM(cCodPro,dDataAbe,"0")
		//      TRB->TRB_ATO10 := If(ix2_ == 0,TRB->TRB_ATO10 + nTemDis,TRB->TRB_ATO10)
		//      TRB->TRB_ATO21 := If(ix2_ == 0,TRB->TRB_ATO21 + nTemDis,TRB->TRB_ATO21)
		//      TRB->TRB_ATO22 := If(ix2_ == 0,TRB->TRB_ATO22 + nTemDis,TRB->TRB_ATO22)
		//      TRB->TRB_ATO23 := If(ix2_ == 0,TRB->TRB_ATO23 + nTemDis,TRB->TRB_ATO23)
		
		TRB->TRB_ATO10 += nAto10
		TRB->TRB_ATO21 += nAto21
		TRB->TRB_ATO22 += nAto22
		TRB->TRB_ATO23 += nAto23
		
		TRB->TRB_ATO11 += nAto11
		TRB->TRB_ATO12 += nAto12
		TRB->TRB_ATO13 += nAto13
		TRB->TRB_ATO14 += nAto14
		TRB->TRB_ATO15 += nAto15
		TRB->TRB_ATO16 += nAto16
		TRB->TRB_ATO17 += nAto17
		TRB->TRB_ATO18 += nAto18
		TRB->TRB_ATO19 += nAto19
		TRB->TRB_ATO20 += nAto20
		TRB->TRB_ATO24 += nAto24
		TRB->TRB_ATO25 += nAto25
		//      TRB->TRB_ATO21 := TRB->TRB_ATO21 - (TRB->TRB_ATO12 + TRB->TRB_ATO13 + TRB->TRB_ATO14)
		
		//      TRB->TRB_ATO21 := TRB->TRB_ATO21 - (nAto12 + nAto13 + nAto14 + nAto15)
		//      TRB->TRB_ATO23 := (TRB->TRB_ATO22 + TRB->TRB_ATO15) - TRB->TRB_ATO20
		//		TRB->TRB_ATO10 := TRB->TRB_ATO21 - (TRB->TRB_ATO12- TRB->TRB_ATO13)*0 - TRB->TRB_ATO25
		
		//      TRB->TRB_ATO10 := TRB->TRB_ATO21 - (TRB->TRB_ATO01+TRB->TRB_ATO02+TRB->TRB_ATO03+;
		//                                          TRB->TRB_ATO04+TRB->TRB_ATO05+TRB->TRB_ATO06+;
		//                                          TRB->TRB_ATO07+TRB->TRB_ATO08+TRB->TRB_ATO09+;
		//                                          TRB->TRB_ATO11)
		
		TRB->TRB_QMEC  += nQMec
		TRB->TRB_QPIN  += nQPin
		
		MsUnLock()
	EndIf
	
	DbSetOrder( XPAR23 )
	dbGoTo(nRecAtu)
	dbSkip()
	
EndDo

DbSelectArea("TRB")
DbSetOrder( XPAR23 )
DbGoTop()

While !eof()
	
	If TRB->TRB_TTOTAL $ "0/2"
		dbSkip()
		Loop
	EndIf
	
	If TRB->TRB_TTOTAL == "1"
		
		nRecAtu := RecNo()
		cMecFun := TRB->TRB_MECFUN
		nAto01 := TRB->TRB_ATO01
		nAto02 := TRB->TRB_ATO02
		nAto03 := TRB->TRB_ATO03
		nAto04 := TRB->TRB_ATO04
		nAto05 := TRB->TRB_ATO05
		nDesloc := TRB->TRB_DESLOC
        nIntRep := TRB->TRB_INTREP
        nTPDesl := TRB->TRB_TPDESL
		nAto06 := TRB->TRB_ATO06
		nAto07 := TRB->TRB_ATO07
		nAto08 := TRB->TRB_ATO08
		nAto09 := TRB->TRB_ATO09
		nAto10 := TRB->TRB_ATO10
		nAto11 := TRB->TRB_ATO11
		nAto12 := TRB->TRB_ATO12
		nAto13 := TRB->TRB_ATO13
		nAto14 := TRB->TRB_ATO14
		nAto15 := TRB->TRB_ATO15
		nAto16 := TRB->TRB_ATO16
		nAto17 := TRB->TRB_ATO17
		nAto18 := TRB->TRB_ATO18
		nAto19 := TRB->TRB_ATO19
		nAto20 := TRB->TRB_ATO20
		nAto21 := TRB->TRB_ATO21
		nAto22 := TRB->TRB_ATO22
		nAto23 := TRB->TRB_ATO23
		nAto24 := TRB->TRB_ATO24
		nAto25 := TRB->TRB_ATO24
		nQMec  := TRB->TRB_QMEC
		nQPin  := TRB->TRB_QPIN
		
		If XPAR23 == 1  // Por Dia
			DbSetOrder( 1 )
			DbSeek(cMecFun + "0")
		Else              // Por Mecânico
			DbSetOrder( 2 )
			DbSeek(cMecFun + "0")
		EndIf
		
		lFound := Found()
		RecLock( "TRB" , !lFound )
		TRB->TRB_MECFUN := cMecFun
		TRB->TRB_TTOTAL := "0"
		TRB->TRB_DATABE := cTod("  /  /  ")
		TRB->TRB_CODPRO := ""
		TRB->TRB_NUMOSV := ""
		TRB->TRB_ATO01 += nAto01
		TRB->TRB_ATO02 += nAto02
		TRB->TRB_ATO03 += nAto03
		TRB->TRB_ATO04 += nAto04
		TRB->TRB_ATO05 += nAto05
        TRB->TRB_DESLOC += nDesloc
        TRB->TRB_TPDESL += nTPDesl
        TRB->TRB_INTREP += nIntRep
		TRB->TRB_ATO06 += nAto06
		TRB->TRB_ATO07 += nAto07
		TRB->TRB_ATO08 += nAto08
		TRB->TRB_ATO09 += nAto09
		TRB->TRB_ATO10 += nAto10
		TRB->TRB_ATO11 += nAto11
		TRB->TRB_ATO12 += nAto12
		TRB->TRB_ATO13 += nAto13
		TRB->TRB_ATO14 += nAto14
		TRB->TRB_ATO15 += nAto15
		TRB->TRB_ATO16 += nAto16
		TRB->TRB_ATO17 += nAto17
		TRB->TRB_ATO18 += nAto18
		TRB->TRB_ATO19 += nAto19
		TRB->TRB_ATO20 += nAto20
		TRB->TRB_ATO21 += nAto21
		TRB->TRB_ATO22 += nAto22
		TRB->TRB_ATO23 += nAto23
		TRB->TRB_ATO24 += nAto24
		TRB->TRB_ATO25 += nAto25
		TRB->TRB_QMEC  += nQMec
		TRB->TRB_QPIN  += nQPin
		MsUnLock()
		
	EndIf
	
	DbSetOrder( XPAR23 )
	dbGoTo(nRecAtu)
	dbSkip()
	
EndDo

Return .t.




















































	



















/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_LEGENDAºAutor  ³Fabio               º Data ³  04/13/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Legenda das colunas de acordo com a fabrica                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_LEGENDA()

/*
Qtd Mec         -> Anotar o numero de produtivos controlados pela apontadoria(CDT).
So havera alteracoes se ocorrer:
Admissoes, demissoes, afastamento a partir do 16 dia(INSS) ou para pretacao de servico militar.
Quando o formulario pertencer ao setor de carroceria, deve-se anotar funileiros e pintores separadamente. Ex: 05/04

Tp Produtivo (1)-> Anotar os tempos aplicados em servicos de revisao ou funilaria, mecanica ou pintura a clientes, inclusive garantia VW
Cliente/Garantia   (CR/CF, GR/GF, CM/CP, GM/GP). Sao os custos das vendas.
DL->Deslocamento: Anotar os tempos aplicados em deslocamento.

Tempo Produtivo -> Anotar os tempos aplicados em servicos para os setores: Veiculos Novos, Usados, Pecas e Administracao.
Interno      (2)   IVC-Interno Vendas Caminhoes. Veiculos novos
IVO-Interno Vendas Onibus. Veiculos novos
IU -Interno Usados. Veiculos usados
IP -Interno pecas. Servicos para o setor de pecas
IA -Interno Administracao. Servicos para o setor de administracao

Tempo Oficina(3)-> Todos estes tempos constituem despesas para os setor:
PO-Atividades internas de oficina. Anotar os tempos aplicados em atividades internas da oficina,
que tambem constituem despesas. Sao as horas gastas na construcao de ferramentas/consertos/manutencao/limpeza/etc.
TP-Total do tempo perdido. Anotar o total de tempo perdido que tambem constitui despesas. Sao as horas em que o produtivo,
por qualquer razao, nao realiza nenhum trabalho, falta de servico e ou ma distribuicao de trabalho.
GO-Tempos aplicados em servicos refeitos em garantia. Anotar os tempos aplicados em servicos refeitos pela oficina em garantia.
sao as horas gastas nos servicos refeitos da oficina.

Tempo disponivel-> E a soma dos tempos das colunas 1, 2 e 3, obtendo-se o tempo total em que produtivos estiverem a disposicao da oficina para
(1+2+3)   prestar servicos.

Ausencia(4)     -> Anotar a soma dos tempos referentes aos produtivos que estiverem em ferias, treinamento ou
remunerada         ausencia remunerada.

Total tempo(5)  -> Anotar a soma do tempo disponivel mais ausencia remunerada.
Remunerado(1+2+3+4)

Ausencia nao    -> Anotar a soma dos tempos referentes a faltas e atrasos nao justicados, nao remunerados.
Remunerada(6)

Horas(7)        -> Anotar a soma dos tempos que os produtivos ultrapassam na sua jornada diaria de trabalho.
Suplementares

Total do tp(8)  -> Anotar a soma das colunas(5+6+7). O resultado devera ser igual a quantidade de Produtivos x JDT
Normal(5+6-7)
Tempo Vendido   -> Cliente Rev./Fun./Mec./Pin.: Anotar os tempos registrados no CDT, para servicos de revisao/funilaria
e mecanica/pintura. Referem-se aos tempos TPR/Orcamento para servicos "Clientes" e/ou "Garantia VW",
exclusivamente.
Deslocamento: Tempos vendidos nos atendimentos com deslocamento(DL).
Interno: Anotar tempos, registrados no CDT, para servicos executados a favor dos setores internos do DN
(IVC, IVO, IU, IP e IA)
*/

Return
