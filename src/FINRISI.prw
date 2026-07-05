/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINRISI   ºAutor  ³ Acacio Egas        º Data ³  02/03/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio de comprovante retenção de ISI. Imposto da       º±±
±±º          ³ municipio de Zarate (Argentina)                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FinRISI()

Local cPerg := "FinRISI"

Pergunte(cPerg)

PrintISI()

return

Static Function PrintISI()

Local nX
Local aNfs	:= {}
Local cChave
Local cTitulo	:= "COMPROBANTE DE RETENCION DE ISI"
Local oPrint

oPrint	:= TMSPrinter():New( cTitulo )
oPrint:SetPortrait() //Retrato
//oPrint:SetLandscape() //Paisagem

DbSelectArea("SFE")
DbSetOrder(4)
If !Empty(MV_PAR01)
	DbSeek(xFilial("SFE")+MV_PAR01)
Else
	DbSeek(xFilial("SFE"))
EndIf

bFil 	:= {|| SFE->FE_FILIAL==xFilial("SFE")}
bFornec := {|| SFE->FE_FORNECE>=MV_PAR01 .and. SFE->FE_FORNECE<=MV_PAR02 }
bNota	:= {|| SFE->(FE_NFISCAL+FE_SERIE)>=MV_PAR03+MV_PAR05 .and. SFE->(FE_NFISCAL+FE_SERIE)<=MV_PAR04+MV_PAR06}


Do While !SFE->(Eof())

	If EVAL(bFil) .and. EVAL(bFornec) .and. EVAL(bNota)

		If SFE->FE_TIPO == "Z"

			If (nX := aScan( aNfs , {|x| SFE->FE_NFISCAL==x[1]  } )==0)
				aAdd( aNfs , {SFE->FE_NFISCAL,{SFE->FE_VALBASE,SFE->FE_RETENC,SFE->FE_ALIQ}} )
			Else
				//	aAdd( aNfs[2] , {SFE->FE_VALBASE,SFE->FE_RETENC,SFE->FE_ALIQ} ) Imprime cada pagamento
				aNfs[2,1]	+= SFE->FE_VALBASE
				aNfs[2,2]	+= SFE->FE_RETENC
			EndIf

		EndIf

	EndIf

	SFE->(DbSkip())

	If Len(aNfs)>0 .and. SFE->(Eof()) .or. cChave <> SFE->(FE_FILIAL+FE_FORNECE+FE_LOJA+FE_NFISCAL+FE_SERIE+FE_TIPO)

		DbSelectArea("SA2")
		DbSetOrder(1)
		DbSeek(xFilial("SA2") + SFE->FE_FORNECE + SFE->FE_LOJA)

//		DbSelectArea("SM0")
//		DbSeek(cEmpAnt+cFilAnt)

		PrintPag( oPrint , aNfs )
		cChave := SFE->(FE_FILIAL+FE_FORNECE+FE_LOJA+FE_NFISCAL+FE_SERIE+FE_TIPO)
		aNfs := {}

	EndIf

EndDo


oPrint:Preview()

Return

Static Function PrintPag( oPrint , aNfs )

Local cStartPath:= GetSrvProfString("StartPath","")
Local cBmp 		:= cStartPath + "ZARATE.BMP" //Logo do municipio de Zarate
Local oFont1	:= TFont():New("Arial",16,16,,.T.,,,,.T.,.F.)// Fonte o Titulo Negrito
Local oFont2	:= TFont():New("Arial",14,14,,.F.,,,,.T.,.F.)// Fonte do Sub-Titulo
Local oFont2n	:= TFont():New("Arial",14,14,,.T.,,,,.T.,.F.)// Fonte do Sub-Titulo
Local oFont3	:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
Local oFont4	:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
Local nVia
Local nI,nX

For nI:= 1 To Len(aNFs)
	oPrint:StartPage()
	For nX:= 1 To 2

		If nX==2
			nVia    := 1550 // Imprime 2° Via
		Else
			nVia    := 0
		EndIf

		oPrint:Box( nVia + 0450,0100, nVia + 1800,2250)
		oPrint:Box( nVia + 0450,0100, nVia + 0850,1800)
		oPrint:Say( nVia + 0500,0700,"COMPROBANTE DE RETENCION",oFont1)
		oPrint:Say( nVia + 0625,0600,"TASA POR INSPECCION DE SEGURIDAD E HIGIENE",oFont2)
		oPrint:Say( nVia + 0750,0800,"MUNICIPALIDAD DE ZARATE",oFont2n)

		oPrint:Box( nVia + 0450,1800, nVia + 0850,2250)
		oPrint:SayBitmap( nVia + 0500, 1850,cBmp, 350, 350)

		oPrint:Say( nVia + 0850,0850,"DADOS DEL AGENTE DE RETENCION",oFont2n)
		oPrint:Box( nVia + 0910,0100, nVia + 0970,1150);oPrint:Box( nVia + 0910,1150, nVia + 0970,1600);oPrint:Box( nVia + 0910,1600, nVia + 0970,2250)
		oPrint:Say( nVia + 0910,0150,SM0->M0_NOMECOM,oFont4)  // Empresa
		oPrint:Say( nVia + 0910,1200,SM0->M0_CGC,oFont4)   // Cuit
		oPrint:Say( nVia + 0910,1650,SM0->M0_INSC,oFont4)   // Legajo Municipal
		oPrint:Say( nVia + 0970,0300,"APELLIDO(S) Y NOMBRE(S) O RAZÓN SOCIAL",oFont4)
		oPrint:Say( nVia + 0970,1300,"C.U.I.T.",oFont4)
		oPrint:Say( nVia + 0970,1800,"LAGAJO MUNICIPAL",oFont4)
		oPrint:Box( nVia + 0970,0100, nVia + 1000,2250)

		oPrint:Say( nVia + 1000,0750,"DADOS DEL SUJETO PASIBLE DE RETENCION",oFont2n)
		oPrint:Box( nVia + 1060,0100, nVia + 1120,1700);oPrint:Box( nVia + 1060,1700, nVia + 1120,2250)
		oPrint:Say( nVia + 1070,0200,SA2->A2_NOME,oFont3) // Fornecedor
		oPrint:Say( nVia + 1070,1800,SA2->A2_CGC,oFont3)  // Cuit Fornecedor
		oPrint:Say( nVia + 1120,0450,"APELLIDO(S) Y NOMBRE(S) O RAZÓN SOCIAL",oFont4)
		oPrint:Say( nVia + 1120,1900,"C.U.I.T.",oFont4)
		oPrint:Box( nVia + 1120,0100, nVia + 1150,2250)
		oPrint:Box( nVia + 1150,0100, nVia + 1210,0800);oPrint:Box( nVia + 1150,0800, nVia + 1210,1100);oPrint:Box( nVia + 1150,1100, nVia + 1210,1300);oPrint:Box( nVia + 1150,1300, nVia + 1210,1650);oPrint:Box( nVia + 1150,1650, nVia + 1210,2250)
		oPrint:Say( nVia + 1150,0150,SA2->A2_END,oFont4) // Endereço
		oPrint:Say( nVia + 1150,1125,SA2->A2_INSCRM,oFont4)// Inscrição
		oPrint:Say( nVia + 1210,0350,"DOMICILIO FISAL:CALLE",oFont4)
		oPrint:Say( nVia + 1210,0850,"NUMERO",oFont4)
		oPrint:Say( nVia + 1210,1175,"PISO",oFont4)
		oPrint:Say( nVia + 1210,1400,"DPTO",oFont4)
		oPrint:Say( nVia + 1210,1850,"Legajo Municial",oFont4)
//		oPrint:Box( nVia + 1210,0100, nVia + 1240,2250)
		oPrint:Box( nVia + 1240,0100, nVia + 1300,0800);oPrint:Box( nVia + 1240,0800, nVia + 1300,1350);oPrint:Box( nVia + 1240,1350, nVia + 1300,1800);oPrint:Box( nVia + 1240,1800, nVia + 1300,2250)
		oPrint:Say( nVia + 1240,0250,SA2->A2_CEP,oFont4) // Cep
		oPrint:Say( nVia + 1240,0900,SA2->A2_MUN,oFont4) // Municipio
		oPrint:Say( nVia + 1240,1900,SA2->A2_EST,oFont4) // Estado
		oPrint:Box( nVia + 1300,0100, nVia + 1330,2250)
		oPrint:Say( nVia + 1300,0350,"COD. POSTAL",oFont4)
		oPrint:Say( nVia + 1300,1050,"LOCALIDAD",oFont4)
		oPrint:Say( nVia + 1300,1450,"PARTIDO",oFont4)
		oPrint:Say( nVia + 1300,1900,"PROVINCIA",oFont4)

		oPrint:Box( nVia + 1330,0100, nVia + 1390,2250)
		oPrint:Say( nVia + 1330,0900,"DATOS DE LA OPERACION",oFont2n)
		oPrint:Box( nVia + 1390,0100, nVia + 1450,0500);oPrint:Box( nVia + 1390,0500, nVia + 1450,1100);oPrint:Box( nVia + 1390,1100, nVia + 1450,1500);oPrint:Box( nVia + 1390,1500, nVia + 1450,1850);oPrint:Box( nVia + 1390,1850, nVia + 1450,2250)
//		oPrint:Say( nVia + 1390,0200,"FACTURA N°",oFont4)
		oPrint:Say( nVia + 1390,0700,aNFs[nI,1],oFont4)
		oPrint:Say( nVia + 1390,1250,Transform(aNFs[nI,2,1], "@E 999,999,999.99"),oFont4) // Base de calculo
		oPrint:Say( nVia + 1390,1600,Transform((aNFs[nI,2,3]*10), "@E 999,999,999.99"),oFont4) // Aliquota por 1000
		oPrint:Say( nVia + 1390,1950,Transform(aNFs[nI,2,2], "@E 999,999,999.99"),oFont4) // Retenção
		oPrint:Box( nVia + 1450,0100, nVia + 1480,2250)
		oPrint:Say( nVia + 1450,0250,"FECHA",oFont4)
		oPrint:Say( nVia + 1450,0650,"FACTURA N°",oFont4)
		oPrint:Say( nVia + 1450,1250,"MONTO",oFont4)
		oPrint:Say( nVia + 1450,1550,"ALICUOTA(por mil)",oFont4)
		oPrint:Say( nVia + 1450,1950,"RETENCION",oFont4)

		oPrint:Say( nVia + 1730,0300,"LUGAR Y FECHA",oFont4)
		oPrint:Say( nVia + 1730,1800,"FIRMA/ACLARACION SELLO",oFont4)

	Next
	oPrint:EndPage()
Next

Return
