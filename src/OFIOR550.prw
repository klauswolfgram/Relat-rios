/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 05     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "OFIOR550.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ OFIOR550 º Autor ³ Andre Luis Almeida º Data ³  25/04/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao de Vendas por Regiao                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Veiculos/Oficina/Pecas                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/          
User Function OFIOR550()

cDesc1    := STR0001
cDesc2    := ""
cDesc3    := ""
cAlias    := "SF2"
aRegistros:= {}
nLin      := 0
aPag      := 1
nIte      := 1
aReturn   := {STR0002,1,STR0003,2,2,1,"",1}
cTamanho  := "P"           // P/M/G
Limite    := 80            // 80/132/220
aOrdem    := {}           // Ordem do Relatorio
cTitulo   := STR0001
cNomeProg := "OFIOR550"
cNomeRel  := "OFIOR550"
nLastKey  := 0
nCaracter := 15
cabec1    := ""
cabec2    := ""
cPerg     := "OFR550"

cNomeRel:=SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)
If nLastKey == 27
	Return
EndIf     
PERGUNTE(cPerg,.f.)

SetDefault(aReturn,cAlias)
RptStatus( { |lEnd| FS_IMP_OFR550(@lEnd,cNomeRel,cAlias) } , cTitulo )

If aReturn[5] == 1
   OurSpool( cNomeRel )
EndIf

MS_Flush()
Return
           
Static Function FS_IMP_OFR550()
                  
Private cbTxt    := Space(10)
Private cbCont   := 0
Private cString  := "SF2"
Private Li       := 80
Private m_Pag    := 1
Private wnRel    := "OFIOR550"
Private nValTot  := 0
Private aTotal   := {}
Private aTotPref := {}
Private aVetCampos:={}
Private cSA1SETOR:= "XXX"
Private lSA1SETOR:= .f.
Private lA1_IBGE := If(SA1->(FieldPos("A1_IBGE"))#0,.t.,.f.)

Set Printer to &cNomeRel
Set Printer On
Set Device  to Printer

 /////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //        C r i a     A r q u i v o    d e    T r a b a l h o                                              //
 /////////////////////////////////////////////////////////////////////////////////////////////////////////////
   aadd(aVetCampos,{ "VCB_CODREG" , "C" ,  3                                       , 0 })   //  Cod Regiao    
   aadd(aVetCampos,{ "VCB_DESREG" , "C" , 30                                       , 0 })   //  Nome Regia    
   aadd(aVetCampos,{ "VAM_IBGE"   , "C" , 11                                       , 0 })   //  Cod IBGE      
   aadd(aVetCampos,{ "VAM_DESCID" , "C" , 27                                       , 0 })   //  Nome Cidad    
   aadd(aVetCampos,{ "SA1_SETOR"  , "C" ,  3                                       , 0 })   //  Setor Bairro  
   aadd(aVetCampos,{ "F2_PREFORI" , "C" ,  3                                       , 0 })   //  Prefixo Vendas
   aadd(aVetCampos,{ "VV1_ESTVEI" , "C" ,  1                                       , 0 })   //  Veic Novo/Usad
   aadd(aVetCampos,{ "VV1_PROVEI" , "C" ,  1                                       , 0 })   //  Veic Nac/Impor
   aadd(aVetCampos,{ "SA1_NOME"   , "C" , 30                                       , 0 })   //  Nome Cliente  
   aadd(aVetCampos,{ "SA1_CGC"    , "C" , 14                                       , 0 })   //  CGC Cliente   
   aadd(aVetCampos,{ "VAM_DDD"    , "C" ,  2                                       , 0 })   //  DDD Fone      
   aadd(aVetCampos,{ "SA1_TEL"    , "C" , 15                                       , 0 })   //  Fone          
   aadd(aVetCampos,{ "SA3_NOME"   , "C" , 15                                       , 0 })   //  Nome Vendedor 
   aadd(aVetCampos,{ "F2_EMISSAO" , "D" ,  8                                       , 0 })   //  Data Emissao  
   aadd(aVetCampos,{ "F2_DOC"     , "C" , TamSx3("F2_DOC")[1]   , 0 })   //  Numero NF
   aadd(aVetCampos,{ "F2_SERIE"   , "C" , TamSx3("F2_SERIE")[1] , 0 })   //  Serie NF      
   If FieldPos("F2_SDOC") > 0
       aadd(aVetCampos,{ "F2_SDOC"    , "C" , TamSx3("F2_SDOC")[1]   , 0 })   //  Serie Simples NF     
   end
   aadd(aVetCampos,{ "F2_VALBRUT" , "N" , 14                                       , 2 })   //  Valor NF      
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////// 

oObjTempTable := OFDMSTempTable():New()
oObjTempTable:cAlias := "TRB"
oObjTempTable:aVetCampos := aVetCampos
oObjTempTable:AddIndex(, {"VCB_CODREG","VAM_DESCID","SA1_SETOR","F2_PREFORI","VV1_ESTVEI","VV1_PROVEI","SA1_NOME","F2_DOC"} )
oObjTempTable:CreateTable()

cSA1 := "INICIAL"
cVAM := "INICIAL"
cVCB := "INICIAL"
cSA3 := "INICIAL"

// Verifica se existe o campo: SA1->A1_SETOR //
lSA1SETOR := .f.
If SA1->(FieldPos("A1_SETOR")) > 0 
	lSA1SETOR := .t.
Endif

If !Empty(MV_PAR01)
	DbSelectArea("SD2")
	DbSetOrder(5)
	DbSeek( xFilial("SD2") + DTOS(MV_PAR01) , .t. )
	DbSelectArea("SF2")
	DbSetOrder(1)
	DbSeek( xFilial("SF2") + SD2->D2_DOC + SD2->D2_SERIE + SD2->D2_CLIENTE + SD2->D2_LOJA )
Else
	DbSelectArea("SF2")
	DbSetOrder(1)
	DbSeek( xFilial("SF2") )    
EndIf
SetRegua(RecCount())

aAdd(aTotal,{ STR0005 , "" , "" , "" , "" , "" , 0 , 0 , "T" }) //Total das Vendas
aAdd(aTotPref,{ 0 , 0 }) //Total Balcao Pecas
aAdd(aTotPref,{ 0 , 0 }) //Total Oficina Pecas
aAdd(aTotPref,{ 0 , 0 }) //Total Oficina Servicos
aAdd(aTotPref,{ 0 , 0 }) //Total Veiculos Novos
aAdd(aTotPref,{ 0 , 0 }) //Total Veiculos Usados

Do Case
	Case MV_PAR04 == 1
		cPrefix := GetNewPar("MV_PREFBAL","BAL")
		cTitPref:= STR0006
	Case MV_PAR04 == 2
		cPrefix := GetNewPar("MV_PREFOFI","OFI")
		cTitPref:= STR0007
	Case MV_PAR04 == 3
		cPrefix := GetNewPar("MV_PREFVEI","VEI")
		cTitPref:= STR0008
		cVeiNU  := "01"
	Case MV_PAR04 == 4
		cPrefix := GetNewPar("MV_PREFVEI","VEI")
		cTitPref:= STR0009
		cVeiNU  := "0"
	OtherWise
		cPrefix := GetNewPar("MV_PREFBAL","BAL")+"/"+GetNewPar("MV_PREFOFI","OFI")+"/"+GetNewPar("MV_PREFVEI","VEI")
		cTitPref:= STR0010
		cVeiNU  := "01"
EndCase

Do While !Eof() .and. SF2->F2_FILIAL == xFilial("SF2") .and. ( Empty(MV_PAR02) .or. (SF2->F2_EMISSAO<=MV_PAR02) )

	IncRegua()  
   
   If ((!(SF2->F2_PREFORI $ cPrefix)) .or. SF2->F2_TIPO # "N" )
		DbSelectArea("SF2")
		DbSkip()
		Loop
   EndIf

	If !Empty(MV_PAR05) .and. ( SF2->F2_VEND1 # MV_PAR05 )
		DbSelectArea("SF2")
		Dbskip()
		Loop
	EndIf	

	DbSelectArea( "SD2" )
	DbSetOrder(3)
	If !DbSeek( xFilial("SD2") + SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA )
		DbSelectArea("SF2")
		Dbskip()
		Loop
	EndIf	

	DbSelectArea( "SF4" )	
	DbSetOrder(1)
	DbSeek( xFilial("SF4") + SD2->D2_TES )
		    
	If SF4->F4_DUPLIC == "N" .or. Alltrim(SF4->F4_ATUATF) == "S"
		DbSelectArea("SF2")
		Dbskip()
		Loop
	EndIf	
	
	If (SF2->F2_BASEISS == 0 .and. SF4->F4_ESTOQUE # "S")
		DbSelectArea("SF2")
		Dbskip()
		Loop
	EndIf	

	If SF2->F2_PREFORI == GetNewPar("MV_PREFVEI","VEI")
		DbSelectArea( "VV1" )
		DbSetOrder(1)
		DbSeek( xFilial("VV1") + SD2->D2_COD )
		If !(Alltrim(VV1->VV1_ESTVEI) $ cVeiNU )
			DbSelectArea("SF2")
			Dbskip()
			Loop
		EndIf	
	EndIf
	
	If cSA1 # (SF2->F2_CLIENTE + SF2->F2_LOJA)
		cSA1 := (SF2->F2_CLIENTE + SF2->F2_LOJA) 
		DbSelectArea( "SA1" )
		DbSetOrder(1)
		DbSeek( xFilial("SA1") + cSA1 , .F. )
		If lSA1SETOR
			cSA1SETOR := SA1->A1_SETOR
		Else 
			cSA1SETOR := "XXX"
		EndIf
	EndIf

	If lA1_IBGE
		If cVAM # SA1->A1_IBGE
			cVAM := SA1->A1_IBGE 
			DbSelectArea("VAM")
			DbSetOrder(1)
			DbSeek(xFilial("VAM") + cVAM , .F. )
		EndIf
		If !Empty(MV_PAR03) .and. ( VAM->VAM_REGIAO # MV_PAR03 )
			DbSelectArea("SF2")
			Dbskip()
			Loop
		EndIf	
		If cVCB # VAM->VAM_REGIAO
			cVCB := VAM->VAM_REGIAO 
			DbSelectArea( "VCB" )
			DbSetOrder(1)
			DbSeek( xFilial("VCB") + cVCB , .F. )
		EndIf
	EndIf


	If cSA3 # SF2->F2_VEND1
		cSA3 := SF2->F2_VEND1
		DbSelectArea( "SA3" )
		DbSetOrder(1)
		DbSeek( xFilial("SA3") + cSA3 , .F. )
	EndIf
	
	nValTot := 0
  	cESTVEI := "9"
 	cPROVEI := "9"
	Do Case
	   Case SF2->F2_PREFORI == GetNewPar("MV_PREFBAL","BAL")
			   nValTot := SF2->F2_VALBRUT - SF2->F2_BASEISS
			   aTotPref[1,1]++
			   aTotPref[1,2]+=nValTot
   	Case SF2->F2_PREFORI == GetNewPar("MV_PREFOFI","OFI")
			   nValTot := SF2->F2_VALBRUT
			   aTotPref[2,1]++
			   aTotPref[2,2]+=nValTot - SF2->F2_BASEISS
			   aTotPref[3,1]+=nValTot
			   aTotPref[3,2]+=SF2->F2_BASEISS
	   Case SF2->F2_PREFORI == GetNewPar("MV_PREFVEI","VEI")
			   nValTot := SF2->F2_VALBRUT 
		      cESTVEI := Alltrim(VV1->VV1_ESTVEI) //( 0-Novo / 1-Usado )
		      cPROVEI := Alltrim(VV1->VV1_PROVEI) //( 1-Nacional / 2-Importado )
      		If cESTVEI == "0"
					aTotPref[4,1]++
					aTotPref[4,2]+=nValTot
				Else
					aTotPref[5,1]++
					aTotPref[5,2]+=nValTot
				EndIf
		OtherWise
				DbSelectArea("SF2")
				Dbskip()
				Loop
	EndCase


	//    T O T A I S 
	
	aTotal[1,7]++
 	aTotal[1,8]+=nValTot
	nPos := 0
	nPos := aScan(aTotal,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[9] == VCB->VCB_CODREG + space(7) + "R" })
	If nPos == 0 
		aAdd(aTotal,{ VCB->VCB_CODREG , " " , "   " , " " , " " , " " , 1 , nValTot , "R" }) 
	Else
	 	aTotal[nPos,7]++
	 	aTotal[nPos,8]+=nValTot
	EndIf
	
	nPos := 0
	nPos := aScan(aTotal,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[9] == If(lA1_IBGE,VCB->VCB_CODREG+VAM->VAM_IBGE,space(14)) + space(6) + "C" })
	If nPos == 0 
		aAdd(aTotal,{ If(lA1_IBGE,VCB->VCB_CODREG,space(3)) , If(lA1_IBGE,VAM->VAM_IBGE,space(11)) , "   " , " " , " " , " " , 1 , nValTot , "C" })
	Else
	 	aTotal[nPos,7]++
	 	aTotal[nPos,8]+=nValTot
	EndIf
	nPos := 0
	nPos := aScan(aTotal,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[9] == If(lA1_IBGE,VCB->VCB_CODREG+VAM->VAM_IBGE,space(14)) + cSA1SETOR + space(3) + "S" })
	If nPos == 0 
		aAdd(aTotal,{ If(lA1_IBGE,VCB->VCB_CODREG,space(3)) , If(lA1_IBGE,VAM->VAM_IBGE,space(11)) , cSA1SETOR , " " , " " , " " , 1 , nValTot , "S" })
	Else
	 	aTotal[nPos,7]++
	 	aTotal[nPos,8]+=nValTot
	EndIf
	nPos := 0
	nPos := aScan(aTotal,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[9] == If(lA1_IBGE,VCB->VCB_CODREG+VAM->VAM_IBGE,space(14)) + cSA1SETOR + SF2->F2_PREFORI + cESTVEI + space(1) + "P" })
	If nPos == 0 
		aAdd(aTotal,{ If(lA1_IBGE,VCB->VCB_CODREG,space(3)) , If(lA1_IBGE,VAM->VAM_IBGE,space(11)) , cSA1SETOR , SF2->F2_PREFORI , cESTVEI , " " , 1 , nValTot , "P" }) 
	Else
	 	aTotal[nPos,7]++
	 	aTotal[nPos,8]+=nValTot
	EndIf
	If cESTVEI == "0"
	   nPos := 0
		nPos := aScan(aTotal,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[9] == If(lA1_IBGE,VCB->VCB_CODREG+VAM->VAM_IBGE,space(14)) + cSA1SETOR + SF2->F2_PREFORI + cESTVEI + cPROVEI + "V" })
		If nPos == 0 
			aAdd(aTotal,{ If(lA1_IBGE,VCB->VCB_CODREG,space(3)) , If(lA1_IBGE,VAM->VAM_IBGE,space(11)) , cSA1SETOR , SF2->F2_PREFORI , cESTVEI , cPROVEI , 1 , nValTot , "V" })
		Else
		 	aTotal[nPos,7]++
		 	aTotal[nPos,8]+=nValTot
		EndIf
	EndIf
      
	DbSelectArea("TRB")
	RecLock("TRB",.t.)
		If lA1_IBGE
			TRB->VCB_CODREG:= VCB->VCB_CODREG
			TRB->VCB_DESREG:= VCB->VCB_DESREG
			TRB->VAM_IBGE	:= VAM->VAM_IBGE
			TRB->VAM_DESCID:= Alltrim(left(VAM->VAM_DESCID,22))+" - "+VAM->VAM_ESTADO
			TRB->VAM_DDD	:= VAM->VAM_DDD
		Else
			TRB->VCB_CODREG:= space(3)
			TRB->VCB_DESREG:= space(30)
			TRB->VAM_IBGE	:= space(11)
			TRB->VAM_DESCID:= Alltrim(left(SA1->A1_MUN,22))+" - "+SA1->A1_EST
			TRB->VAM_DDD	:= space(4)
		EndIf
		TRB->SA1_SETOR 	:= cSA1SETOR
		TRB->F2_PREFORI	:= SF2->F2_PREFORI
		TRB->VV1_ESTVEI	:= cESTVEI
		TRB->VV1_PROVEI	:= cPROVEI
		TRB->SA1_NOME		:= SA1->A1_NOME
		TRB->SA1_CGC		:= SA1->A1_CGC
		TRB->SA1_TEL		:= SA1->A1_TEL
		TRB->SA3_NOME	   := left(SA3->A3_NOME,15)
		TRB->F2_EMISSAO	:= SF2->F2_EMISSAO
		TRB->F2_DOC			:= SF2->F2_DOC
		TRB->F2_SERIE		:= SF2->F2_SERIE
		If FieldPos("F2_SDOC") > 0
			TRB->F2_SDOC := SF2->F2_SDOC
		end
		TRB->F2_VALBRUT	:= nValTot
   MsUnlock()

   DbSelectArea("SF2")
   DbSkip()
EndDo

cRegiao := "INICIAL"
cCidade := "INICIAL"
cSetor  := If(lSA1SETOR,"INICIAL","XXX")
cPrefix := "INICIAL"
cNome   := "INICIAL"
cPROVEI := "INICIAL"
cQuebra := "INICIAL"

nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1

@ nLin , 00 psay Repl("*",80)
nLin++
@ nLin , 00 psay STR0011
nLin++
@ nLin , 00 psay STR0012 + cTitPref + STR0013 + Transform(MV_PAR01,"@D") + STR0014 + Transform(MV_PAR02,"@D")
@ nLin , 59 psay str(aTotal[1,7],6) + Transform(aTotal[1,8],"@E 9999,999,999.99")
nLin++
@ nLin++ , 00 psay Repl("*",80)
nLin++
nLin++

If MV_PAR04 # 1 .and. MV_PAR04 # 4
	@ nLin++ , 17 psay STR0015
	nLin++
EndIf   
If MV_PAR04 == 5
	nLin++
	@ nLin++ , 17 psay STR0016 + Transform((aTotPref[1,2]/aTotal[1,8])*100,"@E 999.9") + "% " + str(aTotPref[1,1],6) + Transform(aTotPref[1,2],"@E 99999,999,999.99")
EndIf
If MV_PAR04 == 2 .or. MV_PAR04 == 5
	nLin++
	@ nLin++ , 17 psay STR0017 + Transform((aTotPref[3,1]/aTotal[1,8])*100,"@E 999.9") + "% " + str(aTotPref[2,1],6) + Transform(aTotPref[3,1],"@E 99999,999,999.99")
	@ nLin++ , 17 psay STR0018 + Transform((aTotPref[2,2]/aTotal[1,8])*100,"@E 999.9") + "%       " + Transform(aTotPref[2,2],"@E 99999,999,999.99")
	@ nLin++ , 17 psay STR0019 + Transform((aTotPref[3,2]/aTotal[1,8])*100,"@E 999.9") + "%       " + Transform(aTotPref[3,2],"@E 99999,999,999.99")
EndIf
If MV_PAR04 == 3 .or. MV_PAR04 == 5
	nLin++
	@ nLin++ , 17 psay STR0020 + Transform(((aTotPref[4,2]+aTotPref[5,2])/aTotal[1,8])*100,"@E 999.9") + "% " + str(aTotPref[4,1]+aTotPref[5,1],6) + Transform(aTotPref[4,2]+aTotPref[5,2],"@E 99999,999,999.99")
	@ nLin++ , 17 psay STR0021 + Transform((aTotPref[4,2]/aTotal[1,8])*100,"@E 999.9") + "% " + str(aTotPref[4,1],6) + Transform(aTotPref[4,2],"@E 99999,999,999.99")
	@ nLin++ , 17 psay STR0022 + Transform((aTotPref[5,2]/aTotal[1,8])*100,"@E 999.9") + "% " + str(aTotPref[5,1],6) + Transform(aTotPref[5,2],"@E 99999,999,999.99")
EndIf
If MV_PAR04 # 1 .and. MV_PAR04 # 4
	nLin++
	nLin++
	@ nLin , 00 psay Repl("*",80)
EndIf

If MV_PAR06 # 1
	nLin++   
EndIf
DbSelectArea("TRB")
DbGoTop()
Do While !Eof()
	If cRegiao # TRB->VCB_CODREG
		cRegiao := TRB->VCB_CODREG
		cCidade := "INICIAL"
		cSetor  := If(lSA1SETOR,"INICIAL","XXX")
		cPrefix := "INICIAL"
		cNome   := "INICIAL"
		nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1      
		nLin++
		@ nLin++ , 00 psay Repl("-",80)
		nPos := aScan(aTotal,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[9] == TRB->VCB_CODREG + space(7) + "R" })
		nPosReg := nPos
	  	@ nLin , 00 psay "***"+STR0024+ Alltrim(TRB->VCB_CODREG) + " - " +  Alltrim(TRB->VCB_DESREG)
	  	@ nLin , 47 psay STR0005+Transform((aTotal[nPos,8]/aTotal[1,8])*100,"@E 999.9")+"%"
		@ nLin , 59 psay str(aTotal[nPos,7],6) + Transform(aTotal[nPos,8],"@E 9999,999,999.99")
		@ nLin++ , 00 psay Repl("-",80)
		If MV_PAR06 == 3
			nLin++ 
		EndIf
	EndIf
	If cCidade # TRB->VAM_IBGE
		cCidade := TRB->VAM_IBGE
		cSetor  := If(lSA1SETOR,"INICIAL","XXX")
		cPrefix := "INICIAL"
		cNome   := "INICIAL"
      If MV_PAR06 == 2
			nLin++
			nLin++
		EndIf
	   If nLin >= 55
			nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1      
	   EndIf
		nLin++
		nPos := aScan(aTotal,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[9] == TRB->VCB_CODREG + TRB->VAM_IBGE + space(6) + "C" })
		nPosCid := nPos
	  	@ nLin , 01 psay Alltrim(TRB->VAM_DESCID) 
	  	@ nLin , 33 psay STR0025+Transform((aTotal[nPos,8]/aTotal[nPosReg,8])*100,"@E 999.9") +"%  "+STR0005+Transform((aTotal[nPos,8]/aTotal[1,8])*100,"@E 999.9")+"%"
		@ nLin , 59 psay str(aTotal[nPos,7],6) + Transform(aTotal[nPos,8],"@E 9999,999,999.99")
		If MV_PAR06 >= 2
			nLin++
		  	@ nLin , 00 psay Repl("-",len(Alltrim(TRB->VAM_DESCID))+2) 
		EndIf
	EndIf

	If MV_PAR06 >= 2

		If cSetor # TRB->SA1_SETOR
			cSetor := TRB->SA1_SETOR
			cPrefix := "INICIAL"
			cNome   := "INICIAL"
			nLin++
			nPos := aScan(aTotal,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[9] == TRB->VCB_CODREG + TRB->VAM_IBGE + TRB->SA1_SETOR + space(3) + "S" })
			nPosSet := nPos
		   If nLin >= 50
				nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1      
	   	EndIf
	      If MV_PAR06 >= 2
				nLin++
			EndIf    			
	  		@ nLin , 03 psay STR0026+"<<< "+cSetor+" >>>"
		  	@ nLin , 33 psay STR0027+Transform((aTotal[nPos,8]/aTotal[nPosCid,8])*100,"@E 999.9") +"%  "+STR0005+Transform((aTotal[nPos,8]/aTotal[1,8])*100,"@E 999.9")+"%"
			@ nLin , 59 psay str(aTotal[nPos,7],6) + Transform(aTotal[nPos,8],"@E 9999,999,999.99")
		EndIf

		If cPrefix # TRB->F2_PREFORI+TRB->VV1_ESTVEI
			cPrefix := TRB->F2_PREFORI+TRB->VV1_ESTVEI
			cNome   := "INICIAL"
			If MV_PAR06 == 3
				nLin++       
			EndIf
			If Alltrim(TRB->F2_PREFORI) == GetNewPar("MV_PREFVEI","VEI")
				cPROVEI := "INICIAL"
				If TRB->VV1_ESTVEI == "0"
			 		cTipo := STR0028
			 	Else
		  			cTipo := STR0029
			 	EndIf
			ElseIf Alltrim(TRB->F2_PREFORI) ==GetNewPar("MV_PREFBAL","BAL")
	  			cTipo := STR0030
	  		Else
			  	cTipo := STR0031
	  		EndIf  
		   If nLin >= 50
				nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1      
		   EndIf
			nLin++
			nPos := aScan(aTotal,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[9] == TRB->VCB_CODREG + TRB->VAM_IBGE + TRB->SA1_SETOR + TRB->F2_PREFORI + TRB->VV1_ESTVEI + space(1) + "P" })
		  	@ nLin , 06 psay cTipo
			If lSA1SETOR
				@ nLin , 33 psay STR0023+Transform((aTotal[nPos,8]/aTotal[nPosSet,8])*100,"@E 999.9") +"%  "+STR0005+Transform((aTotal[nPos,8]/aTotal[1,8])*100,"@E 999.9")+"%"
			Else
				@ nLin , 33 psay STR0027+Transform((aTotal[nPos,8]/aTotal[nPosCid,8])*100,"@E 999.9") +"%  "+STR0005+Transform((aTotal[nPos,8]/aTotal[1,8])*100,"@E 999.9")+"%"
			EndIf		
			@ nLin , 59 psay str(aTotal[nPos,7],6) + Transform(aTotal[nPos,8],"@E 9999,999,999.99")
			If MV_PAR06 == 3
				nLin++
			EndIf
			nLin++
		EndIf
	
		If TRB->VV1_PROVEI # "9" .and. cPROVEI # TRB->VV1_PROVEI .and. TRB->VV1_ESTVEI == "0"
			cPROVEI := TRB->VV1_PROVEI
			If TRB->VV1_PROVEI == "1"
				cTipo := STR0032
			Else
				cTipo := STR0033
			EndIf
			nPos := aScan(aTotal,{|x| x[1]+x[2]+x[3]+x[4]+x[5]+x[6]+x[9] == TRB->VCB_CODREG + TRB->VAM_IBGE + TRB->SA1_SETOR + TRB->F2_PREFORI + TRB->VV1_ESTVEI + TRB->VV1_PROVEI + "V" })
		  	@ nLin , 09 psay cTipo
			@ nLin , 59 psay str(aTotal[nPos,7],6) + Transform(aTotal[nPos,8],"@E 9999,999,999.99")
			If MV_PAR06 == 3
				nLin++
			EndIf
			nLin++
		EndIf
	
	EndIf   

	If MV_PAR06 == 3
	   If nLin >= 58
			nLin := cabec(ctitulo,cabec1,cabec2,cNomeProg,cTamanho,nCaracter) + 1      
			nLin++
	   EndIf
		If cNome # left(TRB->SA1_NOME,30)
			nTotCli := 0
			cNome := Left(TRB->SA1_NOME,30)
			cMask := If(Len(Alltrim(TRB->SA1_CGC))>=12,"@!R NN.NNN.NNN/NNNN-99","@R 999.999.999-99")
		  	@ nLin++ , 10 psay left(TRB->SA1_NOME,30) + " " + Transform(TRB->SA1_CGC,cMask) + "    " + TRB->VAM_DDD + " " + Alltrim(TRB->SA1_TEL)
		EndIf
		@ nLin++ , 13 psay TRB->F2_DOC +"-"+ ALLTRIM( FGX_UFSNF( TRB->F2_SERIE ) ) +" "+ Transform(TRB->F2_EMISSAO,"@D") +" "+ TRB->SA3_NOME + Transform(TRB->F2_VALBRUT,"@E 99999,999.99")
		nTotCli += TRB->F2_VALBRUT
		cQuebra := TRB->VCB_CODREG + TRB->VAM_IBGE + TRB->SA1_SETOR + TRB->F2_PREFORI + TRB->VV1_ESTVEI + TRB->VV1_PROVEI 
   EndIf

	DbSelectArea("TRB")
	DbSkip()     	          

	If MV_PAR06 == 3
		If !Eof()
			If cNome # left(TRB->SA1_NOME,30) .or. ( cQuebra # (TRB->VCB_CODREG + TRB->VAM_IBGE + TRB->SA1_SETOR + TRB->F2_PREFORI + TRB->VV1_ESTVEI + TRB->VV1_PROVEI) )
				@ nLin++ , 66 psay Transform(nTotCli,"@E 999,999,999.99")   
		   EndIf
		Else
			@ nLin++ , 66 psay Transform(nTotCli,"@E 999,999,999.99")
	   EndIf
		nLin++
    EndIf
EndDo                            

DbSelectArea("TRB")
oObjTempTable:CloseTable()

Set Printer to
Set Device  to Screen

Return
