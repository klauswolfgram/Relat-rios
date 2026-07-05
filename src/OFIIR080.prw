/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma pr·tica e de f·cil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// …ÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕÕª
// ∫ Versao ∫ 5      ∫
// »ÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕÕº

#Include "PROTHEUS.Ch"
#Include "OFIIR080.Ch"

/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|FunÁ„o    | OFIIR080   | Autor |  Luis Delorme         | Data | 27/11/06 |##
##+----------+------------+-------+-----------------------+------+----------+##
##|DescriÁ„o | Exporta CDB - Clientes SCANIA                                |##
##+----------+--------------------------------------------------------------+##
##|Uso       | Concession·rias                                              |##
##+----------+--------------------------------------------------------------+##
###############################################################################
===============================================================================
*/
User Function OFIIR080()

Private cAlias    := "SA1"
Private aReturn   := { STR0002, 1,STR0003, 1, 2, 1, "",1 }    //"Zebrado"##"Administracao"
Private cTamanho  := "G"          // P/M/G
Private Limite    := 220          // 80/132/220
Private cNomeProg := "OFIIR080"
Private cNomeRel  := "OFIIR080"
Private nLastKey  := 0
Private nCaracter := 15
Private cDesc1    := STR0004   //"Gera informaÁ„o de clientes "
Private cDesc2    := STR0005   //"para envio da planilha CSI."
Private cDesc3    := ""
Private cabec1    := STR0013
Private cabec2    := ""
Private lAbortPrint := .f.
Private m_Pag     := 1
Private nLin      := 0
Private nQuebra   := 55
Private cPerg     := "OFIIR080"
Private cTitulo   := STR0001  //"Geracao do CSI/SCANIA" // aprox 45 caracteres
Private aCGC := {}
// Verifica as perguntas selecionadas ============================================================================
ValidPerg()
Pergunte(cPerg,.F.) // .f. / .t.= n„o mostra / mostra janela da PERGUNTE()

cNomeRel := SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,.t.,cTamanho) // TODO: par‚metros

// Verifica se teclou <ESC> para abortar relatÛrio
If nLastKey == 27
	Return
EndIf

// Chamada do Relatorio
SetDefault(aReturn,cAlias)

RptStatus( { |lEnd| FS_GERAREL(@lEnd,cNomeRel,cAlias) } , cTitulo )

If aReturn[5] == 1
	OurSpool( cNomeRel )
EndIf

Ms_Flush()

Return

/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|FunÁ„o    | OFIIR080   | Autor |  Luis Delorme         | Data | 27/11/06 |##
##+----------+------------+-------+-----------------------+------+----------+##
##|DescriÁ„o | GeraÁ„o do Arquivo e dados para impress„o                    |##
##+----------+--------------------------------------------------------------+##
##|Uso       | Concession·rias                                              |##
##+----------+--------------------------------------------------------------+##
###############################################################################
===============================================================================
*/
Static Function FS_GERAREL()

Local cTipoReg   := "I"
Local nTotN      := 0
Local nTotNE     := 0
Local nValNR     := 0
Local nValNE     := 0
Local nImpNE     := 0
Local nImpNSF    := 0
Local nTotNR     := 0
Local nImpNR     := 0
Local nId        := 0
Local aVetCampos := {}
Local cQuery     := ""
Local cAliasSF2  := "SQLSF2"
Local cAliasVO2  := "SQLVO2"
Local i := 0
Local aVetInt := {}

Private aNewCampos :={}
Private aVetOrdem  := {}
Private aTabulacao := {51,58,15,9,26,3,2,2,2,2} // TabulaÁıes dos registros dos relatorios
Private cNImpCpo := ""

// CriaÁ„o de Arquivos de Trabalho e Indices =====================================================================
// Arquivo de trabalho para armazenar relatÛrio
aadd(aVetCampos,{ "REL_LINHA" , "C" , 220 , 0 })  //  Linha do RelatÛrio
oObjTempTable := OFDMSTempTable():New()
oObjTempTable:cAlias := "REL"
oObjTempTable:aVetCampos := aVetCampos
oObjTempTable:CreateTable(.f.)

aVetCampos := {}
// Arquivo de Trabalho para exportaÁ„o
aadd(aVetCampos,{ "TRB_CODIGO" , "C" ,  8 , 0 })   //  Linha Texto
aadd(aVetCampos,{ "A1_NOME"    , "C" , 50 , 0 })   //  Linha Texto
aadd(aVetCampos,{ "A1_END"     , "C" , 57 , 0 })   //  Linha Texto
aadd(aVetCampos,{ "A1_TEL"     , "C" , 15 , 0 })   //  Linha Texto
aadd(aVetCampos,{ "A1_CEP"     , "C" ,  8 , 0 })   //  Linha Texto
aadd(aVetCampos,{ "A1_MUN"     , "C" , 25 , 0 })   //  Linha Texto
aadd(aVetCampos,{ "A1_EST"     , "C" ,  2 , 0 })   //  Linha Texto
aadd(aVetCampos,{ "TRB_VEI"    , "C" ,  1 , 0 })   //  Linha Texto
aadd(aVetCampos,{ "TRB_OFF"    , "C" ,  1 , 0 })   //  Linha Texto - Os Fechada Oficina
aadd(aVetCampos,{ "TRB_OFA"    , "C" ,  1 , 0 })   //  Linha Texto - Os Aberta
aadd(aVetCampos,{ "TRB_OFB"    , "C" ,  1 , 0 })   //  Linha Texto - Balcao
If ( ExistBlock("IR080TRB") ) // Adiciona novos campos no arquivo de trabalho
	aNewCampos := ExecBlock("IR080TRB",.f.,.f.,{aVetCampos})
	For i := 1 to Len(aNewCampos)
		aadd(aVetCampos,{aNewCampos[i,1],aNewCampos[i,2],aNewCampos[i,3],aNewCampos[i,4]})
	Next
EndIf
cDocInd1 := CriaTrab(NIL, .F.)
o2ObjTempTable := OFDMSTempTable():New()
o2ObjTempTable:cAlias := "TRB"
o2ObjTempTable:aVetCampos := aVetCampos
o2ObjTempTable:AddIndex(cDocInd1, {"TRB_CODIGO"} )
o2ObjTempTable:CreateTable(.f.)

// Lista clientes de veiculos
cQuery := "SELECT DISTINCT SF2.F2_CLIENTE,SF2.F2_LOJA,SF2.F2_PREFORI,"
For i := 1 to Len(aNewCampos)
	cQuery += aNewCampos[i,1]+","
Next
cQuery += " SA1.A1_NOME,SA1.A1_END,SA1.A1_NUMERO,SA1.A1_CEP,SA1.A1_MUN,SA1.A1_EST,SA1.A1_TEL"
cQuery += " FROM "+RetSqlName("SF2")+" SF2 "
cQuery += " INNER JOIN "+RetSqlName("SD2")+" SD2 ON (SD2.D2_FILIAL = '"+xFilial("SD2")+"' AND SD2.D2_DOC     = SF2.F2_DOC      AND SD2.D_E_L_E_T_=' ') "
cQuery += " INNER JOIN "+RetSqlName("SF4")+" SF4 ON (SF4.F4_FILIAL = '"+xFilial("SF4")+"' AND SF4.F4_CODIGO  = SD2.D2_TES      AND SF4.F4_OPEMOV = '05'      AND SF4.D_E_L_E_T_=' ') "
cQuery += " INNER JOIN "+RetSqlName("SA1")+" SA1 ON (SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD     = SF2.F2_CLIENTE  AND SA1.A1_LOJA = SF2.F2_LOJA AND SA1.D_E_L_E_T_=' ') "
cQuery += " WHERE SF2.F2_FILIAL='"+xFilial("SF2")+"' AND SF2.F2_EMISSAO >='"+Dtos(MV_Par01)+"' AND SF2.F2_EMISSAO <= '"+Dtos(MV_Par02)+"' AND "
cQuery += " SF2.F2_PREFORI = '"+GetNewPar("MV_PREFVEI","VEI")+"' AND SF2.D_E_L_E_T_ = ' ' "
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cAliasSF2 , .F., .T. )

DBSelectArea("TRB")

while (cAliasSF2)->(!Eof())
	
	if !DBSeek((cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA)
		
		Reclock("TRB",.t.)
		TRB_CODIGO 	:=(cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA
		A1_NOME     := (cAliasSF2)->A1_NOME
		A1_END 		:= Alltrim((cAliasSF2)->A1_END)
		A1_CEP 		:= (cAliasSF2)->A1_CEP
		A1_MUN 		:= (cAliasSF2)->A1_MUN
		A1_EST		:= (cAliasSF2)->A1_EST
		A1_TEL 		:= (cAliasSF2)->A1_TEL
		TRB_VEI 		:= "X"

		For i := 1 to Len(aNewCampos)
			&(aNewCampos[i,1]) := (cAliasSF2)->&(aNewCampos[i,1])
		Next
		
		Msunlock()
		
	endif
	
	(cAliasSF2)->(DBSkip())
	
enddo
(cAliasSF2)->(DBCloseArea())

// lista clientes oficina (OS fechada)
cQuery := "SELECT DISTINCT SF2.F2_CLIENTE,SF2.F2_LOJA,SF2.F2_PREFORI,"
For i := 1 to Len(aNewCampos)
	cQuery += aNewCampos[i,1]+","
Next
cQuery += " SA1.A1_NOME,SA1.A1_END,SA1.A1_CEP,SA1.A1_MUN,SA1.A1_EST,SA1.A1_DDD,SA1.A1_TEL"
cQuery += " FROM "+RetSqlName("SF2")+" SF2 "
cQuery += " INNER JOIN "+RetSqlName("SD2")+" SD2 ON (SD2.D2_FILIAL = '"+xFilial("SD2")+"' AND SD2.D2_DOC     = SF2.F2_DOC      AND SD2.D_E_L_E_T_=' ') "
cQuery += " INNER JOIN "+RetSqlName("SF4")+" SF4 ON (SF4.F4_FILIAL = '"+xFilial("SF4")+"' AND SF4.F4_CODIGO  = SD2.D2_TES      AND SF4.F4_OPEMOV = '05'      AND SF4.D_E_L_E_T_=' ') "
cQuery += " INNER JOIN "+RetSqlName("SA1")+" SA1 ON (SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD     = SF2.F2_CLIENTE  AND SA1.A1_LOJA = SF2.F2_LOJA AND SA1.D_E_L_E_T_=' ') "
cQuery += " WHERE SF2.F2_FILIAL='"+xFilial("SF2")+"' AND SF2.F2_EMISSAO >='"+Dtos(MV_Par03)+"' AND SF2.F2_EMISSAO <= '"+Dtos(MV_Par04)+"' AND "
cQuery += " SF2.F2_PREFORI IN ('"+GetNewPar("MV_PREFOFI","OFI")+"','"+GetNewPar("MV_PREFBAL","BAL")+"') AND SF2.D_E_L_E_T_ = ' ' "
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cAliasSF2 , .F., .T. )

DBSelectArea("TRB")

while (cAliasSF2)->(!Eof())
	
	DBSelectArea("TRB")
	if !DBSeek((cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA)
		
		Reclock("TRB",.t.)
		TRB_CODIGO	:=(cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA
		A1_NOME     := (cAliasSF2)->A1_NOME
		A1_END 		:= Alltrim((cAliasSF2)->A1_END)
		A1_CEP 		:= (cAliasSF2)->A1_CEP
		A1_MUN 		:= (cAliasSF2)->A1_MUN
		A1_EST		:= (cAliasSF2)->A1_EST
		A1_TEL 		:= (cAliasSF2)->A1_TEL
		
		If (cAliasSF2)->F2_PREFORI == "OFI"
			TRB_OFF := "X"
		Else
			TRB_OFB := "X"
		Endif

		For i := 1 to Len(aNewCampos)
			&(aNewCampos[i,1]) := (cAliasSF2)->&(aNewCampos[i,1])
		Next

		Msunlock()
		
	else
		
		Reclock("TRB",.f.)
		If (cAliasSF2)->F2_PREFORI == "OFI"
			TRB_OFF := "X"
		Else
			TRB_OFB := "X"
		Endif
		Msunlock()
		
	endif
	
	(cAliasSF2)->(DBSkip())
	
enddo
(cAliasSF2)->(DBCloseArea())

// lista clientes oficina (OS aberta)
cQuery := "SELECT DISTINCT VO1.VO1_PROVEI,VO1.VO1_LOJPRO,"
For i := 1 to Len(aNewCampos)
	cQuery += aNewCampos[i,1]+","
Next
cQuery += " SA1.A1_NOME,SA1.A1_END,SA1.A1_CEP,SA1.A1_MUN,SA1.A1_EST,SA1.A1_DDD,SA1.A1_TEL"
cQuery += " FROM "+RetSqlName("VO2")+" VO2 "
cQuery += " INNER JOIN "+RetSqlName("VO1")+" VO1 ON (VO1.VO1_FILIAL = '"+xFilial("VO1")+"' AND VO1.VO1_NUMOSV = VO2.VO2_NUMOSV  AND VO1.D_E_L_E_T_ = ' ') "
cQuery += " INNER JOIN "+RetSqlName("VO3")+" VO3 ON (VO3.VO3_FILIAL = '"+xFilial("VO3")+"' AND VO3.VO3_NUMOSV = VO2.VO2_NUMOSV  AND VO3.VO3_DATCAN = ' ' AND VO3.VO3_DATFEC = ' ' AND VO3.D_E_L_E_T_=' ') "
cQuery += " INNER JOIN "+RetSqlName("SA1")+" SA1 ON (SA1.A1_FILIAL  = '"+xFilial("SA1")+"' AND SA1.A1_COD     = VO1.VO1_PROVEI  AND SA1.A1_LOJA    = VO1.VO1_LOJPRO AND SA1.D_E_L_E_T_=' ') "
cQuery += " WHERE VO2.VO2_FILIAL='"+xFilial("VO2")+"' AND VO2.VO2_DATREQ >='"+Dtos(MV_Par05)+"' AND VO2.VO2_DATREQ <= '"+Dtos(MV_Par06)+"' AND VO2.D_E_L_E_T_ = ' ' "
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cAliasVO2 , .F., .T. )

while (cAliasVO2)->(!Eof())
	
	DBSelectArea("TRB")
	if !DBSeek((cAliasVO2)->VO1_PROVEI+(cAliasVO2)->VO1_LOJPRO)
		
		Reclock("TRB",.t.)
		TRB_CODIGO	 :=(cAliasVO2)->VO1_PROVEI+(cAliasVO2)->VO1_LOJPRO
		A1_NOME     := (cAliasVO2)->A1_NOME
		A1_END 		:= Alltrim((cAliasVO2)->A1_END)
		A1_CEP 		:= (cAliasVO2)->A1_CEP
		A1_MUN 		:= (cAliasVO2)->A1_MUN
		A1_EST		:= (cAliasVO2)->A1_EST
		A1_TEL 		:= (cAliasVO2)->A1_TEL
		TRB_OFA 	 := "X"

		For i := 1 to Len(aNewCampos)
			&(aNewCampos[i,1]) := (cAliasVO2)->&(aNewCampos[i,1])
		Next

		Msunlock()
		
	else
		
		Reclock("TRB",.f.)
		TRB_OFA		 := "X"
		Msunlock()
		
	endif
	
	(cAliasVO2)->(DBSkip())
	
enddo
(cAliasVO2)->(DBCloseArea())

For i := 1 to Len(aVetCampos)
	aAdd(aVetOrdem,aVetCampos[i,1])
Next

cNImpCpo := "REL_LINHA,TRB_CODIGO"

If ( ExistBlock("IR080ORD") )
	ExecBlock("IR080ORD",.f.,.f.,{aVetOrdem,aTabulacao}) // ordem de impress„o dos campos
EndIf

DBSelectArea("TRB")
DBGoTop()
while !eof()
	aVetInt := {}
	For i := 1 to Len(aVetOrdem)
		If !(aVetOrdem[i] $ cNImpCpo)
			aAdd(aVetInt,TRB->&(aVetOrdem[i]))
		EndIf
	Next
	FS_GRAVAREL(aVetInt,aTabulacao)
	DBSelectArea("TRB")
	DBSkip()
enddo

o2ObjTempTable:CloseTable()

MsgStop(STR0006)   //"Arquivo gerado com sucesso"
FS_IMPRIME()

oObjTempTable:CloseTable()

Return

/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|FunÁ„o    | FS_GRAVAREL| Autor |  Luis Delorme         | Data | 27/11/06 |##
##+----------+------------+-------+-----------------------+------+----------+##
##|DescriÁ„o | GravaÁ„o do Arquivo de trabalho                              |##
##+----------+--------------------------------------------------------------+##
##|Uso       | Concession·rias                                              |##
##+----------+--------------------------------------------------------------+##
###############################################################################
===============================================================================
*/
Static Function FS_GRAVAREL(aInf,aTab)

Local nTab := 0

Private cLinha := ""

for nTab := 1 to Len(aTab)
	cLinha += Left(aInf[nTab]+space(aTab[nTab]),aTab[nTab]-1)+" "
next

reclock("REL",.t.)
REL->REL_LINHA := cLinha
msunlock()

return

/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|FunÁ„o    | FS_IMPRIME | Autor |  Luis Delorme         | Data | 27/11/06 |##
##+----------+------------+-------+-----------------------+------+----------+##
##|DescriÁ„o | Impress„o do relatÛrio                                       |##
##+----------+--------------------------------------------------------------+##
##|Uso       | Concession·rias                                              |##
##+----------+--------------------------------------------------------------+##
###############################################################################
===============================================================================
*/
Static Function FS_IMPRIME()

nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,ctamanho,nCaracter) + 1

DBSelectArea("REL")
DBGoTop()
while !eof()
	
	if nLin == nQuebra
		nLin := cabec(ctitulo,cabec1,cabec2,cNomeRel,ctamanho,nCaracter) + 1
	endif
	
	@nLin++,00 psay REL->REL_LINHA
	
	DBSkip()
	
enddo

@++nLin,00 psay STR0014

return

/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|FunÁ„o    | ValidPerg  | Autor |  Luis Delorme         | Data | 27/11/06 |##
##+----------+------------+-------+-----------------------+------+----------+##
##|DescriÁao | Gera Pergunte SX1                                            |##
##+----------+--------------------------------------------------------------+##
##|Uso       | Concession·rias                                              |##
##+----------+--------------------------------------------------------------+##
###############################################################################
===============================================================================
*/
Static Function ValidPerg

local _sAlias := Alias()
local aRegs := {}
local i,j

dbSelectArea("SX1")
dbSetOrder(1)

cPerg := PADR(cPerg, Len(SX1->X1_GRUPO) )
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01",STR0007,"","","mv_ch1","D",8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})             //"Veiculos   -Dt Inicial?"
aAdd(aRegs,{cPerg,"02",STR0008,"","","mv_ch2","D",8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})             //"Veiculos   -Dt Final  ?"
aAdd(aRegs,{cPerg,"03",STR0009,"","","mv_ch3","D",8,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})             //"OFI F / Bal-Dt Inicial?"
aAdd(aRegs,{cPerg,"04",STR0010,"","","mv_ch4","D",8,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","",""})             //"OFI F / Bal-Dt Final  ?"
aAdd(aRegs,{cPerg,"05",STR0011,"","","mv_ch5","D",8,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})             //"OFI Aberta -Dt Inicial?"
aAdd(aRegs,{cPerg,"06",STR0012,"","","mv_ch6","D",8,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","",""})             //"OFI Aberta -Dt Final  ?"

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
