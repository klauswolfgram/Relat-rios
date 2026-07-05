/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "OMSR030.CH"

Static lDaiRedesp  := DAI->( ColumnPos( "DAI_REDESP" ) ) > 0

/*/{Protheus.doc} OMSR030
	Relatorio de Mapa de Entrega
@author Squad OMS Protheus
@since  04.05.2006
/*/
User Function OMSR030()
Local oReport := Nil

	If FindFunction("OMSMsgRelD")
		OMSMsgRelD()
	EndIf

	oReport := ReportDef()
	oReport:PrintDialog()

Return

//-----------------------------------------------------------------------------
// Definição da configuração do relatório
//-----------------------------------------------------------------------------
Static Function ReportDef()

Local oReport
Local oCarga
Local oCliente
Local oForma
Local oDocSai
Local oItemSai

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("OMSR030",STR0034,"OMR030", {|oReport| ReportPrint(oReport)},STR0023) //"Mapa de Entregas"###"Este relatorio ira imprimir o mapa de entregas de acordo com os parametros informados pelo usuario. O mapa de entrega demonstra o roteiro de entrega dos documentos de saída, bem como os valores que serão coletados pelo responsável da entrega."
oReport:SetLandscape()
oReport:SetTotalInLine(.F.)
Pergunte("OMR030",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCarga := TRSection():New(oReport,STR0024,{"DAK","DA3","DA4"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Carga"
oCarga:SetTotalInLine(.F.)
TRCell():New(oCarga ,"DAK_COD"    ,"DAK" ,STR0024    ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"Carga"
TRCell():New(oCarga ,"DAK_SEQCAR" ,"DAK" ,STR0025    ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"Seq."
TRCell():New(oCarga ,"DAK_CAMINH" ,"DAK" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oCarga ,"DA3_DESC"   ,"DA3" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oCarga ,"DAK_MOTORI" ,"DAK" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oCarga ,"DA4_NOME"   ,"DA4" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oCarga ,"DAK_PESO"   ,"DAK" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oCarga ,"DAK_CAPVOL" ,"DAK" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oCarga ,"DAK_PTOENT" ,"DAK" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oCarga ,"DAK_VALOR"  ,"DAK" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oCarga ,"DAK_DATA"   ,"DAK" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oCarga ,"DAK_HORA"   ,"DAK" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)

oCliente := TRSection():New(oCarga,STR0026,{"SA1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Cliente"
oCliente:SetTotalInLine(.F.)
TRCell():New(oCliente ,"A1_COD"  ,"SA1" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oCliente ,"A1_LOJA" ,"SA1" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oCliente ,"A1_NOME" ,"SA1" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)

oForma := TRSection():New(oCliente,STR0027,{},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Forma de Pagamento"
oForma:SetTotalInLine(.F.)
oForma:SetEditCell(.F.)
TRCell():New(oForma ,"CV_FORMAPG" ,"SCV" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,{|| aFormas[nFormas][3] })
TRCell():New(oForma ,"CV_DESCFOR" ,"SCV" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,{|| IIf(Empty(aFormas[nFormas][3]),STR0028,aFormas[nFormas][4]) }) //"Não informada"
TRCell():New(oForma ,"C6_VALOR"   ,"SC6" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,{|| aFormas[nFormas][5] })
oCliente:SetTotalInLine()
TRFunction():New(oForma:Cell("C6_VALOR"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)

oDocSai := TRSection():New(oCarga,STR0029,{"SF2","SE4"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Documento de Saída"
oDocSai:SetTotalInLine(.F.)
TRCell():New(oDocSai ,"DAI_SEQUEN" ,"DAI" ,STR0025				,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"Seq."
TRCell():New(oDocSai ,"F2_TIPODOC" ,"SF2" ,"Tipo"				,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,{|| IIf(IsRemito(1,"SF2->F2_TIPODOC"),"(2)","(1)")})
TRCell():New(oDocSai ,"F2_DOC"     ,"SF2" ,FWX3Titulo("DAI_NFISCA"),/*Picture*/ ,TamSx3("F2_DOC")[1]+2 ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oDocSai ,"F2_SERIE"   ,"SF2" ,FWX3Titulo("DAI_SERIE"),/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"Serie"
TRCell():New(oDocSai ,"F2_CLIENTE" ,"SF2" ,/*Titulo*/			,/*Picture*/ ,TamSx3("F2_CLIENTE")[1]+2 ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oDocSai ,"F2_LOJA"    ,"SF2" ,/*Titulo*/			,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oDocSai ,"A1_NREDUZ"  ,"SA1" ,/*Titulo*/			,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
If lDaiRedesp
	TRCell():New(oDocSai , "DAI_REDESP" ,"DAI" , /*Titulo*/			,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
	TRCell():New(oDocSai , "A4_NREDUZ"  ,"SA4" , /*Titulo*/			,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
EndIf
TRCell():New(oDocSai ,"A1_END"     ,"SA1" ,/*Titulo*/			,/*Picture*/ ,60 ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oDocSai ,"A1_BAIRRO"  ,"SA1" ,/*Titulo*/ 		    ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oDocSai ,"A1_MUN"     ,"SA1" ,/*Titulo*/	 		,/*Picture*/ ,50 ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oDocSai ,"A1_EST"     ,"SA1" ,STR0031    			,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"UF"
TRCell():New(oDocSai ,"F2_COND"    ,"SF2" ,STR0032    			,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/) //"Cond.Pag."
TRCell():New(oDocSai ,"E4_DESCRI"  ,"SE4" ,/*Titulo*/ 			,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)

oItemSai := TRSection():New(oDocSai,STR0033,{"SD2","SC6"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Item do documento de saída"
oItemSai:SetTotalInLine(.F.)
TRCell():New(oItemSai ,"C6_NUM"     ,"SC6" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oItemSai ,"C6_ITEM"    ,"SC6" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oItemSai ,"D2_COD"     ,"SD2" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oItemSai ,"C6_DESCRI"  ,"SC6" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oItemSai ,"D2_QUANT"   ,"SD2" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oItemSai ,"D2_VALBRUT" ,"SD2" ,/*Titulo*/ ,/*Picture*/ ,/*Tamanho*/ ,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRFunction():New(oItemSai:Cell("D2_QUANT"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oItemSai:Cell("D2_VALBRUT"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)

Return( oReport )

//-----------------------------------------------------------------------------
// Efetua a impressão do relatório
//-----------------------------------------------------------------------------
Static Function ReportPrint(oReport)

Local nTipoOper  := OsVlEntCom()
Local cCliLoja   := ""
Local cFilPv     := ""
Local cAliasQry  := ""
Local cSelectAdd := ""
Local cCodSeqDAK := ""
Local nTotal     := 0
Local nX         := 0
Local cRotCep    := SuperGetMv("MV_ROTCEP",.F.,"1")
Local oCarga     := oReport:Section(1)
Local oCliente   := oCarga:Section(1)
Local oForma     := oCliente:Section(1)
Local oDocSai    := oCarga:Section(2)
Local oItemSai   := oDocSai:Section(1)
Local cCliEnt    := ""
Local cLojaEnt   := ""
Local cNomReduz  := ""
Local cEndereco  := ""
Local cBairro    := ""
Local cMunicipio := ""
Local cEstado    := ""
Local cWhere     := ""
Local cRedesp    := ""
Local cRedNom    := ""

Private aFormas := {}
Private nFormas := 0

	cSelectAdd := Iif(nTipoOper == 2 .Or. nTipoOper == 3,",DAI_FILPV","")
	If Empty(cSelectAdd)
		cSelectAdd := Iif(lDaiRedesp,",DAI_REDESP","")
	Else
		cSelectAdd += Iif(lDaiRedesp,",DAI_REDESP","")
	EndIf

	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:uParam)
	cSelectAdd := "%"+cSelectAdd+"%"

	cWhere := "%"
	If nTipoOper == 1
		cWhere += "AND C5_FILIAL  = '"+xFilial("SC5")+"'"
	Else
		cWhere += "AND C5_FILIAL  = DAI_FILPV"
	EndIf
	cWhere += "%"

	// Query do relatório da seção 1
	oCarga:BeginQuery()
	cAliasQry := GetNextAlias()
	BeginSql Alias cAliasQry
	SELECT DAK.DAK_COD,
			 DAK.DAK_SEQCAR,
			 DAK.DAK_CAMINH,
			 DAK.DAK_MOTORI,
			 DAK.DAK_DATA,
			 DAK.DAK_PESO,
			 DAK.DAK_CAPVOL,
			 DAK.DAK_PTOENT,
			 DAK.DAK_VALOR,
			 DAK.DAK_HORA,
			 DAI.DAI_FILIAL,
			 DAI.DAI_SEQUEN,
			 DAI.DAI_NFISCA,
			 DAI.DAI_SERIE,
			 DAI.DAI_PEDIDO,
			 DAI.DAI_PESO,
			 DAI.DAI_CAPVOL,
			 SC5.C5_TIPO,
			 SC5.C5_CLIENTE, 
			 SC5.C5_LOJACLI,
			 SC5.C5_CLIENT, 
			 SC5.C5_LOJAENT
			 %Exp:cSelectAdd%
	 FROM %table:DAK% DAK,
			%table:DAI% DAI,
			%table:SC5% SC5
	WHERE DAK_FILIAL = %xFilial:DAK% 
	  AND DAK_COD    >= %Exp:mv_par01% 
	  AND DAK_COD    <= %Exp:mv_par02% 
	  AND DAK_SEQCAR >= %Exp:mv_par03% 
	  AND DAK_SEQCAR <= %Exp:mv_par04% 
	  AND DAK_CAMINH >= %Exp:mv_par05% 
	  AND DAK_CAMINH <= %Exp:mv_par06% 
	  AND DAK_MOTORI >= %Exp:mv_par07% 
	  AND DAK_MOTORI <= %Exp:mv_par08% 
	  AND DAK_DATA   >= %Exp:Dtos(mv_par09)% 
	  AND DAK_DATA   <= %Exp:Dtos(mv_par10)% 
	  AND DAK_FEZNF  = '1' 
	  AND DAK.%NotDel% 
	  AND DAI_FILIAL = %xFilial:DAI% 
	  AND DAI_COD    = DAK_COD
	  AND DAI_SEQCAR = DAK_SEQCAR
	  AND DAI.%NotDel%
	  AND C5_NUM     = DAI_PEDIDO
	  AND SC5.%NotDel%
	  %Exp:cWhere%
	ORDER BY DAK_COD,DAK_SEQCAR //,DAI_SEQUEN,DAI_PEDIDO

	EndSql
	oCarga:EndQuery(/*Array com os parametros do tipo Range*/)

	oDocSai:SetParentQuery()

	TRPosition():New(oCarga,"DA3",1,{|| xFilial("DA3")+(cAliasQry)->DAK_CAMINH })
	TRPosition():New(oCarga,"DA4",1,{|| xFilial("DA4")+(cAliasQry)->DAK_MOTORI })

	TRPosition():New(oCliente,"SA1",1,{|| OsFilial("SA1",cFilPv)+aFormas[nFormas][2] })

	TRPosition():New(oDocSai ,"SF2",1,{|| OsFilial("SF2",cFilPv)+(cAliasQry)->DAI_NFISCA+(cAliasQry)->DAI_SERIE+(cAliasQry)->C5_CLIENTE+(cAliasQry)->C5_LOJACLI })
	TRPosition():New(oDocSai ,"SE4",1,{|| OsFilial("SE4",cFilPv)+SF2->F2_COND })

	oItemSai:SetRelation({|| OsFilial("SD2",cFilPv)+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA }, "SD2" , 3 , .T. )
	oItemSai:SetParentFilter({|| SD2->D2_FILIAL+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA == OsFilial("SD2",cFilPv)+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA })

	TRPosition():New(oItemSai,"SC6",1,{|| OsFilial("SC6",cFilPv)+SD2->D2_PEDIDO+SD2->D2_ITEMPV })

	oDocSai:Cell("F2_CLIENTE"):SetBlock({|| cCliEnt})
	oDocSai:Cell("F2_LOJA"):SetBlock({|| cLojaEnt})
	oDocSai:Cell("A1_NREDUZ"):SetBlock({|| cNomReduz})
	If lDaiRedesp
		oDocSai:Cell("DAI_REDESP"):SetBlock({|| cRedesp})
		oDocSai:Cell("A4_NREDUZ"):SetBlock({|| cRedNom})
	EndIf
	oDocSai:Cell("A1_END"):SetBlock({|| cEndereco})
	oDocSai:Cell("A1_BAIRRO"):SetBlock({|| cBairro})
	oDocSai:Cell("A1_MUN"):SetBlock({|| cMunicipio})
	oDocSai:Cell("A1_EST"):SetBlock({|| cEstado})

	// Inicio da impressao do fluxo do relatório
	oReport:SetMeter((cAliasQry)->(LastRec()))

	dbSelectArea(cAliasQry)
	(cAliasQry)->(DbGoTop())
	While !oReport:Cancel() .And. (cAliasQry)->(!Eof())

		aFormas := OsFormasPg((cAliasQry)->DAK_COD,(cAliasQry)->DAK_SEQCAR,1,3)
		If Len(aFormas) == 0
			oCarga:Cell("DAK_VALOR"):SetValue((cAliasQry)->DAK_VALOR)
		Else
			nTotal := 0
			AEval(aFormas,{|x|nTotal+=x[5]})
			oCarga:Cell("DAK_VALOR"):SetValue(nTotal)
		EndIf
		// Imprime a secao da carga
		oCarga:Init()
		oCarga:PrintLine()

		// Imprime a secao da forma de pagamento
		If Len(aFormas) > 0
			aFormas := aSort(aFormas,,,{|x,y| x[2] < y[2] } )
			For nX := 1 to Len(aFormas)
				nFormas := nX

				oCliente:Init()
				oCliente:PrintLine()
				oCliente:Finish()

				cCliLoja := aFormas[nFormas][2]

				While !oReport:Cancel() .And. nFormas <= Len(aFormas) .And. cCliLoja == aFormas[nX][2]
					oForma:Init()
					oForma:PrintLine()
					oForma:Finish()
					nX ++
					nFormas := nX
				EndDo

				nX := nFormas - 1
			Next nX
		EndIf

		If MV_PAR11 != 1
			oDocSai:Init()
		EndIf
		// Imprime a sequencia de entrega
		cCodSeqDAK := (cAliasQry)->DAK_COD+(cAliasQry)->DAK_SEQCAR
		While !oReport:Cancel() .And. (cAliasQry)->(!Eof()) .And. (cAliasQry)->DAI_FILIAL+(cAliasQry)->DAK_COD+(cAliasQry)->DAK_SEQCAR == xFilial("DAI")+cCodSeqDAK
			cFilPv := Iif(nTipoOper == 1, cFilAnt ,(cAliasQry)->DAI_FILPV)
			// Posiciona o cliente ou fornecedor
			If !Empty((cAliasQry)->C5_CLIENT)
				cCliEnt  := (cAliasQry)->C5_CLIENT
				cLojaEnt := (cAliasQry)->C5_LOJAENT
			Else
				cCliEnt  := (cAliasQry)->C5_CLIENTE
				cLojaEnt := (cAliasQry)->C5_LOJACLI
			EndIf
			If (cAliasQry)->C5_TIPO $ "DB"
				SA2->(dbSetOrder(1))
				SA2->(MsSeek(OsFilial("SA2",cFilPv)+cCliEnt+cLojaEnt))
				cNomReduz  := SA2->A2_NREDUZ
				cEndereco  := SA2->A2_END
				cBairro    := SA2->A2_BAIRRO
				cMunicipio := SA2->A2_MUN
				cEstado    := SA2->A2_EST
			Else
				SA1->(dbSetOrder(1))
				SA1->(MsSeek(OsFilial("SA1",cFilPv)+cCliEnt+cLojaEnt))
				cNomReduz := SA1->A1_NREDUZ
				Do Case
					Case cRotCep == "1"
						cEndereco  := SA1->A1_END
						cBairro    := SA1->A1_BAIRRO
						cMunicipio := SA1->A1_MUN
						cEstado    := SA1->A1_EST
					Case cRotCep == "2"
						cEndereco  := IIf(Empty(SA1->A1_ENDENT),SA1->A1_END,SA1->A1_ENDENT)
						cBairro    := IIf(Empty(SA1->A1_BAIRROE),SA1->A1_BAIRRO,SA1->A1_BAIRROE)
						cMunicipio := IIf(Empty(SA1->A1_MUNE),SA1->A1_MUN,SA1->A1_MUNE)
						cEstado    := IIf(Empty(SA1->A1_ESTE),SA1->A1_EST,SA1->A1_ESTE)
					OtherWise
						cEndereco  := SA1->A1_ENDENT
						cBairro    := SA1->A1_BAIRROE
						cMunicipio := SA1->A1_MUNE
						cEstado    := SA1->A1_ESTE
				EndCase
			EndIf

			//Caso exista Redespachante na Carga, os dados dele serão considerados como dados de Entrega da Carga.
			If lDaiRedesp .And. !Empty((cAliasQry)->DAI_REDESP)
				cRedesp    := (cAliasQry)->DAI_REDESP
				SA4->(dbSetOrder(1))
				SA4->(MsSeek(OsFilial("SA4",cFilPv)+cRedesp))
				cRedNom    := SA4->A4_NREDUZ
				cEndereco  := SA4->A4_END
				cBairro    := SA4->A4_BAIRRO
				cMunicipio := SA4->A4_MUN
				cEstado    := SA4->A4_EST
			Else
				cRedesp    := ""
				cRedNom    := ""
			EndIf

			If MV_PAR11 == 1
				oDocSai:Init()
				oDocSai:PrintLine()
				oItemSai:Print()
				oDocSai:Finish()
			Else
				oDocSai:PrintLine()
			EndIf
			(cAliasQry)->(dbSkip())
		EndDo
		If MV_PAR11 != 1
			oDocSai:Finish()
		EndIf
		oCarga:Finish()
		oCarga:SetPageBreak(.T.)
		oReport:IncMeter()
	EndDo
	(cAliasQry)->(DbCloseArea())

Return
