/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 10     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "protheus.ch"
#Include "fileio.ch"
#Include "VEICR100.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao    ³ VEICR100 ³ Autor ³ Manoel Filho         ³ Data ³ 26/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao ³ Impressao de Pesquisas da Concessionaria                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEICR100
Private cPerg := "VCR100"
Private cPRW  := "VEICR100"
DbSelectArea("VCJ")
ValidPerg()
Processa({|| FS_VEICR100()})
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao    ³FS_VEICR100³ Autor ³ Manoel Filho        ³ Data ³ 26/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao ³ Impressao de Pesquisas da Concessionaria                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_VEICR100()
Local nTPIni    := 1 // Tipo de Pesquisa Incial
Local nTPFin    := 4 // Tipo de Pesquisa Final
Local nTPesq    := 0 // Tipo de Pesquisa
Local cTPesq    := "000" // Tipo de Pesquisa
Local _i_       := 0
Local _cAlVCK   := "SQLVCK"
Local cQuery    := ""
Local aPesquisa := {}
Local lA1_IBGE    := ( SA1->(FieldPos("A1_IBGE")) > 0 )
Local lVAQ_TIPOSI := ( VAQ->(FieldPos("VAQ_TIPOSI")) > 0 )
Local lVAO_ORIGEM := ( VAO->(FieldPos("VAO_ORIGEM")) > 0 )
Local cDtFecP   := ""
Local cDtFecS   := ""
Local cDtFec    := ""

cDesc1 := cDesc2 := cDesc3 := ""
aReturn := { STR0017, 1,STR0018, 2, 2, 1, "",1 }//Zebrado ## Administracao

li        := 80
m_pag     := 1
cTamanho  := "M"
Tamanho   := "M"
limite    := 132
nTipo     := 15
nCaracter := 15
nomeprog  := STR0002   //PESQUISA
cString   := "VCK"
nLastKey  := 0

titulo    := STR0002
wnrel     := "VEICR100"
wnrel     := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,Tamanho)

If nLastKey == 27
	Set Filter to
	Return
Endif

Pergunte(cPerg,.f.)
While .t.
	If MV_PAR02 == 1 .and. Empty(MV_PAR03) // Codigo de Origem (VV0_NUMTRA)
		MsgInfo(STR0001)//Para utilizar o Filtro por CODIGO DE ORIGEM e' necessario informar o CODIGO DE ORIGEM!
	Else
		exit
	EndIf
	If !Pergunte(cPerg,.t.)
		Return
	Endif
Enddo

Set Printer to &wnrel
Set Printer On
Set Device  to Printer

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter To
	Return
Endif

If !Empty(MV_PAR01)
	nTPIni := nTPFin := val(MV_PAR01)
EndIf
For nTPesq := nTPIni to nTPFin
	cTPesq := strzero(nTPesq,3) // Tipo de Pesquisa
	If cTPesq == "001" // Satisfacao de Venda de Veiculos
		Titulo := STR0003  //Pesquisa de Satisfacao de Venda de Veiculos
		cQuery := "SELECT VV0.VV0_DATMOV , VV0.VV0_NUMTRA , VCJ.VCJ_CODPER , VCJ.VCJ_PERGUN , VCJ.VCJ_OPCOES , VCJ.VCJ_HABOBS , VCK.* , SA1.A1_TEL , SA1.A1_MUN , SA1.A1_EST , VV9.VV9_FILIAL , VV9.VV9_CODCLI , VV9.VV9_LOJA , VV9.VV9_NOMVIS "
		If lA1_IBGE
			cQuery += ", VAM.VAM_DESCID , VAM.VAM_DDD , VAM.VAM_ESTADO "
		EndIf
		If ( MV_PAR02 == 1 .and. !Empty(MV_PAR03) ) .or. ( MV_PAR02 == 2 ) // Codigo de Origem (VV0_NUMTRA) ou Data de Origem (VV0_DATMOV)
			cQuery += "FROM "+RetSqlName("VV0")+" VV0 "
			cQuery += "JOIN "+RetSqlName("VV9")+" VV9 ON ( VV9.VV9_FILIAL = '"+xFilial("VV9")+"' AND VV9.VV9_NUMATE = VV0.VV0_NUMTRA AND VV9.D_E_L_E_T_ = ' ' ) "
			cQuery += "JOIN "+RetSqlName("VCK")+" VCK ON ( VCK.VCK_FILIAL = '"+xFilial("VCK")+"' AND VCK.VCK_ORIGEM = VV0.VV0_NUMTRA AND VCK.D_E_L_E_T_ = ' ' ) "
			cQuery += "JOIN "+RetSqlName("VCJ")+" VCJ ON ( VCJ.VCJ_FILIAL = '"+xFilial("VCJ")+"' AND VCJ.VCJ_TIPPES = '001' AND VCJ.VCJ_CODPER = VCK.VCK_CODPER AND VCJ.D_E_L_E_T_ = ' ' ) "
			cQuery += "JOIN "+RetSqlName("VC1")+" VC1 ON ( VC1.VC1_FILIAL = '"+xFilial("VC1")+"' AND VC1.VC1_ORIGEM = VCK.VCK_ORIGEM AND VC1.VC1_TIPORI='V' AND VC1.D_E_L_E_T_=' ' ) "
			If Empty(MV_PAR07) // SEM Nivel de Importancia do Cliente
				cQuery += "LEFT JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VV9.VV9_CODCLI AND SA1.A1_LOJA = VV9.VV9_LOJA AND SA1.D_E_L_E_T_ = ' ' ) "
			Else // COM Nivel de Importancia Cliente
				cQuery += "JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VV9.VV9_CODCLI AND SA1.A1_LOJA = VV9.VV9_LOJA AND SA1.D_E_L_E_T_ = ' ' ) "
				cQuery += "JOIN "+RetSqlName("VCF")+" VCF ON ( VCF.VCF_FILIAL = '"+xFilial("VCF")+"' AND VCF.VCF_CODCLI = SA1.A1_COD AND VCF.VCF_LOJCLI = SA1.A1_LOJA AND VCF.VCF_NIVIMP = '"+MV_PAR07+"' AND VCF.D_E_L_E_T_ = ' ' ) "
			EndIf
			If lA1_IBGE
				cQuery += "LEFT JOIN "+RetSqlName("VAM")+" VAM ON (  VAM.VAM_FILIAL = '"+xFilial("VAM")+"' AND VAM.VAM_IBGE = SA1.A1_IBGE AND VAM.D_E_L_E_T_ = ' ' ) "
			Endif
			cQuery += "WHERE VV0.VV0_FILIAL = '"+xFilial("VV0")+"' AND "
			If MV_PAR02 == 1 .and. !Empty(MV_PAR03) // Codigo de Origem (VV0_NUMTRA)
				cQuery += "VV0.VV0_NUMTRA = '"+Left(MV_PAR03,Len(VV0->VV0_NUMTRA))+"' AND "
			ElseIf MV_PAR02 == 2 // Data de Origem (VV0_DATMOV)
				cQuery += "VV0.VV0_DATMOV >= '"+Dtos(MV_PAR04)+"' AND VV0.VV0_DATMOV <= '"+Dtos(MV_PAR05)+"' AND "
			EndIf
			cQuery += "VV0.D_E_L_E_T_ = ' ' "
		ElseIf MV_PAR02 == 3 // Data de Pesquisa (Data da Agenda VC1)
			cQuery += ", VC1.VC1_DATAGE "
			cQuery += "FROM "+RetSqlName("VC1")+" VC1 "
			cQuery += "JOIN "+RetSqlName("VCK")+" VCK ON ( VCK.VCK_FILIAL = '"+xFilial("VCK")+"' AND VCK.VCK_ORIGEM = VC1.VC1_ORIGEM AND VCK.D_E_L_E_T_ = ' ' ) "
			cQuery += "JOIN "+RetSqlName("VCJ")+" VCJ ON ( VCJ.VCJ_FILIAL = '"+xFilial("VCJ")+"' AND VCJ.VCJ_TIPPES = '001' AND VCJ.VCJ_CODPER = VCK.VCK_CODPER AND VCJ.D_E_L_E_T_ = ' ' ) "
			cQuery += "LEFT JOIN "+RetSqlName("VV0")+" VV0 ON ( VV0.VV0_FILIAL = '"+xFilial("VV0")+"' AND VV0.VV0_NUMTRA = VCK.VCK_ORIGEM AND VV0.D_E_L_E_T_ = ' ' ) "
			cQuery += "LEFT JOIN "+RetSqlName("VV9")+" VV9 ON ( VV9.VV9_FILIAL = '"+xFilial("VV9")+"' AND VV9.VV9_NUMATE = VV0.VV0_NUMTRA AND VV9.D_E_L_E_T_ = ' ' ) "
			If Empty(MV_PAR07) // SEM Nivel de Importancia do Cliente
				cQuery += "LEFT JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VV9.VV9_CODCLI AND SA1.A1_LOJA = VV9.VV9_LOJA AND SA1.D_E_L_E_T_ = ' ' ) "
			Else // COM Nivel de Importancia Cliente
				cQuery += "JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VV9.VV9_CODCLI AND SA1.A1_LOJA = VV9.VV9_LOJA AND SA1.D_E_L_E_T_ = ' ' ) "
				cQuery += "JOIN "+RetSqlName("VCF")+" VCF ON ( VCF.VCF_FILIAL = '"+xFilial("VCF")+"' AND VCF.VCF_CODCLI = SA1.A1_COD AND VCF.VCF_LOJCLI = SA1.A1_LOJA AND VCF.VCF_NIVIMP = '"+MV_PAR07+"' AND VCF.D_E_L_E_T_ = ' ' ) "
			EndIf
			If lA1_IBGE
				cQuery += "LEFT JOIN "+RetSqlName("VAM")+" VAM ON (  VAM.VAM_FILIAL = '"+xFilial("VAM")+"' AND VAM.VAM_IBGE = SA1.A1_IBGE AND VAM.D_E_L_E_T_ = ' ' ) "
			Endif
			cQuery += "WHERE VC1.VC1_FILIAL='"+xFilial("VC1")+"' AND VC1.VC1_DATAGE >= '"+dtos(MV_PAR04)+"' AND VC1.VC1_DATAGE <= '"+dtos(MV_PAR05)+"' AND VC1.VC1_TIPORI='V' AND VC1.D_E_L_E_T_=' ' "
		Endif
		cQuery += "ORDER BY VCK.VCK_ORIGEM , VCJ.VCJ_SEQUEN , VCK.VCK_CODPER "
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), _cAlVCK , .F., .T. )
		While !( _cAlVCK )->( Eof() )
			cOpcoes := FORMATIN(Alltrim(( _cAlVCK )->( VCJ_OPCOES )),';')
			cOpcoes := "{"+Subs(cOpcoes,2,Len(cOpcoes)-2)+"}"
			nPos  := at(( _cAlVCK )->( VCK_RESPOS )+"=",cOpcoes)
			nPos1 := at("','",Subs(cOpcoes,nPos))
			If nPos1 == 0
				cResp := Subs(cOpcoes,nPos,len(cOpcoes)-(nPos+1))
			Else
				cResp := Subs(cOpcoes,nPos,nPos1-1)
			Endif
			If cResp == "{''"
				cResp := ""
			Endif
			cDtImp := IIf(MV_PAR02<>3,( _cAlVCK )->VCK_DATPES,( _cAlVCK )->VC1_DATAGE) // Data de Pesquisa / Agenda
			cFone  := IIf(lA1_IBGE,"("+( _cAlVCK )->VAM_DDD+") ","")+Alltrim(( _cAlVCK )->A1_TEL)
			cCidade:= Alltrim(left(IIf(lA1_IBGE,( _cAlVCK )->VAM_DESCID,( _cAlVCK )->A1_MUN),17))+"-"+IIf(lA1_IBGE,( _cAlVCK )->VAM_ESTADO,( _cAlVCK )->A1_EST)
			Cabec1 := STR0004+" "+( _cAlVCK )->VV0_NUMTRA+"    "+STR0005+" "+Dtoc(Stod(( _cAlVCK )->VV0_DATMOV)) + "   " + STR0006 + "  " + Dtoc(sTod(cDtImp))//Numero do Atendimento ## Data Origem ## Data da Pesquisa
			Cabec2 := STR0007+" "+( _cAlVCK )->VV9_CODCLI+"-"+( _cAlVCK )->VV9_LOJA+" "+( _cAlVCK )->VV9_NOMVIS + " - "+STR0008+" " + cFone + "  -  " + Alltrim(cCidade) ////Cliente ## Fone
			If MV_PAR06 <> 3
				cQuery := "SELECT VAO.R_E_C_N_O_ AS RECVAO FROM "+RetSqlName("VAO")+" VAO "
				If lVAQ_TIPOSI
					cQuery += "JOIN "+RetSqlName("VAQ")+" VAQ ON ( VAQ.VAQ_FILIAL='"+xFilial("VAQ")+"' AND VAQ.VAQ_TIPREC=VAO.VAO_TIPREC AND VAQ.VAQ_TIPOSI<>'1' AND VAQ.D_E_L_E_T_=' ' ) "
				EndIf
				cQuery += "WHERE VAO.VAO_FILIAL='"+xFilial("VAO")+"' AND VAO.VAO_CODCLI='"+( _cAlVCK )->VV9_CODCLI+"' AND VAO.VAO_LOJCLI='"+( _cAlVCK )->VV9_LOJA+"' AND VAO.D_E_L_E_T_=' '"
				If MV_PAR06 == 2 .and. lVAO_ORIGEM
					cQuery += " AND VAO.VAO_FILORI='"+( _cAlVCK )->VV9_FILIAL+"' AND VAO.VAO_ORIGEM='"+( _cAlVCK )->VCK_ORIGEM+"'"
				EndIf				
				If FM_SQL(cQuery) > 0
					Cabec1 += " "+STR0026 // Cliente com RAIC
				EndIf
			EndIf
			aadd(aPesquisa,{( _cAlVCK )->VCJ_PERGUN,cResp,( _cAlVCK )->VCK_OBSERV,( _cAlVCK )->VCJ_HABOBS,cOpcoes,( _cAlVCK )->VCJ_CODPER,cDtImp,( _cAlVCK )->VV0_NUMTRA, Cabec1, Cabec2})
			( _cAlVCK )->(DbSkip())
		EndDo
		( _cAlVCK )->(DbCloseArea())
	ElseIf cTPesq == "002" // Satisfacao de Oficina
		Titulo := STR0009 //Pesquisa de Satisfacao de Oficina
		cQuery := "SELECT VO1.VO1_DATABE , VO1.VO1_NUMOSV , VCJ.VCJ_CODPER , VCJ.VCJ_PERGUN , VCJ.VCJ_OPCOES , VCJ.VCJ_HABOBS , VCK.* , SA1.A1_TEL , SA1.A1_MUN , SA1.A1_EST , VO1.VO1_FILIAL , VO1.VO1_PROVEI , VO1.VO1_LOJPRO , SA1.A1_NOME "
		If lA1_IBGE
			cQuery += ", VAM.VAM_DESCID , VAM.VAM_DDD , VAM.VAM_ESTADO "
		EndIf
		If ( MV_PAR02 == 1 .and. !Empty(MV_PAR03) ) .or. ( MV_PAR02 == 2 ) // Codigo de Origem (VO1_NUMOSV) ou Data de Origem (VO1_DATABE)
			cQuery += "FROM "+RetSqlName("VO1")+" VO1 "
			cQuery += "JOIN "+RetSqlName("VCK")+" VCK ON ( VCK.VCK_FILIAL = '"+xFilial("VCK")+"' AND VCK.VCK_ORIGEM = VO1.VO1_NUMOSV AND VCK.D_E_L_E_T_ = ' ' ) "
			cQuery += "JOIN "+RetSqlName("VCJ")+" VCJ ON ( VCJ.VCJ_FILIAL = '"+xFilial("VCJ")+"' AND VCJ.VCJ_TIPPES = '002' AND VCJ.VCJ_CODPER = VCK.VCK_CODPER AND VCJ.D_E_L_E_T_ = ' ' ) "
			cQuery += "JOIN "+RetSqlName("VC1")+" VC1 ON ( VC1.VC1_FILIAL = '"+xFilial("VC1")+"' AND VC1.VC1_ORIGEM = VCK.VCK_ORIGEM AND VC1.VC1_TIPORI='O' AND VC1.D_E_L_E_T_=' ' ) "
			If Empty(MV_PAR07) // SEM Nivel de Importancia do Cliente
				cQuery += "LEFT JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VO1.VO1_PROVEI AND SA1.A1_LOJA = VO1.VO1_LOJPRO AND SA1.D_E_L_E_T_ = ' ' ) "
			Else // COM Nivel de Importancia Cliente
				cQuery += "JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VO1.VO1_PROVEI AND SA1.A1_LOJA = VO1.VO1_LOJPRO AND SA1.D_E_L_E_T_ = ' ' ) "
				cQuery += "JOIN "+RetSqlName("VCF")+" VCF ON ( VCF.VCF_FILIAL = '"+xFilial("VCF")+"' AND VCF.VCF_CODCLI = SA1.A1_COD AND VCF.VCF_LOJCLI = SA1.A1_LOJA AND VCF.VCF_NIVIMP = '"+MV_PAR07+"' AND VCF.D_E_L_E_T_ = ' ' ) "
			EndIf
			If lA1_IBGE
				cQuery += "LEFT JOIN "+RetSqlName("VAM")+" VAM ON (  VAM.VAM_FILIAL = '"+xFilial("VAM")+"' AND VAM.VAM_IBGE = SA1.A1_IBGE AND VAM.D_E_L_E_T_ = ' ' ) "
			Endif
			cQuery += "WHERE VO1.VO1_FILIAL = '"+xFilial("VO1")+"' AND "
			If MV_PAR02 == 1 .and. !Empty(MV_PAR03) // Codigo de Origem (VO1_NUMOSV)
				cQuery += "VO1.VO1_NUMOSV = '"+Left(MV_PAR03,Len(VO1->VO1_NUMOSV))+"' AND "
			ElseIf MV_PAR02 == 2 // Data de Origem (VO1_DATABE)
				cQuery += "VO1.VO1_DATABE >= '"+Dtos(MV_PAR04)+"' AND VO1.VO1_DATABE <= '"+Dtos(MV_PAR05)+"' AND "
			EndIf
			cQuery += "VO1.D_E_L_E_T_ = ' ' "
		ElseIf MV_PAR02 == 3 // Data de Pesquisa (Data da Agenda VC1)
			cQuery += ", VC1.VC1_DATAGE "
			cQuery += "FROM "+RetSqlName("VC1")+" VC1 "
			cQuery += "JOIN "+RetSqlName("VCK")+" VCK ON ( VCK.VCK_FILIAL = '"+xFilial("VCK")+"' AND VCK.VCK_ORIGEM = VC1.VC1_ORIGEM AND VCK.D_E_L_E_T_ = ' ' ) "
			cQuery += "JOIN "+RetSqlName("VCJ")+" VCJ ON ( VCJ.VCJ_FILIAL = '"+xFilial("VCJ")+"' AND VCJ.VCJ_TIPPES = '002' AND VCJ.VCJ_CODPER = VCK.VCK_CODPER AND VCJ.D_E_L_E_T_ = ' ' ) "
			cQuery += "LEFT JOIN "+RetSqlName("VO1")+" VO1 ON ( VO1.VO1_FILIAL = '"+xFilial("VO1")+"' AND VO1.VO1_NUMOSV = VCK.VCK_ORIGEM AND VO1.D_E_L_E_T_ = ' ' ) "
			If Empty(MV_PAR07) // SEM Nivel de Importancia do Cliente
				cQuery += "LEFT JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VO1.VO1_PROVEI AND SA1.A1_LOJA = VO1.VO1_LOJPRO AND SA1.D_E_L_E_T_ = ' ' ) "
			Else // COM Nivel de Importancia Cliente
				cQuery += "JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VO1.VO1_PROVEI AND SA1.A1_LOJA = VO1.VO1_LOJPRO AND SA1.D_E_L_E_T_ = ' ' ) "
				cQuery += "JOIN "+RetSqlName("VCF")+" VCF ON ( VCF.VCF_FILIAL = '"+xFilial("VCF")+"' AND VCF.VCF_CODCLI = SA1.A1_COD AND VCF.VCF_LOJCLI = SA1.A1_LOJA AND VCF.VCF_NIVIMP = '"+MV_PAR07+"' AND VCF.D_E_L_E_T_ = ' ' ) "
			EndIf
			If lA1_IBGE
				cQuery += "LEFT JOIN "+RetSqlName("VAM")+" VAM ON (  VAM.VAM_FILIAL = '"+xFilial("VAM")+"' AND VAM.VAM_IBGE = SA1.A1_IBGE AND VAM.D_E_L_E_T_ = ' ' ) "
			Endif
			cQuery += "WHERE VC1.VC1_FILIAL='"+xFilial("VC1")+"' AND VC1.VC1_DATAGE >= '"+dtos(MV_PAR04)+"' AND VC1.VC1_DATAGE <= '"+dtos(MV_PAR05)+"' AND VC1.VC1_TIPORI='O' AND VC1.D_E_L_E_T_=' ' "
		Endif                                                                 
		cQuery += "ORDER BY VCK.VCK_ORIGEM , VCJ.VCJ_SEQUEN , VCK.VCK_CODPER "
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), _cAlVCK , .F., .T. )
		While !( _cAlVCK )->( Eof() )
			cOpcoes := FORMATIN(Alltrim(( _cAlVCK )->( VCJ_OPCOES )),';')
			cOpcoes := "{"+Subs(cOpcoes,2,Len(cOpcoes)-2)+"}"
			nPos  := at(( _cAlVCK )->( VCK_RESPOS )+"=",cOpcoes)
			nPos1 := at("','",Subs(cOpcoes,nPos))
			If nPos1 == 0
				cResp := Subs(cOpcoes,nPos,len(cOpcoes)-(nPos+1))
			Else
				cResp := Subs(cOpcoes,nPos,nPos1-1)
			Endif
			If cResp == "{''"
				cResp := ""
			Endif                
			// Data de Pesquisa / Agenda
			cDtImp := IIf(MV_PAR02<>3,( _cAlVCK )->VCK_DATPES,( _cAlVCK )->VC1_DATAGE)
	        // Data de Fechamento da OS
			cDtFecP := FM_SQL("SELECT MAX(VO3.VO3_DATFEC) FROM "+RetSqlName("VO3")+" VO3 WHERE VO3.VO3_FILIAL = '"+xFilial("VO3")+"' AND VO3.VO3_NUMOSV = '"+( _cAlVCK )->VO1_NUMOSV+"' AND VO3.VO3_DATFEC <= '"+cDtImp+"' AND VO3.D_E_L_E_T_ = ' ' ")
			cDtFecS := FM_SQL("SELECT MAX(VO4.VO4_DATFEC) FROM "+RetSqlName("VO4")+" VO4 WHERE VO4.VO4_FILIAL = '"+xFilial("VO4")+"' AND VO4.VO4_NUMOSV = '"+( _cAlVCK )->VO1_NUMOSV+"' AND VO4.VO4_DATFEC <= '"+cDtImp+"' AND VO4.D_E_L_E_T_ = ' ' ")
			If !Empty(cDtFecP)
				cDtFec := cDtFecP
			ElseIf !Empty(cDtFecS)
				cDtFec := cDtFecS
			Endif
			//		
			cFone  := IIf(lA1_IBGE,"("+( _cAlVCK )->VAM_DDD+") ","")+Alltrim(( _cAlVCK )->A1_TEL)
			cCidade:= Alltrim(left(IIf(lA1_IBGE,( _cAlVCK )->VAM_DESCID,( _cAlVCK )->A1_MUN),17))+"-"+IIf(lA1_IBGE,( _cAlVCK )->VAM_ESTADO,( _cAlVCK )->A1_EST)
			Cabec1 := STR0010+" "+( _cAlVCK )->VO1_NUMOSV+" "+STR0005+" "+Dtoc(Stod(( _cAlVCK )->VO1_DATABE)) + " " + STR0027 + " " + Dtoc(sTod(cDtFec)) + " " + STR0006 + " " + Dtoc(stod(cDtImp))//num os ## data origem ## data da pesquisa
			Cabec2 := STR0007+" "+( _cAlVCK )->VO1_PROVEI+"-"+( _cAlVCK )->VO1_LOJPRO+" "+left(( _cAlVCK )->A1_NOME,25) + " - "+STR0008+" " + cFone + "  -  " + Alltrim(cCidade) ////Cliente ## Fone
			If MV_PAR06 <> 3
				cQuery := "SELECT VAO.R_E_C_N_O_ AS RECVAO FROM "+RetSqlName("VAO")+" VAO "
				If lVAQ_TIPOSI
					cQuery += "JOIN "+RetSqlName("VAQ")+" VAQ ON ( VAQ.VAQ_FILIAL='"+xFilial("VAQ")+"' AND VAQ.VAQ_TIPREC=VAO.VAO_TIPREC AND VAQ.VAQ_TIPOSI<>'1' AND VAQ.D_E_L_E_T_=' ' ) "
				EndIf
				cQuery += "WHERE VAO.VAO_FILIAL='"+xFilial("VAO")+"' AND VAO.VAO_CODCLI='"+( _cAlVCK )->VO1_PROVEI+"' AND VAO.VAO_LOJCLI='"+( _cAlVCK )->VO1_LOJPRO+"' AND VAO.D_E_L_E_T_=' '"
				If MV_PAR06 == 2 .and. lVAO_ORIGEM
					cQuery += " AND VAO.VAO_FILORI='"+( _cAlVCK )->VO1_FILIAL+"' AND VAO.VAO_ORIGEM='"+( _cAlVCK )->VCK_ORIGEM+"'"
				EndIf				
				If FM_SQL(cQuery) > 0
					Cabec1 += "    *** "+STR0026+" ***" // Cliente com RAIC
				EndIf
			EndIf
			nPosPsq := aScan(aPesquisa,{|x| x[1]+x[8] == ( _cAlVCK )->VCJ_PERGUN+( _cAlVCK )->VO1_NUMOSV})
			If nPosPsq == 0
				aadd(aPesquisa,{( _cAlVCK )->VCJ_PERGUN,cResp,( _cAlVCK )->VCK_OBSERV,( _cAlVCK )->VCJ_HABOBS,cOpcoes,( _cAlVCK )->VCJ_CODPER,cDtImp,( _cAlVCK )->VO1_NUMOSV, Cabec1, Cabec2})
			EndIf
			( _cAlVCK )->(DbSkip())
		EndDo
		( _cAlVCK )->(DbCloseArea())
	ElseIf cTPesq == "003" // Satisfacao de Balcao de Pecas
		Titulo := STR0011 //Pesquisa de Satisfacao de Balcao de Pecas
		cQuery := "SELECT VS1.VS1_DATORC , VS1.VS1_NUMORC , VCJ.VCJ_CODPER , VCJ.VCJ_PERGUN , VCJ.VCJ_OPCOES , VCJ.VCJ_HABOBS , VCK.* , SA1.A1_TEL , SA1.A1_MUN , SA1.A1_EST , VS1.VS1_FILIAL , VS1.VS1_CLIFAT , VS1.VS1_LOJA , SA1.A1_NOME "
		If lA1_IBGE
			cQuery += ", VAM.VAM_DESCID , VAM.VAM_DDD , VAM.VAM_ESTADO "
		EndIf
		If ( MV_PAR02 == 1 .and. !Empty(MV_PAR03) ) .or. ( MV_PAR02 == 2 ) // Codigo de Origem (VS1_NUMORC) ou Data de Origem (VS1_DATORC)
			cQuery += "FROM "+RetSqlName("VS1")+" VS1 "
			cQuery += "JOIN "+RetSqlName("VCK")+" VCK ON ( VCK.VCK_FILIAL = '"+xFilial("VCK")+"' AND VCK.VCK_ORIGEM = VS1.VS1_NUMORC AND VCK.D_E_L_E_T_ = ' ' ) "
			cQuery += "JOIN "+RetSqlName("VCJ")+" VCJ ON ( VCJ.VCJ_FILIAL = '"+xFilial("VCJ")+"' AND VCJ.VCJ_TIPPES = '003' AND VCJ.VCJ_CODPER = VCK.VCK_CODPER AND VCJ.D_E_L_E_T_ = ' ' ) "
			cQuery += "JOIN "+RetSqlName("VC1")+" VC1 ON ( VC1.VC1_FILIAL = '"+xFilial("VC1")+"' AND VC1.VC1_ORIGEM = VCK.VCK_ORIGEM AND VC1.VC1_TIPORI='B' AND VC1.D_E_L_E_T_=' ' ) "
			If Empty(MV_PAR07) // SEM Nivel de Importancia do Cliente
				cQuery += "LEFT JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VS1.VS1_CLIFAT AND SA1.A1_LOJA = VS1.VS1_LOJA AND SA1.D_E_L_E_T_ = ' ' ) "
			Else // COM Nivel de Importancia Cliente
				cQuery += "JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VS1.VS1_CLIFAT AND SA1.A1_LOJA = VS1.VS1_LOJA AND SA1.D_E_L_E_T_ = ' ' ) "
				cQuery += "JOIN "+RetSqlName("VCF")+" VCF ON ( VCF.VCF_FILIAL = '"+xFilial("VCF")+"' AND VCF.VCF_CODCLI = SA1.A1_COD AND VCF.VCF_LOJCLI = SA1.A1_LOJA AND VCF.VCF_NIVIMP = '"+MV_PAR07+"' AND VCF.D_E_L_E_T_ = ' ' ) "
			EndIf
			If lA1_IBGE
				cQuery += "LEFT JOIN "+RetSqlName("VAM")+" VAM ON (  VAM.VAM_FILIAL = '"+xFilial("VAM")+"' AND VAM.VAM_IBGE = SA1.A1_IBGE AND VAM.D_E_L_E_T_ = ' ' ) "
			Endif
			cQuery += "WHERE VS1.VS1_FILIAL = '"+xFilial("VS1")+"' AND "
			If MV_PAR02 == 1 .and. !Empty(MV_PAR03) // Codigo de Origem (VS1_NUMORC)
				cQuery += "VS1.VS1_NUMORC = '"+Left(MV_PAR03,Len(VS1->VS1_NUMORC))+"' AND "
			ElseIf MV_PAR02 == 2 // Data de Origem (VS1_DATORC)
				cQuery += "VS1.VS1_DATORC >= '"+Dtos(MV_PAR04)+"' AND VS1.VS1_DATORC <= '"+Dtos(MV_PAR05)+"' AND "
			EndIf
			cQuery += "VS1.D_E_L_E_T_ = ' ' "
		ElseIf MV_PAR02 == 3 // Data de Pesquisa (Data da Agenda VC1)
			cQuery += ", VC1.VC1_DATAGE "
			cQuery += "FROM "+RetSqlName("VC1")+" VC1 "
			cQuery += "JOIN "+RetSqlName("VCK")+" VCK ON ( VCK.VCK_FILIAL = '"+xFilial("VCK")+"' AND VCK.VCK_ORIGEM = VC1.VC1_ORIGEM AND VCK.D_E_L_E_T_ = ' ' ) "
			cQuery += "JOIN "+RetSqlName("VCJ")+" VCJ ON ( VCJ.VCJ_FILIAL = '"+xFilial("VCJ")+"' AND VCJ.VCJ_TIPPES = '003' AND VCJ.VCJ_CODPER = VCK.VCK_CODPER AND VCJ.D_E_L_E_T_ = ' ' ) "
			cQuery += "LEFT JOIN "+RetSqlName("VS1")+" VS1 ON ( VS1.VS1_FILIAL = '"+xFilial("VS1")+"' AND VS1.VS1_NUMORC = VCK.VCK_ORIGEM AND VS1.D_E_L_E_T_ = ' ' ) "
			If Empty(MV_PAR07) // SEM Nivel de Importancia do Cliente
				cQuery += "LEFT JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VS1.VS1_CLIFAT AND SA1.A1_LOJA = VS1.VS1_LOJA AND SA1.D_E_L_E_T_ = ' ' ) "
			Else // COM Nivel de Importancia Cliente
				cQuery += "JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VS1.VS1_CLIFAT AND SA1.A1_LOJA = VS1.VS1_LOJA AND SA1.D_E_L_E_T_ = ' ' ) "
				cQuery += "JOIN "+RetSqlName("VCF")+" VCF ON ( VCF.VCF_FILIAL = '"+xFilial("VCF")+"' AND VCF.VCF_CODCLI = SA1.A1_COD AND VCF.VCF_LOJCLI = SA1.A1_LOJA AND VCF.VCF_NIVIMP = '"+MV_PAR07+"' AND VCF.D_E_L_E_T_ = ' ' ) "
			EndIf
			If lA1_IBGE
				cQuery += "LEFT JOIN "+RetSqlName("VAM")+" VAM ON (  VAM.VAM_FILIAL = '"+xFilial("VAM")+"' AND VAM.VAM_IBGE = SA1.A1_IBGE AND VAM.D_E_L_E_T_ = ' ' ) "
			Endif
			cQuery += "WHERE VC1.VC1_FILIAL='"+xFilial("VC1")+"' AND VC1.VC1_DATAGE >= '"+dtos(MV_PAR04)+"' AND VC1.VC1_DATAGE <= '"+dtos(MV_PAR05)+"' AND VC1.VC1_TIPORI='B' AND VC1.D_E_L_E_T_=' ' "
		Endif
		cQuery += "ORDER BY VCK.VCK_ORIGEM , VCJ.VCJ_SEQUEN , VCK.VCK_CODPER "
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), _cAlVCK , .F., .T. )
		While !( _cAlVCK )->( Eof() )
			cOpcoes := FORMATIN(Alltrim(( _cAlVCK )->( VCJ_OPCOES )),';')
			cOpcoes := "{"+Subs(cOpcoes,2,Len(cOpcoes)-2)+"}"
			nPos  := at(( _cAlVCK )->( VCK_RESPOS )+"=",cOpcoes)
			nPos1 := at("','",Subs(cOpcoes,nPos))
			If nPos1 == 0
				cResp := Subs(cOpcoes,nPos,len(cOpcoes)-(nPos+1))
			Else
				cResp := Subs(cOpcoes,nPos,nPos1-1)
			Endif
			If cResp == "{''"
				cResp := ""
			Endif
			cDtImp := IIf(MV_PAR02<>3,( _cAlVCK )->VCK_DATPES,( _cAlVCK )->VC1_DATAGE) // Data de Pesquisa / Agenda
			cFone  := IIf(lA1_IBGE,"("+( _cAlVCK )->VAM_DDD+") ","")+Alltrim(( _cAlVCK )->A1_TEL)
			cCidade:= Alltrim(left(IIf(lA1_IBGE,( _cAlVCK )->VAM_DESCID,( _cAlVCK )->A1_MUN),17))+"-"+IIf(lA1_IBGE,( _cAlVCK )->VAM_ESTADO,( _cAlVCK )->A1_EST)
			Cabec1 := STR0012+" "+( _cAlVCK )->VS1_NUMORC+"    "+STR0005+" "+Dtoc(Stod(( _cAlVCK )->VS1_DATORC)) + "    " + STR0006+" " + Dtoc(sTod(cDtImp))//Numero do Orcamento ##Data Origem ## Data da Pesquisa
			Cabec2 := STR0007+" "+( _cAlVCK )->VS1_CLIFAT+"-"+( _cAlVCK )->VS1_LOJA+" "+left(( _cAlVCK )->A1_NOME,25) + " - "+STR0008+" " + cFone + "  -  " + Alltrim(cCidade) ////Cliente ## Fone
			If MV_PAR06 <> 3
				cQuery := "SELECT VAO.R_E_C_N_O_ AS RECVAO FROM "+RetSqlName("VAO")+" VAO "
				If lVAQ_TIPOSI
					cQuery += "JOIN "+RetSqlName("VAQ")+" VAQ ON ( VAQ.VAQ_FILIAL='"+xFilial("VAQ")+"' AND VAQ.VAQ_TIPREC=VAO.VAO_TIPREC AND VAQ.VAQ_TIPOSI<>'1' AND VAQ.D_E_L_E_T_=' ' ) "
				EndIf
				cQuery += "WHERE VAO.VAO_FILIAL='"+xFilial("VAO")+"' AND VAO.VAO_CODCLI='"+( _cAlVCK )->VS1_CLIFAT+"' AND VAO.VAO_LOJCLI='"+( _cAlVCK )->VS1_LOJA+"' AND VAO.D_E_L_E_T_=' '"
				If MV_PAR06 == 2 .and. lVAO_ORIGEM
					cQuery += " AND VAO.VAO_FILORI='"+( _cAlVCK )->VS1_FILIAL+"' AND VAO.VAO_ORIGEM='"+( _cAlVCK )->VCK_ORIGEM+"'"
				EndIf				
				If FM_SQL(cQuery) > 0
					Cabec1 += "    *** "+STR0026+" ***" // Cliente com RAIC
				EndIf
			EndIf
			aadd(aPesquisa,{( _cAlVCK )->VCJ_PERGUN,cResp,( _cAlVCK )->VCK_OBSERV,( _cAlVCK )->VCJ_HABOBS,cOpcoes,( _cAlVCK )->VCJ_CODPER,cDtImp,( _cAlVCK )->VS1_NUMORC, Cabec1, Cabec2})
			( _cAlVCK )->(DbSkip())
		EndDo
		( _cAlVCK )->(DbCloseArea())
	ElseIf cTPesq == "004" // Satisfacao do CEV
		Titulo := STR0013 //Pesquisa de Satisfacao do CEV
		cQuery := "SELECT VC1.VC1_DATVIS , VC1.VC1_ORIGEM , VCJ.VCJ_CODPER , VCJ.VCJ_PERGUN , VCJ.VCJ_OPCOES , VCJ.VCJ_HABOBS , VCK.* , SA1.A1_TEL , SA1.A1_MUN , SA1.A1_EST , VC1.VC1_FILIAL , VC1.VC1_CODCLI , VC1.VC1_LOJA , SA1.A1_NOME "
		If lA1_IBGE
			cQuery += ", VAM.VAM_DESCID , VAM.VAM_DDD , VAM.VAM_ESTADO "
		EndIf
		If ( MV_PAR02 == 1 .and. !Empty(MV_PAR03) ) .or. ( MV_PAR02 == 2 ) // Codigo de Origem (VC1_ORIGEM) ou Data de Origem (VC1_DATVIS)
			cQuery += "FROM "+RetSqlName("VC1")+" VC1 "
			cQuery += "JOIN "+RetSqlName("VCK")+" VCK ON ( VCK.VCK_FILIAL = '"+xFilial("VCK")+"' AND VCK.VCK_ORIGEM = VC1.VC1_ORIGEM AND VCK.D_E_L_E_T_ = ' '  ) "
			cQuery += "JOIN "+RetSqlName("VCJ")+" VCJ ON ( VCJ.VCJ_FILIAL = '"+xFilial("VCJ")+"' AND VCJ.VCJ_TIPPES = '004' AND VCJ.VCJ_CODPER = VCK.VCK_CODPER AND VCJ.D_E_L_E_T_ = ' ' ) "
			If Empty(MV_PAR07) // SEM Nivel de Importancia do Cliente
				cQuery += "LEFT JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VC1.VC1_CODCLI AND SA1.A1_LOJA = VC1.VC1_LOJA AND SA1.D_E_L_E_T_ = ' ' ) "
			Else // COM Nivel de Importancia Cliente
				cQuery += "JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VC1.VC1_CODCLI AND SA1.A1_LOJA = VC1.VC1_LOJA AND SA1.D_E_L_E_T_ = ' ' ) "
				cQuery += "JOIN "+RetSqlName("VCF")+" VCF ON ( VCF.VCF_FILIAL = '"+xFilial("VCF")+"' AND VCF.VCF_CODCLI = SA1.A1_COD AND VCF.VCF_LOJCLI = SA1.A1_LOJA AND VCF.VCF_NIVIMP = '"+MV_PAR07+"' AND VCF.D_E_L_E_T_ = ' ' ) "
			EndIf
			If lA1_IBGE
				cQuery += "LEFT JOIN "+RetSqlName("VAM")+" VAM ON (  VAM.VAM_FILIAL = '"+xFilial("VAM")+"' AND VAM.VAM_IBGE = SA1.A1_IBGE AND VAM.D_E_L_E_T_ = ' ' ) "
			Endif
			cQuery += "WHERE VC1.VC1_FILIAL = '"+xFilial("VC1")+"' AND "
			If MV_PAR02 == 1 .and. !Empty(MV_PAR03) // Codigo de Origem (VC1_ORIGEM)
				cQuery += "VC1.R_E_C_N_O_ = "+STR(VAL(MV_PAR03))+" AND VC1.VC1_TIPORI='C' AND "
			ElseIf MV_PAR02 == 2 // Data de Origem (VC1_DATVIS)
				cQuery += "VC1.VC1_DATVIS >= '"+Dtos(MV_PAR04)+"' AND VC1.VC1_DATVIS <= '"+Dtos(MV_PAR05)+"' AND VC1.VC1_TIPORI='C' AND "
			EndIf
			cQuery += "VC1.D_E_L_E_T_ = ' ' "
		ElseIf MV_PAR02 == 3 // Data de Pesquisa (Data da Agenda VC1)
			cQuery += ", VC1.VC1_DATAGE "
			cQuery += "FROM "+RetSqlName("VC1")+" VC1 "
			cQuery += "JOIN "+RetSqlName("VCK")+" VCK ON ( VCK.VCK_FILIAL = '"+xFilial("VCK")+"' AND VCK.VCK_ORIGEM = VC1.VC1_ORIGEM AND VCK.D_E_L_E_T_ = ' ' ) "
			cQuery += "JOIN "+RetSqlName("VCJ")+" VCJ ON ( VCJ.VCJ_FILIAL = '"+xFilial("VCJ")+"' AND VCJ.VCJ_TIPPES = '004' AND VCJ.VCJ_CODPER = VCK.VCK_CODPER AND VCJ.D_E_L_E_T_ = ' ' ) "
			If Empty(MV_PAR07) // SEM Nivel de Importancia do Cliente
				cQuery += "LEFT JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VC1.VC1_CODCLI AND SA1.A1_LOJA = VC1.VC1_LOJA AND SA1.D_E_L_E_T_ = ' ' ) "
			Else // COM Nivel de Importancia Cliente
				cQuery += "JOIN "+RetSqlName("SA1")+" SA1 ON ( SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND SA1.A1_COD = VC1.VC1_CODCLI AND SA1.A1_LOJA = VC1.VC1_LOJA AND SA1.D_E_L_E_T_ = ' ' ) "
				cQuery += "JOIN "+RetSqlName("VCF")+" VCF ON ( VCF.VCF_FILIAL = '"+xFilial("VCF")+"' AND VCF.VCF_CODCLI = SA1.A1_COD AND VCF.VCF_LOJCLI = SA1.A1_LOJA AND VCF.VCF_NIVIMP = '"+MV_PAR07+"' AND VCF.D_E_L_E_T_ = ' ' ) "
			EndIf
			If lA1_IBGE
				cQuery += "LEFT JOIN "+RetSqlName("VAM")+" VAM ON (  VAM.VAM_FILIAL = '"+xFilial("VAM")+"' AND VAM.VAM_IBGE = SA1.A1_IBGE AND VAM.D_E_L_E_T_ = ' ' ) "
			Endif
			cQuery += "WHERE VC1.VC1_FILIAL='"+xFilial("VC1")+"' AND VC1.VC1_DATAGE >= '"+dtos(MV_PAR04)+"' AND VC1.VC1_DATAGE <= '"+dtos(MV_PAR05)+"' AND VC1.VC1_TIPORI='C' AND VC1.D_E_L_E_T_=' ' "
		EndIf
		cQuery += "ORDER BY VCK.VCK_ORIGEM , VCJ.VCJ_SEQUEN , VCK.VCK_CODPER "
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), _cAlVCK , .F., .T. )
		while !( _cAlVCK )->( Eof() )
			cOpcoes := FORMATIN(Alltrim(( _cAlVCK )->( VCJ_OPCOES )),';')
			cOpcoes := "{"+Subs(cOpcoes,2,Len(cOpcoes)-2)+"}"
			nPos  := at(( _cAlVCK )->( VCK_RESPOS )+"=",cOpcoes)
			nPos1 := at("','",Subs(cOpcoes,nPos))
			If nPos1 == 0
				cResp := Subs(cOpcoes,nPos,len(cOpcoes)-(nPos+1))
			Else
				cResp := Subs(cOpcoes,nPos,nPos1-1)
			Endif
			If cResp == "{''"
				cResp := ""
			Endif
			cDtImp := IIf(MV_PAR02<>3,( _cAlVCK )->VCK_DATPES,( _cAlVCK )->VC1_DATAGE) // Data de Pesquisa / Agenda
			cFone  := IIf(lA1_IBGE,"("+( _cAlVCK )->VAM_DDD+") ","")+Alltrim(( _cAlVCK )->A1_TEL)
			cCidade:= Alltrim(left(IIf(lA1_IBGE,( _cAlVCK )->VAM_DESCID,( _cAlVCK )->A1_MUN),17))+"-"+IIf(lA1_IBGE,( _cAlVCK )->VAM_ESTADO,( _cAlVCK )->A1_EST)
			Cabec1 := STR0014+" "+( _cAlVCK )->VC1_ORIGEM+ "    " +STR0015+" "+Dtoc(Stod(( _cAlVCK )->VC1_DATVIS)) + "    " + STR0006+" " + Dtoc(sTod(cDtImp)) //Cod.CEV # Data Abordagem
			Cabec2 := STR0007+" "+( _cAlVCK )->VC1_CODCLI+"-"+( _cAlVCK )->VC1_LOJA+" "+left(left(( _cAlVCK )->A1_NOME,25),25) + " - "+STR0008+" " + cFone + "  -  " + Alltrim(cCidade) ////Cliente ## Fone
			If MV_PAR06 <> 3
				cQuery := "SELECT VAO.R_E_C_N_O_ AS RECVAO FROM "+RetSqlName("VAO")+" VAO "
				If lVAQ_TIPOSI
					cQuery += "JOIN "+RetSqlName("VAQ")+" VAQ ON ( VAQ.VAQ_FILIAL='"+xFilial("VAQ")+"' AND VAQ.VAQ_TIPREC=VAO.VAO_TIPREC AND VAQ.VAQ_TIPOSI<>'1' AND VAQ.D_E_L_E_T_=' ' ) "
				EndIf
				cQuery += "WHERE VAO.VAO_FILIAL='"+xFilial("VAO")+"' AND VAO.VAO_CODCLI='"+( _cAlVCK )->VC1_CODCLI+"' AND VAO.VAO_LOJCLI='"+( _cAlVCK )->VC1_LOJA+"' AND VAO.D_E_L_E_T_=' '"
				If MV_PAR06 == 2 .and. lVAO_ORIGEM
					cQuery += " AND VAO.VAO_FILORI='"+( _cAlVCK )->VC1_FILIAL+"' AND VAO.VAO_ORIGEM='"+( _cAlVCK )->VCK_ORIGEM+"'"
				EndIf				
				If FM_SQL(cQuery) > 0
					Cabec1 += "    *** "+STR0026+" ***" // Cliente com RAIC
				EndIf
			EndIf
			aadd(aPesquisa,{( _cAlVCK )->VCJ_PERGUN,cResp,( _cAlVCK )->VCK_OBSERV,( _cAlVCK )->VCJ_HABOBS,cOpcoes,( _cAlVCK )->VCJ_CODPER,cDtImp,( _cAlVCK )->VC1_ORIGEM, Cabec1, Cabec2})
			( _cAlVCK )->(DbSkip())
		EndDo
		( _cAlVCK )->(DbCloseArea())
	Endif
Next

If Len(aPesquisa) == 0
	MsgStop(STR0016)//Nao ha dados a serem impressos!
	Return
Endif

cOrigem := ""

For _i_ := 1 to Len(aPesquisa)
	If li > 55 .or. cOrigem <> aPesquisa[_i_,8]
		If cOrigem <> aPesquisa[_i_,8]
			nPerg   := 1
			cOrigem := aPesquisa[_i_,08]
		EndIf
		Cabec1 := aPesquisa[_i_,09]
		Cabec2 := aPesquisa[_i_,10]
		li := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo) + 1
	Endif
	@ li++,00 PSAY StrZero(nPerg,3)+") "+aPesquisa[_i_,1]
	If !Empty(aPesquisa[_i_,2])
		@ li++,00 PSAY Subs(aPesquisa[_i_,2],3)
	EndIf
	If !Empty(aPesquisa[_i_,3])
		@ li++,00 PSAY aPesquisa[_i_,3]
	EndIf
	nPerg++
	li++
Next

ms_flush()

Set Printer to
set Device  to Screen

If aReturn[5] == 1
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
Endif

return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao    ³ VALIDPERG ³ Autor ³ Manoel Filho        ³ Data ³ 26/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao ³ ValidPerg SX1 (Pergunte)                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValidPerg()
Local _sAlias := Alias()
Local aRegs := {}
Local ni,nj
Local aEstrSX1 := { "X1_GRUPO","X1_ORDEM","X1_PERGUNT","X1_PERSPA","X1_PERENG","X1_VARIAVL","X1_TIPO","X1_TAMANHO","X1_DECIMAL","X1_PRESEL","X1_GSC","X1_VALID","X1_VAR01","X1_DEF01","X1_DEFSPA1","X1_DEFENG1","X1_CNT01","X1_VAR02","X1_DEF02","X1_DEFSPA2","X1_DEFENG2","X1_CNT02","X1_VAR03","X1_DEF03","X1_DEFSPA3","X1_DEFENG3","X1_CNT03","X1_VAR04","X1_DEF04","X1_DEFSPA4","X1_DEFENG4","X1_CNT04","X1_VAR05","X1_DEF05","X1_DEFSPA5","X1_DEFENG5","X1_CNT05","X1_F3","X1_PYME","X1_GRPSXG","X1_HELP","X1_PICTURE","X1_IDFIL" }
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,LEN(SX1->X1_GRUPO))
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
Aadd(aRegs,{cPerg,"01",STR0019,"","","MV_CH1","C", 3,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","PS","N","","","",""})
aAdd(aRegs,{cPerg,"02",STR0020,"","","MV_CH2","N", 1,0,0,"C","","MV_PAR02",STR0021,"","","","",STR0022,"","","","",STR0023,"","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03",STR0021,"","","MV_CH3","C",10,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04",STR0024,"","","MV_CH4","D", 8,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05",STR0025,"","","MV_CH5","D", 8,0,0,"G","(MV_PAR04<=MV_PAR05)","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06",STR0028,"","","MV_CH6","N", 1,0,1,"C","","MV_PAR06",STR0029,"","","","",STR0030,"","","","",STR0031,"","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"07",STR0032,"","","MV_CH7","C", 2,0,0,"G","","MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
dbSelectArea("SX1")
DbSetOrder(1)
For ni:= 1 To Len(aRegs)
	If !DbSeek(aRegs[ni,1]+aRegs[ni,2])
		RecLock("SX1",.t.)
		For nj:=1 To Len(aRegs[ni])
			If ( FieldPos(aEstrSX1[nj])>0 .and. aRegs[ni,nj] # NIL )
				FieldPut(FieldPos(aEstrSX1[nj]),aRegs[ni,nj])
			EndIf
		Next nj
		dbCommit()
		MsUnLock()
	Endif
Next ni
dbSelectArea(_sAlias)
Return