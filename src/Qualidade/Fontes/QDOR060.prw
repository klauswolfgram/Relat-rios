/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QDOR060.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "Report.CH"

/*
Funcao QDOR060, Autor  Leandro S. Sabino, Data  01/06/06
Descricao: Protocolo de Entrega de Documentos
(Versao Relatorio Personalizavel)
Uso QDOR060
*/
User Function QDOR060(lBat)
Local oReport := Nil

//	Variavel utiLizada para verificar se o relatorio foi iniciado
//	pelo MNU ou pela rotina de documentos.

lBat:= If(lBat == NIL,.F.,lBat)
Private cPerg	:= If(lBat,"QDR061","QDR060")

//	Salva a posicao do Documento

	If lBat
		Private cChave:= M->QDH_FILIAL+M->QDH_DOCTO+M->QDH_RV
	Endif
	
	// Interface de impressao
		//Variaveis utiLizadas para parametros
		//mv_par01	// Quebra por Departamento 1- Sim 2-Nao
		//mv_par02	// De Documento
		//mv_par03	// Ate Documento
		//mv_par04	// De  Revisao
		//mv_par05	// Ate Revisao
		//mv_par06	// De  Depto. Destino
		//mv_par07	// Ate Depto. Destino  
		//mv_par08	// Tipo de Distribuicao

	Pergunte(cPerg,.F.) 
	oReport := ReportDef(lBat)
	oReport:PrintDialog()

Return

/*
Funcao ReportDef(), Autor Leandro Sabino, Data 01/06/06
Descricao Montar a secao
Sintaxe ReportDef()
Uso QDOR060
*/

Static Function ReportDef(lBat)
Local oReport                                             
Local oSection1, oSection2 

DEFINE REPORT oReport NAME "QDOR060" TITLE OemToAnsi(STR0001) PARAMETER cPerg   ACTION {|oReport| PrintReport(oReport,lBat)} DESCRIPTION (OemToAnsi(STR0002)+OemToAnsi(STR0003)+OemToAnsi(STR0004))
//"PROTOCOLO DE ENTREGA DE DOCUMENTOS E REGISTROS DA QUALIDADE"
//"Este programa ir  imprimir o Protocolo de Entrega de Documentos"
//"e Registros da QuaLidade, que assegura o recebimento de documentos"
//"por todos os envolvidos em sua implementa‡„o"

oReport:SetPortrait() 


DEFINE SECTION oSection1 OF oReport TABLES "TRB","QDH" TITLE STR0019 
DEFINE CELL NAME "DOCTO"  OF oSection1 ALIAS "TRB" TITLE OemToAnsi(STR0019) SIZE 50// "Documento"
DEFINE CELL NAME "RV"     OF oSection1 ALIAS "TRB" TITLE OemToAnsi(STR0020) SIZE 03//"Revisao" 
DEFINE CELL NAME "TITULO" OF oSection1 ALIAS "TRB" TITLE OemToAnsi(STR0021) AUTO SIZE//"Titulo" 
DEFINE CELL NAME "DESCTP" OF oSection1 ALIAS "TRB" TITLE OemToAnsi(STR0022) SIZE 80//"Texto do protocolo"
oSection1:Cell("DESCTP"):SeTLineBREAK(.T.)


DEFINE SECTION oSection2 OF oSection1 TITLE Oemtoansi(STR0025) //"Responsavel"
DEFINE CELL NAME "DEPTO" OF oSection2 TITLE OemToAnsi(STR0023) SIZE 30//"Depto"
DEFINE CELL NAME "SETOR" OF oSection2 TITLE OemToAnsi(STR0024) SIZE 26//"Setor"
DEFINE CELL NAME "RESP"  OF oSection2 TITLE OemToAnsi(STR0025) SIZE 30//"Responsavel"
DEFINE CELL NAME "TIPO"  OF oSection2 TITLE OemToAnsi(STR0026) SIZE 20//"Tipo"
DEFINE CELL NAME "NCOP"  OF oSection2 TITLE OemToAnsi(STR0027) SIZE 23//"Copias"
DEFINE CELL NAME "DATADOC"  OF oSection2 TITLE OemToAnsi(STR0028) SIZE 12//"Data"
DEFINE CELL NAME "Assin" OF oSection2 TITLE OemToAnsi(STR0029) SIZE 25  //"Assinatura"
Return oReport


/*
Funcao PrintReport, Autor Leandro Sabino, Data 01/06/06
Descricao Imprimir os campos do relatorio
Sintaxe PrintReport(ExpO1,ExpO21)
Parametros ExpO1 = Objeto oPrint
ExpO2 = variavel lBat
Uso QADR080
*/

Static Function PrintReport( oReport,lBat)
Local aCampos    := {}
Local aRegQDG    := {}
Local aTexC      := {}
Local cAliasQD1  := "QD1"
Local cAliasQDH  := "QDH"
Local cAliasQry  := GetNextAlias()
Local cBreak     := .F.
Local cChave1    := ""
Local cChave2    := ""
Local cChave3    := ""
Local cFiltro    := ""
Local cIndex     := ""
Local cIndex2    := ""
Local cKey       := ""
Local cProtocolo := ""
Local cQuery     := ""
Local cTipPro    := GETMV("MV_QDOTPPR") // Parametro para impressao de somente copias em pael ou nao
Local cTPDIST    := ""
Local cTpDistr   := iif(!lbat,iif(type("MV_PAR08")= 'N' , cvaltochar(mv_par08),mv_par08),iif(type("MV_PAR02")= 'N' , cvaltochar(mv_par02), mv_par02))
Local lPrim      := .F.
Local nI         := 0
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
	if lbat
	mv_par08 :=mv_par02
	EndIf

DbSelectArea("QD2")
DbSetOrder(1)

DbSelectArea("QDG")
DbSetOrder(3)

DbSelectarea("QD1")
DbSetOrder(1)

DbSelectarea("QDH")                                                           
DbSetOrder(1)

// Cria Arquivo de Trabalho temporario

Aadd(aCampos,{"DOCTO"	,"C",18,0})
Aadd(aCampos,{"RV"  	,"C",03,0})
Aadd(aCampos,{"TITULO"	,"C",100,0})
Aadd(aCampos,{"DESCTP"	,"C",1000,0})
Aadd(aCampos,{"DEPTO"	,"C",30,0})
Aadd(aCampos,{"SETOR"	,"C",26,0})
Aadd(aCampos,{"RESP"	,"C",30,0})
Aadd(aCampos,{"TIPO"	,"C",20,0})
Aadd(aCampos,{"NCOP"	,"C",23,0})
Aadd(aCampos,{"DATADOC"	,"C",12,0})
Aadd(aCampos,{"Assin"	,"C",25,0})	
Aadd(aCampos,{"QDHREC"  ,"N",10,0})
Aadd(aCampos,{"QD1REC"  ,"N",10,0})

oTempTable := FWTemporaryTable():New( "TRB" )
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("indice1", {"DOCTO","RV","DEPTO"} )
oTempTable:Create()

//	Manipula dados do arquivos QDH

	If !lBat
	cIndex	:= CriaTrab(NIL,.F.)
	cFiltro:= 'QDH->QDH_FILIAL == "'+xFiLial("QDH")+'".And. '
	cFiltro+= 'QDH->QDH_DOCTO >= "'+mv_par02+'".And. QDH->QDH_DOCTO <= "'+mv_par03+'".And. '
	cFiltro+= 'QDH->QDH_RV >= "'+mv_par04+'".And. QDH->QDH_RV <= "'+mv_par05+'"'
		If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QDH")))
		cFiltro+= ' .And. '+oReport:Section(1):GetAdvplExp("QDH")
		Endif
	IndRegua(cAliasQDH,cIndex,QDH->(IndexKey()),,cFiltro,OemToAnsi(STR0007))	//"Selecionando Registros.."
	dbGoTop()
	Else
	QDH->(DbSeek(cChave))//Retorna a Posicao do QDH - Documentos
	EndIf

// Manipula dados do arquivos QD1

cIndex2:= CriaTrab(Nil,.F.)
cKey   := QD1->(IndexKey())
	If !lBat
		cFiltro:= 'QD1->QD1_FILIAL == "'+xFiLial("QD1")+'".And. '
		cFiltro+= 'QD1->QD1_DOCTO >= "'+mv_par02+'".And. QD1->QD1_DOCTO <= "'+mv_par03+'".And. '
		cFiltro+= 'QD1->QD1_RV >= "'+mv_par04+'".And. QD1->QD1_RV <= "'+mv_par05+'".And. '
		cFiltro+= 'QD1->QD1_DEPTO >= "'+mv_par06+'".And. QD1->QD1_DEPTO <= "'+mv_par07+'".And. '
		cFiltro+= 'QD1->QD1_TPPEND == "L  " .And. QD1->QD1_SIT <> "I"'
	Else
		cFiltro:= 'QD1->QD1_FILIAL == "'+QDH->QDH_FILIAL+'".And. '
		cFiltro+= 'QD1->QD1_DOCTO == "'+QDH->QDH_DOCTO+'".And. '
		cFiltro+= 'QD1->QD1_RV == "'+QDH->QDH_RV+'".And. '
		cFiltro+= 'QD1->QD1_TPPEND == "L  " .And. QD1->QD1_SIT <> "I"'
	EndIf

	If cTipPro == "S"
		cFiltro+= '.And. QD1->QD1_TPDIST $ "2,3"'
	Else
		If mv_par08 == 3
			cFiltro +=  " .And. (QD1->QD1_TPDIST == '1' "
			cFiltro +=  " .Or. QD1->QD1_TPDIST == '2' "
			cFiltro +=  " .Or. QD1->QD1_TPDIST == '3') "
		Else
			cFiltro +=  " .And. (QD1->QD1_TPDIST == '" + cvaltochar(mv_par08) + "' "	
			cFiltro +=  " .Or. QD1->QD1_TPDIST == '3') "
		Endif
	Endif 
	If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QD1")))
		cFiltro+= ' .And. '+oReport:Section(1):GetAdvplExp("QD1")
	Endif

	IndRegua(cAliasQD1,cIndex2,cKey,,cFiltro,OemToAnsi(STR0007))	//"Selecionando Registros.."
	dbGoTop()

	// Processando os arquivos

	If !lBat //Relatórios via menu
		
		cQuery :=  " SELECT DISTINCT QD1.QD1_FILIAL, "
		cQuery +=  "                 QD1.QD1_FILMAT, "
		cQuery +=  "                 QD1.QD1_MAT, "
		cQuery +=  "                 QD1.QD1_TPDIST, "
		cQuery +=  "                 QD1.QD1_DOCTO, "
		cQuery +=  "                 QD1.QD1_RV, "
		cQuery +=  "                 QD1.QD1_DEPTO, "
		cQuery +=  "                 QD1.QD1_SIT "
		cQuery +=  "            FROM " +RetSQLName("QD1") +" QD1 "
		cQuery +=  "           WHERE QD1.QD1_FILIAL = '"+xFiLial("QD1")+"' "
		cQuery +=  "             AND QD1.QD1_DOCTO >= '"+mv_par02+"' " //Documento
		cQuery +=  "             AND QD1.QD1_DOCTO <= '"+mv_par03+"' " //Documento
		cQuery +=  "             AND QD1.QD1_RV    >= '"+mv_par04+"' " //Revisão
		cQuery +=  "             AND QD1.QD1_RV    <= '"+mv_par05+"' " //Revisão
		cQuery +=  "             AND QD1.QD1_DEPTO >= '"+mv_par06+"' " //Departamento
		cQuery +=  "             AND QD1.QD1_DEPTO <= '"+mv_par07+"' " //Departamento
		cQuery +=  "             AND QD1.QD1_SIT <> 'I' "
		cQuery +=  "             AND QD1.D_E_L_E_T_ = ' ' "
		cQuery +=  "             AND QD1.QD1_TPPEND = 'L'  "
		cQuery +=  "             AND QD1.QD1_TPDIST = '" + cTpDistr + "' " 
			
		cQuery +=  "           UNION "
			
		cQuery +=  " SELECT DISTINCT QDG.QDG_FILIAL, "
		cQuery +=  "                 QDG.QDG_FILMAT, "
		cQuery +=  "                 QDG.QDG_MAT, "
		cQuery +=  "                 QDG.QDG_TPRCBT, "
		cQuery +=  "                 QDG.QDG_DOCTO, "
		cQuery +=  "                 QDG.QDG_RV, "
		cQuery +=  "                 QDG.QDG_DEPTO, "
		cQuery +=  "                 QDG.QDG_SIT "
		cQuery +=  "            FROM " +RetSQLName("QDG") +" QDG "
		cQuery +=  "           WHERE QDG.QDG_FILIAL = '"+xFiLial("QDG")+"' "
		cQuery +=  "             AND QDG.QDG_DOCTO >= '"+mv_par02+"' " //Documento
		cQuery +=  "             AND QDG.QDG_DOCTO <= '"+mv_par03+"' " //Documento
		cQuery +=  "             AND QDG.QDG_RV    >= '"+mv_par04+"' " //Revisão
		cQuery +=  "             AND QDG.QDG_RV    <= '"+mv_par05+"' " //Revisão
		cQuery +=  "             AND QDG.QDG_DEPTO >= '"+mv_par06+"' " //Departamento
		cQuery +=  "             AND QDG.QDG_DEPTO <= '"+mv_par07+"' " //Departamento
		cQuery +=  "             AND QDG.QDG_SIT <> 'I' "
		cQuery +=  "             AND QDG.D_E_L_E_T_ = ' ' "
		cQuery +=  "             AND QDG.QDG_TPRCBT = '" + cTpDistr + "' "

	Else

		cQuery :=  " SELECT DISTINCT QD1.QD1_FILIAL, "
		cQuery +=  "                 QD1.QD1_FILMAT, "
		cQuery +=  "                 QD1.QD1_MAT, "
		cQuery +=  "                 QD1.QD1_TPDIST, "
		cQuery +=  "                 QD1.QD1_DOCTO, "
		cQuery +=  "                 QD1.QD1_RV, "
		cQuery +=  "                 QD1.QD1_DEPTO, "
		cQuery +=  "                 QD1.QD1_SIT "
		cQuery +=  "            FROM " +RetSQLName("QD1") +" QD1 "
		cQuery +=  "           WHERE QD1.QD1_FILIAL = '" + (cAliasQDH)->QDH_FILIAL + "' " 
		cQuery +=  "             AND QD1.QD1_DOCTO = '"+ (cAliasQDH)->QDH_DOCTO +"' " 
		cQuery +=  "             AND QD1.QD1_RV = '" + (cAliasQDH)->QDH_RV + "' "
		cQuery +=  "             AND QD1.QD1_SIT <> 'I' "
		cQuery +=  "             AND QD1.D_E_L_E_T_ = ' ' "
		cQuery +=  "             AND QD1.QD1_TPPEND = 'L'  "
		cQuery +=  "             AND QD1.QD1_TPDIST = '" + cTpDistr + "' "
			
		cQuery +=  "           UNION "
			
		cQuery +=  " SELECT DISTINCT QDG.QDG_FILIAL, "
		cQuery +=  "                 QDG.QDG_FILMAT, "
		cQuery +=  "                 QDG.QDG_MAT, "
		cQuery +=  "                 QDG.QDG_TPRCBT, "
		cQuery +=  "                 QDG.QDG_DOCTO, "
		cQuery +=  "                 QDG.QDG_RV, "
		cQuery +=  "                 QDG.QDG_DEPTO, "
		cQuery +=  "                 QDG.QDG_SIT "
		cQuery +=  "            FROM " +RetSQLName("QDG") +" QDG "
		cQuery +=  "           WHERE QDG.QDG_FILIAL = '" + (cAliasQDH)->QDH_FILIAL + "' " 
		cQuery +=  "             AND QDG.QDG_DOCTO = '"+ (cAliasQDH)->QDH_DOCTO +"' " 
		cQuery +=  "             AND QDG.QDG_RV = '" + (cAliasQDH)->QDH_RV + "' "
		cQuery +=  "             AND QDG.QDG_SIT <> 'I' "
		cQuery +=  "             AND QDG.D_E_L_E_T_ = ' ' "
		cQuery +=  "             AND QDG.QDG_TPRCBT = '" + cTpDistr + "' "

	EndIf

	cQuery := ChangeQuery(cQuery)
	DbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery), cAliasQry, .T., .T.)
   
    While (cAliasQDH)->(!Eof()) 
		
		While (cAliasQry)->(!Eof())

			If (cAliasQDH)->QDH_DOCTO+(cAliasQDH)->QDH_RV == (cAliasQry)->QD1_DOCTO+(cAliasQry)->QD1_RV

				RecLock("TRB",.T.)
			
				TRB->DOCTO := (cAliasQDH)->QDH_DOCTO
				TRB->RV    := (cAliasQDH)->QDH_RV
				TRB->TITULO:= (cAliasQDH)->QDH_TITULO
				TRB->QDHREC := (cAliasQDH)->(RECNO())	

				TRB->DEPTO := (cAliasQry)->QD1_DEPTO
				TRB->SETOR := QA_NDEPT((cAliasQry)->QD1_DEPTO,.T.,xFilial("QAD"))
				TRB->RESP  := (SubsTr(QA_NUSR((cAliasQry)->QD1_FILMAT,(cAliasQry)->QD1_MAT,.T.),1,30)) 

				cProtocolo:=""
			
				If QD2->(DbSeek(xFilial("QD2")+(cAliasQDH)->QDH_CODTP))
						aTexC:=JustificaTXT(MSMM(QD2->QD2_PROTOC,80),80,.T.)	
					For nI:=1 to Len(aTexC)
							cProtocolo += aTexC[nI]
					Next
						TRB->DESCTP := cProtocolo
				EndIf
				If (cAliasQry)->QD1_TPDIST <> "4"
					If QDG->(DbSeek((cAliasQry)->QD1_FILIAL+(cAliasQry)->QD1_DOCTO+(cAliasQry)->QD1_RV+(cAliasQry)->QD1_FILMAT+(cAliasQry)->QD1_DEPTO+(cAliasQry)->QD1_MAT))
						While QDG->(!Eof()) .And. QDG->QDG_DOCTO+QDG->QDG_RV+QDG->QDG_FILMAT+QDG->QDG_DEPTO+QDG->QDG_MAT == (cAliasQry)->QD1_DOCTO+(cAliasQry)->QD1_RV+(cAliasQry)->QD1_FILMAT+(cAliasQry)->QD1_DEPTO+(cAliasQry)->QD1_MAT
							If aScan(aRegQDG,{ |X| X == QDG->(Recno()) }) == 0 .AND. QDG->QDG_TPRCBT == (cAliasQry)->QD1_TPDIST
								aAdd(aRegQDG,QDG->(Recno()))
								Exit
							EndIf
							QDG->(DbSkip())
						EndDo
						If (QDG->QDG_TIPO == "D")
							TRB->TIPO :=OemToAnsi(STR0017)
						Else	
							TRB->TIPO :=OemToAnsi(STR0018)
						Endif

						TPDIST := U_QDORSTR60((cAliasQry)->QD1_TPDIST)

						TRB->NCOP := (StrZero(QDG->QDG_NCOP,4))+" "+TPDIST
					Endif
				Else
				
					TPDIST := U_QDORSTR60((cAliasQry)->QD1_TPDIST)

					TRB->NCOP := (StrZero(00,4))+" "+TPDIST

				Endif
				TRB->QD1REC := (cAliasQry)->(RECNO())	        
				TRB->DATADOC  := "___/___/___"
				TRB->Assin := RepLicate("_",40)
				TRB->(MsUnlock())
			EndIf
			(cAliasQry)->(dbSkip())
		EndDo
		(cAliasQry)->(dbGoTop())

		(cAliasQDH)->(dbSkip())
	EndDo

	If mv_par01 == 1
		cBreak:= .T.
	Else
		cBreak:= .F.
	Endif
	
	//	Impressao do arquivo temporario

	dbSelectArea("TRB")
	dbGoTop()
	oSection2:SetLinesBefore(3)
	While !oReport:Cancel() .And. TRB->(!Eof())
		dbselectarea("QDH")// posiciona tabelas para posibilitar personalizar campos no relatorio
		QDH->(dbgoto(TRB->QDHREC))
		dbselectarea("QD1")
		QD1->(dbgoto(TRB->QD1REC))
		If cChave3 = TRB->DOCTO+TRB->RV+TRB->DEPTO+TRB->RESP
			TRB->(dbSkip())
			loop
		EndIf
		If cChave1 <> TRB->DOCTO+TRB->RV
			oSection1:Finish()
			oSection2:Finish()
			oSection1:Init()
			oSection1:PrintLine()
			oSection2:Init()
			oSection1:SetPageBreak(.T.)
			lPrim := .T.
		Else
			If cChave2 <> TRB->DOCTO+TRB->RV+TRB->DEPTO
				If cBreak
					oSection1:SetPageBreak(.T.) 
					oSection1:Finish()
					oSection2:Finish()
					oSection1:Init()
					oSection1:PrintLine()
					oSection2:Init()					
					lPrim := .T.
				Endif
			Endif
		EndIf
		cChave1 := TRB->DOCTO+TRB->RV
		cChave2 := TRB->DOCTO+TRB->RV+TRB->DEPTO

		If lPrim
			oSection2:Cell("DEPTO"):SetValue("")
			oSection2:Cell("SETOR"):SetValue("")
			oSection2:Cell("RESP"):SetValue("")
			oSection2:Cell("Tipo"):SetValue("")
			oSection2:Cell("NCOP"):SetValue("")
			oSection2:Cell("DATADOC"):SetValue("")
			oSection2:Cell("Assin"):SetValue("")
			lPrim := .F.

		Else
			oSection2:Cell("DEPTO"):SetValue(TRB->DEPTO)
			oSection2:Cell("SETOR"):SetValue(TRB->SETOR)
			oSection2:Cell("RESP"):SetValue(TRB->RESP)
			oSection2:Cell("Tipo"):SetValue(TRB->Tipo)
			oSection2:Cell("NCOP"):SetValue(TRB->NCOP)
			oSection2:Cell("DATADOC"):SetValue(TRB->DATADOC)
			oSection2:Cell("Assin"):SetValue(TRB->Assin)

			cChave3 := TRB->DOCTO+TRB->RV+TRB->DEPTO+TRB->RESP
			TRB->(dbSkip())
		Endif
		oSection2:PrintLine()
		oReport:SkipLine(3)
	Enddo
             
TRB->(DbCloseArea())

//	Devolve as ordens originais dos arquivos
RetIndex("QDH")
Set Filter to

RetIndex("QD1")
Set Filter to

QDG->(DbSetOrder(1))

// Apaga indices de trabalho
oTempTable:Delete()

cIndex  += OrdBagExt()
Delete File &(cIndex)

cIndex2 += OrdBagExt()
Delete File &(cIndex2)

Return

/*/{Protheus.doc} QDORSTR60
Função genérica para validar o tipo de distribuição
@type function
@version 
@author thiago.rover
@since 20/02/2020
@param cTPDIST, character, param_description
@return return_type, return_description
/*/
User Function QDORSTR60(cTPDIST)

	Local cSTRDIST := ""

	Do Case 
		Case cTPDIST == "1"
			cSTRDIST:=OemToAnsi(STR0011)// " Eletronicas"
		Case cTPDIST == "2"
			cSTRDIST:=OemToAnsi(STR0012)// " Em Papel"
		Case cTPDIST == "3"
			cSTRDIST:=OemToAnsi(STR0013)// " Eletronica/Papel"
		Case cTPDIST == "4"
			cSTRDIST:=OemToAnsi(STR0014)// " Nao Recebe"
	EndCase

Return cSTRDIST
