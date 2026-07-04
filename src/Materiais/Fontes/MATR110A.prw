/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "REPORT.CH"
#include "rwmake.ch"
#INCLUDE "MATR110A.CH"

Static lLGPD  := FindFunction("SuprLGPD") .And. SuprLGPD()
/*-------------------------------------------------------------------------------------------
Função: U_Matr110a()

Descrição: Esta rotina tem como objetivo imprimir os pedidos de compras com um layout
alternativo com o objeto TmsPrinter

---------------------------------------------------------------------------------------------*/

User Function Matr110a(cNumPed)

DEFAULT cNumPed		:= ""
Private _cAlias		:= GetNextAlias()
Private _cAlias1	:= GetNextAlias()
Private cEOL 		:= "CHR(13)+CHR(10)"
Private cPerg   	:= "MTR110A" // Nome do grupo de perguntas

If !Empty(cNumPed)
	Pergunte(cPerg,.F.)
	MV_PAR01 := Replicate(" ", Len(SA2->A2_COD)) 
	MV_PAR02 := Replicate("Z", Len(SA2->A2_COD))
	MV_PAR03 := Replicate(" ", Len(SA2->A2_LOJA)) 
	MV_PAR04 := Replicate("Z", Len(SA2->A2_LOJA))
	MV_PAR05 := cNumPed
	MV_PAR06 := cNumPed
	MV_PAR07 := CTOD("01/01/1900")
	MV_PAR08 := CTOD("31/12/2049")
ElseIf !Pergunte(cPerg,.T.)
	
	Return
Endif

If Empty(cEOL)
	cEOL := CHR(13)+CHR(10)
Else
	cEOL := Trim(cEOL)
	cEOL := &cEOL
Endif

//Monta arquivo de trabalho temporário
MsAguarde({||MontaQuery()},STR0001,STR0002) //"Aguarde"##"Criando arquivos para impressão..."

//Verifica resultado da query

DbSelectArea(_cAlias)
DbGoTop()
If (_cAlias)->(Eof())
	MsgAlert(STR0003,STR0004)  //"Relatório vazio! Verifique os parâmetros."##"Atenção"
	(_cAlias)->(DbCloseArea())
Else
	Processa({|| Imprime() },STR0005,STR0006) //"Pedido de Compras "##"Imprimindo..."
EndIf

Return

//********************************************************************************************
//                                          MONTA A PAGINA DE IMPRESSAO
//********************************************************************************************
Static Function Imprime()
Local _nCont 		:= 1
Local cPedidoAtu	:= ""
Local cPedidoAnt	:= ""
Local cQuantPict:= X3Picture("C7_QUANT")
Local cPrecoPict:= X3Picture("C7_PRECO")
Local cTotalPict:= X3Picture("C7_TOTAL")
Local cIPIPict	:= X3Picture("C7_IPI")

Private cBitmap	:= ""
Private cStartPath:= GetSrvProfString("Startpath","")
Private cPosi
Private nLin
Private _nValIcm		:= 0   // Valor do Icms
Private _nValIcmR		:= 0	// Valore do Icms retido
Private _nValIpi		:= 0   // Valor do Ipi
Private _nPag  		:= 1   // Numero da
Private _nTot    		:= 0   // Valor Total
Private _nFrete		:= 0   // Valor do frete
Private _nDescPed		:= 0
Private _nDesc1	 	:= 0
Private _nDesc2	 	:= 0 
Private _nDesc3	 	:= 0
Private _nDespesa	:= 0
Private _nSeguro		:= 0
Private _dDtEnt
Private _cEndEnt		:= ""
Private _cBairEnt		:= ""
Private _cCidEnt		:= ""
Private _cEstEnt		:= ""		
Private _cTel			:= ""

cBitmap := R110ALogo()

//Fontes a serem utilizadas no relatório
Private oFont08  	:= TFont():New( "Arial",,08,,.F.,,,,,.f.)
Private oFont08N 	:= TFont():New( "Arial",,08,,.T.,,,,,.f.)
Private oFont08I 	:= TFont():New( "Arial",,08,,.f.,,,,,.f.,.T.)
Private oFont09  	:= TFont():New( "Arial",,09,,.F.,,,,,.f.)
Private oFont09N 	:= TFont():New( "Arial",,09,,.T.,,,,,.f.)
Private oFontC9  	:= TFont():New( "Courier New",,09,,.F.,,,,,.f.)
Private oFontC9N 	:= TFont():New( "Courier New",,09,,.T.,,,,,.f.)
Private oFont10  	:= TFont():New( "Arial",,10,,.f.,,,,,.f.)
Private oFont10N 	:= TFont():New( "Arial",,10,,.T.,,,,,.f.)
Private oFont10I 	:= TFont():New( "Arial",,10,,.f.,,,,,.f.,.T.)
Private oFont11  	:= TFont():New( "Arial",,11,,.f.,,,,,.f.)
Private oFont11N 	:= TFont():New( "Arial",,11,,.T.,,,,,.f.)
Private oFont12N 	:= TFont():New( "Arial",,12,,.T.,,,,,.f.)
Private oFont12  	:= TFont():New( "Arial",,12,,.F.,,,,,.F.)
Private oFont12NS	:= TFont():New( "Arial",,12,,.T.,,,,,.T.)
Private oFont13N 	:= TFont():New( "Arial",,13,,.T.,,,,,.f.)
Private oFont17 	:= TFont():New( "Arial",,17,,.F.,,,,,.F.)
Private oFont17N 	:= TFont():New( "Arial",,17,,.T.,,,,,.F.)

//Start de impressão
Private oPrn:= TMSPrinter():New()

oPrn:SetLandScape()  // SetPortrait() - Formato retrato   SetLandscape() - Formato Paisagem

oPrn:SetPaperSize(DMPAPER_A4)

//cabecalho da pagina
Cabec(.t.)

cPedidoAnt := (_cAlias)->C7_NUM

If((_cAlias)->C7_FILENT != NIL) 	 
 	GetInfFil((_cAlias)->C7_FILENT,@_cEndEnt,@_cBairEnt,@_cCidEnt, @_cEstEnt, @_cTel)// Carrega dados da filial de Entrega	
EndIf

While (_cAlias)->(!Eof())

	
	cPedidoAtu := (_cAlias)->C7_NUM
	
	If _nCont >= 29 .Or. cPedidoAtu <> cPedidoAnt
		
		If cPedidoAtu <> cPedidoAnt			
			
			Rodap()
			
			If((_cAlias)->C7_FILENT != NIL)
				GetInfFil((_cAlias)->C7_FILENT,@_cEndEnt,@_cBairEnt,@_cCidEnt, @_cEstEnt, @_cTel)// Carrega dados da filial de Entrega
			EndIf
			
			_nDescPed 	:= 0
			_nDesc1 	:= 0
			_nDesc2 	:= 0
			_nDesc3 	:= 0
			_nValIpi	:= 0
			_nValIcm	:= 0
			_nValIcmR	:= 0
			_nTot		:= 0
			_nFrete	:= 0
			_dDtEnt 	:= NIL
			
			oPrn :EndPage()			
		Else
			oPrn:line(1960,0075,1960,3425)    //Linha Horizontal Rodape Inferior
		EndIf
		
		_nCont		:= 0
		_nPag 		+= 1
		
		oPrn :EndPage() 
		Cabec(.t.)
	EndIf
		
	oPrn:say(nLin,0035,(_cAlias)->C7_ITEM						, oFont08)		//item
	oPrn:say(nLin,0116,Transform((_cAlias)->C7_QUANT,cQuantPict), oFont08)		//Quantidade 
	oPrn:say(nLin,0370,Substr((_cAlias)->C7_PRODUTO,1,25)		, oFont08)		//codigo
	
	If ValType(mv_par10) == "N" .And. mv_par10 == 1 //1=Imprime Codigo do Produto do Fornecedor / 2=Nao imprime cod. do fornecedor
		oPrn:say(nLin,0850,Substr((_cAlias)->A5_CODPRF,1,18)	, oFont08)		//codigo do fornecedor
	Else
		oPrn:say(nLin,0850,"********", oFont08)
	EndIf
	
	oPrn:say(nLin,1200,(_cAlias)->C7_UM							, oFont08)		//unidade de medida
	oPrn:say(nLin,1400,Substr((_cAlias)->B1_DESC,1,70)			, oFont08)		//descricao
	oPrn:say(nLin,2250,Transform((_cAlias)->C7_PRECO,cPrecoPict), oFont08)		//VLR UNIT
	oPrn:say(nLin,2570,Transform((_cAlias)->C7_TOTAL,cTotalPict), oFont08)		//VLR TOT
	oPrn:say(nLin,2890,Transform((_cAlias)->C7_IPI,cIPIPict)	, oFont08)		//IPI
	oPrn:say(nLin,3150,DTOC((_cAlias)->C7_DATPRF)				, oFont08)		//data de entrega
	
	_nFrete	+= (_cAlias)->C7_VALFRE
	
	If (_cAlias)->C7_DESC1 != 0 .or. (_cAlias)->C7_DESC2 != 0 .or. (_cAlias)->C7_DESC3 != 0
		_nDescPed  += CalcDesc((_cAlias)->C7_TOTAL,(_cAlias)->C7_DESC1,(_cAlias)->C7_DESC2,(_cAlias)->C7_DESC3)
	    _nDesc1	:= (_cAlias)->C7_DESC1
		_nDesc2	:= (_cAlias)->C7_DESC2
		_nDesc3	:= (_cAlias)->C7_DESC3
	Else
		_nDescPed += (_cAlias)->C7_VLDESC
	Endif
	
	If _dDtEnt == NIL
		_dDtEnt := (_cAlias)->C7_DATPRF 
	ElseIf (_cAlias)->C7_DATPRF > _dDtEnt
		_dDtEnt := (_cAlias)->C7_DATPRF 
	Endif
	
	_nCont 		+= 1
	_nValIcm 	+= (_cAlias)->C7_VALICM
	If cPaisLoc == "BRA"
		_nValIcmR	+= (_cAlias)->C7_ICMSRET 
	EndIf
	_nValIpi 	+= (_cAlias)->C7_VALIPI
	_nTot 	 	+= (_cAlias)->C7_TOTAL
	_nDespesa 	+= (_cAlias)->C7_DESPESA
	_nSeguro	+= (_cAlias)->C7_SEGURO
	
	nLin += 50   //pula linha
	
	cPedidoAnt := (_cAlias)->C7_NUM
	
	//Verifica a quebra de pagina	
	(_cAlias)->(dbSkip())
EndDo

If _nCont <= 32
	(_cAlias)->(DbGoTop())
	Rodap()
Else
	(_cAlias)->(DbGoTop())
	Rodap()
	oPrn :EndPage()
	Cabec(.F.)
	Rodap()
EndIF

If(mv_par09 == 1)
  oPrn:Print()
Else
  oPrn:Preview() //Preview DO RELATORIO
EndIf

Return

//********************************************************************************************
//										Impressão do Relatório
//********************************************************************************************
Static Function  Cabec(_lCabec)

oPrn:StartPage()	//Inicia uma nova pagina

_cFileLogo	:= GetSrvProfString('Startpath','') + cBitmap

oPrn:SayBitmap(0045,0060,_cFileLogo,0400,0125)

oPrn:say(0070,1000, STR0007+ " " +Alltrim((_cAlias)->C7_NUM),oFont17) //"PEDIDO DE COMPRA:"
oPrn:say(0070,1865,Iif(!Empty(Alltrim((_cAlias)->C7_OP))," |   OP: " +Alltrim((_cAlias)->C7_OP),""),oFont17N)
oPrn:say(0090,2800, STR0008+ " " + dtoc((_cAlias)->C7_EMISSAO) ,oFont08) //"EMISSÃO:"

oPrn:line(180,1350,430,1350) 	//Linha Vertical Cabecalho                                               '
oPrn:line(445,0035,445,3425)    //Linha Horizontal Cabecalho Inferior
oPrn:line(505,0035,505,3425)    //Linha Horizontal Cabecalho Inferior

//********************************************************************************************
//										cabecalho
//********************************************************************************************

// Primeira coluna do cabecalho
nLin := 225
oPrn:say (nLin,0035, SM0->M0_NOMECOM ,oFont08)
nLin += 50
oPrn:say (nLin,0035,STR0009+" "+Transform(SM0->M0_CGC,"@R 99.999.999/9999-99")+"  -  "+STR0010+" "+Alltrim(SM0->M0_INSC) ,oFont08)  //"CNPJ:"##"I.E:"
nLin += 50
oPrn:say (nLin,0035,Alltrim(SM0->M0_ENDCOB)+" "+ Alltrim(SM0->M0_BAIRCOB)+" - "+Alltrim(SM0->M0_CIDCOB)+" /"+Alltrim(SM0->M0_ESTCOB)+" "+STR0011+" "+(SM0->M0_CEPENT),oFont08) //"CEP:"
nLin += 50
oPrn:say (nLin,0035,STR0012+" "+Alltrim(SM0->M0_TEL)+"  -  "+STR0013+" "+Alltrim(SM0->M0_FAX) ,oFont08) //"TEL.:"##"FAX:"

//............................................................................................
// Segunda coluna do cabecalho (FORNECEDOR)
nLin := 180
oPrn:say (nLin,1365,STR0014,oFont08I)  //"Fornecedor"
nLin += 40
oPrn:say (nLin,1365,(_cAlias)->A2_COD+" - ", oFont08)
oPrn:say (nLin,1535,;
If(lLGPD,RetTxtLGPD((_cAlias)->A2_NOME,"A2_NOME"),(_cAlias)->A2_NOME), oFont08)

oPrn:say (nLin,2700,STR0009+" ", oFont08I) //"CNPJ:"
oPrn:say (nLin,2830,Transform(;
If(lLGPD,RetTxtLGPD((_cAlias)->A2_CGC,"A2_CGC"),(_cAlias)->A2_CGC),"@R 99.999.999/9999-99"), oFont08)

nLin += 50
oPrn:say (nLin,1365,STR0015+" ", oFont08I) //"End:"
oPrn:say (nlin,1535,;
If(lLGPD,RetTxtLGPD((_cAlias)->A2_END,"A2_END"),(_cAlias)->A2_END), oFont08)


oPrn:say (nLin,2700,STR0010+" ",oFont08I) //"I.E:"
oPrn:say (nLin,2830,Transform(;
If(lLGPD,RetTxtLGPD((_cAlias)->A2_INSCR,"A2_INSCR"),(_cAlias)->A2_INSCR),"@R 999.999.999.999"),oFont08)

nLin += 50
oPrn:say (nLin,1365,STR0016+" ", oFont08I) //"Bairro:"
oPrn:say (nLin,1535,;
If(lLGPD,RetTxtLGPD((_cAlias)->A2_BAIRRO,"A2_BAIRRO"),(_cAlias)->A2_BAIRRO),oFont08)

oPrn:say (nLin,2125,STR0017+" ", oFont08I) //"Municipio/UF:"
oPrn:say (nLin,2370,Alltrim(;
If(lLGPD,RetTxtLGPD((_cAlias)->A2_MUN,"A2_MUN"),(_cAlias)->A2_MUN))+" / "+;
If(lLGPD,RetTxtLGPD((_cAlias)->A2_EST,"A2_EST"),(_cAlias)->A2_EST),oFont08)


oPrn:say (nLin,2700,STR0011+" ", oFont08I) //"CEP:"
oPrn:say (nLin,2830,Transform(;
If(lLGPD,RetTxtLGPD((_cAlias)->A2_CEP,"A2_CEP"),(_cAlias)->A2_CEP),"@R 99.999-999"), oFont08)

nLin += 50
oPrn:say (nLin,1365,STR0012+" ", oFont08I) //"TEL.:"
oPrn:say (nLin,1535,"("+Alltrim(;
If(lLGPD,RetTxtLGPD((_cAlias)->A2_DDD,"A2_DDD"),(_cAlias)->A2_DDD))+") "+Transform(;
If(lLGPD,RetTxtLGPD((_cAlias)->A2_TEL,"A2_TEL"),(_cAlias)->A2_TEL),"@R 9999-9999"),oFont08)


oPrn:say (nLin,2125,STR0013+" ", oFont08I) //"FAX:"
oPrn:say (nLin,2370,"("+Alltrim(;
If(lLGPD,RetTxtLGPD((_cAlias)->A2_DDD,"A2_DDD"),(_cAlias)->A2_DDD))+") "+Transform(;
If(lLGPD,RetTxtLGPD((_cAlias)->A2_FAX,"A2_FAX"),(_cAlias)->A2_FAX),"@R 9999-9999"),oFont08)

//********************************************************************************************
//										Corpo
//********************************************************************************************
nLin := 450
// Subtitulo do Corpo
oPrn:say (nLin,0035,STR0018,oFont08I) //"Item"
oPrn:say (nLin,0116,STR0019,oFont08I) //"Qtde" 
oPrn:say (nLin,0370,STR0020,oFont08I) //"Código"
oPrn:say (nLin,0850,STR0021,oFont08I) //"Cód. Prod. Fornec."
oPrn:say (nLin,1200,STR0041,oFont08I) //unidade de medida
oPrn:say (nLin,1400,STR0022,oFont08I) //"Descrição" 
oPrn:say (nLin,2300,STR0024,oFont08I) //"Vl. Unit."
oPrn:say (nLin,2600,STR0025,oFont08I) //"Vl. Total"
oPrn:say (nLin,2900,STR0026,oFont08I) //"IPI"
oPrn:say (nLin,3150,STR0042,oFont08I) //data de entrega

nLin := 510
oPrn:say (2340,3330,Transform(_nPag,"@R 999"),oFont08I)    //Impressão do numero da página

return
//********************************************************************************************
//										Rodape
//********************************************************************************************
Static Function Rodap()
oPrn:line(1900,0035,1900,3425)    //Linha Horizontal Rodape Inferior
oPrn:line(1960,0035,1960,3425)    //Linha Horizontal Rodape Inferior
oPrn:line(2120,0035,2120,3425)    //Linha Horizontal Rodape Inferior  Alterado em 22.08.2012 por André Luiz de Sousa

nLin := 1905

_nTot := (_nTot + _nValIcmR + _nValIpi + _nDespesa + _nSeguro - _nDescPed)

oPrn:say(nLin,0035,STR0027+" "+Transform(_nDesc1,"@E 999.99")+"%  "+Transform(_nDesc2,"@E 999.99")+"%  "+Transform(_nDesc3,"@E 999.99")+"%    "+Transform(_nDescPed, "@E 999,999,999.99") ,oFont08I) //"Desc:"
oPrn:say(nLin,0700,STR0028+" "+Transform(_nValIcm,"@E 999,999,999.99"),oFont08I) 		//"ICMS:"
oPrn:say(nLin,1100,STR0029+" "+Transform(_nValIpi,"@E 999,999,999.99"),oFont08I) 		//"IPI:"
oPrn:say(nLin,1500,STR0044+" "+Transform(_nDespesa,"@E 99,999,999.99"),oFont08I)		//"Despesas: "
oPrn:say(nLin,1900,STR0045+" "+Transform(_nSeguro,"@E 99,999,999.99"),oFont08I)		//"Seguro: "
oPrn:say(nLin,2300,STR0043+" "+Transform(_nFrete,"@E 999,999,999.99"),oFont08I) 		//"Vlr Frete:"
oPrn:say(nLin,2700,STR0030+" "+Transform(_nTot,"@E 999,999,999.99"),oFont08N) 			//"Valor Total:"
nLin += 110
oPrn:say(nLin,0035,STR0031+"  "+DTOC(_dDtEnt),oFont08) 										//"Prazo Programado p/ Entrega:"
nLin += 50
oPrn:say(nLin,0035,STR0032+" "+Alltrim(_cEndEnt) +" - "+Alltrim(_cBairEnt),oFont08) 	//"Endereço de Entrega:"
oPrn:say(nLin,1700,STR0033+" "+Alltrim(_cCidEnt)+ "/" +Alltrim(_cEstEnt),oFont08) 		//"Cidade / UF:"
oPrn:say(nLin,2300,STR0034+" "+Alltrim(_cTel),oFont08) 									//"Telefone:"

oPrn :EndPage()

Return

//********************************************************************************************
// 										   		QUERY
//********************************************************************************************
Static Function MontaQuery

Local cQuery  

cQuery := "SELECT DISTINCT SC7.C7_NUM,SC7.C7_ITEM,SC7.C7_FILENT, SC7.C7_VALFRE, SC7.C7_UM, SC7.C7_OP,"
cQuery += " SC7.C7_QUANT, SC7.C7_PRODUTO, SC7.C7_FORNECE, SC7.C7_LOJA, SC7.C7_DESCRI, SC7.C7_PRECO,"
cQuery += " SC7.C7_TOTAL, SC7.C7_EMISSAO, SC7.C7_DATPRF, SC7.C7_IPI, SC7.C7_DESC1,"
cQuery += " SC7.C7_DESC2, SC7.C7_DESC3, SC7.C7_VLDESC, SC7.C7_BASEICM, SC7.C7_BASEIPI, SC7.C7_VALIPI,"
cQuery += " SC7.C7_VALICM,SC7.C7_DT_EMB, SC7.C7_TOTAL, SC7.C7_CODTAB, SC7.C7_SEGURO, SC7.C7_DESPESA,"
If cPaisLoc == "BRA"
	cQuery += " SC7.C7_ICMSRET,"
EndIf
cQuery += " SA2.A2_COD, SA2.A2_NOME, SA2.A2_END, SA2.A2_BAIRRO, SA2.A2_EST, SA2.A2_MUN, SA2.A2_CEP,"
cQuery += " SA2.A2_CGC, SA2.A2_INSCR, SA2.A2_TEL, SA2.A2_FAX, SA2.A2_DDD, 
If ValType(mv_par10) == "N" .And. mv_par10 == 1
	cQuery += " SA5.A5_CODPRF,"
Else 
	cQuery += " SA5.A5_PRODUTO,"
EndIf
cQuery += " SB1.B1_DESC"

cQuery += " FROM "+RetSqlName('SC7')+" SC7 "
cQuery += " INNER JOIN "+RetSqlName('SA2')+" SA2 ON SA2.A2_FILIAL = '"+xFilial("SA2")+"' AND SC7.C7_FORNECE =  SA2.A2_COD     AND SC7.C7_LOJA = SA2.A2_LOJA        AND SA2.D_E_L_E_T_ = ' ' "
cQuery += " LEFT JOIN "+RetSqlName('SA5')+" SA5 ON SA5.A5_FILIAL = '"+xFilial("SA5")+"'  AND SC7.C7_PRODUTO =  SA5.A5_PRODUTO AND SC7.C7_FORNECE =  SA5.A5_FORNECE AND SC7.C7_LOJA = SA5.A5_LOJA  AND SA5.D_E_L_E_T_ = ' ' "
cQuery += " INNER JOIN "+RetSqlName('SB1')+" SB1 ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' AND SC7.C7_PRODUTO =  SB1.B1_COD     AND SB1.D_E_L_E_T_ = ' ' "
cQuery += " WHERE SC7.C7_FILIAL = '"+xFilial("SC7")+"' "
cQuery += " AND SC7.C7_FORNECE BETWEEN '"+(MV_PAR01)+"' AND '"+(MV_PAR02)+"' "
cQuery += " AND SC7.C7_LOJA    BETWEEN '"+(MV_PAR03)+"' AND '"+(MV_PAR04)+"' "
cQuery += " AND SC7.C7_NUM     BETWEEN '"+(MV_PAR05)+"' AND '"+(MV_PAR06)+"' "
cQuery += " AND SC7.C7_EMISSAO BETWEEN '"+Dtos(MV_PAR07)+"' AND '"+Dtos(MV_PAR08)+"' "
cQuery += " AND SC7.D_E_L_E_T_ = ' ' "

If Upper(TcGetDb()) $ "ORACLE.INFORMIX"
	cQuery += "   ORDER BY 1,2"
Else
	cQuery += "   ORDER BY SC7.C7_NUM,SC7.C7_ITEM"
Endif

//Criar alias temporário
TCQUERY cQuery NEW ALIAS (_cAlias)

tCSetField((_cAlias), "C7_EMISSAO", "D")
tCSetField((_cAlias), "C7_DATPRF",  "D")
tCSetField((_cAlias), "C7_DT_EMB",  "D")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³R110ALogo ³ Autor ³ Materiais             ³ Data ³08/01/2015³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Retorna string com o nome do arquivo bitmap de logotipo    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR110A                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R110ALogo()

Local cRet := "LGRL"+SM0->M0_CODIGO+SM0->M0_CODFIL+".BMP" // Empresa+Filial

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao encontrar o arquivo com o codigo do grupo de empresas ³
//³ completo, retira os espacos em branco do codigo da empresa   ³
//³ para nova tentativa.                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !File( cRet )
	cRet := "LGRL" + AllTrim(SM0->M0_CODIGO) + SM0->M0_CODFIL+".BMP" // Empresa+Filial
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao encontrar o arquivo com o codigo da filial completo,  ³
//³ retira os espacos em branco do codigo da filial para nova    ³
//³ tentativa.                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !File( cRet )
	cRet := "LGRL"+SM0->M0_CODIGO + AllTrim(SM0->M0_CODFIL)+".BMP" // Empresa+Filial
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se ainda nao encontrar, retira os espacos em branco do codigo³
//³ da empresa e da filial simultaneamente para nova tentativa.  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !File( cRet )
	cRet := "LGRL" + AllTrim(SM0->M0_CODIGO) + AllTrim(SM0->M0_CODFIL)+".BMP" // Empresa+Filial
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se nao encontrar o arquivo por filial, usa o logo padrao     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !File( cRet )
	cRet := "LGRL"+SM0->M0_CODIGO+".BMP" // Empresa
EndIf

Return cRet

/*/{Protheus.doc} GetInfFil
	Obtem os dados da filial de entrega
@author philipe.pompeu
@since 22/08/2019
@return nil, nulo
/*/
Static Function GetInfFil(cFilEnt, cEndEnt, cBairEnt, cCidEnt, cEstEnt, cTel)
	Local aSM0Info := {}
	
	aSM0Info := FWSM0Util():GetSM0Data( cEmpAnt, cFilEnt, {"M0_ENDENT",  "M0_BAIRENT", "M0_CIDENT", "M0_ESTENT", "M0_TEL"})
 	If(Len(aSM0Info) >= 5)
		cEndEnt	:= aSM0Info[1,2]
		cBairEnt:= aSM0Info[2,2]
		cCidEnt	:= aSM0Info[3,2]
		cEstEnt	:= aSM0Info[4,2]
		cTel	:= aSM0Info[5,2]
 	EndIf 	
	aSize(aSM0Info, 0)
Return Nil
