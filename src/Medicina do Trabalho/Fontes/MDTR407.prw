/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR407.ch"
#Include "Protheus.ch"

//------------------------------------------------------------------------------
/*/{Protheus.doc} MDTR407
Impressao da Receita Medica

@param cNUMFIC, Caracter, Numero da Ficha médica
@param dDTCONS, Data, Data da Consulta
@param hHRCONS, Caracter, Hora da consulta
@param cCODUSA, Caracter, Codigo do Usuário

@author Inacio Luiz Kolling
@since 26/04/2000

@return NIL, Sempre nulo
/*/
//------------------------------------------------------------------------------
User Function MDTR407(cNUMFIC,dDTCONS,hHRCONS,cCODUSA)

	//Armazena variaveis p/ devolucao (NGRIGHTCLICK)

	Local aNGBEGINPRM := NGBEGINPRM( )

	//Define Variaveis
	Local wnrel   := "MDTR407"
	Local cDesc1  := " "
	Local cDesc2  := " "
	Local cDesc3  := " "
	Local cString := "TM2"
	Local limite  := 80

	Local oRadOp,oDLGppra
	Local nModeloImp := 2
	Local lPE4071  := .F.
	Local lRet := .T.

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

	Private nomeprog := "MDTR407"
	Private tamanho  := "P"
	Private aReturn  := { STR0001, 1,STR0002, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
	Private titulo   := STR0003 //"Receita medica"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cabec1, cabec2
	Private cPerg    :="MDT407    "
	Private ccNUMFIC := cNUMFIC
	Private ddDTCONS := dDTCONS
	Private hhHRCONS := hHRCONS
	Private ccCODUSA := cCODUSA
	Private aMedic := {}
	Private cAliasZ := "SI3"
	Private cDescrZ := "SI3->I3_DESC"

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAliasZ := "CTT"
		cDescrZ := "CTT->CTT_DESC01"
	Endif

	If !MDTRESTRI("MDTR407")
		//Devolve variaveis armazenadas (NGRIGHTCLICK)admimn
		NGRETURNPRM(aNGBEGINPRM)
		lRet := .F.
	ElseIf IsInCallStack('MDTA155') .And. Empty(M->TMT_NUMFIC)
		lRet := .F.
		ShowHelpDLG( STR0032 , ;//"ATENÇÃO"
				{ STR0036 } , 1 , ;//"Não é possível gerar o relatorio de receita médica para um funcionário que não possui ficha médica."
				{ STR0037 } , 2 )//"Incluir uma ficha médica para o funcionário."
	EndIf

	If lRet

		If ExistBlock("MDTR4071")

			DEFINE MSDIALOG oDLGppra FROM  0,0 TO 150,320 TITLE STR0008 PIXEL //"Selecione o tipo de impressão da receita médica"
			@ 10,10 TO 55,150 LABEL STR0009 of oDLGppra Pixel //"Tipo de Impressão"
			@ 20,14 RADIO oRadOp VAR nModeloImp ITEMS STR0010,STR0011 SIZE 70,15 PIXEL OF oDLGppra //"Via Tela"###"Via Impressora"

			DEFINE SBUTTON FROM 59,90  TYPE 1 ENABLE OF oDLGppra ACTION EVAL({|| lPE4071 := .T.,oDLGppra:END()})
			DEFINE SBUTTON FROM 59,120 TYPE 2 ENABLE OF oDLGppra ACTION oDLGppra:END()

			ACTIVATE MSDIALOG oDLGppra CENTERED

			If lPE4071
				ExecBlock( "MDTR4071", .F., .F., { nModeloImp } )
			Endif
			//Devolve variaveis armazenadas (NGRIGHTCLICK)
			NGRETURNPRM(aNGBEGINPRM)
			Return

		Endif

		/*-------------------------------
		| PERGUNTAS PADRÃO				|
		|  01  Imprimir Cabecalho ?		|
		|  02  Modelo Impressao ?		|
		|  03  Numero de vias?			|
		--------------------------------*/
		pergunte(cPerg,.F.)

		wnrel:="MDTR407"
		//wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")
		WnRel := SetPrint(cString,WnRel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.,'P')

		If nLastKey == 27
			Set Filter to
			//Devolve variaveis armazenadas (NGRIGHTCLICK)
			NGRETURNPRM(aNGBEGINPRM)
			Return
		Endif

		SetDefault(aReturn,cString)

		If nLastKey == 27
			Set Filter to
			Return
		Endif

		If mv_par02 == 1 // modelo de impressão padrao
			RptStatus({|lEnd| R407Imp1(@lEnd,wnRel,titulo,tamanho)},titulo)
		Else // modelo de impressão grafico
			RptStatus({|lEnd| R407Imp2(@lEnd,wnRel,titulo,tamanho)},titulo)
		EndIf

		//Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM(aNGBEGINPRM)

	EndIf

Return NIL

//------------------------------------------------------------------------------
/*/{Protheus.doc} R407Imp1
Impressão do Relatório modelo Padrão

@param lEnd, lógico, fim da impressão
@param wnRel
@param titulo, Caracter, título do relatório
@param tamanho, Caracter, tamanho do relatório

@author Inacio Luiz Kolling
@since 26/04/2000

@return NIL, Sempre nulo
/*/
//------------------------------------------------------------------------------
Static Function R407Imp1(lEnd,wnRel,titulo,tamanho)

	//Define Variaveis
	Local xx,nind
	//Variaveis para controle do cursor de progressao do relatorio
	Local lPrint := .F.
	Local lContinua := .T.
	Local nCntImpr := 0
	Local cRodaTxt := ""
	Local nVia := 0
	Local cNameFunc :=""
	Local nLinhasMemo :=0
	Local LinhaCorrente :=0
	Local cText:=""

	//Contadores de linha e pagina
	Private li := 80 ,m_pag := 1

	//Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	//Monta os Cabecalhos
	cabec1 := " "
	cabec2 := " "

	/*
				1         2         3         4         5         6         7
	01234567890123456789012345678901234567890123456789012345678901234567890123456789
	Empresa                                                               Pag.: 999
	Endereco
	Telefone
	--------------------------------------------------------------------------------
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx    CRM.: xxxxxxxxxxxx

		Cliente
		xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

	Medicamentos                             Quantidade Unid
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  99.999.999,99 xxxxxx
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  99.999.999,99 xxxxxx
	xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	*/

	For nVia := 1 To MV_PAR03
		dbSelectArea("TM2")
		dbSetOrder(1)

		If DbSeek(xFilial("TM2")+ccNUMFIC+DTOS(ddDTCONS)+hhHRCONS)

			DbSelectArea("TM0")
			DbSetOrder(1)
			if DbSeek(xFilial("TM0")+ccNUMFIC)

				lCandidato := .F.
				lPrint := .t.

				DbSelectArea("SRA")
				DbSetOrder(1)
				If DbSeek(xFilial("SRA",TM0->TM0_FILFUN)+TM0->TM0_MAT)

					cC_CustoZ := SRA->RA_CC
					If Empty(cC_CustoZ)
						cC_CustoZ := TM0->TM0_CC
					Endif
					DbSelectArea(cAliasZ)
					DbSetOrder(1)
					DbSeek(xFilial(cAliasZ,TM0->TM0_FILFUN)+cC_CustoZ)
					DbSelectArea("TMK")
					DbSetOrder(1)
					If !DbSeek(xFilial("TMK",TM0->TM0_FILFUN)+ccCODUSA)
						DbSeek(xFilial("TMK")+ccCODUSA)
					Endif
					If !Empty(SRA->RA_NOMECMP)
						cNameFunc:=SRA->RA_NOMECMP
					ELse
						cNameFunc:=TM0->TM0_NOMFIC
					Endif
					Somalinha(nVia)
					Somalinha(nVia)
					@Li,000 PSAY STR0012 //"Funcionário: "
					@Li,013 PSAY TM0->TM0_MAT+" - "+Alltrim(cNameFunc)
					Somalinha(nVia)
					@Li,000 PSAY STR0030 //Idade:
					@Li,007 PSAY R555ID(SRA->RA_NASC,dDataBase)
					@Li,015 PSAY STR0031 //Sexo:
					@Li,021 PSAY NGRETSX3BOX("RA_SEXO",SRA->RA_SEXO)
					Somalinha(nVia)
					@Li,000 PSAY STR0013 //"Centro de Custo: "
					@Li,017 PSAY Alltrim(cC_CustoZ)+" - "+Alltrim(&cDescrZ)
					If SRA->(FieldPos("RA_RAMAL"))>0
						Somalinha(nVia)
						@Li,000 PSAY STR0014 //"Ramal: "
						@Li,007 PSAY SRA->RA_RAMAL
					EndIf

				Else

					lCandidato := .T.
					cC_CustoZ := TM0->TM0_CC
					DbSelectArea(cAliasZ)
					DbSetOrder(1)
					DbSeek(xFilial(cAliasZ)+cC_CustoZ)
					DbSelectArea("TMK")
					DbSetOrder(1)
					DbSeek(xFilial("TMK")+ccCODUSA)

					Somalinha(nVia)
					Somalinha(nVia)
					@Li,000 PSAY AllTrim(NGRETTITULO("TM0_CANDID"))+":"
					@Li,013 PSAY TM0->TM0_CANDID+" - "+Alltrim(TM0->TM0_NOMFIC)
					Somalinha(nVia)
					@Li,000 PSAY STR0013 //"Centro de Custo: "
					@Li,017 PSAY Alltrim(cC_CustoZ)+" - "+Alltrim(&cDescrZ)

				Endif

				Somalinha(nVia)

				DbSelectArea("TM2")
				dbSetOrder(01)
				dbSeek(xFilial('TM2')+ccNUMFIC+DTOS(ddDTCONS)+hhHRCONS)

				SetRegua(LastRec())

				While lContinua                         .AND.;
					!Eof()                            .AND.;
					TM2->TM2_FILIAL == xFIlial('TM2') .AND.;
					TM2->TM2_NUMFIC == ccNUMFIC       .AND.;
					TM2->TM2_DTCONS == ddDTCONS       .AND.;
					TM2->TM2_HRCONS == hhHRCONS

					IncRegua()

					If TM2->TM2_INDREC == "1"

					DbSelectArea("TM1")
					DbSetOrder(1)
					DbSeek(xFilial("TM1",If(lCandidato,nil,TM0->TM0_FILFUN)) + TM2->TM2_CODMED)

					cQtde := TransForm(TM2->TM2_QTUTIL,"@E 9,999,999.99")
					AADD(aMedic,{TM1->TM1_INDUSO,TM1->TM1_NOMEDI,TM2->TM2_DOSE,cQtde,TM2->TM2_UNIDAD,TM2->TM2_PSOLOG,TM2->TM2_FORFAR})

					Endif

					dbSelectArea("TM2")
					dbskip()

				Enddo

				Somalinha(nVia)
				Somalinha(nVia)

				lPrim := .t.
				FOR nInd := 1 TO LEN(aMedic)
					IF aMedic[nInd,1] == "1"
						If lPrim
							Somalinha(nVia)
							@ Li,000 PSay "- " + Capital(STR0016) //"USO INTERNO"
							Somalinha(nVia)
							lPrim := .f.
						EndIf
							Somalinha(nVia)
							cNomeTM1 := Alltrim(aMedic[nInd,2])+" ("+ Alltrim(Lower(aMedic[nInd,3]))+") "+ " (" + Alltrim(aMedic[nInd,4]) + " " + Alltrim(aMedic[nInd,5]) + ")"
							IF !Empty(aMedic[nInd,6])
								cNomeTM1 += "   ---->  " + Alltrim(aMedic[nInd,6])+" ("+Alltrim(aMedic[nInd,7])+")"
								If Len(cNomeTM1) > 70 //se as informações a serem impressas ultrapassar 90 caracter entra na condição
									nLinhasMemo := MLCOUNT(cNomeTM1,60)
										For LinhaCorrente := 1 to nLinhasMemo
										cText :=MemoLine(cNomeTM1,60,LinhaCorrente)
											If LinhaCorrente == 1
												@ Li,006 PSay Alltrim(SUBSTR(cText,1,60))
											ElseIf LinhaCorrente == 2
												Somalinha(nVia)
												@ Li,006 PSay "  "+Alltrim(SUBSTR(cText,1,60))
											Else
												Somalinha(nVia)
												@ Li,006 PSay "  "+Alltrim(SUBSTR(cText,1,60))
											Endif
										Next LinhaCorrente
								Else
									cNomeTM1 := Alltrim(aMedic[nInd,2])+" ("+ Alltrim(Lower(aMedic[nInd,3]))+") "+ " (" + Alltrim(aMedic[nInd,4]) + " " + Alltrim(aMedic[nInd,5]) + ")"
									cNomeTM1 += "   ---->  " + Alltrim(aMedic[nInd,6])+ " ("+Alltrim(aMedic[nInd,7])+")"
									@ Li,006 PSay Alltrim(cNomeTM1)
								Endif
								Somalinha(nVia)
							Endif
						Endif
				NEXT

				Somalinha(nVia)
				lPrim := .t.
				FOR nInd := 1 TO LEN(aMedic)
					IF aMedic[nInd,1] == "2"
						If lPrim
							Somalinha(nVia)
							@ Li,000 PSay "- " + Capital(STR0017) //"USO EXTERNO"
							Somalinha(nVia)
							lPrim := .f.
						EndIf
							Somalinha(nVia)
							cNomeTM1 := Alltrim(aMedic[nInd,2])+" ("+ Alltrim(Lower(aMedic[nInd,3]))+") "+ " (" + Alltrim(aMedic[nInd,4]) + " " + Alltrim(aMedic[nInd,5]) + ")"
							IF !Empty(aMedic[nInd,6])
								cNomeTM1 += "   ---->  " + Alltrim(aMedic[nInd,6])+" ("+Alltrim(aMedic[nInd,7])+")"
								If Len(cNomeTM1) > 70 //se as informações a serem impressas ultrapassar 90 caracter entra na condição
									nLinhasMemo := MLCOUNT(cNomeTM1,60)
										For LinhaCorrente := 1 to nLinhasMemo
										cText :=MemoLine(cNomeTM1,60,LinhaCorrente)
											If LinhaCorrente == 1
												@ Li,006 PSay Alltrim(SUBSTR(cText,1,60))
											ElseIf LinhaCorrente == 2
												Somalinha(nVia)
												@ Li,006 PSay "  "+Alltrim(SUBSTR(cText,1,60))
											Else
												Somalinha(nVia)
												@ Li,006 PSay "  "+Alltrim(SUBSTR(cText,1,60))
											Endif
										Next LinhaCorrente
								Else
									cNomeTM1 := Alltrim(aMedic[nInd,2])+" ("+ Alltrim(Lower(aMedic[nInd,3]))+") "+ " (" + Alltrim(aMedic[nInd,4]) + " " + Alltrim(aMedic[nInd,5]) + ")"
									cNomeTM1 += "   ---->  " + Alltrim(aMedic[nInd,6])+ " ("+Alltrim(aMedic[nInd,7])+")"
									@ Li,006 PSay Alltrim(cNomeTM1)
								Endif
								Somalinha(nVia)
							Endif
						Endif
				NEXT

				If Li > 50
					Li := 80
					Somalinha(nVia)
				Endif
				cCidadeRe := Alltrim(If(!lSigaMdtps,SM0->M0_CIDCOB,SA1->A1_MUN))
				If !Empty(cCidadeRe)
					cCidadeRe := Capital(cCidadeRe)+", "
				Endif
				cCidadeRe := cCidadeRe + StrZero(Day(dDataBase),2)+STR0022+MesExtenso(dDataBase)+STR0022+StrZero(Year(dDataBase),4)+"." //" de "###" de "
				@50,000 PSAY PadL(cCidadeRe,80)
				@51,000 PSAY PadL(STR0035,80) //"Válido por 10 dias."
				@52,000 PSAY Replicate("_",80)
		Else
			While lContinua                         .AND.;
					!Eof()                            .AND.;
					TM2->TM2_FILIAL == xFIlial('TM2') .AND.;
					TM2->TM2_NUMFIC == ccNUMFIC       .AND.;
					TM2->TM2_DTCONS == ddDTCONS       .AND.;
					TM2->TM2_HRCONS == hhHRCONS

					IncRegua()

					If TM2->TM2_INDREC == "1"

					DbSelectArea("TM1")
					DbSetOrder(1)
					DbSeek(xFilial("TM1",If(lCandidato,nil,TM0->TM0_FILFUN)) + TM2->TM2_CODMED)

					cQtde := TransForm(TM2->TM2_QTUTIL,"@E 9,999,999.99")
					AADD(aMedic,{TM1->TM1_INDUSO,TM1->TM1_NOMEDI,cQtde,TM2->TM2_UNIDAD,TM2->TM2_PSOLOG})

					Endif

					dbSelectArea("TM2")
					dbskip()

				Enddo

				Somalinha(nVia)
				Somalinha(nVia)

				lPrim := .t.
				FOR nInd := 1 TO LEN(aMedic)
					IF aMedic[nInd,1] == "1"
						If lPrim
							Somalinha(nVia)
							@ Li,000 PSay "- " + Capital(STR0016) //"USO INTERNO"
							Somalinha(nVia)
							lPrim := .f.
						EndIf
						Somalinha(nVia)
						cNomeTM1 := Alltrim(aMedic[nInd,2]) + " (" + Alltrim(aMedic[nInd,3]) + " " + Alltrim(aMedic[nInd,4]) + ")"
						If !Empty(aMedic[nInd,5])
							cNomeTM1 += " ----> " + Alltrim(aMedic[nInd,5])
						Endif
						@ Li,006 PSay SUBSTR(cNomeTM1,1,74)
						Somalinha(nVia)
					ENDIF
				NEXT

				Somalinha(nVia)
				lPrim := .t.
				FOR nInd := 1 TO LEN(aMedic)
					IF aMedic[nInd,1] == "2"
						If lPrim
							Somalinha(nVia)
							@ Li,000 PSay "- " + Capital(STR0017) //"USO EXTERNO"
							Somalinha(nVia)
							lPrim := .f.
						EndIf
						Somalinha(nVia)
						cNomeTM1 := Alltrim(aMedic[nInd,2]) + " (" + Alltrim(aMedic[nInd,3]) + " " + Alltrim(aMedic[nInd,4]) + ")"
						If !Empty(aMedic[nInd,5])
							cNomeTM1 += " ----> " + Alltrim(aMedic[nInd,5])
						Endif
						@ Li,006 PSay SUBSTR(cNomeTM1,1,74)
						Somalinha(nVia)
					ENDIF
				NEXT

				If Li > 50
					Li := 80
					Somalinha(nVia)
				Endif
				cCidadeRe := Alltrim(If(!lSigaMdtps,SM0->M0_CIDCOB,SA1->A1_MUN))
				If !Empty(cCidadeRe)
					cCidadeRe := Capital(cCidadeRe)+", "
				Endif
				cCidadeRe := cCidadeRe + StrZero(Day(dDataBase),2)+STR0022+MesExtenso(dDataBase)+STR0022+StrZero(Year(dDataBase),4)+"." //" de "###" de "
				@50,000 PSAY PadL(cCidadeRe,80)
				@51,000 PSAY PadL(STR0035,80) //"Válido por 10 dias."
				@52,000 PSAY Replicate("_",80)
		Endif
				cEnd_Emp := ""
				cCid_Emp := ""
				cTel_Emp := ""
				If lSigaMdtps
					cEnd_Emp := Capital(ALLTRIM(SA1->A1_END))
					If !Empty(SA1->A1_BAIRRO)
						cEnd_Emp += " - " + Capital(ALLTRIM(SA1->A1_BAIRRO))
					Endif
					If !Empty(SA1->A1_CEP)
						cEnd_Emp += " - " + STR0023 + ALLTRIM(SA1->A1_CEP) //"CEP: "
					Endif
					If !Empty(SA1->A1_MUN)
						cCid_Emp := Capital(ALLTRIM(SA1->A1_MUN))+" - "+ ALLTRIM(SA1->A1_EST)
					Endif
					If !Empty(SA1->A1_TEL)
						cTel_Emp := STR0005+ALLTRIM(SA1->A1_TEL) //"Telefone: "
					Endif
				Else
					cEnd_Emp := Capital(ALLTRIM(SM0->M0_ENDCOB))
					If !Empty(SM0->M0_BAIRCOB)
						cEnd_Emp += " - " + Capital(ALLTRIM(SM0->M0_BAIRCOB))
					Endif
					If !Empty(SM0->M0_CEPCOB)
						cEnd_Emp += " - " + STR0023 + ALLTRIM(SM0->M0_CEPCOB) //"CEP: "
					Endif
					If !Empty(SM0->M0_CIDCOB)
						cCid_Emp := Capital(ALLTRIM(SM0->M0_CIDCOB))+" - "+ ALLTRIM(SM0->M0_ESTCOB)
					Endif
					If !Empty(SM0->M0_TEL)
						cTel_Emp := STR0005+ALLTRIM(SM0->M0_TEL) //"Telefone: "
					Endif
				Endif
				@53,000 PSAY PadC(cEnd_Emp,80)
				@54,000 PSAY PadC(cCid_Emp,80)
				@55,000 PSAY PadC(cTel_Emp,80)

			Endif
		li := 80
		aMedic := {}
	Next
	If MV_PAR01 == 1 .and. .F.
		Roda(nCntImpr,cRodaTxt,Tamanho)
	Endif

	//Devolve a condicao original do arquivo principal
	RetIndex("TM2")
	Set Filter To

	If !lPrint
		MsgInfo(STR0007)  //"Não há nada para imprimir no relatório."
		dbCommitAll()
		MS_FLUSH()
		Return .F.
	Endif

	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	Endif
	MS_FLUSH()

	dbSelectArea("TM2")
	dbSetOrder(1)

Return NIL

//------------------------------------------------------------------------------
/*/{Protheus.doc} R407Imp2
Impressão do Relatório modelo gráfico

@param lEnd, lógico, fim da impressão
@param wnRel
@param titulo, Caracter, título do relatório
@param tamanho, Caracter, tamanho do relatório

@author Liber De Esteban
@since 01/04/2005

@return NIL, Sempre nulo
/*/
//------------------------------------------------------------------------------
Static Function R407Imp2(lEnd,wnRel,titulo,tamanho)

	Local nind
	Local lPrint := .f.
	Local cBarraSrv := "\"
	Local cSMCOD := FWGrpCompany()
	Local cSMFIL := FWCodFil()
	Local nVia := 0
	Local cNameFunc:= ""
	Local cTemp :=""
	Local nLinhasMemo
	Local LinhaCorrente
	Local cText :=""
	Local lFunc := .T.

	Private aTM1Combo := MDTCbox("TM1_INDUSO"," ",1)
	Private oPrint := TMSPrinter():New( OemToAnsi(STR0003) )//"Receita medica"
	Private oFont12,oFont13,oFont14,oFont15,oFont13S,oFont14N
	Private cRootPath := GetPvProfString(GetEnvServer(),"RootPath","",GetADV97())
	Private cPathSiga := GetPvProfString( GetEnvServer(), "StartPath", "ERROR", GetADV97() )

	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
	Endif

	If aReturn[4] == 1
		oPrint:SetPortrait() //retrato
	Else
		oPrint:SetLandsCape() //paisagem
	Endif
	oPrint:Setup()

	cPathSiga += IF( RIGHT(cPathSiga,1) != cBarraSrv,cBarraSrv,"")
	cPathSiga := IF( Substr(cPathSiga,1,1) != cBarraSrv,cBarraSrv+cPathSiga,cPathSiga)
	cRootPath := IF( RIGHT(cRootPath,1) == cBarraSrv,SubStr(cRootPath,1,Len(cRootPath)-1), cRootPath)

	oFont12 := TFont():New("TAHOMA",12,12,,.F.,,,,.F.,.F.)
	oFont13	:= TFont():New("TAHOMA",13,13,,.F.,,,,.F.,.F.)
	oFont13S:= TFont():New("TAHOMA",13,13,,.F.,,,,.T.,.T.)
	oFont14	:= TFont():New("TAHOMA",14,14,,.F.,,,,.F.,.F.)
	oFont14N:= TFont():New("TAHOMA",14,14,,.F.,,,,.F.,.F.)
	oFont15	:= TFont():New("TAHOMA",15,15,,.T.,,,,.T.,.F.)

	lin := 150

	dbSelectArea("TM2")
	dbSetOrder(1)
	If DbSeek(xFilial("TM2")+ccNUMFIC+DTOS(ddDTCONS)+hhHRCONS)

	DbSelectArea("TM0")
	DbSetOrder(1)
	if DbSeek(xFilial("TM0")+ccNUMFIC)

			For nVia := 1 To MV_PAR03

				oPrint:StartPage()
			lCandidato := .F.
			DbSelectArea("SRA")
			DbSetOrder(1)
			If DbSeek(xFilial("SRA",TM0->TM0_FILFUN)+TM0->TM0_MAT)
				cC_CustoZ := SRA->RA_CC
				If Empty(cC_CustoZ)
					cC_CustoZ := TM0->TM0_CC
				Endif
				DbSelectArea(cAliasZ)
				DbSetOrder(1)
				DbSeek(xFilial(cAliasZ,TM0->TM0_FILFUN)+cC_CustoZ)
			Else
				cC_CustoZ := TM0->TM0_CC
				lCandidato := .T.
				DbSelectArea(cAliasZ)
				DbSetOrder(1)
				DbSeek(xFilial(cAliasZ)+cC_CustoZ)
			Endif

			If mv_par01 == 1
				DbSelectArea("TMK")
				DbSetOrder(1)
				If !DbSeek(xFilial("TMK",If(lCandidato,nil,TM0->TM0_FILFUN))+ccCODUSA)
						DbSeek(xFilial("TMK")+ccCODUSA)
				Endif

				oPrint:Line(lin,55,lin,2295)
				oPrint:Say(lin+5,900,STR0024,oFont15)  //"RECEITA MÉDICA"
				oPrint:Say(lin+5,2230,Str(nVia)+STR0029,oFont12,,,,1)
				lin+=60
				oPrint:Line(lin+10,55,lin+10,2295)
				cFileLogo := cRootPath+cPathSiga+"lgrl"+cSMCOD+cSMFIL+".bmp"
				If File(cFileLogo)
						oPrint:sayBitMap(lin+20,120,cFileLogo,560,200)
				Else
					cFileLogo := cRootPath+cPathSiga+"lgrl"+cSMCOD+".bmp"
					If File(cFileLogo)
							oPrint:sayBitMap(lin+20,120,cFileLogo,560,200)
					EndIf
				EndIf
				oPrint:Say(lin+15,2230,Transform(dDataBase,"99/99/99"),oFont12,,,,1)
				oPrint:Say(lin+60,2230,Substr(time(),1,5),oFont12,,,,1)

				oPrint:Say(lin+15,780,STR0025 + Capital(Alltrim(SubStr(TMK->TMK_NOMUSU,1,40))) ,oFont15) //"Dr(a). "
				oPrint:Say(lin+75,780,If(Empty(TMK->TMK_ENTCLA),STR0026,Alltrim(TMK->TMK_ENTCLA))+": " +; //"CRM"
										If(Empty(TMK->TMK_NUMENT),TMK->TMK_REGMTB,TMK->TMK_NUMENT),oFont12)
				nLinTmk := 130
					If !Empty(TMK->TMK_ENDUSU)
						oPrint:Say(lin+nLinTmk,780,STR0020 + TMK->TMK_ENDUSU,oFont12) //"Endereço: "
						nLinTmk := 185
					EndIf
					If !Empty(TMK->TMK_TELUSU)
						oPrint:Say(lin+nLinTmk,780,STR0005 + TMK->TMK_TELUSU,oFont12) //"Telefone: "
					EndIf
				Else
					oPrint:Say(lin+5,2230,Str(nVia)+STR0029,oFont12,,,,1)
				EndIf

				lin += 260
				oPrint:Line(lin,55,lin,2295)

				linaux := lin
				If !Empty(SRA->RA_NOMECMP)
					cNameFunc:=SRA->RA_NOMECMP
				ELse
					cNameFunc:=TM0->TM0_NOMFIC
				Endif
				lin+=60
				If lCandidato
					oPrint:Say(lin,100,AllTrim(NGRETTITULO("TM0_CANDID"))+": " + Alltrim(TM0->TM0_CANDID)+" - "+Alltrim(TM0->TM0_NOMFIC),oFont12)
				Else
					oPrint:Say(lin,100,STR0012 + Alltrim(TM0->TM0_MAT)+" - "+Alltrim(cNameFunc),oFont12) //"Funcionário: "
					lin+=80
					oPrint:Say(lin,100,STR0030 +Alltrim(R555ID(SRA->RA_NASC,dDataBase)),oFont12) //"Idade:"
					oPrint:Say(lin,500,STR0031 + NGRETSX3BOX("RA_SEXO",SRA->RA_SEXO) ,oFont12) //"Sexo:"
				Endif
				oPrint:Say(lin+80,100,STR0013 + Alltrim(cC_CustoZ)+" - "+Alltrim(&cDescrZ),oFont12) //"Centro de Custo: "

				If !lCandidato .and. SRA->(FieldPos("RA_RAMAL"))>0
					oPrint:Say(lin+160,100,STR0014,oFont12) //"Ramal: "
					oPrint:Say(lin+160,350,SRA->RA_RAMAL,oFont13)
					lin+=80
				EndIf
				lin+=240

				DbSelectArea("TM2")
				dbSetOrder(01)
				dbSeek(xFilial('TM2')+ccNUMFIC+DTOS(ddDTCONS)+hhHRCONS)

				SetRegua(LastRec())
			If lFunc == .T.
				While !Eof()                            .AND.;
					TM2->TM2_FILIAL == xFIlial('TM2') .AND.;
					TM2->TM2_NUMFIC == ccNUMFIC       .AND.;
					TM2->TM2_DTCONS == ddDTCONS       .AND.;
					TM2->TM2_HRCONS == hhHRCONS

					IncRegua()


					If TM2->TM2_INDREC == "1"

						DbSelectArea("TM1")
						DbSetOrder(1)
						DbSeek(xFilial("TM1",If(lCandidato,nil,TM0->TM0_FILFUN)) + TM2->TM2_CODMED)

						cQtde := TransForm(TM2->TM2_QTUTIL,"@E 9,999,999.99")
						AADD(aMedic,{TM1->TM1_INDUSO,TM1->TM1_NOMEDI,TM2->TM2_DOSE,cQtde,TM2->TM2_UNIDAD,TM2->TM2_PSOLOG,TM2->TM2_FORFAR})

					Endif

					dbSelectArea("TM2")
					dbskip()

				Enddo

				//oPrint:Say(lin,100,STR0015,oFont14) //"MEDICAMENTOS:"
				//lin+=60

				lPrim := .t.
				FOR nInd := 1 TO LEN(aMedic)
					IF aMedic[nInd,1] == "1"
						If lPrim
							lin+=80
							oPrint:Say(lin,100,Capital(STR0016),oFont13S) //"USO INTERNO"
							lin+=80
							lPrim := .f.
						EndIf
						lin+=60
						cNomeTM1 := Alltrim(aMedic[nInd,2])+" ("+ Alltrim(Lower(aMedic[nInd,3]))+") "+ " (" + Alltrim(aMedic[nInd,4]) + " " + Alltrim(aMedic[nInd,5]) + ")"
						IF !Empty(aMedic[nInd,6])
							cNomeTM1 += "    ---->  " + Alltrim(aMedic[nInd,6])+" ("+Alltrim(aMedic[nInd,7])+")"
							If Len(cNomeTM1) > 90 //se as informações a serem impressas ultrapassar 90 caracter entra na condição
								nLinhasMemo := MLCOUNT(cNomeTM1,80)
									For LinhaCorrente := 1 to nLinhasMemo
									cText :=MemoLine(cNomeTM1,80,LinhaCorrente)
										If LinhaCorrente == 1
											oPrint:Say(lin,200,Alltrim(SubStr(cText,1,80)),oFont12)
										ElseIf LinhaCorrente == 2
											lin+=60
											oPrint:Say(lin,250,Alltrim(SubStr(cText,1,80)),oFont12)
										Else
											lin+=60
											oPrint:Say(lin,250,Alltrim(SubStr(cText,1,80)),oFont12)
										Endif
									Next LinhaCorrente
								Else
								cNomeTM1 := Alltrim(aMedic[nInd,2])+" ("+ Alltrim(Lower(aMedic[nInd,3]))+") "+ " (" + Alltrim(aMedic[nInd,4]) + " " + Alltrim(aMedic[nInd,5]) + ")"
								cNomeTM1 += "    ---->  " + Alltrim(aMedic[nInd,6])+ " ("+Alltrim(aMedic[nInd,7])+")"
								oPrint:Say(lin,200,Alltrim(cNomeTM1),oFont12)
							Endif
							lin+=70
						Endif
						If lin > 2500 .and. nInd <> LEN(aMedic)
							oPrint:Line(lin,55,lin,2295)
							oPrint:EndPage()
							oPrint:StartPage()
							lin:=200
							oPrint:Line(lin,55,lin,2295)
						Endif
					ENDIF
				NEXT

				lin+=80
				lPrim := .t.
				FOR nInd := 1 TO LEN(aMedic)
					IF aMedic[nInd,1] == "2"
						If lPrim
							lin+=80
							oPrint:Say(lin,100,Capital(STR0017),oFont13S) //"USO EXTERNO"
						lin+=80
							lPrim := .f.
						EndIf
						lin+=60
						cNomeTM1 := Alltrim(aMedic[nInd,2])+" ("+ Alltrim(Lower(aMedic[nInd,3]))+") "+ " (" + Alltrim(aMedic[nInd,4]) + " " + Alltrim(aMedic[nInd,5]) + ")"
						IF !Empty(aMedic[nInd,6])
							cNomeTM1 += "    ---->  " + Alltrim(aMedic[nInd,6])+" ("+Alltrim(aMedic[nInd,7])+")"
							If Len(cNomeTM1) > 90 //se as informações a serem impressas ultrapassar 90 caracter entra na condição
								nLinhasMemo := MLCOUNT(cNomeTM1,80)
									For LinhaCorrente := 1 to nLinhasMemo
									cText :=MemoLine(cNomeTM1,80,LinhaCorrente)
										If LinhaCorrente == 1
											oPrint:Say(lin,200,Alltrim(SubStr(cText,1,80)),oFont12)
										ElseIf LinhaCorrente == 2
											lin+=60
											oPrint:Say(lin,250,Alltrim(SubStr(cText,1,80)),oFont12)
										Else
											lin+=60
											oPrint:Say(lin,250,Alltrim(SubStr(cText,1,80)),oFont12)
										Endif
									Next LinhaCorrente
								Else
								cNomeTM1 := Alltrim(aMedic[nInd,2])+" ("+ Alltrim(Lower(aMedic[nInd,3]))+") "+ " (" + Alltrim(aMedic[nInd,4]) + " " + Alltrim(aMedic[nInd,5]) + ")"
								cNomeTM1 += "    ---->  " + Alltrim(aMedic[nInd,6])+ " ("+Alltrim(aMedic[nInd,7])+")"
								oPrint:Say(lin,200,Alltrim(cNomeTM1),oFont12)
							Endif
							lin+=70
						Endif
						If lin > 2500 .and. nInd <> LEN(aMedic)
							oPrint:Line(lin,55,lin,2295)
							oPrint:EndPage()
							oPrint:StartPage()
							lin:=200
							oPrint:Line(lin,55,lin,2295)
						Endif
					ENDIF
				NEXT

				cCidadeRe := Alltrim(If(!lSigaMdtps,SM0->M0_CIDCOB,SA1->A1_MUN))
				If !Empty(cCidadeRe)
					cCidadeRe := Capital(cCidadeRe)+", "
				Endif
				cCidadeRe := cCidadeRe + StrZero(Day(dDataBase),2)+STR0022+MesExtenso(dDataBase)+STR0022+StrZero(Year(dDataBase),4)+"." //" de "###" de "
				oPrint:Say(2600,2250,cCidadeRe,oFont12,,,,1)
				oPrint:Say(2700,2250,STR0035 ,oFont12,,,,1) //"Válido por 10 dias."
				oPrint:Line(2800,55,2800,2295)
			Endif
				cEnd_Emp := ""
				cCid_Emp := ""
				cTel_Emp := ""
				If lSigaMdtps
					cEnd_Emp := Capital(ALLTRIM(SA1->A1_END))
					If !Empty(SA1->A1_BAIRRO)
						cEnd_Emp += " - " + Capital(ALLTRIM(SA1->A1_BAIRRO))
					Endif
					If !Empty(SA1->A1_CEP)
						cEnd_Emp += " - " + STR0023 + ALLTRIM(SA1->A1_CEP) //"CEP: "
					Endif
					If !Empty(SA1->A1_MUN)
						cCid_Emp := Capital(ALLTRIM(SA1->A1_MUN))+" - "+ ALLTRIM(SA1->A1_EST)
					Endif
					If !Empty(SA1->A1_TEL)
						cTel_Emp := STR0005+ALLTRIM(SA1->A1_TEL) //"Telefone: "
					Endif
				Else
					cEnd_Emp := Capital(ALLTRIM(SM0->M0_ENDCOB))
					If !Empty(SM0->M0_BAIRCOB)
						cEnd_Emp += " - " + Capital(ALLTRIM(SM0->M0_BAIRCOB))
					Endif
					If !Empty(SM0->M0_CEPCOB)
						cEnd_Emp += " - " + STR0023 + ALLTRIM(SM0->M0_CEPCOB) //"CEP: "
					Endif
					If !Empty(SM0->M0_CIDCOB)
						cCid_Emp := Capital(ALLTRIM(SM0->M0_CIDCOB))+" - "+ ALLTRIM(SM0->M0_ESTCOB)
					Endif
					If !Empty(SM0->M0_TEL)
						cTel_Emp := STR0005+ALLTRIM(SM0->M0_TEL) //"Telefone: "
					Endif
				Endif

				oPrint:Say(2810,1150,cEnd_Emp,oFont12,,,,2)
				oPrint:Say(2865,1150,cCid_Emp,oFont12,,,,2)
				oPrint:Say(2920,1150,cTel_Emp,oFont12,,,,2)
				oPrint:EndPage()
				lPrint := .t.
				lin := 150
				aMedic := {}
			Next
		Endif
	Endif

	//Devolve a condicao original do arquivo principal
	RetIndex("TM2")
	Set Filter To

	If !lPrint
		MsgInfo(STR0007)  //"Não há nada para imprimir no relatório."
		Set Printer To
		dbCommitAll()
		MS_FLUSH()
		Return .F.
	Endif

	If aReturn[5] == 1
		oPrint:Preview()
	Else
		oPrint:Print()
	EndIf

	Set Printer To
	dbCommitAll()
	MS_FLUSH()

	dbSelectArea("TM2")
	dbSetOrder(1)

Return NIL

//------------------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha()
Incrementa Linha e Controla Salto de Pagina

@param nVia, nuérico, número da via

@author Inacio Luiz Kolling
@since 26/04/2000

@return Sem retorno
/*/
//------------------------------------------------------------------------------
Static Function Somalinha(nVia)

    Li++
    If Li > 58
       If MV_PAR01 == 1
          Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo,,.f.)
          If !Empty(nVia)
          	@Li,060 PSAY Str(nVia)+STR0029//"º Via"
          EndIf
          @li,000 PSAY STR0025 + Capital(Alltrim(SubStr(TMK->TMK_NOMUSU,1,40))) //"Dr(a). "
          Somalinha()
          @li,000 PSAY If(Empty(TMK->TMK_ENTCLA),STR0026,Alltrim(TMK->TMK_ENTCLA))+": "+If(Empty(TMK->TMK_NUMENT),TMK->TMK_REGMTB,TMK->TMK_NUMENT) //"CRM"
	   		If !Empty(TMK->TMK_ENDUSU)
				Somalinha()
			 	@li,000 PSAY STR0020 + TMK->TMK_ENDUSU //"Endereço: "
			EndIf
	   		If !Empty(TMK->TMK_TELUSU)
		   		Somalinha()
		   		@li,000 PSAY STR0005 + TMK->TMK_TELUSU //"Telefone: "
		 	EndIf
          Somalinha()
          @li,000 PSAY Replicate("-",80)
          Somalinha()
       Else
       	Li := 05
       	@Li,060 PSAY Str(nVia)+STR0029//"º Via"
       Endif
    EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR407SX1
Válida o parametro Número de Vias: "mv_ch3" não permitindo imprimir menos
de duas vias.

@author Guilherme Freudenburg
@since 23/09/2013
@return lRet, Lógico, Verdadeiro se o parâmetro for válido
/*/
//---------------------------------------------------------------------
User Function MDTR407SX1()

	Local lRet:= .T. //Variavel de retorno

	If !Empty(mv_par03)
		If mv_par03 < 2
			ShowHelpDlg(STR0032,{STR0033},1,{STR0034},2) //("ATENÇÃO",{"O Número de Vias não póde ser inferior a duas vias."},1,{"Favor, informe no minimo a impressão de duas vias."},2)
			lRet:=  .F.
		Endif
	Else
		ShowHelpDlg(STR0032,{STR0033},1,{STR0034},2)
		lRet:=  .F.
	Endif

Return lRet
