/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "protheus.ch"
#include "FINR127.ch"


/*-----------------------------------------------------------------
{Protheus.doc} FINR127
@description Relatorio referente a lei 12.007 - Quitação anual de debito   
@author Clovis Magenta
@since 16/06/10
-----------------------------------------------------------------*/
User Function FINR127()

	Local oReport

	oReport := ReportDef()
	oReport:PrintDialog()

Return

// Impressao
Static Function ReportDef()

	Local oReport
	Local oSection1
	Local oSection2
	Local cAlias	:= " "

	oReport := TReport():New("FINR127",STR0002,"FIN127",{|oReport| PrintReport(oReport)},STR0003) //"LEI Nº 12.007" //"Relatório de quitação de Debitos"

	Pergunte("FIN127",.T.)

	oSection1 := TRSection():New(oReport,STR0004+ALLTRIM(SM0->M0_NOME),,,,,,,.F.,.F.,.F.,.T.,/*25*/,,,.F.) //"DECLARAÇÃO DE QUITAÇÃO ANUAL DE DÉBITOS "
	oSection1:oReport:nFontBody := 20
	oSection2 := TRSection():New(oReport,STR0005,cAlias,,,,,,,,,.T.,,,,.T.) //"QUITAÇÃO ANUAL DE DÉBITOS"
	oSection2:oReport:nFontBody := 12

	oReport:SetLineHeight(50)
	//TRCell():New(oSection1,STR0006,"",,,100,,,,.T.,"LEFT",.F.,,.F.)
	TRCell():New(oSection1,STR0006,"",STR0006,,100,,,,.T.,"LEFT",.F.,,.F.)

	If  MV_PAR06 == 1 // Simplificado = 1 / Detalhado = 2
		TRCell():New(oSection2,STR0016,cAlias,,, 10,,,,,"LEFT")//QTD
	EndIf

	TRCell():New(oSection2,"E1_CLIENTE",cAlias,,PesqPict("SE1","E1_CLIENTE"), TamSX3("E1_CLIENTE")[1],,,,,"LEFT")
	TRCell():New(oSection2,"E1_LOJA",cAlias,,PesqPict("SE1","E1_LOJA"), TamSX3("E1_LOJA")[1],,,,,"LEFT")
	TRCell():New(oSection2,"A1_NOME",cAlias,,PesqPict("SA1","A1_NOME"), TamSX3("A1_NOME")[1],,,,,"LEFT")

	If  MV_PAR06 == 1 // Simplificado = 1 / Detalhado = 2
		TRCell():New(oSection2,STR0015,cAlias,,PesqPict("SE1","E1_SALDO"), TamSX3("E1_SALDO")[1],,,,,"RIGHT") //"SALDO"
	Else
		TRCell():New(oSection2,STR0008,cAlias,,,10,,,,,"LEFT") // MES
		TRCell():New(oSection2,STR0007,cAlias,,PesqPict("SE1","E1_SALDO"), TamSX3("E1_SALDO")[1],,,,,"RIGHT") //"SALDO PAGO"
	EndIf

Return oReport

Static Function PrintReport(oReport)
	Local oSection1   	:= oReport:Section(1)
	Local oSection2   	:= oReport:Section(2)
	Local cQuery 		:= ""
	Local cTitulo		:= STR0005  //"Quitação ANUAL de Débitos"
	Local lSimples 		:= MV_PAR06 == 1 // Simplificado = 1 / Detalhado = 2
	Local lModified 	:= .F.
	Local cCliLoj 		:= ""
	Local cAno			:= Alltrim(MV_PAR05)
	Local cEmpresa		:= ALLTRIM(SM0->M0_NOME)
	Local lPETexto  	:= ExistBlock("FIN127TXT")
	Local lPEQry 		:= ExistBlock("FIN127QRY")
	Local lPETitulo		:= ExistBlock("FIN127TIT")
	Local cNomeCli		:= ""
	Local cTexto 		:= " "

	If oReport:nDevice	== 6
		oSection2:Cell("E1_CLIENTE"):nSize += 4
		oSection2:Cell("E1_LOJA"):nSize += 4
		oSection2:Cell("A1_NOME"):nSize += 6
	EndIf

	#IFDEF TOP         

	If lSimples                

		cAlias := GetNextAlias()
		
		cQuery := " SELECT "
		cQuery += " COUNT(SE1.E1_CLIENTE) AS QTD, SE1.E1_CLIENTE, SE1.E1_LOJA, SA1.A1_NOME NOME, SUM(SE1.E1_SALDO) SALDO "
		cQuery += " FROM " + RetSqlName('SE1') + " SE1 " 
		cQuery += " INNER JOIN " + RetSqlName("SA1") + " SA1 ON (SE1.E1_LOJA = SA1.A1_LOJA) AND (SE1.E1_CLIENTE = SA1.A1_COD) "
		cQuery += " INNER JOIN " + RetSqlName("SE5") + " SE5 ON (SE1.E1_NUM = SE5.E5_NUMERO) AND (SE1.E1_PREFIXO = SE5.E5_PREFIXO) AND (SE1.E1_PARCELA = SE5.E5_PARCELA)"
		cQuery += " AND (SE1.E1_TIPO = SE5.E5_TIPO) AND (SE1.E1_CLIENTE = SE5.E5_CLIFOR)AND (SE1.E1_LOJA = SE5.E5_LOJA) AND (SE1.E1_BAIXA = SE5.E5_DATA)"
		cQuery += " WHERE "
		cQuery += " SE1.E1_CLIENTE >= '" + MV_PAR01 + "' "
		cQuery += " AND SE1.E1_CLIENTE <= '" + MV_PAR02 + "' "
		cQuery += " AND SE1.E1_LOJA >= '" + MV_PAR03 + "' "
		cQuery += " AND SE1.E1_LOJA <= '" + MV_PAR04 + "' "
		cQuery += " AND SUBSTRING(SE1.E1_VENCREA,1,4) = '" + MV_PAR05 + "' "
		cQuery += " AND SE1.E1_TIPOLIQ = ' ' "
		cQuery += " AND SE1.E1_TIPOFAT = ' ' "
		cQuery += " AND SE1.E1_TIPO NOT IN ('RA ', 'NCC') "
		cQuery += " AND SE1.E1_TIPO NOT IN ('AB-','IR-', 'IN-','IS-','PI-','CF-','CS-','FU-','FE-','PR') "
		cQuery += " AND SE5.E5_MOTBX NOT IN ('DSD','LIQ','FAT','REN')
		cQuery += " AND SE5.E5_TIPODOC NOT IN ( 'DC' , 'JR' , 'MT' , 'CM' , 'CX' , 'DB' ) "
		cQuery += " AND SE5.E5_SITUACA <> 'C' "
		cQuery += " AND SE1.D_E_L_E_T_ = ' ' "
		cQuery += " AND SA1.D_E_L_E_T_ = ' ' "
		cQuery += " AND SE5.D_E_L_E_T_ = ' ' "  
			cQuery += " AND (SE1.E1_CLIENTE || SE1.E1_LOJA) NOT IN (
			cQuery += " SELECT "
			cQuery += " A.E1_CLIENTE || A.E1_LOJA "
			cQuery += " FROM " + RetSqlName('SE1') + " A " 
			cQuery += " INNER JOIN " + RetSqlName("SA1") + " B ON (A.E1_LOJA = B.A1_LOJA) AND (A.E1_CLIENTE = B.A1_COD) "
			cQuery += " WHERE "
			cQuery += " A.E1_CLIENTE >= '" + MV_PAR01 + "' "
			cQuery += " AND A.E1_CLIENTE <= '" + MV_PAR02 + "' "
			cQuery += " AND A.E1_LOJA >= '" + MV_PAR03 + "' "
			cQuery += " AND A.E1_LOJA <= '" + MV_PAR04 + "' "
			cQuery += " AND SUBSTRING(A.E1_VENCREA,1,4) = '" + MV_PAR05 + "' "
			cQuery += " AND A.E1_SALDO > 0 "
			cQuery += " AND A.E1_TIPOLIQ = ' ' "
			cQuery += " AND A.E1_TIPOFAT = ' ' "
			cQuery += " AND A.E1_TIPO NOT IN ('RA ', 'NCC') "
			cQuery += " AND A.E1_TIPO NOT IN ('AB-','IR-', 'IN-','IS-','PI-','CF-','CS-','FU-','FE-','PR') " 
			cQuery += " AND A.D_E_L_E_T_ = ' ' "
			cQuery += " AND B.D_E_L_E_T_ = ' ' "  

		cQuery += " ) "	
		
		cQuery += " GROUP BY E1_CLIENTE,E1_LOJA,A1_NOME "
		cQuery += " ORDER BY E1_CLIENTE,E1_LOJA,A1_NOME "

	Else

		cAlias := GetNextAlias()
		
		cQuery := " SELECT "  
		cQuery += " SE1.E1_CLIENTE, SE1.E1_LOJA, SA1.A1_NOME NOME, SUM(SE1.E1_SALDO) SALDO, SUM(SE1.E1_VALOR) VALOR, SUBSTRING(SE1.E1_VENCREA,5,2) MES "
		cQuery += " FROM " + RetSqlName('SE1') + " SE1 " 
		cQuery += " JOIN " + RetSqlName("SA1") + " SA1 ON (SE1.E1_LOJA = SA1.A1_LOJA) AND (SE1.E1_CLIENTE = SA1.A1_COD) "
		cQuery += " JOIN " + RetSqlName("SE5") + " SE5 ON (SE1.E1_NUM = SE5.E5_NUMERO) AND (SE1.E1_PREFIXO = SE5.E5_PREFIXO) and (SE1.E1_PARCELA = SE5.E5_PARCELA)"
		cQuery += " AND (SE1.E1_TIPO = SE5.E5_TIPO) AND (SE1.E1_CLIENTE = SE5.E5_CLIFOR) AND (SE1.E1_LOJA = SE5.E5_LOJA) AND (SE1.E1_BAIXA = SE5.E5_DATA)"
		cQuery += " WHERE "
		cQuery += " SE1.E1_CLIENTE >= '" + MV_PAR01 + "' "
		cQuery += " AND SE1.E1_CLIENTE <= '" + MV_PAR02 + "' "                       
		cQuery += " AND SE1.E1_LOJA >= '" + MV_PAR03 + "' "
		cQuery += " AND SE1.E1_LOJA <= '" + MV_PAR04 + "' "
		cQuery += " AND SUBSTRING(SE1.E1_VENCREA,1,4) = '" + MV_PAR05 + "' "
		cQuery += " AND SE1.E1_TIPOLIQ = ' ' "
		cQuery += " AND SE1.E1_TIPOFAT = ' ' "
		cQuery += " AND SE1.E1_TIPO NOT IN ('RA ', 'NCC') "
		cQuery += " AND SE1.E1_TIPO NOT IN ('AB-','IR-', 'IN-','IS-','PI-','CF-','CS-','FU-','FE-', 'PR') "
		cQuery += " AND SE5.E5_DTCANBX = ' '"
		cQuery += " AND SE5.E5_MOTBX NOT IN ('DSD','LIQ','FAT','REN') "
		cQuery += " AND SE5.E5_TIPODOC NOT IN ( 'DC' , 'JR' , 'MT' , 'CM' , 'CX' , 'DB' ) "
		cQuery += " AND SE5.E5_SITUACA <> 'C' "
		cQuery += " AND SE1.D_E_L_E_T_ = ' ' "
		cQuery += " AND SA1.D_E_L_E_T_ = ' ' "
		cQuery += " AND SE5.D_E_L_E_T_ = ' ' "
		cQuery += " AND SE1.E1_CLIENTE || SE1.E1_LOJA NOT IN (
			cQuery += " SELECT "
			cQuery += " A.E1_CLIENTE || A.E1_LOJA "
			cQuery += " FROM " + RetSqlName('SE1') + " A " 
			cQuery += " JOIN " + RetSqlName("SA1") + " B ON (A.E1_LOJA = B.A1_LOJA) AND (A.E1_CLIENTE = B.A1_COD) "
			cQuery += " WHERE "
			cQuery += " A.E1_CLIENTE >= '" + MV_PAR01 + "' "
			cQuery += " AND A.E1_CLIENTE <= '" + MV_PAR02 + "' "
			cQuery += " AND A.E1_LOJA >= '" + MV_PAR03 + "' "
			cQuery += " AND A.E1_LOJA <= '" + MV_PAR04 + "' "
			cQuery += " AND SUBSTRING(A.E1_VENCREA,1,4) = '" + MV_PAR05 + "' "
			cQuery += " AND A.E1_SALDO > 0 "
			cQuery += " AND A.E1_TIPOLIQ = ' ' "
			cQuery += " AND A.E1_TIPOFAT = ' ' "
			cQuery += " AND A.E1_TIPO NOT IN ('RA ', 'NCC') "
			cQuery += " AND A.E1_TIPO NOT IN ('AB-','IR-', 'IN-','IS-','PI-','CF-','CS-','FU-','FE-', 'PR') " 
			cQuery += " AND A.D_E_L_E_T_ = ' ' "
			cQuery += " AND B.D_E_L_E_T_ = ' ' "  

		cQuery += " ) "	

		cQuery += " GROUP BY A1_NOME,E1_CLIENTE,E1_LOJA,SUBSTRING(SE1.E1_VENCREA,5,2) "
		cQuery += " ORDER BY A1_NOME,E1_CLIENTE,E1_LOJA,MES "

	Endif

	If lPEQry
		cQuery:= ExecBlock("FIN127QRY", .F.,.F., {cQuery,MV_PAR01,MV_PAR02,MV_PAR03,MV_PAR04,MV_PAR05,MV_PAR06})
	EndIf

	cQuery := ChangeQuery(cQuery)

	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery),cAlias , .T., .F. )

	oSection1:Cell("DECLARACAO"):SetBlock( { || cTexto } )

	DbSelectArea(cAlias)
	(cAlias)->(dbGoTop())

	If lSimples
		oSection2:Cell(STR0016):SetBlock( { || (cAlias)->(QTD) } )
	Endif

	oSection2:Cell("E1_CLIENTE"):SetBlock( { || (cAlias)->(E1_CLIENTE) } )
	oSection2:Cell("E1_LOJA"):SetBlock( { || (cAlias)->(E1_LOJA) } )
	oSection2:Cell("A1_NOME"):SetBlock( { || (cAlias)->(NOME) } )

	If !lSimples
		oSection2:Cell(STR0008):SetBlock( { || MesExtenso( Val((cAlias)->(MES))) } ) //"MÊS"
		oSection2:Cell(STR0007):SetBlock( { || (cAlias)->(VALOR) } ) //"SALDO PAGO"
	Else
		oSection2:Cell(STR0015):SetBlock( { || (cAlias)->(VALOR) } ) //"SALDO"
	Endif


	If lPETitulo
		cTitulo := ExecBlock("FIN127TIT", .F.,.F., {cTitulo})
	EndIf	

	oReport:SetTitle(cTitulo)

	If lSimples

		While !(cAlias)->(eof())
			If (cAlias)->(SALDO) == 0
				oSection1:Init()
				If RetGlbLGPD("A1_NOME")
					cNomeCli := Replicate("*", TamSx3("A1_NOME")[1])
				Else
					cNomeCli := (cAlias)->(NOME)
				EndIf
				cTexto 	:= STR0009+cEmpresa+STR0010+Alltrim(cNomeCli)+STR0011+cAno+STR0012+STR0013+cAno+STR0014
				//	cTexto 	:= "Em cumprimento à Lei 12.007, de 29 de julho de 2009, o "+cEmpresa+" declara que o cliente "+Alltrim((cAlias)->(NOME))+" está quite quanto às faturas com "+;
	//			"vencimento no ano de "+cAno+". Esta declaração substitui, para comprovação do cumprimento das obrigações do cliente, "+;
	//			"as quitações dos pagamentos mensais das faturas do ano de "+cAno+", bem como dos anos anteriores."
				If lPETexto
					cTexto := EXECBLOCK("FIN127TXT", .F., .F., {cTexto,(cAlias)->(NOME), cAno })
				Endif
				oSection1:Printline()
				oSection1:Finish()
				oSection2:Init()
				oSection2:Printline()
				oSection2:Finish()
				oReport:EndPage()
			Endif
			
			(cAlias)->(dbSkip())
		EndDo	                  

	Else

		oSection1:Init()
		oSection2:Init()
		cCliLoj := (cAlias)->(E1_CLIENTE)+(cAlias)->(E1_LOJA)
		
		While !(cAlias)->(eof())
		
		If (cAlias)->(SALDO) == 0
			If RetGlbLGPD("A1_NOME")
				cNomeCli := Replicate("*", TamSx3("A1_NOME")[1])
			Else
				cNomeCli := (cAlias)->(NOME)
			EndIf
			cTexto 	:= STR0009+cEmpresa+STR0010+Alltrim(cNomeCli)+STR0011+cAno+STR0012+STR0013+cAno+STR0014
	//		cTexto 	:= "Em cumprimento à Lei 12.007, de 29 de julho de 2009, o "+cEmpresa+" declara que o cliente "+Alltrim((cAlias)->(NOME))+" está quite quanto às faturas com "+;
	//						"vencimento no ano de "+cAno+". Esta declaração substitui, para comprovação do cumprimento das obrigações do cliente, "+;
	//						"as quitações dos pagamentos mensais das faturas do ano de "+cAno+", bem como dos anos anteriores."

			If lPETexto
				cTexto := EXECBLOCK("FIN127TXT", .F., .F., {cTexto})
			Endif

		If cCliLoj <> (cAlias)->(E1_CLIENTE)+(cAlias)->(E1_LOJA)
				oSection1:Finish()
				oSection2:Finish()
				oReport:EndPage()
				oSection1:Init()
				oSection2:Init()
				oSection1:Printline()
				oSection2:Printline()
				cCliLoj := (cAlias)->(E1_CLIENTE)+(cAlias)->(E1_LOJA)
				lModified := .T.
			Else
				If !lModified
					oSection1:Printline()
					lModified := .T.
				Endif
				oSection2:Printline()
			Endif
			
		Endif

		(cAlias)->(dbSkip())
		EndDo	 

	Endif	                         

	oSection1:Finish()
	oSection2:Finish()

	#ENDIF	

	If Select(cAlias)>0
		(cAlias)->(DbClosearea())
	Endif

Return NIL      
