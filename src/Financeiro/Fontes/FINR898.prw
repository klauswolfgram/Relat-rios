/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "SIGAWIN.CH"        // incluido pelo assistente de conversao do AP5 IDE em 09/09/99
#include "FINR898.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR898   ºAutor  ³Bruno Sobieski      º Data ³  21/12/98   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relacao dos Recibos por cliente                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function finr898()        // incluido por el asistente de conversión del AP5 IDE en 01/06/00

Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport	:= ReportDef()
oReport:PrintDialog()

If Select("TRB") > 0
	DbSelectArea("TRB")
	DbCloseArea()
EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Paulo Augusto       º Data ³  21/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tratamanto release 04                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport,oSection1,oSection2,oSection3,oSection4,oSection5
Local cReport 	:= "FINR898"
Local cTitulo 	:= OemToAnsi(STR0005)
Local cDescri 	:= OemToAnsi(STR0001) + OemToAnsi(STR0002)
Local cPerg		:= ""

If cPaisLoc == "ARG"
	DbSelectArea("SEL")
	cPerg := "FIR898A"
Else
	cPerg := "FIR898"
EndIf
If cPaisLoc == "ARG"
	oReport  := TReport():New( cReport, cTitulo, cPerg , { |oReport| ReportPrint( oReport, "SEL" ) }, cDescri )
Else
	oReport  := TReport():New( cReport, cTitulo, "FIR898" , { |oReport| ReportPrint( oReport, "SEL" ) }, cDescri )
Endif


oSection1 := TRSection():New( oReport,STR0044, {"SA1"},{ OemToAnsi(STR0042), OemToAnsi(STR0043) } ) //"Dados dos Clientes"

TRCell():New( oSection1, "A1_COD" 	  ,"SA1",/*X3Titulo*/	,/*Picture*/,TAMSX3("A1_COD" )[1] +TAMSX3("A1_LOJA" )[1],/*lPixel*/,)
TRCell():New( oSection1, "A1_LOJA"	  ,"SA1",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection1, "A1_SALDUP" ,"SA1",STR0045			,/*Picture*/,/*Tamanho*/,/*lPixel*/,) //"Saldo"

oSection2 := TRSection():New( oSection1,STR0046 , {"SEL"} ) //"Recibos de Cobrancas"
TRCell():New( oSection2, "EL_RECIBO" 	,"SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
If cPaisLoc $ "ARG"
	DbSelectArea("SEL")
	TRCell():New( oSection2, "EL_VERSAO" ,"SEL",/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
EndIf
TRCell():New( oSection2, "EL_DTDIGIT" 	,"SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection2, "EL_COBRAD"	,"SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection2, "AQ_NOME  "	,"SAQ",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)

oSection3 := TRSection():New( oSection2,STR0047 , {"SEL"} ) //"Titulos Baixados"
TRCell():New( oSection3, "EL_TIPO" 		,"SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection3, "EL_NUMERO"	,"SEL",/*X3Titulo*/	,/*Picture*/,20/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection3, "EL_PREFIXO"	,"SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection3, "EL_PARCELA"	,"SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection3, "EL_EMISSAO"	,"SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection3, "EL_DTVCTO"	,"SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection3, "EL_VALOR"		,"SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)

oSection4 := TRSection():New( oSection2,STR0048 , {"SEL"} ) //"Dados Bancarios"

TRCell():New( oSection4, "EL_BCOCHQ" 	,"SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection4, "EL_AGECHQ"	,"SEL",/*X3Titulo*/	,/*Picture*/, /*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection4, "EL_CTACHQ"	,"SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection4, "EL_NUMERO"	,"SEL",/*X3Titulo*/	,/*Picture*/,20/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection4, "EL_VALOR"		,"SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)

oSection5 := TRSection():New( oSection2,STR0048 , {"SEL"} ) //"Dados Bancarios"
TRCell():New(oSection5,"EL_TIPO","SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New(oSection5,"EL_NUMERO","SEL",/*X3Titulo*/	,/*Picture*/,20/*Tamanho*/,/*lPixel*/,)
TRCell():New(oSection5,"EL_VALOR","SEL",/*X3Titulo*/	,/*Picture*/,/*Tamanho*/,/*lPixel*/,)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Augusto       º Data ³  21/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de impressao                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )

Local oSection1 := oReport:Section(1)
Local oSection2 := oSection1:Section(1)
Local oSection3 := oSection2:Section(1)
Local oSection4 := oSection2:Section(2)
Local oSection5 := oSection2:Section(3)
Local nX := 1
Local nOrder	:=oReport:Section(1):GetOrder()
Local cPictSEL  := ""
Local nTotal:=0
Local nretenc:=0
Local nRetencGer:=0
Local nTotGer:=0
Local nDecs :=2
Local lImprimio:=.F.
Local cFiltSEL := oReport:Section(1):GetADVPLExp("SEL")

Local lVersao 	:= .F.
Local cVersao 	:= ""
Local cVerDe	:= MV_PAR05
Local cVerAte	:= MV_PAR06
Local dDtIni	:= Iif(cPaisLoc == "ARG",MV_PAR07,MV_PAR05)
Local dDtFim	:= Iif(cPaisLoc == "ARG",MV_PAR08,MV_PAR06)
Local nMoeInf	:= Iif(cPaisLoc == "ARG",MV_PAR09,MV_PAR07)
Local cCobrDe	:= Iif(cPaisLoc == "ARG",MV_PAR10,MV_PAR08)
Local cCobrAte	:= Iif(cPaisLoc == "ARG",MV_PAR11,MV_PAR09)
Local cSerDe	:= Iif(cPaisLoc == "ARG",MV_PAR12,MV_PAR10)
Local cSerAte	:= Iif(cPaisLoc == "ARG",MV_PAR13,MV_PAR11)
Local nOutMoe	:= Iif(cPaisLoc == "ARG",MV_PAR14,MV_PAR12)
Local aArea	:= {}
Local aBackup	:= {}
/*
 * Considerando controle de versionamento do recibos (Argentina)
 */
If cPaisLoc $ "ARG"
	DbSelectArea("SEL")
	lVersao := .T.
EndIf

If !Empty(oReport:uParam)
	Pergunte(oReport:uParam,.F.)
EndIf

// Após o pergunte carrega as variáveis com os parametros.
cVerDe	:= MV_PAR05
cVerAte	:= MV_PAR06
dDtIni	:= Iif(cPaisLoc == "ARG",MV_PAR07,MV_PAR05)
dDtFim	:= Iif(cPaisLoc == "ARG",MV_PAR08,MV_PAR06)
nMoeInf	:= Iif(cPaisLoc == "ARG",MV_PAR09,MV_PAR07)
cCobrDe	:= Iif(cPaisLoc == "ARG",MV_PAR10,MV_PAR08)
cCobrAte:= Iif(cPaisLoc == "ARG",MV_PAR11,MV_PAR09)

If cPaisLoc == "BRA"
	cSerDe	:= MV_PAR08
	cSerAte	:= MV_PAR09
	nOutMoe	:= MV_PAR10
ElseIf cPaisLoc == "ARG"
	cSerDe	:= MV_PAR12
	cSerAte	:= MV_PAR13
	nOutMoe	:= MV_PAR14
Else
	cSerDe	:= MV_PAR10
	cSerAte	:= MV_PAR11
	nOutMoe	:= MV_PAR12
EndIf

If cPaisLoc $ "ARG"
	oReport:SetTitle(OemToAnsi(STR0005) + Iif(nOrder==1,OemToAnsi(STR0042), OemToAnsi(STR0043) )+ " - " + GetMV("MV_MOEDA"+STR(nMoeInf,1)) )// " - Por Cliente")
Else
	oReport:SetTitle(OemToAnsi(STR0005) + Iif(nOrder==1,OemToAnsi(STR0042), OemToAnsi(STR0043) )+ " - " + GetMV("MV_MOEDA"+STR(mv_par07,1)) )// " - Por Cliente")
EndIf
If cPaisLoc $ "ARG"
	nDecs := MsDecimais(nMoeInf)
EndIf
If cPaisLoc $ "ARG"
	cPictSEL  := PesqPict("SEL","EL_VALOR",16,nMoeInf)
EndIf
cIndexSEL := CriaTrab(nil,.f.)

If nOrder == 1 //Ordenado por RECIBO
	If cPaisLoc $ "ARG" .AND. lVersao
		cChaveSEL := "EL_FILIAL+EL_RECIBO+EL_VERSAO+EL_CLIORIG+EL_LOJORIG+EL_TIPODOC+EL_COBRAD"
	Else
		cChaveSEL := "EL_FILIAL+EL_RECIBO+EL_CLIORIG+EL_LOJORIG+EL_TIPODOC+EL_COBRAD"
	EndIf
Else //Ordenado por CLIENTE
	If cPaisLoc $ "ARG" .AND. lVersao
		cChaveSEL := "EL_FILIAL+EL_CLIORIG+EL_LOJORIG+EL_RECIBO+EL_VERSAO+EL_TIPODOC+EL_COBRAD"
	Else
		cChaveSEL := "EL_FILIAL+EL_CLIORIG+EL_LOJORIG+EL_RECIBO+EL_TIPODOC+EL_COBRAD"
	EndIf
EndIf

If cPaisLoc != "BRA"
	cCondicao := ' EL_CLIORIG >= "'+mv_par01+'" .And. EL_CLIORIG <= "'+mv_par02+'" .And. EL_RECIBO>="'+;
      	       mv_par03+'" .And. EL_RECIBO <= "'+mv_par04+'" .And. EL_FILIAL == "'+xFilial("SEL")+'"'
 	If cPaisLoc == "ARG" .AND. lVersao
 		cCondicao += ' .AND. DTOS(EL_DTDIGIT) >= "' + DTOS(dDtIni) + '" .And. DTOS(EL_DTDIGIT) <= "' + DTOS(dDtFim) + '"'
		cCondicao += ' .AND. EL_COBRAD 	>= 	"' + cCobrDe	+'" .AND. EL_COBRAD		<=	"'	+ cCobrAte	+'" '
		cCondicao += ' .AND. EL_SERIE	>=	"' + cSerDe 	+'" .AND. EL_SERIE		<=	"'	+ cSerAte	+'" '
	    cCondicao += ' .AND. EL_VERSAO 	>= 	"' + cVerDe 	+'" .AND. EL_VERSAO 	<=	"'	+ cVerAte 	+'" '
	Else
		cCondicao += ' .AND. DTOS(EL_DTDIGIT) >= "'+DTOS(mv_par05)+'" .And. DTOS(EL_DTDIGIT) <= "'+DTOS(mv_par06)+'"'
		cCondicao += ' .And. EL_SERIE>="'+mv_par10+'".And. EL_SERIE<="'+mv_par11
  		cCondicao += '" .And.  EL_COBRAD >= "'+mv_par08+'" .And. EL_COBRAD <= "'+mv_par09+'"'
	EndIf
Else
	cCondicao := 'DTOS(EL_DTDIGIT) >= "'+DTOS(mv_par05)+'" .And. DTOS(EL_DTDIGIT) <= "'+DTOS(mv_par06)+'"';
   	          +' .And. EL_CLIORIG >= "'+mv_par01+'" .And. EL_CLIORIG <= "'+mv_par02+'" .And. EL_RECIBO>="'+;
      	       mv_par03+'" .And. EL_RECIBO <= "'+mv_par04+'" .And. EL_SERIE>="'+mv_par08+'".And. EL_SERIE<="'+mv_par09+;
         	    '" .And. EL_FILIAL == "'+xFilial("SEL")+'"'
Endif

//Adiciono o filtro do usuario na condicao
If !Empty(cFiltSEL)
	cCondicao += ' .And. ('+cFiltSEL +')'
EndIf

IndRegua("SEL",cIndexSEL,cChaveSEL,,cCondicao,OemToAnsi(STR0007))  //"Selecionando Registros..."
nIndexSEL := RetIndex("SEL")

dbSetOrder(nIndexSEL+1)
DbGoTop()

oReport:SetMeter(Reccount())
lImprimio:=.f.

While  !Eof() .and. EL_FILIAL == xFilial("SEL")

	cCarAnt := SEL->EL_CLIORIG + SEL->EL_LOJORIG

	SA1->(DbSetOrder(1))
	SA1->(DbSeek(xFilial("SA1")+cCarAnt))
	oSection1:Init()
	oSection1 :PrintLine()
	oSection1 :Finish()
 	While SEL->EL_CLIORIG + SEL->EL_LOJORIG==cCarAnt .And. !Eof()  .And. xFilial("SEL") == SEL->EL_FILIAL

    	If EL_CANCEL
    		oReport:IncMeter()
			DbSkip()
			Loop
		Endif

		If Substr(SEL->EL_TIPODOC,1,2) == "TJ"
			DbSkip()
			oReport:IncMeter()
			Loop
		Endif
	    If cPaisLoc $ "ARG"
  			If IIf(cPaisLoc=="BRA",mv_par10,nMoeInf) == 2 // nao imprime
				If Val(SEL->EL_MOEDA) != nMoeInf //verifica moeda do campo=moeda parametro
					DbSkip()
					oReport:IncMeter()
					Loop
				EndIf
			EndIf
		EndIf
		
		cCobrador := SEL->EL_COBRAD
		cDtRecibo := DTOC(SEL->EL_DTDIGIT)
    	cRcboAnt  := SEL->EL_RECIBO
		cSerAnt   := SEL->EL_SERIE
		
		If cPaisLoc $ "ARG" .AND. lVersao
			cVersao := SEL->EL_VERSAO
		EndIf

		SAQ->(DbSetOrder(1))
		SAQ->(Dbseek(xfilial("SAQ") +cCobrador))
		cNome	  := SAQ->AQ_NOME

		aTitulos  := {}
		aRetenc   := {}
		aChequePr := {}
		aDepos    := {}
		aPas      := {}
		aCartao   := {}
		nPaGen:=0
		nTotal:=0
		nretenc:=0

		DbSelectArea("SEL")
		lImprimio:=.t.

		oSection2:Init()
		oSection2 :PrintLine()
		oSection2 :Finish()
		aArea := SEL->( getArea() )
       If cPaisLoc == "ARG"
		Do while cSerAnt+cRcboAnt+cVersao == SEL->EL_SERIE+SEL->EL_RECIBO+Iif(lVersao,SEL->EL_VERSAO,) .And. SEL->EL_FILIAL==xFilial("SEL")
  		   oReport:IncMeter()
			nValTmp	:=	IIf(nMoeInf==1,EL_VLMOED1,xMoeda(EL_VALOR,Max(Val(EL_MOEDA),1),nMoeInf,,,EL_VLMOED1/EL_VALOR))
			If Subs(SEL->EL_TIPODOC,1,1)=="R"
				If SEL->EL_TIPODOC=="RA"
					nPaGen  := nPaGen  + nValTmp
				Else
					Aadd(aRetenc,{EL_TIPODOC,EL_NUMERO,nValTmp}  )
				EndIf
			Elseif Substr(SEL->EL_TIPODOC,1,2) == "TB"
				Aadd(aTitulos,{EL_TIPO,EL_NUMERO,EL_PREFIXO,EL_PARCELA,EL_EMISSAO,EL_DTVCTO,nValTmp})
                If Len(aCartao) == 0
				   BuscaCC(cSerAnt,cRcboAnt,nMoeInf)
				EndIf
			Elseif Substr(SEL->EL_TIPODOC,1,2) == "CH"
				Aadd(aChequePr,{SEL->EL_BCOCHQ,SEL->EL_AGECHQ,SEL->EL_CTACHQ,SEL->EL_NUMERO,nValTmp,SEL->EL_PREFIXO,SEL->EL_PARCELA, SEL->EL_TIPODOC, SEL->EL_TIPO})
			Elseif Substr(SEL->EL_TIPODOC,1,2) $ "TF/EF"
				Aadd(aDepos,{SEL->EL_BANCO,SEL->EL_AGENCIA,SEL->EL_CONTA,SEL->EL_NUMERO,nValTmp,SEL->EL_PREFIXO,SEL->EL_PARCELA, SEL->EL_TIPODOC, SEL->EL_TIPO})
			Elseif Substr(SEL->EL_TIPODOC,1,2) == "PA"
				Aadd(aPas,{SEL->EL_NUMERO,nValTmp})
			EndIf
			SEL->(dbskip())
		Enddo
		Else
		Do while cSerAnt+cRcboAnt == SEL->EL_SERIE+SEL->EL_RECIBO .And. SEL->EL_FILIAL==xFilial("SEL")
  		   oReport:IncMeter()
			nValTmp	:=	IIf(mv_par07==1,EL_VLMOED1,xMoeda(EL_VALOR,Max(Val(EL_MOEDA),1),mv_par07,,,EL_VLMOED1/EL_VALOR))
			If Subs(SEL->EL_TIPODOC,1,1)=="R"
				If SEL->EL_TIPODOC=="RA"
					nPaGen  := nPaGen  + nValTmp
				Else
					Aadd(aRetenc,{EL_TIPODOC,EL_NUMERO,nValTmp}  )
				EndIf
			Elseif Substr(SEL->EL_TIPODOC,1,2) == "TB"
				Aadd(aTitulos,{EL_TIPO,EL_NUMERO,EL_PREFIXO,EL_PARCELA,EL_EMISSAO,EL_DTVCTO,nValTmp})
                If Len(aCartao) == 0
				   BuscaCC(cSerAnt,cRcboAnt,nMoeInf)
				EndIf
			Elseif Substr(SEL->EL_TIPODOC,1,2) == "CH"
				Aadd(aChequePr,{SEL->EL_BCOCHQ,SEL->EL_AGECHQ,SEL->EL_CTACHQ,SEL->EL_NUMERO,nValTmp,SEL->EL_PREFIXO,SEL->EL_PARCELA, SEL->EL_TIPODOC, SEL->EL_TIPO})
			Elseif Substr(SEL->EL_TIPODOC,1,2) $ "TF/EF"
				Aadd(aDepos,{SEL->EL_BANCO,SEL->EL_AGENCIA,SEL->EL_CONTA,SEL->EL_NUMERO,nValTmp,SEL->EL_PREFIXO,SEL->EL_PARCELA, SEL->EL_TIPODOC, SEL->EL_TIPO})
			Elseif Substr(SEL->EL_TIPODOC,1,2) == "PA"
				Aadd(aPas,{SEL->EL_NUMERO,nValTmp})
			EndIf
			SEL->(dbskip())
		Enddo
		EndIf
		If Len(aTitulos) >0
			oSection3:Init()
			For nX := 1 To Len(aTitulos)
				oSection3:Cell("EL_TIPO"):SetBlock({||aTitulos[nX][1]})	///Tipo
				oSection3:Cell("EL_NUMERO"):SetBlock({||aTitulos[nX][2]})	//Ag
				oSection3:Cell("EL_PREFIXO"):SetBlock({||aTitulos[nX][3]})	//Serie
				oSection3:Cell("EL_PARCELA"):SetBlock({||aTitulos[nX][4]})	//Parcela
				oSection3:Cell("EL_EMISSAO"):SetBlock({||aTitulos[nX][5]})	//Emissao
				oSection3:Cell("EL_DTVCTO"):SetBlock({||aTitulos[nX][6]})	//Vencto
				oSection3:Cell("EL_VALOR"):SetBlock({||aTitulos[nX][7]})//Valor

				oSection3:PrintLine()

				If aTitulos[nX][1] $ MV_CRNEG+"|"+MVRECANT  //Tratamento para NCCs e RAs
				   nTotal  := nTotal - aTitulos[nX][7]
				Else
				   nTotal  := nTotal+aTitulos[nX][7]
				EndIf
			Next nX
			oSection3:Finish()
			nTotGer:=nTotGer+nTotal
        EndIf

		If cPaisLoc == "ARG"
			oSection5:Init()
			oReport:PrintText(OemToAnsi(STR0014) + STR(LEN(aRetenc)))  //"Retenciones     : "
			For nX := 1 To Len(aRetenc)
				oSection5:Cell("EL_TIPO"):SetBlock({||aRetenc[nX][1]})		//Tipo
				oSection5:Cell("EL_NUMERO"):SetBlock({||aRetenc[nX][2]})	//Numero
				oSection5:Cell("EL_VALOR"):SetBlock({||aRetenc[nX][3]})	//Valor
				nRetenc:=nRetenc+aRetenc[nX][3]
				oSection5:PrintLine()
			Next nX
			nRetencGer:=nRetencGer+nRetenc
			oSection5:Finish()
		EndIf

		// Imprimir Totais
		oReport:PrintText( OemToAnsi(STR0015) + Transform(nTotal,Tm(nTotal,16,nDecs)))  //"Total Titulos      : "

		If cPaisLoc == "ARG"
			oReport:PrintText( OemToAnsi(STR0016) + Transform(nRetenc,Tm(nRetenc,16,nDecs)))  //"Total Retenciones  : "
		Endif

		oReport:PrintText( OemToAnsi(STR0017) + Transform(nTotal-nRetenc,Tm(nTotal-nRetenc,16,nDecs)))  //"Total Liquido      : "

		If Len(aPas) > 0 .Or. Len(aChequePr) > 0 .Or. Len(aDepos) > 0 .Or. Len(aCartao) > 0
		   oReport:PrintText( OemToAnsi(STR0018))  //"Pagado con  : "
		EndIf

		For	nX	:=	1  to Len(aPas)  //Pagos anticipados
			oReport:PrintText( OemToAnsi(STR0019) + aPas[nX][1] + " " +  OemToAnsi(STR0020) + TRANSFORM(aPas[nX][2],Tm(aPas[nX][2],16,nDecs)))   //"Valor : "
		Next

		If len(aChequePr)>0 .Or. len(aDepos)>0 .Or. len(aCartao)>0
			oSection4:Init()
		EndIf

		If len(aChequePr)>0
			For nX:=1 To len(aChequePr)     //CHEQUE Propio
				oSection4:Cell("EL_BCOCHQ"):SetBlock({||aChequePr[nX][1]})//"BANCO : "
				oSection4:Cell("EL_AGECHQ"):SetBlock({||aChequePr[nX][2]})//Ag
				oSection4:Cell("EL_CTACHQ"):SetBlock({||aChequePr[nX][3]})//Conta
				oSection4:Cell("EL_NUMERO"):SetBlock({||aChequePr[nX][4]})//Numero
				oSection4:Cell("EL_VALOR"):SetBlock({||aChequePr[nX][5]})//Valor
				aBackup := SEL->(getArea())
				SEL->(DbSetOrder(1))
				SEL->( DbSeek(xFilial("SEL") + cRcboAnt + aChequePr[nX][8] + aChequePr[nX][6] + aChequePr[nX][4] + aChequePr[nX][7] + aChequePr[nX][9]) )
				oSection4:PrintLine()
				RestArea(aBackup)
			Next
		EndIf

		If len(aDepos)>0
			For nX:=1 To len(aDepos)        //Depositos   // Bancos
				oSection4:Cell("EL_BCOCHQ"):SetBlock({||aDepos[nX][1]})
				oSection4:Cell("EL_AGECHQ"):SetBlock({||aDepos[nX][2]})
				oSection4:Cell("EL_CTACHQ"):SetBlock({||aDepos[nX][3]})
				oSection4:Cell("EL_NUMERO"):SetBlock({||aDepos[nX][4]})
				oSection4:Cell("EL_VALOR"):SetBlock({||aDepos[nX][5]})
				aBackup := SEL->(getArea())
				SEL->(DbSetOrder(1))
				SEL->( DbSeek(xFilial("SEL") + cRcboAnt + aDepos[nX][8] + aDepos[nX][6] + aDepos[nX][4] + aDepos[nX][7] + aDepos[nX][9]) )
				oSection4:PrintLine()
				RestArea(aBackup)
			Next
		EndIf

		If len(aCartao)>0
			For nX:=1 To len(aCartao)      //Cartao
				oSection4:Cell("EL_BCOCHQ"):SetBlock({||aCartao[nX][1]})
				oSection4:Cell("EL_AGECHQ"):SetBlock({||aCartao[nX][2]})
				oSection4:Cell("EL_CTACHQ"):SetBlock({||aCartao[nX][3]})
				oSection4:Cell("EL_NUMERO"):SetBlock({||aCartao[nX][4]})
				oSection4:Cell("EL_VALOR"):SetBlock({||aCartao[nX][5]})
				aBackup := SEL->(getArea())
				RestArea(aArea)
				oSection4:PrintLine()
				RestArea(aBackup)
			Next
		EndIf

		If len(aChequePr)>0 .Or. len(aDepos)>0 .Or. len(aCartao)>0
			oSection4:Finish()
		EndIf

		If nPaGen>0
			oReport:PrintText( OemToAnsi(STR0026) + TransForm(nPaGen,Tm(nPaGen,14,nDecs)) )  //"Total de Recibos Anticipados generados : "
		Endif
		oReport:SkipLine()
	EndDo
	oSection2:Finish()

	oReport:SkipLine()
	oReport:SkipLine()

EndDo
oSection1:Finish()
oReport:FatLine()

If lImprimio
	If cPaisLoc == "ARG"
		oReport:PrintText( OemToAnsi(STR0029) + TransForm(nRetencGer,Tm(nRetencGer,16,nDecs)) ) //"Total Geral de Retenciones :  "
	Endif
	oReport:PrintText(  OemToAnsi(STR0030) + TransForm(nTotGer,Tm(nTotGer,16,nDecs)) ) //"Total Geral Recibido       :  "
End

dbSelectArea("SEL")
dbClearFil()
RetIndex( "SEL" )

dbSetOrder(1)

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³BuscaCC   ºAutor  ³Fernando Machima    ºFecha ³  14/09/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Busca registros de cartao de credito no recibo              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR898                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function BuscaCC(cSerie,cRecibo,nMoeda)
LOCAL aArea    := GetArea()
LOCAL nValRec  := 0

DbSelectArea("SEL")
DbSetOrder(8)
If DbSeek(xFilial("SEL")+cSerie+cRecibo)
	While !Eof() .And. xFilial() == SEL->EL_FILIAL .And. cSerie+cRecibo == SEL->EL_SERIE+SEL->EL_RECIBO 
		If SEL->EL_TIPODOC $ 'TJ|CC|CD'
			nValRec	:=	IIf(nMoeda==1,SEL->EL_VLMOED1,xMoeda(SEL->EL_VALOR,Max(Val(SEL->EL_MOEDA),1),nMoeda,SEL->EL_EMISSAO))
			Aadd(aCartao,{SEL->EL_BANCO,SEL->EL_AGENCIA,SEL->EL_CONTA,SEL->EL_NUMERO,nValRec})
		Endif	
		DbSkip()
   EndDo
EndIf
RestArea(aArea)
	
Return
	