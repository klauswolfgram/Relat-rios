/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMSRD40.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE _CRLF Chr(13) + Chr(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ TMSRD40  ³ Autor ³Helio Novais de Jesus Jr³ Data ³13.Set.07³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao da Carta de Autorizacao de Veiculos              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TMSAD50                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMSXFUNC/ TMSAD50                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TMSRD40(cCodMot,cCodVeic,cFilBas,cAcv,lImprime)

Local titulo   := STR0001 // "Autorização para Conduzir Veiculo"
Local cString  := "DA4"
Local wnrel    := "TMSRD40"
Local cDesc1   := STR0002 //"Este programa ira listar a autorizacao para conduzir veiculos"
Local cDesc2   := ""
Local cDesc3   := ""
Local tamanho  := "P"
Local nLimite  := 80
Local lRet     := .F.
Local aCposProtg      := {}
Local aCpoAccess	  := {'DA4_CGC'}

Private NomeProg := "TMSRD40"
Private aReturn  := {STR0003,1,STR0004,2, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private nLastKey := 0
Private cPerg    := "TMRD40"
Default lImprime := !IsBlind() // Default para sempre imprimir
Default cCodMot  := ''
Default cCodVeic := ''
Default cFilBas  := ''
Default cAcv     := GetMv("MV_TMSADCV",," ")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        // Do Motorista                              ³
//³ mv_par02        // Ate o Motorista                           ³
//³ mv_par03        // Do Veiculo                                ³
//³ mv_par04        // Ate o Veiculo                             ³
//³ mv_par05        // Da Filial Base                            ³
//³ mv_par06        // Ate a Filial Base                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If ExistFunc('TMLGPDCpPr')
	aCposProtg := TMLGPDCpPr(aCpoAccess, "DA4")
	If ExistFunc('FWPDCanUse') .And. FWPDCanUse() .And. !Empty(aCposProtg)
		If Len(FwProtectedDataUtil():UsrAccessPDField( __CUSERID, aCposProtg )) < Len(aCposProtg)
			Help(" ",1,STR0032,,,5,11) //"LGPD - Acesso Restrito: Este usuário não possui permissão de acesso aos dados dessa rotina. Para mais informações contate o Administrador do sistema !!"
			Return
		EndIf	
	EndIf
EndIf

Pergunte(cPerg,.F.)

If Empty(cACV) // Nao foi passado o parametro no configurador
	Help('',1,"TMSRD4001") //--Favor Preencher o parametro MV_TMSADCV
	Return NIL
EndIf

If lImprime
	wnrel := SetPrint(cString,wnrel,IIF(Empty(cCodMot),cPerg,''),@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)
	If nLastKey = 27
		lRet := .F.
		Return lRet
	Endif
	
	SetDefault(aReturn,cString)
	
	If nLastKey = 27
		lRet := .F.
		Return lRet
	Endif
	
	RptStatus({|lEnd| IIF(TMSAD50IMP(@lEnd,wnRel,titulo,tamanho,nLimite,cCodMot,cCodVeic,cFilBas,cACV,lImprime),lRet:=.T.,lRet:=.F.)},titulo)
Else
	lRet := TMSAD50IMP(.F.,wnRel,titulo,tamanho,nLimite,cCodMot,cCodVeic,cFilBas,cACV,lImprime)
EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TMSAD50IMP³ Autor ³ Helio Novais          ³ Data ³03.09.2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime os Motoristas Selecionados                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TMSAD50IMP(lExp1, wExp2, cExp3)                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nil                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/
Static Function TMSAD50IMP(lEnd,wnrel,cString,Tamanho,nLimite,cCodMot,cCodVeic,cFilBas,cACV,lImprime)  

Local aArea     := GetArea()
Local nLin      := 60
Local aMes      := {}
Local cAliasQry := ''
Local cAliasDD4 := ''
Local cAliasVei := ''
Local cAliasArea:= ''
Local cAliasBlq := ''
Local cAliasSYP := ''
Local cQuery    := ''
Local cAliasLay := ''
Local n1Cnt     := 0
Local aCab      := {}
Local aItens    := {}
Local aVeic     := {}
Local aCorpo    := {}
Local aRodape   := {}
Local nCpos     := 0
Local bCampo    := { |nCpo| FieldName(nCpo) }
Local nFator    := 0 
Local lQtdVeic  := .F. // -- Verifica qtde de veiculos por motorista
Local i         := 0
Local a         := 0
Local dVencto   := CtoD('')
Local aDePara   :={}
Local lRet      := .F.
Local aAreaAnt  := {}
Local nM        := 0
Local cModo     := ""
Local cEndAcv   := GetMv("MV_TMSEACV",,"1") //1 Endereco Cobranca / Endereco Entrega
Local aSX5 		:= {}

Private m_pag   := 1
If lImprime
	//-- Vetor de Meses
	Aadd(aMes, STR0005) //-- Janeiro
	Aadd(aMes, STR0006) //-- Fevereiro
	Aadd(aMes, STR0007) //-- Marco
	Aadd(aMes, STR0008) //-- Abril
	Aadd(aMes, STR0009) //-- Maio
	Aadd(aMes, STR0010) //-- Junho
	Aadd(aMes, STR0011) //-- Julho
	Aadd(aMes, STR0012) //-- Agosto
	Aadd(aMes, STR0013) //-- Setembro
	Aadd(aMes, STR0014) //-- Outubro
	Aadd(aMes, STR0015) //-- Novembro
	Aadd(aMes, STR0016) //-- Dezembro
	
	Aadd(aDePara,{"<NOME_EMP>",PadR(SM0->M0_NOMECOM,49,' ')})
	Aadd(aDePara,{"<NOME_CID>" ,AllTrim(SM0->M0_FILIAL)})
	Aadd(aDePara,{"<NOME_EST>" ,AllTrim(Tabela("12",IIF(cEndAcv=="1",SM0->M0_ESTCOB,SM0->M0_ESTENT),.F.))})
	Aadd(aDePara,{"<NOME_END>" ,PadR(IIF(cEndAcv=="1",SM0->M0_ENDCOB,SM0->M0_ENDENT),50,'')})
	Aadd(aDePara,{"<NOME_BAIR>",PadR(IIF(cEndAcv=="1",SM0->M0_BAIRCOB,SM0->M0_BAIRENT),40,'')})
	Aadd(aDePara,{"<NUM_CNPJ>" ,TransForm(SM0->M0_CGC,PesqPict('DA4','DA4_CGC'))})
	Aadd(aDePara,{"<DIA_BASE>" ,Alltrim(Str(Day(dDataBase)))})
	Aadd(aDePara,{"<MES_BASE>" ,aMes[Month(dDataBase)]})
	Aadd(aDePara,{"<ANO_BASE>" ,Alltrim(Str(Year(dDataBase)))})

	//-- Pegando o Layout do Relatorio
	aSX5 := FwGetSX5("MN")
	For a := 1 to Len(aSX5) 
		If Substr(aSX5[a][3],1,1) = "C" // Corpo da Carta
			n1Cnt := Ascan(aCorpo,{ |x| x[1] == Substr(aSX5[a][3],2,2) })
			If n1Cnt == 0
				Aadd(aCorpo,{Substr(aSX5[a][3],2,2),Alltrim(aSX5[a][4])})
			Else
				aCorpo[n1Cnt][2]+=" "+Alltrim(aSX5[a][4])
			EndIf
		ElseIf Substr(aSX5[a][3],1,1) = "R" // Rodape
			n1Cnt := Ascan(aRodape,{ |x| x[1] == Substr(aSX5[a][3],2,2) })
			If n1Cnt == 0
				Aadd(aRodape,{Substr(aSX5[a][3],2,2),Alltrim(aSX5[a][4])})
			Else
				aRodape[n1Cnt][2]+=" "+Alltrim(aSX5[a][4])
			EndIf
		EndIf
	Next

	//Substituindo os Conteudos do layout pelos campos do vetor aDePara
	For a := 1 to Len(aDePara)
		For i := 1 to Len(aCorpo)
			If aDePara[a,1] $ aCorpo[i,2]
				aCorpo[i,2] := Alltrim(StrTran(aCorpo[i,2],aDePara[a,1],aDePara[a,2]))
			EndIf
		Next
	Next
	For a := 1 to Len(aDePara)
		For i := 1 to Len(aRodape)
			If aDePara[a,1] $ aRodape[i,2]
				aRodape[i,2] := Alltrim(StrTran(aRodape[i,2],aDePara[a,1],aDePara[a,2]))
			EndIf
		Next
	Next
EndIf

If (Empty(cCodVeic) .And. Empty(cCodMot)) // Utilizou o Relatorio direto - re-grava os parametros
	aAreaAnt:=GetArea()
	If (Empty(mv_par01) .And. Empty(mv_par02)) // Motorista 
		SetMVValue("TMRD40","MV_PAR01",Space(TamSX3("DA4_COD")[1]))  // Motorista De
		SetMVValue("TMRD40","MV_PAR02",Replicate("Z",TamSX3("DA4_COD")[1])) // Motorista Ate
	EndIf
	
	If	(Empty(mv_par03) .And. Empty(mv_par04)) // Placa do Veiculo
		SetMVValue("TMRD40","MV_PAR03",Space(TamSX3("DA3_PLACA")[1])) //Placa De
		SetMVValue("TMRD40","MV_PAR04",Replicate("Z",TamSX3("DA3_PLACA")[1])) //Placa Ate
	EndIf

	If	(Empty(mv_par05) .And. Empty(mv_par06)) // Filial Base
		SetMVValue("TMRD40","MV_PAR05",Space(TamSX3("DA3_FILATU")[1])) //Filial Base De
		SetMVValue("TMRD40","MV_PAR06",Replicate("Z",TamSX3("DA3_FILATU")[1])) //Filial Base Ate
	EndIf
EndIf

cModo := FWModeAccess ("DD2",3)

cAliasQRY := GetNextAlias()
cQuery    := "SELECT DISTINCT DA4.DA4_COD,DA4.DA4_NOME,DA4.DA4_CGC,DA4.DA4_NUMCNH,DA4.DA4_FILBAS "
If !Empty(cCodVeic) // -- Parametro pela tela de viagens 
	cQuery += " FROM "+RetSqlName("DA4")+ " DA4, "+RetSqlName("DA3")+ " DA3 "
Else
	cQuery += " FROM "+IIF(!Empty(mv_par04),RetSqlName("DA4")+ " DA4, "+RetSqlName("DA3")+ " DA3 ",RetSqlName("DA4")+ " DA4 ")
EndIf
cQuery += " WHERE DA4.DA4_FILIAL = '"+xFilial('DA4')+"'"
cQuery += "   AND DA4.DA4_TIPMOT = '1' " // Somente motoristas Proprios
If !Empty(cFilBas)
	cQuery += " AND DA4.DA4_FILBAS = '"+cFilBas+"' "
Else
	If !Empty(mv_par06) // -- Filbase
		cQuery += " AND DA4.DA4_FILBAS BETWEEN '"+mv_par05+"' AND '"+mv_par06+"' "
	Endif
Endif

If !Empty(cCodMot)
	cQuery += " AND DA4.DA4_COD = '"+cCodMot+"' "
Else
	If !Empty(mv_par02) // -- Motoristas Ate
		cQuery += " AND DA4.DA4_COD BETWEEN '"+mv_par01+"' AND '"+mv_par02+"' "
	ElseIf !Empty(mv_par04)
		cQuery += "AND DA4.DA4_COD = DA3.DA3_COD "
	Endif
Endif
cQuery += "AND DA4.D_E_L_E_T_ = ' ' "

If !Empty(cCodVeic) // -- Nao pode tirar do if tem comparacao na query
	cQuery += "AND DA3.DA3_FILIAL = DA4.DA4_FILIAL "
	cQuery += "AND DA3.DA3_FILBAS = DA4.DA4_FILBAS " 
	cQuery += "AND DA3.DA3_ATIVO  = '1' "
	cQuery += "AND DA3.DA3_COD    = '"+cCodVeic+"' "
	cQuery += "AND DA3.D_E_L_E_T_ = ' ' "
Else
	If !Empty(mv_par04) // -- Veiculos Ate
		cQuery += "AND DA3.DA3_FILIAL = DA4.DA4_FILIAL "
		cQuery += "AND DA3.DA3_FILBAS = DA4.DA4_FILBAS "
		cQuery += "AND DA3.DA3_FROVEI = '1' " // Somente Veiculos Proprios
		cQuery += "AND DA3.DA3_ATIVO  = '1' "
		cQuery += "AND DA3.DA3_COD BETWEEN '"+mv_par03+"' AND '"+mv_par04+"' "
		cQuery += "AND DA3.D_E_L_E_T_ = ' ' "
	EndIf
Endif
cQuery += "ORDER BY DA4.DA4_FILBAS, DA4.DA4_COD"
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQRY) 

If lImprime
	(cAliasQRY)->(DbGotop())
	While (cAliasQRY)->(!Eof()) // Qtos Motoristas tem na rotina
		nM++
		(cAliasQRY)->(DbSkip())
	EndDo
	(cAliasQRY)->( SetRegua( nM ))
EndIf	

//-- Todos os Veiculos da Filial
cAliasVei := GetNextAlias()
cQuery := "SELECT DA3.DA3_DESC,DA3.DA3_ANOFAB,DA3.DA3_PLACA,DA3.DA3_FILBAS "
cQuery += "FROM "+RetSqlName("DA3")+ " DA3 "
If !Empty(cFilBas)
	cQuery += "WHERE DA3.DA3_FILBAS = '"+cFilBas+"' "
Else
	cQuery += "WHERE DA3.DA3_FILBAS BETWEEN '"+mv_par05+"' AND '"+mv_par06+"' "
Endif
cQuery += "  AND DA3.DA3_FROVEI = '1' " // -- Veiculos Proprios
cQuery += "  AND DA3.DA3_ATIVO  = '1' "
cQuery += "  AND DA3.D_E_L_E_T_  = ' '"
cQuery += "ORDER BY DA3.DA3_FILBAS,DA3.DA3_PLACA"
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasVei)

(cAliasVei)->(DbGoTop())
While (cAliasVei)->(!Eof())
	Aadd(aVeic,{	(cAliasVei)->DA3_FILBAS,;
					PadR((cAliasVei)->DA3_DESC,  TamSx3('DA3_DESC')[1])  +Space(10)+;
					PadR((cAliasVei)->DA3_ANOFAB,TamSx3('DA3_ANOFAB')[1])+Space(20)+;
					PadR((cAliasVei)->DA3_PLACA, TamSx3('DA3_PLACA')[1]) +_CRLF})
	(cAliasVei)->(DbSkip())
EndDo

lMsErroAuto := .F. //-- Nao Retirar

// -- Utilizado para Gravacao do vencimento para casos de documentos novos
Posicione("DD0",1,xFilial("DD0")+cAcv,"DD0_TIPPER") // -- Periodo da Apuracao do documento
If DD0->DD0_TIPPER == '1' //-- Diario
	nFator := 1
ElseIf DD0->DD0_TIPPER == '2' //-- Mensal
	nFator := 30
ElseIf DD0->DD0_TIPPER == '3' //-- Anual
	nFator := 365
EndIf
dVencto:= (dDataBase + (DD0->DD0_PERAPR * nFator))

Begin Transaction     
	(cAliasQry)->(DbGoTop())  
	While (cAliasQRY)->(!Eof()) 
		aCab  :={}
		aItens:={}

		lQtdVeic := .T. // -- Verificar veiculos da filial x motorista
		If lImprime   
			Aadd(aCab,		{"DD2_FILIAL",IIf(cModo=="C",Space(TamSX3('DA4_FILBAS')[1]),(cAliasQRY)->DA4_FILBAS),NIL})
			Aadd(aCab,		{"DD2_CODMOT",(cAliasQRY)->DA4_COD        ,NIL})
			Aadd(aCab,		{"DD2_NUMLIB",1                            ,NIL})
			Aadd(aCab,		{"DD2_CTRLIB","2"                          ,NIL})
			Aadd(aItens,{	{"DD4_ITEM", StrZero(1,Len(DD4->DD4_ITEM)),NIL},;
							{"DD4_CODDOC",cACV                         ,NIL}})
		EndIf

		DD2->(DbSetOrder(1))
		If DD2->(!MsSeek(IIf(cModo=="C",Space(TamSX3('DA4_FILBAS')[1]),(cAliasQRY)->DA4_FILBAS)+(cAliasQRY)->DA4_COD)) // -- motorista nao possui o tipo de documento vinculado                     
			If lImprime
				cAglVei:=''
				For i:=1 to Len(aVeic) // -- Pegando os veiculos da filial
					If Alltrim(aVeic[i,1]) == Alltrim((cAliasQry)->DA4_FILBAS) //aqui sempre compara filbase
						cAglVei += aVeic[i,2]
					Endif
				Next i
				Aadd(aItens[1],{"DD4_OBS",cAglVei,NIL})
				Processa({|lEnd| MSExecAuto({|a,b,c| TMSAD30(a,b,c)},aCab,aItens,3)},'Aguarde, Adicionando Documentos') //  -- Grava no DD2 e DD4 automaticamente
				lQtdVeic:=.F. // -- Nao verifique os veiculos acabei de incluir
			Else
				lRet := .T.
			Endif
		Else
			DD4->(DbsetOrder(2))
			If DD4->(!MsSeek(IIf(cModo=="C",Space(TamSX3('DA4_FILBAS')[1]),(cAliasQRY)->DA4_FILBAS)+(cAliasQRY)->DA4_COD+cACV)) // Tem motorista mas nao possue o documento acv
				If lImprime
					cAliasDD4 := GetNextAlias()
					cQuery := "SELECT MAX(DD4.DD4_ITEM) QTDE FROM "+RetSqlName("DD4")+ " DD4 "
					cQuery += "WHERE DD4.DD4_FILIAL = '"+IIf(cModo=="C",Space(TamSX3('DA4_FILBAS')[1]),(cAliasQRY)->DA4_FILBAS)+"' "
					cQuery += "AND   DD4.DD4_CODMOT = '"+(cAliasQRY)->DA4_COD+"' "
					cQuery += "AND   DD4.D_E_L_E_T_ = ' '"
					cQuery    := ChangeQuery(cQuery)
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasDD4)
					If (cAliasDD4)->(!Eof())
						n1Cnt := Val((cAliasDD4)->QTDE) + 1
					EndIf
					(cAliasDD4)->(DbCloseArea())

					aItens[1,1,2] := Strzero(n1Cnt,2)
					cAglVei:=''
					For i:=1 to Len(aVeic) // -- Pegando os veiculos da filial
						If Alltrim(aVeic[i,1]) == Alltrim((cAliasQry)->DA4_FILBAS)
							cAglVei += aVeic[i,2]
						Endif
					Next i
					Aadd(aItens[1],{"DD4_OBS",cAglVei,NIL})
					Processa({|lEnd| MSExecAuto({|a,b,c| TMSAD30(a,b,c)},aCab,aItens,4)},'Aguarde, Regravando Documentos') // -- Alterar o Detalhe do Documento
					lQtdVeic:=.F. // -- Nao verifique os veiculos acabei de incluir
				Else
					lRet := .T.
				EndIf
			Else // tem dd2 e dd4
				If dDataBase > DD4->DD4_PRXAPR
					//-- Expirou data de vencimento rodar a liberacao do documento 
					If DD4->DD4_TIPPER == '1' //-- Diario
						nFator := 1
					ElseIf DD4->DD4_TIPPER == '2' //-- Mensal
						nFator := 30
					ElseIf DD4->DD4_TIPPER == '3' //-- Anual
						nFator := 365
					EndIf
					If lImprime
						RecLock('DD4',.F.)
						DD4->DD4_ULTAPR := dDataBase
						DD4->DD4_PRXAPR := (dDataBase + (DD4->DD4_PERAPR * nFator))
						DD4->DD4_TOLERA := Ctod(Space(8))
						MsUnLock()

						Inclui := .T.
						RegToMemory("DD6",.T.)

						M->DD6_FILIAL := xFilial('DD6')
						M->DD6_CODMOT := DD2->DD2_CODMOT
						M->DD6_CODDOC := DD4->DD4_CODDOC
						M->DD6_DTAAPR := dDataBase
						M->DD6_RESPON := SubStr(cUsuario, 7, 15)
						If DD6->(FieldPos("DD6_TIPO")) > 0
							M->DD6_TIPO := "1" //--Liberacao por Baixa
						EndIf
						RecLock('DD6',.T.)
						For nCpos := 1 TO FCount()
							If	DD6->(FieldName(nCpos)) == 'DD6_FILIAL'
								DD6->(FieldPut(nCpos,xFilial("DD6")))
							Else
								If Type('M->'+DD6->(FieldName(nCpos))) <> 'U'
									DD6->(FieldPut(nCpos,M->&(Eval(bCampo,nCpos))))
								EndIf
							EndIf
						Next nCpos
						MsUnLock()
						//-- Verifica se Existem Bloqueios relacionado ao Documento
						//-- que esta sendo baixado. Caso afirmativo, elimina o bloqueio ( Somente em caso de viagem )
						cAliasBlq := GetNextAlias()
						cQuery := "SELECT DUC.R_E_C_N_O_ DUCRecNo "
						cQuery += "FROM " + RetSQLName('DUC') + " DUC "
						cQuery += "WHERE DUC.DUC_FILIAL = '" + xFilial('DUC') + "' AND "
						cQuery += "DUC.DUC_CODMOT = '" + DD4->DD4_CODMOT + "' AND "
						cQuery += "DUC.DUC_CODDOC = '" + DD4->DD4_CODDOC + "' AND "
						cQuery += "DUC.DUC_STATUS = '1' AND "
						cQuery += "DUC.D_E_L_E_T_ = ' '"
						cQuery := ChangeQuery(cQuery)
						dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasBlq)
						If !(cAliasBlq)->(EoF())
							While !(cAliasBlq)->(EoF()) //-- Exclui o Bloqueio
								DUC->(DbGoTo( (cAliasBlq)->DUCRecNo ))
								RecLock('DUC', .F.)
								DUC->(DbDelete())
								MsUnLock()
								
								(cAliasBlq)->(DbSkip())
							EndDo
						EndIf
						(cAliasBlq)->(DbCloseArea())
					Else
						lRet := .T.
					EndIf
				EndIf
			EndIf
		Endif

		If lImprime
			If lMsErroAuto
				MostraErro()
			EndIf
		EndIf

		If lQtdVeic  // -- verificar os veiculos acabei de incluir
			cAliasSYP := GetNextAlias() 
			cQuery := "SELECT COUNT(SYP.YP_CHAVE) QTDE"
	 		cQuery += "FROM "+ RetSQLName('DD4') + " DD4, "+ RetSQLName('SYP') + " SYP "
			cQuery += "WHERE SYP.YP_FILIAL = '"+xFilial('SYP')+"' "
	 		cQuery += "AND DD4.DD4_FILIAL = '"+IIf(cModo=="C",Space(TamSX3('DA4_FILBAS')[1]),(cAliasQRY)->DA4_FILBAS)+"' "
	 		cQuery += "AND DD4.DD4_CODMOT = '"+(cAliasQry)->DA4_COD+"' "
	 		cQuery += "AND DD4.D_E_L_E_T_ = ' ' "
	 		cQuery += "AND SYP.YP_CHAVE = DD4.DD4_CODOBS "
	 		cQuery += "AND SYP.D_E_L_E_T_ = ' '"
			cQuery := ChangeQuery(cQuery)	
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSYP)

			n1Cnt  := 0
			cAglVei:= ''
			For i:=1 to Len(aVeic) // -- Pegando os veiculos da filial
				If Alltrim(aVeic[i,1]) == Alltrim((cAliasQry)->DA4_FILBAS) // Compara sempre filbas
					cAglVei += aVeic[i,2]
					n1Cnt++
				Endif   
			Next i
			If QTDE <> n1Cnt // -- Se a Qtde de Veiculos da Filial for diferente da Qtde do Documento do Motorista
				If lImprime
					RecLock('DD4',.F.)
					MSMM(DD4->DD4_CODOBS,,,cAglVei,1,,,'DD4','DD4_CODOBS') 
					MSUnlock()
				Else
					lRet := .T.
				EndIf
			Endif
			(cAliasSYP)->(DbcloseArea())
		EndIf

		If lImprime
			IncRegua()
			If lEnd
				lRet := .F.
				Exit
			EndIf

			nLin := Cabec( STR0001,"","", NomeProg, Tamanho,,,.F. ) +1
			For i:=1 to Len(aCorpo)
				nLin := nLin + 1
				@nLin,000 Psay aCorpo[i,2]
			Next
			nLin := nLin + 2
			@nLin,000 PSay STR0025 // -- RELACAO DE MOTORISTAS
			nLin := nLin + 2
			@nLin,000 PSay STR0026 // -- NOME
			@nLin,045 PSay STR0027 // -- CPF
			@nLin,065 PSay STR0028 // -- CNH
			nLin := nLin + 1
			Posicione("DA4",1,xFilial("DA4")+(cAliasQry)->DA4_COD,"DA4_NOME") // -- so para posicionar no DA4
			@nLin,000 PSay PadR(DA4->DA4_NOME,40,'Z')
			@nLin,045 PSay DA4->DA4_CGC
			@nLin,065 PSay DA4->DA4_NUMCNH

			nLin := nLin + 2
			@nLin,000 PSay STR0029 // -- Veiculos
			@nLin,045 PSay STR0030 // -- Ano Fabricacao
			@nLin,065 PSay STR0031 // -- Placa
			nLin := nLin + 2
			(cAliasVei)->(DbGoTop())
			While (cAliasVei)->(!Eof())
				If Alltrim((cAliasVei)->DA3_FILBAS) == Alltrim((cAliasQry)->DA4_FILBAS)
					@nLin,000 PSay (cAliasVei)->DA3_DESC
					@nLin,045 PSay (cAliasVei)->DA3_ANOFAB
					@nLin,065 PSay (cAliasVei)->DA3_PLACA
					nLin := nLin + 1
					If nLin >= 57
						nLin := nLin + 1
						@nLin,060 PSay STR0018
						nLin := nLin + 1
						nLin := Cabec( STR0001,"","", NomeProg, Tamanho,,,.F. ) + 1
						nLin := nLin + 2 
						@nLin,000 PSay STR0026 // -- NOME
						@nLin,045 PSay STR0027 // -- CPF
						@nLin,065 PSay STR0028 // -- CNH
						nLin := nLin + 1
						Posicione("DA4",1,xFilial("DA4")+(cAliasQry)->DA4_COD,"DA4_NOME") // -- so para posicionar no DA4
						@nLin,000 PSay PadR(DA4->DA4_NOME,40,'Z')
						@nLin,045 PSay DA4->DA4_CGC
						@nLin,065 PSay DA4->DA4_NUMCNH
						nLin := nLin + 2
					Endif
				Endif
				(cAliasVei)->(DbSkip())
			Enddo

			If nLin >= 50 // -- Nao da para imprimir rodape entao pula a pagina 
				nLin := nLin + 1
				@nLin,060 PSay STR0018
				nLin := nLin + 1
				nLin := Cabec( STR0001,"","", NomeProg, Tamanho,,,.F. ) + 1
				nLin := nLin + 2
				@nLin,000 PSay STR0026 // -- NOME
				@nLin,045 PSay STR0027 // -- CPF
				@nLin,065 PSay STR0028 // -- CNH
				nLin := nLin + 1
				Posicione("DA4",1,xFilial("DA4")+(cAliasQry)->DA4_COD,"DA4_NOME") // -- so para posicionar no DA4
				@nLin,000 PSay PadR(DA4->DA4_NOME,40,'Z')
				@nLin,045 PSay DA4->DA4_CGC
				@nLin,065 PSay DA4->DA4_NUMCNH
			EndIf

			nLin := nLin + 2
			For i:= 1 to Len(aRodape)
				If "<VALIDADE>" $ aRodape[i,2]
					If !Empty(DD4->DD4_PRXAPR)
						aRodape[i,2] := Alltrim(StrTran(aRodape[i,2],"<VALIDADE>",DtoC(DD4->DD4_PRXAPR)))
					Else
						aRodape[i,2] := Alltrim(StrTran(aRodape[i,2],"<VALIDADE>",Dtoc(dVencto)))
					EndIf
				EndIf
				@nLin,000 PSay aRodape[i,2]
				nLin := nLin + 1
			Next
		EndIf
		(cAliasQRY)->(DbSkip())
	EndDo

End Transaction
(cAliasQRY)->(DbcloseArea())
(cAliasVei)->(DbCloseArea())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Set Device To Screen
If aReturn[5] = 1 .And. lImprime
	lRet := .T.
	Set Printer To
	Commit
	Ourspool(wnrel)
Endif
MS_FLUSH()
RestArea(aArea)
Return lRet