/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Protheus.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  FINR085R    ºAutor  ³ Ana Paula Nascimento º Data ³ 22/12/10 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Certificado de IR de Cuarta Categoria - Peru				   ±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FINR085R()
Local cPerg := "F085IR"
Local cSimbMoed    := GetMv("MV_SIMB1")
Local aDados:= {{"","",0,0,0,0,0}}
Local nBaseTotal := 0
Local nRetTotal  := 0
Local nPos:= 0
Local lPergunte := .T.

lPergunte := Pergunte(cPerg)

If !lPergunte
	Return
EndIf

nAnoAnteior:= val(mv_par05) - 1

/* Não foi utilizado CH´s neste pois trata-se de um certificado legal no qual não poderia conter divergencias
 no texto e foi enviado o modelo já no idiota em espanhol.*/

/*
aDados[1] - Fornecedor
aDados[1] - Loja
aDados[3] - Valor base das compras emitidas no ano anterior ao exercicio
aDados[4] - Valor retenção das compras emitidas no ano anterior ao exercicio
aDados[5] - Valor retenção das compras emitidas e pagas no ano do exercicio
aDados[6] - Valor de base total
aDados[7] - Valor de retenção total
*/

dDataCert:=StrZero(Day(dDatabase),2) + " " + "DE" + " " + MesExtenso(Month(dDatabase)) + " " + "DEL" + " "  + Alltrim(Str(Year(dDatabase)))


cAlias1 := GetNextAlias()
// Seleciona as compras feitas nos anos anterios ao ano do exercicio
cQuery 	:=  "SELECT SUM(FE_VALBASE) FE_VALBASE, SUM(FE_RETENC) FE_RETENC,FE_FORNECE,FE_LOJA FROM "+RetSqlName("SFE")+" SFE, "+RetSqlName("SE2")+" SE2"
cQuery	+=	" WHERE FE_FILIAL = '"+xFilial("SFE")+"' AND "
cQuery	+=	" E2_FILIAL = '"+xFilial("SE2")+"' AND "
cQuery  += " FE_ORDPAGO= E2_ORDPAGO"
cQuery += " AND SUBSTRING(FE_EMISSAO,1,4) = '" + mv_par05 + "' "
cQuery += " AND FE_FORNECE BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'"
cQuery += " AND FE_LOJA BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"
cQuery += " AND FE_TIPO = 'R'"
cQuery += " AND SUBSTRING(E2_EMISSAO,1,4) = '" + Alltrim(Str(nAnoAnteior)) + "' "
cQuery += " AND SFE.D_E_L_E_T_ = ' ' "
cQuery += " AND SE2.D_E_L_E_T_ = ' ' "
cQuery += " GROUP BY FE_FORNECE,FE_LOJA "
cQuery := ChangeQuery(cQuery)
dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAlias1, .F., .T.)

While !( cAlias1)->( Eof())

	nPos:=AScan(aDados,{|x| x[1]== FE_FORNECE .And. x[2]==FE_LOJA})
	If nPos > 0
		nBaseTotal:= aDados[nPos][3] + FE_VALBASE
		nRetTotal:= aDados[nPos][4] + FE_RETENC
		aDados[nPos][3]:= FE_VALBASE
		aDados[nPos][4]:= FE_RETENC
		aDados[nPos][6]:= nBaseTotal
		aDados[nPos][7]:= nRetTotal
	Else
  		nBaseTotal:= FE_VALBASE
		nRetTotal:=  FE_RETENC
		aDados[1][1]:= FE_FORNECE
		aDados[1][2]:= FE_LOJA
		aDados[1][3]:= FE_VALBASE
		aDados[1][4]:= FE_RETENC
		aDados[1][6]:= nBaseTotal
		aDados[1][7]:= nRetTotal
		Aadd(aDados,{"","",0,0,0,0,0})
	EndIf
	(cAlias1)->( dbSkip())
End


cAlias2 := GetNextAlias()
   	// Seleciona as retenções de compras emitidas e pagas no mesmo ano
cQuery := "SELECT SUM(FE_VALBASE) FE_VALBASE, SUM(FE_RETENC) FE_RETENC,FE_FORNECE,FE_LOJA FROM "+RetSqlName("SFE")+" SFE, "+RetSqlName("SE2")+" SE2"
cQuery += " WHERE FE_FILIAL = '"+xFilial("SFE")+"' AND "
cQuery += " E2_FILIAL = '"+xFilial("SE2")+"' AND "
cQuery += " FE_ORDPAGO = E2_ORDPAGO"
cQuery += " AND SUBSTRING(FE_EMISSAO,1,4) = '" + mv_par05 + "' "
cQuery += " AND FE_FORNECE BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "'"
cQuery += " AND FE_LOJA BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"
cQuery += " AND FE_TIPO = 'R'"
cQuery += " AND SUBSTRING(E2_EMISSAO,1,4) = '" + mv_par05 + "' "
cQuery += " AND SFE.D_E_L_E_T_ = ' ' "
cQuery += " AND SE2.D_E_L_E_T_ = ' ' "
cQuery += " GROUP BY FE_FORNECE,FE_LOJA "
cQuery := ChangeQuery(cQuery)
dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAlias2, .F., .T.)

DbSelectArea(cAlias2)
(cAlias2)->(dbGoTop())
While !( cAlias2)->( Eof())
	nPos:=AScan(aDados,{|x| x[1]== FE_FORNECE .And. x[2]==FE_LOJA})
	If nPos > 0
		nBaseTotal:= aDados[nPos][3] + FE_VALBASE
		nRetTotal:= aDados[nPos][4] + FE_RETENC
		aDados[nPos][5]:= FE_RETENC
		aDados[nPos][6]:= nBaseTotal
		aDados[nPos][7]:= nRetTotal
	Else
  		nBaseTotal:= FE_VALBASE
		nRetTotal:=  FE_RETENC

		aDados[Len(aDados)][1]:= FE_FORNECE
		aDados[Len(aDados)][2]:= FE_LOJA
		aDados[Len(aDados)][5]:= FE_RETENC
		aDados[Len(aDados)][6]:= nBaseTotal
		aDados[Len(aDados)][7]:= nRetTotal
		Aadd(aDados,{"","",0,0,0,0,0})
	EndIf
	(cAlias2)->( dbSkip())
End




If !Empty(aDados[1][1])
	PrintPag(aDados,nAnoAnteior)
Else
	Msginfo("No hay certificados para el año "+ mv_par05 + ".")
EndIf

Return

Static Function PrintPag(aDados,nAnoAnteior)
Local oPrint
Local oFont1	:= TFont():New("Arial",14,14,,.T.,,,,.T.,.F.)
Local oFont2	:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
Local oFont3	:= TFont():New("Arial",11,11,,.T.,,,,.T.,.F.)
Local oFont4	:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
Local oFont5	:= TFont():New("Arial",08,08,,.T.,,,,.T.,.F.)
Local cTitulo	:= "CERTIFICADO DE RENTAS Y RETENCIONES POR RENTAS DE CUARTA CATEGORIA"
LOCAL cSimbMoed    := GetMv("MV_SIMB1")
Local nX:= 1
Local nI := 1


DbSelectArea("FIZ")
DbSetOrder(1)
DbSeek(xFilial("FIZ")+MV_PAR06)




For nX = 1 to len(aDados)
	If !Empty(aDados[nX][1])

		//oPrint:SetLandScape() //( Para Paisagem )
		//oPrint:SetPaperSize(1)     ( 1 - Carta ) ou
		//oPrint:SetPaperSize(9)   //  ( 9 - A4 )
		oPrint	:= TMSPrinter():New( cTitulo )
		oPrint:SetPortrait()

		oPrint:StartPage()

		oPrint:Say(0170,0260,"CERTIFICADO DE RENTAS Y RETENCIONES POR RENTAS DE CUARTA CATEGORIA",oFont1)
		oPrint:Say(0270,0245,"(ARTICULO 45º DEL RECLAMENTO DE LA LEY DEL IMPUESTO A LA RENTA D.S. Nº 122-94-EF, R.S. Nº 010-2006/SUNAT)",oFont2)


		oPrint:Say(0400,0950,"EJERCICIO GRAVABLE " + mv_par05 ,oFont3)

		oPrint:Say(0510,0310,Alltrim(SM0->M0_NOME)+" SUCURSAL DEL "+Alltrim(SM0->M0_FILIAL) + "CON RUC Nº" + Alltrim(SM0->M0_CGC) ,oFont3)


		// Dados do Fornecedor
		DbSelectArea("SA2")
		DbSetOrder(1)
		DbSeek(xFilial("SA2") + aDados[nX][1]+ aDados[nX][2])
		cFornece:= Alltrim(SA2->A2_NOME)
		cCUITForn:=Transf(SA2->A2_CGC,pesqpict("SA2","A2_CGC"))
		cEnd := Alltrim(SA2->A2_END)
		cRepres:= SA2->A2_REPRES
		SX5->(DbSeek(xFilial()+"12"+SA2->A2_EST))
		cProvForn:=Alltrim(X5Descri())

		oPrint:Say(0600,1010,"CERTIFICA",oFont1)
		oPrint:Say(0700,0200,"QUE A: " + cFornece +" CON R.U.C. Nº "+ cCUITForn,oFont4)
		oPrint:Say(0750,0200,"CON DOMICILIO EN " + cEnd +" - "+cProvForn,oFont4)
		oPrint:Say(0800,0200,"SE LE HA RETENIDO POR ESTE EJERCICIO GRAVABLE LOS IMPORTES INDICADOS A CONTINUACION, COMO PAGOS A CUENTA DEL IMPUESTO",oFont4)
		oPrint:Say(0850,0200,"A LA RENTA SOBRE RENTAS DE CUARTA CATEGORIA.",oFont4)
		oPrint:Say(0900,0200,"POR CONCEPTO DE :",oFont4)

		oPrint:Say(0980,0200,"CALCULADO EN BASE A :",oFont4)

		oPrint:Say(1035,0400,"TOTAL HONORARIOS",oFont4)
		oPrint:Say(1035,1500,Transform(aDados[nX][6],"@E 999,999,999.99"),oFont4)

		oPrint:Say(1090,0400,"RETENCIONES :",oFont4)
		oPrint:Say(1150,0450,"IMPUESTO A LA RENTA RETENIDO COMO PAGO A CUENTA",oFont4)
		oPrint:Say(1150,1500,Transform(aDados[nX][7],"@E 999,999,999.99"),oFont4)

		If aDados[nX][3] > 0
			cStr1:="ASIMISMO, CERTIFICAMOS QUE " + cFornece +" "+"TIENE RENTAS DE CUARTA CATEGORIA DEVENGADAS DURANTE EL AÑO" + " " + Alltrim(Str(nAnoAnteior)) +" "+"QUE NO FUERON PUESTAS A DISPOSICION DEL MISMO POR LA SUMA DE "
			cStr2:= cSimbMoed + Alltrim(Transform(aDados[nX][3],"@E 999,999,999.99")) + " (" +Extenso(aDados[nX][3],.F.,1,,"2",.T.,.T.,.T.,"3") +") POR LAS QUE SE HAN EFECTUADO PAGO AL FISCO DE "
			cSTR3:= cSimbMoed + Alltrim(Transform(aDados[nX][4],"@E 999,999,999.99")) + " ("+ Extenso(aDados[nX][4],.F.,1,,"2",.T.,.T.,.T.,"3")+") COMO RETENCIONES A DICHAS RENTAS."
			cStr:= cSTR1+cSTR2+cSTR3
			nLinhaAux := 0
			aAuxString := FINBrkStr(cStr,120,1350)
		    For nI := 1 To Len(aAuxString)
		    	If !Empty(aAuxString[nI])
					oPrint:Say(1350+nLinhaAux,0200,aAuxString[nI],oFont4)
		   		 	nLinhaAux +=  50
		   		EndIf
			Next nI

		    nLin:= 1350+nLinhaAux + 100
		Else
			cStr:= "ASSIMISMO CERTIFICAMOS QUE "+ cFornece +" NO TIENE RENTAS DE CUARTA CATEGORIA DEVENGADAS DURANTE EL AÑO " + Alltrim(Str(nAnoAnteior)+".")
			nLinhaAux := 0
			aAuxString := FINBrkStr(cStr,120,1350)
		    For nI := 1 To Len(aAuxString)
		    	If !Empty(aAuxString[nI])
					oPrint:Say(1350+nLinhaAux,0200,aAuxString[nI],oFont4)
		   		 	nLinhaAux +=  50
		   		EndIf
			Next nI

		    nLin:= 1350+nLinhaAux + 100

		EndIf

		oPrint:Say(nLin,0200,"FINALMENTE SE DEJA CONSTANCIA QUE EL IMPORTE DEL CREDITO CONTRA EL IMPUESTO A LA RENTA DEL EJERCICIO A QUE TIENE" ,oFont4)
		oPrint:Say(nLin+50,0200," DERECHO EL, CONTRIBUYENTE INDICADO, POR LAS RETENCIONES EFECTUADAS, ES DE ",oFont4)
		oPrint:Say(nLin+50,1450,cSimbMoed + Alltrim(Transform(aDados[nX][5],"@E 999,999,999.99")),oFont5)


		oPrint:Line(nLin+600 ,0750,nLin+600,1500)
		oPrint:Say( nLin+625,0800,Alltrim(FIZ->FIZ_NOME),oFont4)
		oPrint:Say( nLin+670,0800,FIZ->FIZ_IDENTIF,oFont4)
		oPrint:Say(nLin+720,0800,"REPRESENTANTE LEGAL",oFont4)


		oPrint:Say(nLin+1020,0200,UPPER(dDataCert),oFont4)


		oPrint:EndPage()
		oPrint:Preview()

	EndIf
Next nX

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  FINBrkStr  ºAutor  ³				     º Data ³  20/12/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Quebra linhas no TMSPrinter                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FINBrkStr(cStr,nTam,nLin)
Local cTexto	:= ""
Local nPos		:= 0
Local nX		:= 0
Local aRet		:= {}
Local aPalavras	:= {}

Default cStr	:= ""
Default nTam	:= 0
Default nLin	:= 0

If !Empty(cStr)
	cTexto := Alltrim(cStr)
	nPos := AT(" ",cTexto)
	While nPos > 0
		Aadd(aPalavras,Substr(cTexto,1,nPos-1))
		cTexto := Substr(cTexto,nPos + 1)
		nPos := AT(" ",cTexto)
	Enddo
	Aadd(aPalavras,Alltrim(cTexto))
Endif
If nTam > 0
	nX := 1
	cTexto := ""
	While nX <= Len(aPalavras)
		If (Len(cTexto) + Len(aPalavras[nX])) <= nTam
			cTexto += aPalavras[nX]
			cTexto += " "
			nX++
		Else
			If !Empty(cTexto)
				Aadd(aRet,Alltrim(cTexto))
				cTexto := ""
			Else
				Aadd(aRet,aPalavras[nX])
				nX++
			Endif
		Endif
	Enddo
	If !Empty(cTexto)
		Aadd(aRet,cTexto)
	Endif
Else
	aRet := AClone(aPalavras)
Endif
If nLin > 0
	If Len(aRet) < nLin
		For nX := 1 To (nLin - Len(aRet))
			Aadd(aRet," ")
		Next
	Else
		If Len(aRet) > nLin
			aRet := Asize(aRet,nLin)
		Endif
	Endif
Endif
Return(aRet)
