/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GFEA102.ch"
#INCLUDE "PROTHEUS.CH"

Static __aFilPerm := FwUsrEmp(__cUserID)

// SonarQube - CA1003: Uso não permitido de chamada de API em LOOP
Static s_GFEI20 := SuperGetMV('MV_GFEI20',,'2')

//-------------------------------------------------------------------
/*/{Protheus.doc} GFEA052

Impressão de Romaneios

@author Felipe Mendes
@since 27/08/11
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFEA052()
	Local wnRel      := Nil
	Local cString    := "GWM"
	Local cModelo    := "1"
	Local titulo     := "Emissão de Romaneios de Carga"
	Local NomeProg   := "GFEA052"
	Local Tamanho    := "M"
	Local cFilAntAux := cFilAnt
	
	Private cFilRom    := ""
	Private cRomaneioI := ""
	Private cRomaneioF := ""
	Private cMotor1    := ""
	Private cMotor2    := ""
	Private cPlacaD    := ""
	Private cPlacaT    := ""
	Private cPlacaM    := ""
	Private dDataSaida := CtoD("  /  /    ")
	Private cHoraSaida := ""
	Private cTipoImp   := ""
	Private GFELogImp  := GFEViewProc():New()
	Private aReturn    := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
	
	Default dDtBase   := DDATABASE

	If Type("aPergunta")=="A"
		aPergunta  := NIL
	EndIf

	If Pergunte("GFEA052",.T.) .And. PreparaImp(@wnRel,cString,@titulo,NomeProg,Tamanho,cModelo) .And. !IsBlind()
		RptStatus({|lEnd| U_GFEA052RE(@lEnd,wnRel,cString,Tamanho,NomeProg)},titulo)
	ElseIf IsBlind()
		U_GFEA052RE(,wnRel,cString,Tamanho,NomeProg)
	EndIf

	cFilAnt := cFilAntAux

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} PreparaImp
Preenche as variáveis utilizadas pelo programa e realiza as validações
iniciais antes de proceder com a impressão.

@author  Guilherme A. Metzger
@since   25/10/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function PreparaImp(wnRel,cString,titulo,NomeProg,Tamanho,cModelo)

	cFilRom     := MV_PAR01
	cRomaneioI  := MV_PAR02

	If Len(aPergunta) >= 11
		cRomaneioF := MV_PAR03
		cMotor1    := MV_PAR04
		cMotor2    := MV_PAR05
		cPlacaD    := MV_PAR06
		cPlacaT    := MV_PAR07
		cPlacaM    := MV_PAR08
		dDataSaida := MV_PAR09
		cHoraSaida := MV_PAR10
		cTipoImp   := MV_PAR11
		cModelo    := IIF(Empty(MV_PAR12),"1",cValToChar(MV_PAR12))
	Else
		cMotor1    := MV_PAR03
		cMotor2    := MV_PAR04
		cPlacaD    := MV_PAR05
		cPlacaT    := MV_PAR06
		cPlacaM    := MV_PAR07
		dDataSaida := MV_PAR08
		cHoraSaida := MV_PAR09
		cTipoImp   := MV_PAR10
		cRomaneioF := cRomaneioI
	EndIf

	GWN->(dbSetOrder(1))
	If !GWN->(dbSeek(cFilRom+cRomaneioI))
		Help( ,, 'HELP',, "Romaneio inexistente.", 1, 0,)
		Return .F.
	EndIf

	cTipoImp := cValToChar(cTipoImp)
	
	If cRomaneioI == cRomaneioF
		// Prévia/Reimpressão.
		If cTipoImp == "1"
			//Não permite impressão de romaneio inexiste
			If GWN->GWN_SIT == "4"
				Help( ,, 'HELP',, "Não é permitido imprimir romaneio cancelado.", 1, 0)
				Return .F.
			EndIf
		EndIf
	
		// Oficial.
		If cTipoImp == '2' 
			//Só permite imprimir romaneios Digitados
			If GWN->GWN_SIT != "1"
				Help( ,, 'HELP',, "Só é permitido realizar a impressão oficial para romaneios digitados.", 1, 0)
				Return .F.
			EndIf
		EndIf
	EndIf

	If cModelo == "2"
		GFER067()
		Return .F.
	EndIf

	If !IsBlind()
		wnRel := SetPrint(cString,NomeProg,"",@titulo,"Impressão de Romaneio", "", "",.F.,.F.,.F.,Tamanho,,.F.)

		If nLastkey == 27
			Return .F.
		EndIf

		SetDefault(aReturn,cString)

		If nLastkey == 27
			Return .F.
		EndIf
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} GFEA052FIL

Validação da filial para o Pergunte

@author Israel A. Possoli
@since 19/09/12
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFEA052FIL(cFil)

	If Empty(cFil)
		Help( ,, 'HELP',, "É necessário informar a filial.", 1, 0,)
		Return .F.
	EndIf

	If !ExistCpo("SM0", cEmpAnt+cFil)
		Return .F.
	EndIf

	// A função retorna "@@@@" quando o usuário possui acesso a todas as empresas e filiais do sistema
	If Len(__aFilPerm) > 0 .And. AScan(__aFilPerm,"@@@@") <= 0 .And. AScan(__aFilPerm,AllTrim(cEmpAnt+cFil)) <= 0
		Help( ,, 'HELP',, "Usuário sem permissão de acesso à filial " + cFil + ".", 1, 0)
		Return .F.
	EndIf

	// Deve ser mantido neste ponto porque a cFilAnt é utilizada na apresentação
	// dos romaneios da consulta padrão dos campos "Romaneio de" e "Romaneio até"
	cFilAnt := cFil

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} GFEA052RE

Função que busca os Romaneios

@author Felipe Mendes
@since 27/08/11
@version 1.0
/*/
//-------------------------------------------------------------------
User Function GFEA052RE(lEnd,WnRel,cString,Tamanho,NomeProg)
	Local nCntImpr	 := 0
	Local nCOntGW1	 := 0
	Local nContGWU   := 0
	Local aTotDoc    := {0, 0, 0, 0} // Posição 1=Total Quantidade, Posição 2=Total Valor, Posição 3=Total Volume, Posição 4=Total Peso 
	Local aTotRom    := {0, 0, 0, 0} // Posição 1=Total Quantidade, Posição 2=Total Valor, Posição 3=Total Volume, Posição 4=Total Peso 
	Local nContEnt   := 0
	Local cChave     := ''
	Local lLinha     := 5
	Local TotalRoman := 0
	Local TotRomErro := 0
	Local TotRomEmit := 0
	Local nLinhaTam  := 0
	Local nTamItem   := TamSX3("GW8_ITEM")[1]
	Local nColuna    := 0
	Local aRet		 := {}
	
	// Variável necessária para a rotina do FrameWork
	m_pag := 1
	
	//----------------------------------------------
	// Criacao da tabela temporaria para Romaneios
	//----------------------------------------------
	aROMCampos :=  {{"FILIAL","C",TAMSX3("GWN_FILIAL")[1],0                      },;
	 			 	 {"NRROM" , "C",TAMSX3("GWN_NRROM" )[1],0                      },;
				 	 {"CDTRAN", "C",TAMSX3("GWN_CDTRP" )[1],0                      },; 
				 	 {"NMTRAN", "C",TAMSX3("GWN_DSTRP" )[1],0                      },;
				 	 {"NRENT" , "N",9                      ,0                      },;
				 	 {"NRDC"  , "N",9						    ,0                      },;
				 	 {"NMMOT" , "C",TAMSX3("GWN_NMMTR" )[1],0                      },;
				 	 {"NMMOT2", "C",TAMSX3("GWN_NMMTR2")[1],0                      },;
				 	 {"PLACAD", "C",TAMSX3("GWN_PLACAD")[1],0                      },;
				 	 {"PLACAT", "C",TAMSX3("GWN_PLACAT")[1],0                      },;
				 	 {"PLACAM", "C",TAMSX3("GWN_PLACAM")[1],0                      },;
				 	 {"VPVAL" , "N",TAMSX3("GWN_VPVAL" )[1],TAMSX3("GWN_VPVAL")[2] },;
				 	 {"VPNUM" , "C",TAMSX3("GWN_VPNUM" )[1],0                      },;
				 	 {"VPNMOP", "C",TAMSX3("GWN_VPNMOP")[1],0                      }}   
			                                 
	cROMAlias := GFECriaTab({aROMCampos,{"FILIAL+NRROM"}}) 
	       
	//----------------------------------------------
	// Criacao da tabela temporaria para Doc Cargas
	//----------------------------------------------
	aDOCCampos :=  {{"FILIAL" ,"C",TAMSX3("GWN_FILIAL")[1],0},;
	                {"NRROM"   ,"C",TAMSX3("GWN_NRROM" )[1],0                     },;
	                {"CDDEST"  ,"C",TAMSX3("GW1_CDDEST")[1],0                     },;
	                {"NMDEST"  ,"C",TAMSX3("GW1_NMDEST")[1],0                     },;
	                {"ENTEND"  ,"C",TAMSX3("GW1_ENTEND")[1],0                     },;
	                {"ENTBAI"  ,"C",TAMSX3("GW1_ENTBAI")[1],0                     },;
	                {"ENTCID"  ,"C",TAMSX3("GW1_ENTCID")[1],0                     },;
	                {"ENTUF"   ,"C",TAMSX3("GW1_ENTUF" )[1],0                     },;
	                {"CDESP"   ,"C",TAMSX3("GW1_DSESP" )[1],0                     },;
	                {"DTPREV"  ,"D",TAMSX3("GW1_DTPENT")[1],0                     },;
	                {"QTVOL"   ,"N",TAMSX3("GW1_QTVOL" )[1],TAMSX3("GW1_QTVOL")[2]},;
	                {"QTVLTOT" ,"N",TAMSX3("GW1_QTVOL" )[1],TAMSX3("GW1_QTVOL")[2]},;
	                {"HRPREV"  ,"C",5                      ,0                     }}

	cDOCAlias := GFECriaTab({aDOCCampos,{"FILIAL+NRROM+CDDEST+ENTEND"}})

	//----------------------------------------------
	// Criacao da tabela temporaria para Itens do Doc
	//----------------------------------------------
	aITCampos := {{"FILIAL"  ,"C",TAMSX3("GWN_FILIAL")[1],0                      },;
	              {"NRROM"   ,"C",TAMSX3("GWN_NRROM" )[1],0                      },;
	              {"CDDEST"  ,"C",TAMSX3("GW1_CDDEST")[1],0                      },;
	              {"ENTEND"  ,"C",TAMSX3("GW1_ENTEND")[1],0                      },;
	              {"SERIE"   ,"C",TAMSX3("GW1_SERDC" )[1],0                      },;
	              {"NRDOC"   ,"C",TAMSX3("GW1_NRDC"  )[1],0                      },;
	              {"NRSEQ"   ,"C",TAMSX3("GW8_SEQ"   )[1],0                      },;
	              {"ITEM"    ,"C",TAMSX3("GW8_ITEM"  )[1],0                      },;
	              {"DSITEM"  ,"C",TAMSX3("GW8_DSITEM")[1],0                      },;
	              {"QUANT"   ,"N",TAMSX3("GW8_QTDE"  )[1],TAMSX3("GW8_QTDE"  )[2]},;
	              {"VALOR"   ,"N",TAMSX3("GW8_VALOR" )[1],TAMSX3("GW8_VALOR" )[2]},;
	              {"PESO"    ,"N",TAMSX3("GW8_PESOR" )[1],TAMSX3("GW8_PESOR" )[2]},;
	              {"VOLUME"  ,"N",TAMSX3("GW8_VOLUME")[1],TAMSX3("GW8_VOLUME")[2]}}
	
	cITAlias := GFECriaTab({aITCampos,{"FILIAL+NRROM+CDDEST+ENTEND+NRSEQ"}})
	//---------------------------------------------------------------------------------------------	  		
	
	dbSelectArea("GWN")
	GWN->( dbSetOrder(1) )
	If !IsBlind()
		SetRegua(LastRec())
	EndIf
	GWN->( dbSeek(cFilRom+cRomaneioI) ) 
	
	While !GWN->(Eof()) .And. GWN->GWN_FILIAL == cFilRom .And. (GWN->GWN_NRROM == cRomaneioI .Or. GWN->GWN_NRROM >= cRomaneioI .And. GWN->GWN_NRROM <= cRomaneioF)	
		
		TotalRoman++
		
		If cTipoImp == '1' .And. GWN->GWN_SIT == "4"
			GFELogImp:AddErro(Replicate("-", 50))
			GFELogImp:AddErro("Romaneio: " + GWN->GWN_NRROM +", Filial: " + GWN->GWN_FILIAL  )
			GFELogImp:AddErro(Space(4)+"Motivo: Não é permitido imprimir romaneio cancelado.")
			GFELogImp:AddErro("")
			GWN->( dbSkip() )
			TotRomErro++
			Loop
		ElseIf cTipoImp == '2' .And. GWN->GWN_SIT != "1"
			GFELogImp:AddErro(Replicate("-", 50))
			GFELogImp:AddErro("Romaneio: " + GWN->GWN_NRROM +", Filial: " + GWN->GWN_FILIAL  )
			GFELogImp:AddErro(Space(4)+"Motivo: Só é permitido realizar a impressão oficial para romaneios digitados.")
			GFELogImp:AddErro("")
			GWN->( dbSkip() )
			TotRomErro++
			Loop
		EndIf
		
		// Impressão Oficial
		If cTipoImp == '2'		
			aRet := U_GFE52IMPOF(dDataSaida,cHoraSaida,cMotor1,cMotor2,cPlacaD,cPlacaT,cPlacaM)
			If aRet[1] == .F.
				GFELogImp:AddErro(Replicate("-", 50))
				GFELogImp:AddErro("Romaneio: " + GWN->GWN_NRROM + ", Filial: " + GWN->GWN_FILIAL  )
				GFELogImp:AddErro(Space(4) + "Motivo: " + aRet[2])
				GFELogImp:AddErro("")
				GWN->(dbSkip())
				TotRomErro++
				Loop
			EndIf			
		EndIf

		PrevEntreg(GWN->GWN_FILIAL, GWN->GWN_NRROM, dDataSaida, cHoraSaida)
		RecLock((cROMAlias),.T.)
			(cROMAlias)->FILIAL  := GWN->GWN_FILIAL
			(cROMAlias)->NRROM   := GWN->GWN_NRROM
			(cROMAlias)->CDTRAN  := GWN->GWN_CDTRP
			(cROMAlias)->NMTRAN  := POSICIONE("GU3",1,xFilial("GU3")+GWN->GWN_CDTRP,"GU3_NMEMIT")
			(cROMAlias)->NMMOT   := POSICIONE("GUU",1,xFilial("GUU")+Iif(!Empty(cMotor1),cMotor1,GWN->GWN_CDMTR ),"GUU_NMMTR")
			(cROMAlias)->NMMOT2  := POSICIONE("GUU",1,xFilial("GUU")+Iif(!Empty(cMotor2),cMotor2,GWN->GWN_CDMTR2),"GUU_NMMTR")
			(cROMAlias)->PLACAD  := Iif(!Empty(cPlacaD),cPlacaD,GWN->GWN_PLACAD)
			(cROMAlias)->PLACAT  := Iif(!Empty(cPlacaT),cPlacaT,GWN->GWN_PLACAT)
			(cROMAlias)->PLACAM  := Iif(!Empty(cPlacaM),cPlacaM,GWN->GWN_PLACAM)
			(cROMAlias)->VPVAL   := GWN->GWN_VPVAL
			(cROMAlias)->VPNUM   := GWN->GWN_VPNUM
			(cROMAlias)->VPNMOP  := POSICIONE("GU3",1,XFILIAL("GU3")+GWN->GWN_VPCDOP,"GU3_NMEMIT")
		MsUnlock(cROMAlias)
		  
	    nContGW1 := 0
		dbSelectArea("GW1")
	  	GW1->( dbSetOrder(9) )
	  	GW1->( dbSeek(xFilial("GW1")+GWN->GWN_NRROM) ) 
	  	While !GW1->(Eof()) .And. xFilial("GW1") + GWN->GWN_NRROM == GW1->GW1_FILIAL + GW1->GW1_NRROM
			
			nContGWU := 0 
		  	
		  	dbSelectArea("GWU")
			GWU->( dbSetOrder(1) )
		 	GWU->( dbSeek(xFilial("GWU")+GW1->GW1_CDTPDC+GW1->GW1_EMISDC+GW1->GW1_SERDC+GW1->GW1_NRDC) ) //GWU_FILIAL+GWU_CDTPDC+GWU_EMISDC+GWU_SERDC+GWU_NRDC+GWU_SEQ
		  	While !GWU->(Eof()) .And. xFilial("GWU")+GW1->GW1_CDTPDC+GW1->GW1_EMISDC+GW1->GW1_SERDC+GW1->GW1_NRDC == GWU->GWU_FILIAL+GWU->GWU_CDTPDC+GWU->GWU_EMISDC+GWU->GWU_SERDC+GWU->GWU_NRDC
				nContGWU++
				GWU->( dbSkip() )
			EndDo
	
			If nContGWU > 1
				GWU->( dbSetOrder(1) )
				GWU->( dbSeek(xFilial("GWU")+GW1->GW1_CDTPDC+GW1->GW1_EMISDC+GW1->GW1_SERDC+GW1->GW1_NRDC) ) //GWU_FILIAL+GWU_CDTPDC+GWU_EMISDC+GWU_SERDC+GWU_NRDC+GWU_SEQ
			  	GWU->( dbSkip() ) //pegando o segundo registro
		  	        
				dbSelectArea("GU3")
				GU3->( dbSetOrder(1) )
				If GU3->( dbSeek(xFilial("GU3")+GWU->GWU_CDTRP) )
					RecLock((cDOCAlias),.T.)  
						(cDOCAlias)->FILIAL := GWN->GWN_FILIAL 
					 	(cDOCAlias)->NRROM  := GWN->GWN_NRROM 
					 	(cDOCAlias)->CDDEST := GU3->GU3_CDEMIT 
					 	(cDOCAlias)->NMDEST := GU3->GU3_NMEMIT
					 	(cDOCAlias)->ENTEND := GU3->GU3_ENDER
					 	(cDOCAlias)->ENTBAI := GU3->GU3_BAIRRO
					 	(cDOCAlias)->ENTCID := POSICIONE("GU7",1,XFILIAL("GU7")+GU3->GU3_NRCID,"GU7_NMCID")
					 	(cDOCAlias)->ENTUF  := POSICIONE("GU7",1,XFILIAL("GU7")+GU3->GU3_NRCID,"GU7_CDUF")
					 	(cDOCAlias)->QTVOL  := GW1->GW1_QTVOL   
					 	(cDOCAlias)->CDESP  := GW1->GW1_DSESP
					 	(cDOCAlias)->DTPREV := dDataSaida
					 	(cDOCAlias)->HRPREV := cHoraSaida

				 	MsUnLock(cDOCAlias)
					 	
				    GFEA052IT( GW1->GW1_CDTPDC+GW1->GW1_EMISDC+GW1->GW1_SERDC+GW1->GW1_NRDC ,GWN->GWN_FILIAL , GWN->GWN_NRROM , GU3->GU3_CDEMIT , GU3->GU3_ENDER )		 
				EndIf
			ElseIf !Empty(GW1->GW1_ENTEND) .Or. !Empty(GW1->GW1_ENTBAI) .Or. !Empty(GW1->GW1_ENTNRC)
				RecLock((cDOCAlias),.T.)  
					(cDOCAlias)->FILIAL := GWN->GWN_FILIAL 
				 	(cDOCAlias)->NRROM  := GWN->GWN_NRROM 
				 	(cDOCAlias)->CDDEST := GW1->GW1_CDDEST
					(cDOCAlias)->NMDEST := POSICIONE("GU3",1,XFILIAL("GU3")+GW1->GW1_CDDEST,"GU3_NMEMIT")
				 	(cDOCAlias)->ENTEND := GW1->GW1_ENTEND
				 	(cDOCAlias)->ENTBAI := GW1->GW1_ENTBAI
				 	(cDOCAlias)->ENTCID := POSICIONE("GU7",1,XFILIAL("GU7")+GW1->GW1_ENTNRC,"GU7_NMCID")
				 	(cDOCAlias)->ENTUF  := POSICIONE("GU7",1,XFILIAL("GU7")+GW1->GW1_ENTNRC,"GU7_CDUF")
				 	(cDOCAlias)->QTVOL  := GW1->GW1_QTVOL
				 	(cDOCAlias)->CDESP  := GW1->GW1_DSESP
					(cDOCAlias)->DTPREV := dDataSaida
					(cDOCAlias)->HRPREV := cHoraSaida				 	
			 	MsUnLock(cDOCAlias)
				 	 
			 	GFEA052IT( GW1->GW1_CDTPDC+GW1->GW1_EMISDC+GW1->GW1_SERDC+GW1->GW1_NRDC,GWN->GWN_FILIAL , GWN->GWN_NRROM , GW1->GW1_CDDEST , GW1->GW1_ENTEND )  
			Else
	          dbSelectArea("GU3")
	          GU3->(  dbSetOrder(1))
	          If GU3->( dbSeek(xFilial("GU3")+GW1->GW1_CDDEST) )
					RecLock((cDOCAlias),.T.)  
						(cDOCAlias)->FILIAL := GWN->GWN_FILIAL 
					 	(cDOCAlias)->NRROM  := GWN->GWN_NRROM 
 					 	(cDOCAlias)->CDDEST := GW1->GW1_CDDEST
					 	(cDOCAlias)->NMDEST := POSICIONE("GU3",1,XFILIAL("GU3")+GW1->GW1_CDDEST,"GU3_NMEMIT")
					 	(cDOCAlias)->ENTEND := GU3->GU3_ENDER
					 	(cDOCAlias)->ENTBAI := GU3->GU3_BAIRRO
					 	(cDOCAlias)->ENTCID := POSICIONE("GU7",1,XFILIAL("GU7")+GU3->GU3_NRCID,"GU7_NMCID")
					 	(cDOCAlias)->ENTUF  := POSICIONE("GU7",1,XFILIAL("GU7")+GU3->GU3_NRCID,"GU7_CDUF")
					 	(cDOCAlias)->QTVOL  := GW1->GW1_QTVOL  
					 	(cDOCAlias)->CDESP  := GW1->GW1_DSESP
					 	(cDOCAlias)->DTPREV := dDataSaida
					 	(cDOCAlias)->HRPREV := cHoraSaida					 	
					 MsUnLock(cDOCAlias)
				EndIf
					
			 	GFEA052IT( GW1->GW1_CDTPDC+GW1->GW1_EMISDC+GW1->GW1_SERDC+GW1->GW1_NRDC ,GWN->GWN_FILIAL , GWN->GWN_NRROM , GW1->GW1_CDDEST , GU3->GU3_ENDER )
				 	
		    EndIf 
			
		  	nContGW1++
			GW1->( dbSkip() )
		EndDo
 			
 		RecLock((cROMAlias),.F.)
			(cROMAlias)->NRDC	:= nContGW1
		MsUnLock(cROMAlias)	
		
		TotRomEmit++
		
		
		GWN->( dbSkip() )
	EndDo        
	
	/***/
	dbSelectArea(cROMAlias)
	(cROMAlias)->( dbSetOrder(1) )
	(cROMAlias)->( dbgotop() )
	While !(cROMAlias)->( Eof() )
  		(cDOCAlias)->( dbSetOrder(1) )
		(cDOCAlias)->( dbSeek((cROMAlias)->FILIAL+(cROMAlias)->NRROM) )
		While !(cDOCAlias)->( Eof() ) .And. (cDOCAlias)->FILIAL + (cDOCAlias)->NRROM == (cROMAlias)->FILIAL + (cROMAlias)->NRROM  
			If cChave != (cDOCAlias)->FILIAL+(cDOCAlias)->NRROM+(cDOCAlias)->CDDEST+(cDOCAlias)->ENTEND
				nContEnt++
			EndIf
			cChave := (cDOCAlias)->FILIAL+(cDOCAlias)->NRROM+(cDOCAlias)->CDDEST+(cDOCAlias)->ENTEND
			(cDOCAlias)->( dbSkip() )
	    EndDo
	    
 		
    	RecLock((cROMAlias),.F.)
			(cROMAlias)->NRENT	:= nContEnt
		MsUnLock(cROMAlias)	
		(cROMAlias)->( dbSkip() )
	EndDo 
	cChave := ''  
	/***/
	
	(cROMAlias)->( dbSetOrder(1) )
	(cROMAlias)->( dbgotop() )
	While !(cROMAlias)->( Eof() )

		/*Grava o número do contrato e o cabeçalho*/
		// titulo:= oemtoansi("Romaneio") 
		// cabec1:= oemtoansi("Nr: "+GWN->GWN_NRROM) //
		// cabec2:=""   
		
		If !IsBlind()
			IncRegua()
		EndIf
		cabec("Romaneio", "", "", NomeProg, Tamanho, 15)
		lLinha := 5
		
		@ lLinha,0  PSAY PADR("",132,"-")  	
		lLinha++
		nCntImpr++
		nLinhaTam := 5 + TAMSX3("GWN_FILIAL")[1]   
		
		@ lLinha,0  	  PSAY "Filial" 
		@ lLinha,nLinhaTam  	  PSAY "Romaneio" 
		@ lLinha,nLinhaTam+9   PSAY "Transp" 
		@ lLinha,nLinhaTam+24  PSAY "Nome Transp"
		@ lLinha,nLinhaTam+59 PSAY "Nr Entreg"
		@ lLinha,nLinhaTam+69 PSAY "Nr Doctos"

		
		If (cROMAlias)->VPVAL > 0
			@ lLinha,85 PSAY  " Pedágio   " + "Comprov Pedágio  " + "Operadora"
		EndIf   
		
		lLinha++
		@ lLinha,0  PSAY PADL(" ",nLinhaTam,"-")+PADL(" ",9,"-")+PADL(" ",15,"-")+PADL(" ",35,"-")+PADC(" ",19,"-")
		If (cROMAlias)->VPVAL > 0
			@lLinha,86 PSAY  PADL(" ",10,"-") + PADL(" ",17,"-") + PADL(" ",20,"-")
		EndIF
		
		lLinha++
		@ lLinha, 0            PSAY (cROMAlias)->FILIAL Picture PesqPict("GWN","GWN_FILIAL")
		@ lLinha, nLinhaTam    PSAY (cROMAlias)->NRROM  Picture PesqPict("GWN","GWN_NRROM")
		@ lLinha, nLinhaTam+9  PSAY (cROMAlias)->CDTRAN Picture PesqPict("GWN","GWN_CDTRP")
		@ lLinha, nLinhaTam+24 PSAY (cROMAlias)->NMTRAN Picture PesqPict("GWN","GWN_DSTRP")
		@ lLinha, nLinhaTam+59 PSAY PadL((cROMAlias)->NRDC ,10)
		@ lLinha, nLinhaTam+69 PSAY PadL((cROMAlias)->NRENT,10)

		If (cROMAlias)->VPVAL > 0
			@ lLinha,86 PSAY (cROMAlias)->VPVAL  Picture PesqPict("GWN","GWN_VPVAL")
			@ lLinha,96 PSAY (cROMAlias)->VPNUM
			@ lLinha,113 PSAY PADR((cROMAlias)->VPNMOP,21) Picture PesqPict("GWN","GWN_CDTRP")
		EndIf
		lLinha++
		lLinha++
		aTotRom[1] := 0
		aTotRom[2] := 0
		aTotRom[3] := 0
		aTotRom[4] := 0	 
		
		dbSelectArea(cDOCAlias)
		(cDOCAlias)->( dbSetOrder(1) )
		(cDOCAlias)->( dbSeek((cROMAlias)->FILIAL+(cROMAlias)->NRROM) )
		While !(cDOCAlias)->( Eof() ) .And. (cDOCAlias)->FILIAL + (cDOCAlias)->NRROM == (cROMAlias)->FILIAL + (cROMAlias)->NRROM
		
			If lLinha > 73
				@ lLinha,0 PSAY __PrtThinLine()
				cabec("Romaneio", "", "", NomeProg, Tamanho, 15)
				lLinha := 6
			EndIf	    
				
			If cChave != (cDOCAlias)->FILIAL+(cDOCAlias)->NRROM+(cDOCAlias)->CDDEST+(cDOCAlias)->ENTEND
				
				@ lLinha,00  PSAY "Destinatário/Redespachante  "+PADR("Endereço",37)+PADR("Bairro",12)+PADR("Cidade",12)+PADR("UF",4)+PADR("Nr Vols",8)+"Espécie    "+"Previsão de Entrega"
				lLinha++   
				@ lLinha,00  PSAY PADL("  ",28,"-")+PADL(" ",37,"-")+PADL(" ",12,"-")+PADL(" ",12,"-")+PADR("--",4)+PADR("-------",8) + "---------- " + "-------------------"
				lLinha++   
				@ lLinha,00  PSAY SUBSTR((cDOCAlias)->NMDEST, 0, 25)  Picture PesqPict("GW1","GW1_NMDEST")
				@ lLinha,28  PSAY SUBSTR((cDOCAlias)->ENTEND, 0, 35)  Picture PesqPict("GW1","GW1_ENTEND")
				@ lLinha,65  PSAY SUBSTR((cDOCAlias)->ENTBAI, 0, 10)  Picture PesqPict("GW1","GW1_ENTBAI")
				@ lLinha,77  PSAY SUBSTR((cDOCAlias)->ENTCID, 0, 10)  Picture PesqPict("GW1","GW1_ENTCID")
				@ lLinha,89  PSAY (cDOCAlias)->ENTUF  Picture PesqPict("GW1","GW1_ENTUF")
				@ lLinha,93  PSAY PadL(Transform(U_GFE52RETVL((cDOCAlias)->CDDEST,(cDOCAlias)->ENTEND),"99999"),7)
				@ lLinha,101 PSAY (cDOCAlias)->CDESP
				@ lLinha,112 PSAY (cDOCAlias)->DTPREV
				@ lLinha,123 PSAY (cDOCAlias)->HRPREV Picture PesqPict("GW1","GW1_HRSAI")
				
				lLinha++
				lLinha++
				@ lLinha,0   PSAY PADR("Nome Motorista",50) + PADR("Nome Motorista 2",50) + "Placa D. " + "Placa T. " + "Placa M. "  
				lLinha++
				@ lLinha,0   PSAY PADL(" ",50,"-")+PADL(" ",50,"-")+PADL(" ",9,"-")+PADL(" ",9,"-")+PADL(" ",9,"-")  
				lLinha++
				@ lLinha,0   PSAY (cROMAlias)->NMMOT
				@ lLinha,50  PSAY (cROMAlias)->NMMOT2
				@ lLinha,100 PSAY (cROMAlias)->PLACAD
				@ lLinha,109 PSAY (cROMAlias)->PLACAT
				@ lLinha,118 PSAY (cROMAlias)->PLACAM
				
				lLinha++
				lLinha++
				@ lLinha,00  PSAY "Série "       +PADR("Nr Docto",17)+PADR("Item",nTamItem+1)  +PADR("Descrição",48-nTamItem)+PADL("Quantidade",15)+PADL("Valor",14) +PADL("Peso",16)  +PADL("Volume",14)
				lLinha++ 
				@ lLinha,00  PSAY PADL(" ",6,"-")+PADL(" ",17,"-")   +PADL(" ",nTamItem+1,"-") +PADL(" ",48-nTamItem,"-")    +PADL(" ",16,"-")     +PADL(" ",14,"-") +PADL(" ",16,"-") +PADL(" ",14,"-")
				lLinha++ 
				
				aTotDoc[1] := 0 //Total Quantidade
				aTotDoc[2] := 0 //Total Valor
				aTotDoc[3] := 0 //Total Volume
				aTotDoc[4] := 0 //Total Peso

				dbSelectArea(cITAlias)
				(cITAlias)->( dbSetOrder(1) )
				(cITAlias)->( dbSeek((cDOCAlias)->FILIAL+(cDOCAlias)->NRROM+(cDOCAlias)->CDDEST+(cDOCAlias)->ENTEND) )
				
				While !(cITAlias)->(Eof()) 	.And. (cDOCAlias)->FILIAL  == (cITAlias)->FILIAL;
								.And. (cDOCAlias)->NRROM   == (cITAlias)->NRROM ; 
								.And. (cDOCAlias)->CDDEST  == (cITAlias)->CDDEST;
								.And. (cDOCAlias)->ENTEND  == (cITAlias)->ENTEND
					
					nColuna := 0
					@ lLinha,nColuna PSAY PadR(Transform((cITAlias)->SERIE ,PesqPict("GW8","GW8_SERDC" )),5 )
					nColuna += 6
					@ lLinha,nColuna PSAY PadR(Transform((cITAlias)->NRDOC ,PesqPict("GW8","GW8_NRDC"  )),16)
					nColuna += 17
					@ lLinha,nColuna PSAY PadR(Transform((cITAlias)->ITEM  ,PesqPict("GW8","GW8_ITEM"  )),nTamItem)
					nColuna += nTamItem+1
					@ lLinha,nColuna PSAY PadR(Transform((cITAlias)->DSITEM,PesqPict("GW8","GW8_DSITEM")),47-nTamItem)
					nColuna += (48-nTamItem)
					@ lLinha,nColuna PSAY PadL(Transform((cITAlias)->QUANT ,PesqPict("GW8","GW8_QTDE"  )),15)
					nColuna += 16
					@ lLinha,nColuna PSAY PadL(Transform((cITAlias)->VALOR ,PesqPict("GW8","GW8_VALOR" )),13)
					nColuna += 14
					@ lLinha,nColuna PSAY PadL(Transform((cITAlias)->PESO  ,PesqPict("GW8","GW8_PESOR ")),15)
					nColuna += 16
					@ lLinha,nColuna PSAY PadL(Transform((cITAlias)->VOLUME,PesqPict("GW8","GW8_VOLUME")),13)
					lLinha++

					aTotDoc[1] := aTotDoc[1]  + (cITAlias)->QUANT
					aTotDoc[2] := aTotDoc[2]  + (cITAlias)->VALOR
					aTotDoc[3] := aTotDoc[3]  + (cITAlias)->VOLUME
					aTotDoc[4] := aTotDoc[4]  + (cITAlias)->PESO

					If lLinha > 73
						@ lLinha,0 PSAY __PrtThinLine()
						cabec("Romaneio", "", "", NomeProg, Tamanho, 15)
						lLinha := 6
					EndIf

					(cITAlias)->(dbSkip())
				EndDo
				lLinha++
				@ lLinha,56  PSAY PadL("TOTAL ENTREGA", 15)
				@ lLinha,72  PSAY PadL(Transform(aTotDoc[1],PesqPict("GW8","GW8_QTDE"  )),15) //Total Quantidade
				@ lLinha,88  PSAY PadL(Transform(aTotDoc[2],PesqPict("GW8","GW8_VALOR" )),13) //Total Valor
				@ lLinha,102 PSAY PadL(Transform(aTotDoc[4],PesqPict("GW8","GW8_PESOR ")),15) //Total Peso
				@ lLinha,118 PSAY PadL(Transform(aTotDoc[3],PesqPict("GW8","GW8_VOLUME")),13) //Total Volume
				lLinha++
				lLinha++
				
				If lLinha > 73
					@ lLinha,0 PSAY __PrtThinLine()
					cabec("Romaneio", "", "", NomeProg, Tamanho, 15)
					lLinha := 6
				EndIf
				
				aTotRom[1] := aTotDoc[1] + aTotRom[1]
				aTotRom[2] := aTotDoc[2] + aTotRom[2]
				aTotRom[3] := aTotDoc[3] + aTotRom[3]
				aTotRom[4] := aTotDoc[4] + aTotRom[4]
				
			EndIf
			cChave := (cDOCAlias)->FILIAL+(cDOCAlias)->NRROM+(cDOCAlias)->CDDEST+(cDOCAlias)->ENTEND
			
			(cDOCAlias)->(dbSkip())
		EndDo
		
		lLinha++
		@ lLinha,56  PSAY PadL("TOTAL ROMANEIO",15)
		@ lLinha,72  PSAY PadL(Transform(aTotRom[1],PesqPict("GW8","GW8_QTDE"  )),15) //Total Quantidade
		@ lLinha,88  PSAY PadL(Transform(aTotRom[2],PesqPict("GW8","GW8_VALOR" )),13) //Total Valor
		@ lLinha,102 PSAY PadL(Transform(aTotRom[4],PesqPict("GW8","GW8_PESOR ")),15) //Total Volume
		@ lLinha,118 PSAY PadL(Transform(aTotRom[3],PesqPict("GW8","GW8_VOLUME")),13) //Total Peso
		lLinha++
		lLinha++
		
		
		(cROMAlias)->(dbSkip())
	EndDo
	
	//GFELogImp:Add(Replicate("-",50) )
	GFELogImp:Add("Totais:" )
	GFELogImp:Add("")
	GFELogImp:Add("Romaneios Processados : " + cValToChar(TotalRoman))
	GFELogImp:Add("Romaneios Emitidos : " + cValToChar(TotRomEmit))
	GFELogImp:Add("Romaneios com Erros : " + cValToChar(TotRomErro))
	
	If !IsBlind()
		GFELogImp:Show("Emissão de Romaneios")

		Set Device to Screen
	EndIf

		If aReturn[5] = 1
			Set Printer To 
			dbCommitAll()
			OurSpool(wnrel)
		Endif


	MS_FLUSH()

	/*Apaga as tabelas Temporárias utilizadas no programa.*/
	GFEDelTab(cROMAlias)
	GFEDelTab(cDOCAlias)
	GFEDelTab(cITAlias)	
Return  .T.   			

//---------------------------------------------------------------------------------------------------
/*/{Protheus.doc} GFEA052IT()
Cria a tabela temporaria de ITENS
restrito

@sample
GFEA052IT()

@author Felipe M.
@since 23/11/09
@version 1.0
/*///------------------------------------------------------------------------------------------------

Static Function GFEA052It(cSeek,cFil,cRom,cDest,cEnder)  

	dbSelectArea("GW8")
	GW8->( dbSetorder(2) )
	GW8->( dbSeek(xFilial("GW8")+cSeek) ) //GW1->GW1_CDTPDC+GW1->GW1_EMISDC+GW1->GW1_SERDC+GW1->GW1_NRDC 
	While !GW8->(Eof()) .And. xFilial("GW8")+cSeek == GW8->GW8_FILIAL+GW8->GW8_CDTPDC+GW8->GW8_EMISDC+GW8->GW8_SERDC+GW8->GW8_NRDC
		RecLock((cITAlias),.T.)  
			(cITAlias)->FILIAL := cFil
			(cITAlias)->NRROM  := cRom
			(cITAlias)->CDDEST := cDest
			(cITAlias)->ENTEND := cEnder
			(cITAlias)->SERIE  := GW8->GW8_SERDC
			(cITAlias)->NRDOC  := GW8->GW8_NRDC
			(cITAlias)->NRSEQ  := GW8->GW8_SEQ
			(cITAlias)->ITEM   := GW8->GW8_ITEM
			(cITAlias)->DSITEM := GW8->GW8_DSITEM 
			(cITAlias)->QUANT  := GW8->GW8_QTDE
			(cITAlias)->VALOR  := GW8->GW8_VALOR
			(cITAlias)->VOLUME := GW8->GW8_VOLUME
			(cITAlias)->PESO   := GW8->GW8_PESOR
		MsUnLock(cITAlias)	
		
		GW8->(dbSkip())
	EndDo	   

Return NIL              

//---------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_GFEA052VPL()
Valida a Placa dos veiculos do Pergunte
restrito

@sample
U_GFEA052VPL()

@author Hercilio Henning Neto
@since 06/02/2013
@version 1.0
/*///------------------------------------------------------------------------------------------------
User Function GFEA052VPL(cPlacaD, cPlacaT, cPlacaM, cTpPlc, lPerg, cRomaneio)
	Local cPlaca := ""

	If !GFEA50PLC(cPlacaD, cPlacaT, cPlacaM, cTpPlc, lPerg, cRomaneio)		
  		Return .F.
  	EndIf      

	If cTpPlc == "D"
		cDsTp := "dianteira"
		cPlaca := cPlacaD
	ElseIf cTpPlc == "T"
		cDsTp := "traseira"
		cPlaca := cPlacaT
	ElseIf cTpPlc == "M"
		cDsTp := "do meio"
		cPlaca := cPlacaM
	EndIf
	
	dbSelectArea("GWN")
	GWN -> ( dbSetOrder(1) )
	If GWN -> ( dbSeek(xFilial('GWN') + cRomaneio) )
		dbSelectArea("GU8")
		GU8 -> ( dbSetOrder(2) )
		If GU8 -> ( dbSeek(xFilial('GU8') + cPlaca) )
			If GU8->GU8_CDPROP != GWN->GWN_CDTRP .And. !Empty(GU8->GU8_CDPROP)
				Help(,, 'HELP',, StrTran("A placa [cDsTp] do veículo deve ser de propriedade do transportador informado.", "[cDsTp]", cDsTp), 1, 0,)
				Return .F.
			EndIf
		EndIf
	EndIf
			
Return .T.

//---------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_GFE52VLDMT()
Valida ao motorista informado no pergunte
restrito

@sample
U_GFE52VLDMT()

@author Hercilio Henning Neto
@since 06/02/2013
@version 1.0
/*///------------------------------------------------------------------------------------------------
User Function GFE52VLDMT(cCdMtr, cCdMtr2, cNumMt, lPerg, cRomaneio)
	Local cMotora := ""
	
	If !GFEA50RLMT(cCdMtr, cCdMtr2, cNumMt, lPerg)
		Return .F.
	EndIf	
	
	If cNumMt == "1"
		cMotora := cCdMtr
	ElseIf cNumMt == "2"
		cMotora := cCdMtr2
	EndIf
	
	dbSelectArea("GUU")
	GUU -> ( dbSetOrder(1) )
	If GUU -> ( dbSeek(xFilial("GUU")+cMotora) )
		dbSelectArea("GWN")
		GWN -> ( dbSetOrder(1) )
		If GWN -> ( dbSeek(xFilial('GWN') + cRomaneio) )
			If GUU->GUU_CDTRP != GWN->GWN_CDTRP .And. !Empty(GUU->GUU_CDTRP) .And. !Empty(GWN->GWN_CDTRP)
				Help(,, 'HELP',, "O Motorista informado não é da transportadora do Romaneio", 1, 0,)
				Return .F.
			EndIf
		EndIf
	EndIf           
Return .T.

User Function GFE52RETVL(cCdDest,cEntEnd)
	Local nQtVols  := 0
	Local aAreaDoc := (cDOCAlias)->(GetArea())
		
	(cDOCAlias)->( dbSetOrder(1) )
	(cDOCAlias)->( dbSeek((cROMAlias)->FILIAL+(cROMAlias)->NRROM) )
	(cDOCAlias)->(dbGoTop())
	While !(cDOCAlias)->( Eof() ) .AND. (cDOCAlias)->FILIAL == (cROMAlias)->FILIAL .AND. ; 
	(cDOCAlias)->NRROM == (cROMAlias)->NRROM 
		If (cDOCAlias)->CDDEST == cCdDest .AND. (cDOCAlias)->ENTEND == cEntEnd
			nQtVols += (cDOCAlias)->QTVOL
		EndIf
		(cDOCAlias)->(dbSkip())			
	EndDo
			
	RestArea(aAreaDoc)
Return nQtVols

//---------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_GFE52IMPOF()

Realiza gravação dos dados do romaneio, quando for impressão oficial.
Função originada do trecho de código da função GFEA052RE escrita por Felipe Mendes.

@sample
U_GFE52IMPOF()

@author Amanda Rosa Vieira
@since  11/03/2016
@version 1.0
/*///------------------------------------------------------------------------------------------------
User Function GFE52IMPOF(dDataSaida,cHoraSaida,cMotor1,cMotor2,cPlacaD,cPlacaT,cPlacaM)
	Local cMsg
	Local aRet := {.T.,""}
		
	Private _lSemHelp := .F.
	
	// Impressão Oficial
	lSitGW1 := GfeVerCmpo({"GW1_SITFT"})	
	
	If !Empty(dDataSaida) .And. !Empty(cHoraSaida)
		If  dDataSaida > dDtBase
			aRet[1] := .F.
			aRet[2] := "Romaneio não pode ser liberado. Informe uma data menor ou igual a data corrente."
			Return aRet
		EndIf
	
		If !IsInCallStack("GFER067") .And. !GFEA050LIB(.T., @cMsg,dDataSaida,cHoraSaida)
			aRet[1] := .F.
			aRet[2] := cMsg
			Return aRet
		EndIf
			
		RecLock("GWN",.F.)
			GWN->GWN_SIT    := "3" //Liberado
			PrevEntreg(GWN->GWN_FILIAL, GWN->GWN_NRROM, dDataSaida, cHoraSaida)
			GWN->GWN_CDMTR  := Iif(!Empty(cMotor1),cMotor1,GWN->GWN_CDMTR )
			GWN->GWN_CDMTR2 := Iif(!Empty(cMotor2),cMotor2,GWN->GWN_CDMTR2)
			GWN->GWN_PLACAD := Iif(!Empty(cPlacaD),cPlacaD,GWN->GWN_PLACAD)
			GWN->GWN_PLACAT := Iif(!Empty(cPlacaT),cPlacaT,GWN->GWN_PLACAT)
			GWN->GWN_PLACAM := Iif(!Empty(cPlacaM),cPlacaM,GWN->GWN_PLACAM)
			GWN->GWN_DTSAI  := dDataSaida
			GWN->GWN_HRSAI  := Transform(cHoraSaida, '@R 99:99')	
			// Preenche a data de saída dos documentos de carga associados ao romaneio.
		MsUnlock("GWN")
										
		GW1->( dbSetOrder(9) )
		GW1->( dbSeek(xFilial("GW1")+GWN->GWN_NRROM) ) 
		While !GW1->( Eof() ) .And. xFilial("GW1") + GWN->GWN_NRROM == GW1->GW1_FILIAL + GW1->GW1_NRROM
			RecLock("GW1",.F.)
				GW1->GW1_DTSAI  := dDataSaida
				GW1->GW1_HRSAI  := Transform(cHoraSaida, '@R 99:99')
			MsUnlock("GW1")
							
			If lSitGW1
				dbSelectArea("GV5")
				GV5->( dbSetorder(1) )
				If (GV5->( dbSeek(xFilial("GV5")+GW1->GW1_CDTPDC) ) .AND. GV5->GV5_SENTID == '1') .OR. s_GFEI20 != '1'
					RecLock('GW1', .F.)
						GW1->GW1_SITFT := "6"
					GW1->( MsUnLock() )		
				 Else 
					RecLock('GW1', .F.)
						GW1->GW1_SITFT := "2"
					GW1->( MsUnLock() )			    	
				EndIf
			EndIf
			GW1->( dbSkip() )
		EndDo		
	Else	
		RecLock("GWN",.F.)
			GWN->GWN_SIT    := "2"
			GWN->GWN_CDMTR  := Iif(!Empty(cMotor1),cMotor1,GWN->GWN_CDMTR )
			GWN->GWN_CDMTR2 := Iif(!Empty(cMotor2),cMotor2,GWN->GWN_CDMTR2)
			GWN->GWN_PLACAD := Iif(!Empty(cPlacaD),cPlacaD,GWN->GWN_PLACAD)
			GWN->GWN_PLACAT := Iif(!Empty(cPlacaT),cPlacaT,GWN->GWN_PLACAT)
			GWN->GWN_PLACAM := Iif(!Empty(cPlacaM),cPlacaM,GWN->GWN_PLACAM)				
		MsUnlock("GWN")
	EndIf	
				
	aVinc := {}
				
	AAdd(aVinc, {GWN->GWN_CDMTR , "1"})
	AAdd(aVinc, {GWN->GWN_CDMTR2, "1"})
	AAdd(aVinc, {GWN->GWN_PLACAD, "2"})
	AAdd(aVinc, {GWN->GWN_PLACAM, "2"})
	AAdd(aVinc, {GWN->GWN_PLACAT, "2"})
				
	GFEA050VIN(aVinc, GWN->GWN_CDTRP)
Return aRet
