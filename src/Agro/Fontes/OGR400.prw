/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'Protheus.ch'
#INCLUDE 'TopConn.ch'
#INCLUDE 'OGR400.CH'
/*                                                                                                 
+=================================================================================================+
| Programa  : OGR400                                                                              |
| Descrição : Programa saldos de contrato de terceiros                                            |
| Autor     : Inácio Luiz Kolling                                                                 |
| Data      : 24/03/2016                                                                          | 
+=================================================================================================+                                                                           |  
*/
User Function OGR400()
	Local aArAt		:= GetArea()
	Private oReport	:= Nil
	Private cPerg	:= "OGR400"
	Private lPlanilha,nInc := 0,oSection1
	Private vRetR,cNoT1,cAlT1,aAlT1,vRetT,cNoTT,cAlTT,aAlTT

	U_OGRSALDOTRB("OGR400","3")

	If TRepInUse()
		Pergunte(cPerg,.f.)
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

	AGRDELETRB(cAlT1,cNoT1)
	AGRDELETRB(cAlTT,cNoTT)
	RestArea(aArAt)  
Return( Nil )

/*                                                                                                 
+=================================================================================================+
| Função    : ReportDef                                                                           |
| Descrição : Criação da seção                                                                    |
| Autor     : Inácio Luiz Kolling                                                                 |
| Data      : 24/03/2016                                                                          | 
+=================================================================================================+                                                                           |  
*/
Static Function ReportDef()
	oReport	:= TReport():New('OGR400',STR0021,cPerg,{|oReport|U_OGRSALDOPRI(oReport,'3')},STR0021)
	oReport:SetTotalInLine(.f.)
	oReport:SetLandScape()
	U_OGRSALDOCOL(oReport,STR0021,"3")
Return oReport

/*                                                                                                 
+=================================================================================================+
| Função    : OGRSALDOPRI                                                                         |
| Descrição : Chamada do processo de geração e imnpressão                                         |
| Autor     : Inácio Luiz Kolling                                                                 |
| Data      : 24/03/2016                                                                          | 
+=================================================================================================+    
| Referência: OGR400,OGR500,OGR600,OGR700                                                         | 
+=================================================================================================+                                                                           |  
*/
User Function OGRSALDOPRI(oReport,cTipo)
	Local nx,ny := 0
	Local vCabR,vCaPc := {}
	Local aPicture := AGRGerPic(16,TamSX3("NJR_QTDCTR")[2])
	Local cPict := IIF((Len(aPicture) > 2 .and. aPicture[1] == .T.) , aPicture[2], PesqPict("NJR","NJR_QTDCTR"))   

	Private oS1		:= oReport:Section(1),oS2 := oReport:Section(2)
	Private aQProd	:= {},lPrim := .t.
	Private vVetCab	:= {{STR0022},{STR0023},{STR0024},{"UM"},{STR0025,cPict}}
	Private aCamCol	:= {{"NJR_FILIAL",10},{"NJR_CODCTR",140},{"NJR_CODSAF",270},{"NJR_UM1PRO",490},{"NJR_QTDCTR",530}}
	If cTipo = '1' // Saldo de contrato de Compra
		vCabR := {{STR0036,cPict},{STR0045,cPict},{STR0042,cPict},{STR0029,cPict},{STR0043,cPict},{STR0046,cPict},;
		{STR0044,cPict},{STR0033,cPict},{STR0047,cPict},{STR0048,cPict},{STR0019,cPict}}

		vCaPc := {{"NJR_QTEFIS",750},{"NJR_QTSFIS",960},{"SLDFISCAL",1173},{"DIFFISCAL",1386},{"NJR_QTEFCO",1609},{"NJR_QTSFCO",1829},;
		{"SALDOFICO",2035},{"NJR_QTDRES",2248},{"QTDFIXA",2461},{"QTDAFIXA",2674},{"DISPONIVE",2887}}	

	ElseIf cTipo = '2' //saldos de contrato de Venda

		vCabR := {{STR0049,cPict},{STR0045,cPict},{STR0042,cPict},{STR0029,cPict},{STR0050,cPict},{STR0046,cPict},{STR0044,cPict},;
		{STR0033,cPict},{STR0047,cPict},{STR0048,cPict},{STR0019,cPict}}	          

		vCaPc := {{"NJR_QTSFIS",750},{"NJR_QTEFIS",960},{"SLDFISCAL",1173},{"DIFFISCAL",1386},{"NJR_QTSFCO",1609},{"NJR_QTEFCO",1829},;
		{"SALDOFICO",2035},{"NJR_QTDRES",2248},{"QTDFIXA",2461},{"QTDAFIXA",2674},{"DISPONIVE",2887}}

	ElseIf cTipo = '3' //saldos de contrato de terceiros
		vCabR := {{STR0026,cPict},{STR0027,cPict},{STR0028,cPict},{STR0029,cPict},{STR0030,cPict},{STR0031,cPict},{STR0032,cPict},;
		{STR0033,cPict},{STR0034,cPict},{STR0035,cPict},{STR0019,cPict}}

		vCaPc := {{"NJR_QTEFIS",750},{"NJR_QTSFIS",960},{"SLDFISCAL",1173},{"DIFFISCAL",1386},{"NJR_QTEFCO",1609},{"NJR_QTSFCO",1829},;
		{"SALDOFICO",2035},{"NJR_QTDRES",2248},{"QUEBRATEC",2461},{"RETENCAO",2674},	{"DISPONIVE",2887}}

	ElseIf cTipo = '4' // Saldo de Contratos em Terceiros
		vCabR := {{STR0027,cPict},{STR0026,cPict},{STR0028,cPict},{STR0029,cPict},{STR0031,cPict},{STR0030,cPict},{STR0032,cPict},;
		{STR0033,cPict},{STR0019,cPict}}

		vCaPc := {{"NJR_QTSFIS",750},{"NJR_QTEFIS",1000},{"SLDFISCAL",1230},{"DIFFISCAL",1460},{"NJR_QTSFCO",1690},{"NJR_QTEFCO",1920},;
		{"SALDOFICO",2150},{"NJR_QTDRES",2380},{"DISPONIVE",2610}}
	EndIf 				  

	For nx := 1 To Len(vCabR)
		Aadd(vVetCab,vCabR[nx])
	Next nx                  

	For nx := 1 To Len(vCaPc)
		Aadd(aCamCol,vCaPc[nx])
	Next nx              

	lPlanilha	:= If(oReport:ndevice = 4,.t.,.f.)
	cAliasQry	:= GetNextAlias()

	cSQL := "SELECT NJR.NJR_FILIAL,NJR.NJR_CODPRO,NJR.NJR_CODENT,NJR.NJR_LOJENT,NJR.NJR_CODCTR,NJR.NJR_CODSAF,"
	cSQL += "NJR.NJR_UM1PRO,NJR.NJR_QTDCTR,NJR.NJR_QTEFIS,NJR.NJR_QTSFIS,NJR.NJR_QTEFCO,NJR.NJR_QTSFCO,NJR.NJR_QTDRES"

	If	cTipo $ "1|2"
		cSQL += ",SUM(NN8.NN8_QTDFIX) QTDFIXA "
		cSQL += "FROM "+RetSqlName("NJR")+" NJR "
		cSQL += "LEFT JOIN "+RetSqlName("NN8")+" NN8 ON"		
		cSQL += " NJR.NJR_FILIAL = NN8.NN8_FILIAL AND "		
		cSQL += " NJR.NJR_CODCTR = NN8.NN8_CODCTR AND NN8.NN8_TIPOFX = '1' AND NN8.D_E_L_E_T_ = '' "
	ElseIf cTipo = "3"
		cSQL += ",SUM(CASE WHEN NKG_TIPRET <> '1' THEN NKG_QTDRET END) QUEBRATEC "
		cSQL += ",SUM(CASE WHEN NKG_TIPRET  = '1' THEN NKG_QTDRET END) RETENCAO "
		cSQL += "FROM "+RetSqlName("NJR")+" NJR "
		cSQL += "LEFT JOIN "+RetSqlName("NKG")+" NKG ON"		
		cSQL += " NJR.NJR_FILIAL = NKG.NKG_FILIAL AND "		
		cSQL += " (NKG.NKG_STATUS = '0' OR NKG.NKG_STATUS = '1' OR NKG.NKG_STATUS = '4') AND NKG.NKG_QTDRET > 0 " 
		cSQL += " AND NJR.NJR_CODCTR = NKG.NKG_CODCTR AND NKG.D_E_L_E_T_ = ' ' "
	Else
		cSQL += "FROM "+RetSqlName("NJR")+" NJR "	
	EndIf

	cSQL += "WHERE "
	cSQL += " NJR.NJR_FILIAL >= '"+MV_PAR01+"' AND NJR.NJR_FILIAL <= '"+MV_PAR02+"' AND NJR.NJR_TIPO = '"+cTipo+"'"
	cSQL += " AND NJR.NJR_CODENT >= '"+MV_PAR03+"' AND NJR.NJR_CODENT <= '"+MV_PAR05+"'"
	cSQL += " AND NJR.NJR_LOJENT >= '"+MV_PAR04+"' AND NJR.NJR_LOJENT <= '"+MV_PAR06+"'"
	cSQL += " AND NJR.NJR_CODSAF >= '"+MV_PAR07+"' AND NJR.NJR_CODSAF <= '"+MV_PAR08+"'"
	cSQL += " AND NJR.NJR_CODPRO >= '"+MV_PAR09+"' AND NJR.NJR_CODPRO <= '"+MV_PAR10+"'"
	cSQL += " AND NJR.D_E_L_E_T_ = '' "
	cSQL += "GROUP BY NJR.NJR_FILIAL,NJR.NJR_CODPRO,NJR.NJR_CODENT,NJR.NJR_LOJENT,NJR.NJR_CODCTR,NJR.NJR_CODSAF,"
	cSQL += "NJR.NJR_UM1PRO,NJR.NJR_QTDCTR,NJR.NJR_QTEFIS,NJR.NJR_QTSFIS,NJR.NJR_QTEFCO,NJR.NJR_QTSFCO,NJR.NJR_QTDRES"

	cSQL := ChangeQuery(cSQL)
	DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSQL),cAliasQry,.F.,.T.)

	ARGSETIFARQUI(cAliasQry)
	While !Eof()
		DbSelectArea(cAlt1)
		Reclock(cAlt1, .T.)
		(cAlt1)->NJR_FILIAL := (cAliasQry)->NJR_FILIAL
		(cAlt1)->NJR_CODPRO := (cAliasQry)->NJR_CODPRO
		(cAlt1)->NJR_CODENT := (cAliasQry)->NJR_CODENT
		(cAlt1)->NJR_LOJENT := (cAliasQry)->NJR_LOJENT	
		(cAlt1)->NJR_CODCTR := (cAliasQry)->NJR_CODCTR
		(cAlt1)->NJR_CODSAF := (cAliasQry)->NJR_CODSAF
		(cAlt1)->NJR_UM1PRO := (cAliasQry)->NJR_UM1PRO
		(cAlt1)->NJR_QTDCTR := (cAliasQry)->NJR_QTDCTR
		(cAlt1)->NJR_QTEFIS := (cAliasQry)->NJR_QTEFIS
		(cAlt1)->NJR_QTSFIS := (cAliasQry)->NJR_QTSFIS
		(cAlt1)->NJR_QTEFCO := (cAliasQry)->NJR_QTEFCO
		(cAlt1)->NJR_QTSFCO := (cAliasQry)->NJR_QTSFCO
		(cAlt1)->NJR_QTDRES := (cAliasQry)->NJR_QTDRES

		If	cTipo $ "1|3"
			(cAlt1)->SLDFISCAL	:=	(cAliasQry)->NJR_QTEFIS	- (cAliasQry)->NJR_QTSFIS
			(cAlt1)->SALDOFICO	:=	(cAliasQry)->NJR_QTEFCO	- (cAliasQry)->NJR_QTSFCO
		ElseIf cTipo $ "2|4"	
			(cAlt1)->SLDFISCAL	:=	(cAliasQry)->NJR_QTSFIS	- (cAliasQry)->NJR_QTEFIS	 
			(cAlt1)->SALDOFICO	:=	(cAliasQry)->NJR_QTSFCO	- (cAliasQry)->NJR_QTEFCO
		EndiF	
		If cTipo = "3"
			(cAlt1)->QUEBRATEC := (cAliasQry)->QUEBRATEC  
			(cAlt1)->RETENCAO  := (cAliasQry)->RETENCAO   
			(cAlt1)->DISPONIVE	 := (cAlt1)->SALDOFICO -((cAlt1)->NJR_QTDRES+(cAlt1)->QUEBRATEC+(cAlt1)->RETENCAO)
		ElseIf cTipo $ "1|4"
			(cAlt1)->DISPONIVE	 := (cAlt1)->SALDOFICO - (cAlt1)->NJR_QTDRES
		ElseIf cTipo = "2"
			(cAlt1)->DISPONIVE	 := (cAlt1)->NJR_QTDCTR - ((cAlt1)->NJR_QTSFCO + (cAlt1)->NJR_QTEFCO) - (cAlt1)->NJR_QTDRES //Qt.Contrato-Qt. Saida fisica + qt. Entrada fisica - Qt. Reservado
		EndIf

		If	cTipo $ "1|2"
			(cAlt1)->QTDFIXA	:= (cAliasQry)->QTDFIXA
			(cAlt1)->QTDAFIXA	:=	(cAlt1)->NJR_QTDCTR	- (cAliasQry)->QTDFIXA		
		EndIf
		(cAlt1)->DIFFISCAL	:= (cAlt1)->SALDOFICO - (cAlt1)->SLDFISCAL
		MsUnlock()
		AGRDBSELSKIP(cAliasQry)
	End

	nPag	:= 1
	nPaR	:= 1  
	oReport:SetPageNumber(nPag)
	oReport:Page(nPag)

	oS1:Init()
	ARGSETIFARQUI(cAlt1)
	While !Eof()
		// Entidade 
		If !lPlanilha .And. lPrim
			U_OGRSALDOCAB(oReport)
			lPrim := .f.
		EndIf

		cCodEnt := (cAlt1)->NJR_CODENT
		cLojEnt := (cAlt1)->NJR_LOJENT
		aTotEnd := {}
		While !Eof() .And. (cAlt1)->NJR_CODENT = cCodEnt
			aQProd := {}
			cLoja  := (cAlt1)->NJR_LOJENT
			cProd  := (cAlt1)->NJR_CODPRO

			nPosQP := Ascan(aQProd,{|x| x[1] == cProd})
			If nPosQP = 0
				Aadd(aQProd,{cProd,0,0,0,0,0,0,0,0,0,0,0,0})
				nPosQP := Len(aQProd)
			EndIf

			If !lPlanilha	
				If oReport:opage:npage <> nPaR
					nPar := oReport:opage:npage
					U_OGRSALDOCAB(oReport)
				EndIf
				oReport:PrintText(STR0037+"..:"+" "+Alltrim(cCodEnt)+" - "+Alltrim(Posicione("NJ0",1,xFilial("NJ0")+cCodEnt+cLoja,"NJ0_NOME"))+"   "+;
				STR0041+"..: "+Alltrim(NJ0->NJ0_INSCR)+"   "+STR0039+"..: "+Alltrim(cProd)+" - "+Posicione("SB1",1,xFilial("SB1")+cProd,"B1_DESC"))
			EndIf

			While !Eof() .And. (cAlt1)->NJR_CODENT = cCodEnt .And. (cAlt1)->NJR_CODPRO = cProd .And. (cAlt1)->NJR_LOJENT = cLoja

				If !lPlanilha	
					oReport:SkipLine()
					If oReport:opage:npage <> nPaR
						nPar := oReport:opage:npage
						U_OGRSALDOCAB(oReport)
					EndIf
				EndIf

				nPoE := Ascan(aTotEnd,{|x| x[1] == cProd}) // Total por entidade
				If nPoE = 0
					Aadd(aTotEnd,{cProd,0,0,0,0,0,0,0,0,0,0,0,0})
					nPoE := Len(aTotEnd)
				EndIf

				nInc := Fcount()
				For nx := 1 To nInc
					DbSelectArea(cAlt1)
					cNom := FieldName(nx)
					nPos := Ascan(aCamCol,{|x| x[1] == FieldName(nx)})
					If nPos > 0
						cCa1 := &((cAlt1)+"->"+FieldName(nx))
						//cVal := &(cCa1) 
						oReport:PrintText(If(ValType(cCa1) = 'N',Transform(cCa1,cPict),cCa1),oReport:row(),aCamCol[nPos,2])
						If nPos > 4
							aQProd[nPosQP,nPos-3] += cCa1
							aTotEnd[nPoE,nPos-3] += cCa1
						EndIf
						If !AGRIFSEETRB(cAltT,(cAlt1)->NJR_CODPRO)
							Reclock(cAltT,.T.)
							(cAlTT)->NJR_CODPRO	:= (cAlt1)->NJR_CODPRO 
							(cAlTT)->B1_DESC 		:=  SubStr(Posicione("SB1",1,xFilial("SB1")+(cAlt1)->NJR_CODPRO,"B1_DESC"),1,23) 
						ElseIf nPos > 4
							Reclock(cAltT,.f.)
							cCaT  := (cAltT)+"->"+cNom 
							&cCaT += cCa1 
						EndIf
						MsUnlock()
					EndIf
				Next nx

				If lPlanilha	
					oS1:PrintLine()
				EnDif
				AGRDBSELSKIP(cAlt1)
			End

			If !lPlanilha	
				If oReport:opage:npage <> nPaR
					nPar := oReport:opage:npage
					U_OGRSALDOCAB(oReport)
				EndIf
				oReport:SkipLine()
				
				For nx := 1 To If(cTipo = "4",10,12)
					oReport:PrintText("________________",oReport:row(),aCamCol[nx+4,2]+80)
				Next nx

				For nx := 1 To Len(aQProd)
					If oReport:opage:npage <> nPaR
						nPar := oReport:opage:npage
						U_OGRSALDOCAB(oReport)
					EndIf
					oReport:SkipLine()
					For ny := 1 To If(cTipo = "4",Len(aQProd[nx])-2,Len(aQProd[nx]))
						If ny <> 1
							oReport:PrintText(Transform(aQProd[nx,ny],cPict),oReport:row(),aCamCol[ny+3,2])
						EndIf	
					Next ny
				Next nx
				oReport:SkipLine()
				oReport:SkipLine()
			EndIf	
			aQProd := {}
			DbSelectArea(cAlt1)
		End
		// Totais da entidade
		If !lPlanilha	
			If oReport:opage:npage <> nPaR
				nPar := oReport:opage:npage
				U_OGRSALDOCAB(oReport)
			EndIf
			oReport:SkipLine()
			oReport:PrintText(STR0055+"  "+Alltrim(cCodEnt)+" - "+Alltrim(Posicione("NJ0",1,xFilial("NJ0")+cCodEnt+cLojEnt,"NJ0_NOME")),oReport:row(),10)
			oReport:PrintText(STR0055+"  "+Alltrim(cCodEnt)+" - "+Alltrim(Posicione("NJ0",1,xFilial("NJ0")+cCodEnt+cLojEnt,"NJ0_NOME")),oReport:row(),10)

			For nx := 1 To Len(aTotEnd)
				If oReport:opage:npage <> nPaR
					nPar := oReport:opage:npage
					U_OGRSALDOCAB(oReport)
				EndIf
				oReport:SkipLine()
				For ny := 1 To If(cTipo = "4",Len(aTotEnd[nx])-2,Len(aTotEnd[nx]))
					If ny = 1
						oReport:PrintText(Alltrim(aTotEnd[nx,ny])+" "+Posicione("SB1",1,xFilial("SB1")+aTotEnd[nx,ny],"B1_DESC"),oReport:row(),10)
					Else
						oReport:PrintText(Transform(aTotEnd[nx,ny],cPict),oReport:row(),aCamCol[ny+3,2])
					EndIf	
				Next ny
			Next nx
			oReport:SkipLine()
			oReport:SkipLine()
		EndIf
	End

	oS2:Init()
	lPrim := .t.

	ARGSETIFARQUI(cAltT)
	While !Eof()
		If !lPlanilha .And. oReport:opage:npage <> nPaR
			nPar := oReport:opage:npage
			U_OGRSALDOCAB(oReport)
		EndIf
		If !lPlanilha .And. lPrim
			oReport:PrintText(STR0040,oReport:row(),10)
			oReport:PrintText(STR0040,oReport:row(),10)
		EndIf	
		lPrim := .f.	
		oReport:SkipLine() 
		For nx := 1 To Fcount()
			nPos := Ascan(aCamCol,{|x| x[1] == FieldName(nx)})
			If nPos > 0
				nCoX := aCamCol[nPos,2]
			ElseIf nx = 1
				nCox := 10
			ElseIf nx = 2
				nCox := 10+Len(Alltrim((cAltT)->NJR_CODPRO))*10+50
			EndIf      
			cCa1 := &((cAltT)+"->"+FieldName(nx))
			//cVal := &(cCa1)
			oReport:PrintText(If(ValType(cCa1) = 'N',Transform(cCa1,cPict),cCa1),oReport:row(),nCoX)
		Next nx
		If lPlanilha	
			oS2:PrintLine()
		EndIf	
		(cAltT)->(dbSkip())
	End
	oS2:Finish()
	oS1:Finish()
Return

/*                                                                                                 
+=================================================================================================+
| Função    : OGRSALDOPER                                                                         |
| Descrição : Perguntas                                                                           |
| Autor     : Inácio Luiz Kolling                                                                 |
| Data      : 24/03/2016                                                                          | 
+=================================================================================================+    
| Referência: OGR400,OGR500,OGR600,OGR700                                                         | 
+=================================================================================================+                                                                           |  
*/
User Function OGRSALDOPER()
	Local aPergRel :=	{{STR0001,'C',TamSX3("NJR_FILIAL")[1],0,"AGRDECOD('SM0',MV_PAR01,MV_PAR02)" ,'XM0'	,'G','033','',,,,,,,"@!"},;	
                         {STR0002,'C',TamSX3("NJR_FILIAL")[1],0,"AGRATECOD('SM0',MV_PAR01,MV_PAR02)",'XM0'	,'G','033','',,,,,,,"@!","Z"},;
                         {STR0003,'C',TamSX3("NJR_CODENT")[1],0,"AGRDECOD('NJ0',MV_PAR03,MV_PAR05)","NJ0"		,'G','001','',,,,,,,"@!"},;	
                         {STR0004,'C',TamSX3("NJR_LOJENT")[1],0,""                                  ,""   	,'G','002','',,,,,,,"@!"},; 
                         {STR0005,'C',TamSX3("NJR_CODENT")[1],0,"AGRATECOD('NJ0',MV_PAR03,MV_PAR05)","NJ0"	,'G','001','',,,,,,,"@!","Z"},; 
                         {STR0006,'C',TamSX3("NJR_LOJENT")[1],0,""													 ,""		,'G','002','',,,,,,,"@!","Z"},;
                         {STR0007,'C',TamSX3("NJR_CODSAF")[1],0,"AGRDECOD('NJU',MV_PAR07,MV_PAR08)" ,"NJU"	,'G',     ,'',,,,,,,"@!"},;
                         {STR0008,'C',TamSX3("NJR_CODSAF")[1],0,"AGRATECOD('NJU',MV_PAR07,MV_PAR08)","NJU"	,'G',     ,'',,,,,,,"@!","Z"},; 
                         {STR0009,'C',TamSX3("NJR_CODPRO")[1],0,"AGRDECOD('SB1',MV_PAR09,MV_PAR10)" ,"SB1"	,'G','030','',,,,,,,"@!"},;
                         {STR0010,'C',TamSX3("NJR_CODPRO")[1],0,"AGRATECOD('SB1',MV_PAR09,MV_PAR10)","SB1"	,'G','030','',,,,,,,"@!","Z"},; 
                         {STR0011,'N',1 		   	         ,0,  								    ,   	,'C',     ,'',,STR0012,STR0013,STR0014,,,}}
Return aPergRel

/*                                                                                                 
+=================================================================================================+
| Função    : OGRSALDOTRB                                                                         |
| Descrição : Cria arquivo temporário                                                             |
| Autor     : Inácio Luiz Kolling                                                                 |
| Data      : 24/03/2016                                                                          | 
+=================================================================================================+    
| Referência: OGR400,OGR500,OGR600,OGR700                                                         | 
+=================================================================================================+                                                                           |  
*/ 
User Function OGRSALDOTRB(cProg,cTipo)
	Local nTamCp := 16 //tamanho padrão para os campos numericos DE QUANTIDADE
	lOCAL nTamDec := TamSX3("NJR_QTDCTR")[2] //tamano padrão para o campo decimal 
	Local aPicture := AGRGerPic(nTamCp,TamSX3("NJR_QTDCTR")[2]) //gera picture 
	Local cPict := IIF((Len(aPicture) > 2 .and. aPicture[1] == .T.) , aPicture[2], PesqPict("NJR","NJR_QTDCTR"))  
	
	Local vCaF1 := {{"NJR_FILIAL"},{"NJR_CODPRO"},{"NJR_CODENT"},{"NJR_LOJENT"},{"NJR_CODCTR"},{"NJR_CODSAF"},{"NJR_UM1PRO"},;
					{"NJR_QTDCTR" ,"N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTDCTR"))},;
					{"NJR_QTEFIS" ,"N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTEFIS"))},;
					{"NJR_QTSFIS" ,"N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTSFIS"))},;
					{"SLDFISCAL"  ,"N",nTamCp,nTamDec,cPict,STR0015},; 
					{"DIFFISCAL"  ,"N",nTamCp,nTamDec,cPict,STR0016},;
					{"NJR_QTEFCO" ,"N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTEFCO"))},;
					{"NJR_QTSFCO" ,"N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTSFCO"))},; 
					{"SALDOFICO"  ,"N",nTamCp,nTamDec,cPict,STR0017},;
					{"NJR_QTDRES" ,"N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTDRES"))},;
					{"QUEBRATEC"  ,"N",nTamCp,nTamDec,cPict,STR0034},;
					{"RETENCAO"   ,"N",nTamCp,nTamDec,cPict,STR0018},{"DISPONIVE","N",nTamCp,nTamDec,cPict,STR0019},;
					{"QTDFIXA"    ,"N",nTamCp,nTamDec,cPict,STR0047},{"QTDAFIXA" ,"N",nTamCp,nTamDec,cPict,STR0048}}
	Local vCaF2 := {{"NJR_CODPRO"},{"B1_DESC"},{"NJR_QTDCTR","N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTDCTR"))}},nx
	Local vCaES := {{"NJR_QTEFIS" ,"N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTEFIS"))},;
					{"NJR_QTSFIS" ,"N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTSFIS"))}}
	Local vCaSE := {{"NJR_QTSFIS" ,"N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTSFIS"))},;
					{"NJR_QTEFIS" ,"N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTEFIS")) }}
	Local vCaQR := {{"QUEBRATEC"  ,"N",nTamCp,nTamDec,cPict,STR0034},{"RETENCAO" ,"N",nTamCp,nTamDec,cPict,STR0018}}			
	Local vCaMe := {{"SLDFISCAL"  ,"N",nTamCp,nTamDec,cPict,STR0015},{"DIFFISCAL","N",nTamCp,nTamDec,cPict,STR0016},;
					{"NJR_QTEFCO" ,"N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTEFCO"))},;
					{"NJR_QTSFCO" ,"N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTSFCO"))},;
					{"SALDOFICO"  ,"N",nTamCp,nTamDec,cPict,STR0017},{"NJR_QTDRES","N",nTamCp,nTamDec,cPict,Alltrim( RetTitle("NJR_QTDRES"))}}
	Local vCaFi := 	{{"QTDFIXA"   ,"N",nTamCp,nTamDec,cPict,STR0047},{"QTDAFIXA","N",nTamCp,nTamDec,cPict,STR0048}}

	If cTipo $ "1|3"
		For nx := 1 To Len(vCaES)
			Aadd(vCaF2,vCaES[nx])
		Next nx  
	ElseIf cTipo $ "2|4"
		For nx := 1 To Len(vCaSE)
			Aadd(vCaF2,vCaSE[nx])
		Next nx 
	EndIf

	For nx := 1 To Len(vCaMe)
		Aadd(vCaF2,vCaMe[nx])
	Next nx  

	If cTipo = "3"
		For nx := 1 To Len(vCaQR)
			Aadd(vCaF2,vCaQR[nx])
		Next nx 
	ElseIf cTipo $ "1|2"
		For nx := 1 To Len(vCaFi)
			Aadd(vCaF2,vCaFi[nx])
		Next nx 
	EndIf
	Aadd(vCaF2,{"DISPONIVE","N",nTamCp,nTamDec,cPict,STR0034})							

	vRetR := AGRCRIATRB(,vCaF1,{"NJR_CODENT+NJR_CODPRO+NJR_LOJENT"},cProg,.T.)
	cNoT1 := vRetR[3]	//INDICE
	cAlT1 := vRetR[4] //ALIAS        
	aAlT1 := vRetR[5]	//ARRAY 		

	vRetT := AGRCRIATRB(,vCaF2,{"NJR_CODPRO"},cProg,.T.)
	cNoTT := vRetT[3]	//INDICE
	cAlTT := vRetT[4] //ALIAS        
	aAlTT := vRetT[5]	//ARRAY 
Return

/*                                                                                                 
+=================================================================================================+
| Função    : OGRSALDOCOL                                                                         |
| Descrição : Cria as colunas                                                                     |
| Autor     : Inácio Luiz Kolling                                                                 |
| Data      : 24/03/2016                                                                          | 
+=================================================================================================+    
*/ 
User Function OGRSALDOCOL(oReport,cTitulo,cTipo)
	Local nTamCp := 16 //tamanho padrão para os campos numericos DE QUANTIDADE
	Local aPicture := AGRGerPic(nTamCp,TamSX3("NJR_QTDCTR")[2])
	Local cPict := IIF((Len(aPicture) > 2 .and. aPicture[1] == .T.) , aPicture[2], PesqPict("NJR","NJR_QTDCTR"))   

	oSection1 := TRSection():New(oReport,cTitulo,cAlT1) 
	TRCell():New(oSection1,"(cAlT1)->NJR_FILIAL"	,,STR0022	,"@!"	 ,TamSX3("NJR_FILIAL")[1]+5) 
	TRCell():New(oSection1,"(cAlT1)->NJR_QTDCTR"	,,STR0023	,"@!"	 ,nTamCp)  
	TRCell():New(oSection1,"(cAlT1)->NJR_CODSAF"	,,STR0024	,"@!"	 ,TamSX3("NJR_CODSAF")[1])   
	TRCell():New(oSection1,"(cAlT1)->NJR_UM1PRO"	,,"UM"		,"@!" ,TamSX3("NJR_UM1PRO")[1]) 
	TRCell():New(oSection1,"(cAlT1)->NJR_QTDCTR"	,,STR0025	,cPict, nTamCp)

	If cTipo $ "1|3"
		TRCell():New(oSection1,"(cAlT1)->NJR_QTEFIS"	,,If(cTipo = "1",STR0042,STR0026)	,cPict,TamSX3("NJR_QTEFIS")[1]) 
		TRCell():New(oSection1,"(cAlT1)->NJR_QTSFIS"	,,If(cTipo = "1",STR0045,STR0027)	,cPict,TamSX3("NJR_QTSFIS")[1]) 
		TRCell():New(oSection1,"(cAlT1)->SLDFISCAL"	,,If(cTipo = "1",STR0042,STR0028)	,cPict,TamSX3("NJR_QTSFIS")[1]) 
		TRCell():New(oSection1,"(cAlT1)->DIFFISCAL"	,,STR0029									 	,cPict,TamSX3("NJR_QTSFIS")[1]) 
		TRCell():New(oSection1,"(cAlT1)->NJR_QTEFCO"	,,If(cTipo = "1",STR0044,STR0030)	,cPict,TamSX3("NJR_QTEFCO")[1])
		TRCell():New(oSection1,"(cAlT1)->NJR_QTSFCO"	,,If(cTipo = "1",STR0046,STR0031)	,cPict,TamSX3("NJR_QTSFCO")[1]) 
		TRCell():New(oSection1,"(cAlT1)->SALDOFICO"	,,If(cTipo = "1",STR0044,STR0032)	,cPict,TamSX3("NJR_QTSFIS")[1]) 
		TRCell():New(oSection1,"(cAlT1)->NJR_QTDRES"	,,STR0033										,cPict,TamSX3("NJR_QTDRES")[1]) 
	ElseIf cTipo $ "2|4"
		TRCell():New(oSection1,"(cAlT1)->NJR_QTSFIS"	,,If(cTipo = "2",STR0045,STR0051)	,cPict,TamSX3("NJR_QTSFIS")[1])
		TRCell():New(oSection1,"(cAlT1)->NJR_QTEFIS"	,,If(cTipo = "2",STR0049,STR0052)	,cPict,TamSX3("NJR_QTEFIS")[1]) 
		TRCell():New(oSection1,"(cAlT1)->SLDFISCAL"	,,If(cTipo = "2",STR0042,STR0028)	,cPict,TamSX3("NJR_QTSFIS")[1]) 
		TRCell():New(oSection1,"(cAlT1)->DIFFISCAL"	,,STR0029										,cPict,TamSX3("NJR_QTSFIS")[1]) 
		TRCell():New(oSection1,"(cAlT1)->NJR_QTSFCO"	,,If(cTipo = "2",STR0046,STR0053)	,cPict,TamSX3("NJR_QTSFCO")[1])
		TRCell():New(oSection1,"(cAlT1)->NJR_QTEFCO"	,,If(cTipo = "2",STR0050,STR0054)	,cPict,TamSX3("NJR_QTEFCO")[1]) 
		TRCell():New(oSection1,"(cAlT1)->SALDOFICO"	,,If(cTipo = "2",STR0044,STR0032)	,cPict,TamSX3("NJR_QTSFIS")[1]) 
		TRCell():New(oSection1,"(cAlT1)->NJR_QTDRES"	,,STR0033										,cPict,TamSX3("NJR_QTDRES")[1])
	EndIf

	If cTipo = "1" 	
		TRCell():New(oSection1,"(cAlT1)->QTDFIXA"		,,STR0047,cPict,TamSX3("NJR_QTSFIS")[1])
		TRCell():New(oSection1,"(cAlT1)->QTDAFIXA"	,,STR0048,cPict,TamSX3("NJR_QTSFIS")[1])
	ElseIf cTipo = "2"	
		TRCell():New(oSection1,"(cAlT1)->QTDFIXA"		,,STR0047,cPict,TamSX3("NJR_QTSFIS")[1])
		TRCell():New(oSection1,"(cAlT1)->QTDAFIXA"	,,STR0048,cPict,TamSX3("NJR_QTSFIS")[1])
	ElseIf cTipo = "3"	
		TRCell():New(oSection1,"(cAlT1)->QUEBRATEC"	,,STR0034,cPict,TamSX3("NJR_QTSFIS")[1])
		TRCell():New(oSection1,"(cAlT1)->RETENCAO"	,,STR0035,cPict,TamSX3("NJR_QTSFIS")[1])
	EndIf
	TRCell():New(oSection1,"(cAlT1)->DISPONIVE"	,,STR0019,cPict,TamSX3("NJR_QTSFIS")[1])

	oSection2 := TRSection():New(oReport,STR0040,cAlTT) 
	TRCell():New(oSection2,"(cAlTT)->NJR_CODPRO"	,,AGRTITULO("NJR_CODPRO")	,"@!" ,TamSX3("B1_COD")[1]) 
	TRCell():New(oSection2,"(cAlTT)->B1_DESC"		,,AGRTITULO("B1_DESC")		,"@!"	 ,TamSX3("B1_DESC")[1])  
	TRCell():New(oSection2,"(cAlTT)->NJR_QTDCTR"	,,STR0025							,cPict,TamSX3("NJR_QTEFIS")[1])

	If cTipo $ "1|3"
		TRCell():New(oSection2,"(cAlTT)->NJR_QTEFIS"	,,If(cTipo = "1",STR0042,STR0026)	,cPict,TamSX3("NJR_QTEFIS")[1]) 
		TRCell():New(oSection2,"(cAlTT)->NJR_QTSFIS"	,,If(cTipo = "1",STR0045,STR0027)	,cPict,TamSX3("NJR_QTSFIS")[1]) 
		TRCell():New(oSection2,"(cAlTT)->SLDFISCAL"	,,If(cTipo = "1",STR0042,STR0028)	,cPict,TamSX3("NJR_QTSFIS")[1]) 
		TRCell():New(oSection2,"(cAlTT)->DIFFISCAL"	,,STR0029										,cPict,TamSX3("NJR_QTSFIS")[1])
		TRCell():New(oSection2,"(cAlTT)->NJR_QTEFCO"	,,If(cTipo = "1",STR0044,STR0030)	,cPict,TamSX3("NJR_QTEFCO")[1])
		TRCell():New(oSection2,"(cAlTT)->NJR_QTSFCO"	,,If(cTipo = "1",STR0046,STR0031)	,cPict,TamSX3("NJR_QTSFCO")[1]) 
		TRCell():New(oSection2,"(cAlTT)->SALDOFICO"	,,If(cTipo = "1",STR0044,	STR0030),cPict,TamSX3("NJR_QTSFIS")[1]) 	
		TRCell():New(oSection2,"(cAlTT)->NJR_QTDRES"	,,STR0033										,cPict,TamSX3("NJR_QTDRES")[1])
	ElseIf cTipo $ "2|4"
		TRCell():New(oSection2,"(cAlTT)->NJR_QTSFIS"	,,If(cTipo = "2",STR0045,STR0051)	,cPict,TamSX3("NJR_QTSFIS")[1])
		TRCell():New(oSection2,"(cAlTT)->NJR_QTEFIS"	,,If(cTipo = "2",STR0049,STR0052)	,cPict,TamSX3("NJR_QTEFIS")[1]) 
		TRCell():New(oSection2,"(cAlTT)->SLDFISCAL"	,,If(cTipo = "2",STR0042,STR0028)	,cPict,TamSX3("NJR_QTSFIS")[1]) 
		TRCell():New(oSection2,"(cAlTT)->DIFFISCAL"	,,STR0029										,cPict,TamSX3("NJR_QTSFIS")[1]) 
		TRCell():New(oSection2,"(cAlTT)->NJR_QTSFCO"	,,If(cTipo = "2",STR0046,STR0053)	,cPict,TamSX3("NJR_QTSFCO")[1])
		TRCell():New(oSection2,"(cAlTT)->NJR_QTEFCO"	,,If(cTipo = "2",STR0050,STR0054)	,cPict,TamSX3("NJR_QTEFCO")[1]) 
		TRCell():New(oSection2,"(cAlTT)->SALDOFICO"	,,If(cTipo = "2",STR0044,STR0032)	,cPict,TamSX3("NJR_QTSFIS")[1]) 
		TRCell():New(oSection2,"(cAlTT)->NJR_QTDRES"	,,STR0033										,cPict,TamSX3("NJR_QTDRES")[1])
	EndIf

	If cTipo = "1"	
		TRCell():New(oSection2,"(cAlTT)->QTDFIXA" 	,,STR0047,cPict,TamSX3("NJR_QTSFIS")[1])
		TRCell():New(oSection2,"(cAlTT)->QTDAFIXA"	,,STR0048,cPict,TamSX3("NJR_QTSFIS")[1]) 
	ElseIf cTipo = "2"	 
		TRCell():New(oSection2,"(cAlTT)->QTDFIXA" 	,,STR0047,cPict,TamSX3("NJR_QTSFIS")[1])
		TRCell():New(oSection2,"(cAlTT)->QTDAFIXA"	,,STR0048,cPict,TamSX3("NJR_QTSFIS")[1])	
	ElseIf cTipo = "3"	 
		TRCell():New(oSection2,"(cAlTT)->QUEBRATEC"	,,STR0034,cPict,TamSX3("NJR_QTSFIS")[1])
		TRCell():New(oSection2,"(cAlTT)->RETENCAO"	,,STR0035,cPict,TamSX3("NJR_QTSFIS")[1])
	EndIf
	TRCell():New(oSection2,"(cAlTT)->DISPONIVE",,STR0019,cPict,TamSX3("NJR_QTSFIS")[1])
Return oReport

/*                                                                                                 
+=================================================================================================+
| Função    : OGRSALDOCAB                                                                         |
| Descrição : Cabeçalho                                                                           |
| Autor     : Inácio Luiz Kolling                                                                 |
| Data      : 24/03/2016                                                                          | 
+=================================================================================================+                                                                           |
*/
User Function OGRSALDOCAB(oReport)	
	Local nx	
	Local cPict := ""	 	
	oReport:SkipLine()
	For nx := 1 To Len(vVetCab)
		nColI := aCamCol[nx,2] 
		If Len(vVetCab[nx]) > 1
			cPict := Alltrim(StrTran(vVetCab[nx,2],"@E",""))             			
			nColI := aCamCol[nx,2]+Int(((Len(cPict)-Len(vVetCab[nx,1])) * 16))
		EndIf
		oReport:PrintText(vVetCab[nx,1],oReport:row(),nColI)
	Next nx
	oReport:PrintText(Replicate("_",1300),oReport:row(),1)
	oReport:SkipLine()
	oReport:SkipLine()
Return
