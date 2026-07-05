/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"  
#INCLUDE "WMSR125.CH"

#define RELDETUNI  06
#define RELDETEND  09

//-----------------------------------------------------------
/*/{Protheus.doc} WMSR125
Rotina que permite gerar um relatório da busca de endereços 
para o endereçamento

@author  Jackson Patrick Werka
@version	P12
@since   24/04/2017
/*/
//-----------------------------------------------------------
User Function WMSR125(aLogAux)
Local oReport
Private nCL := 1
Private nUT := 1
Private nED := 1
Private aLogEnd := aLogAux

	If Type("aLogEnd") != "A"
		Return Nil
	EndIf

	oReport := ReportDef()
	oReport:PrintDialog()
Return
//---------------------------------------------------------- 
// Definições do relatório
//---------------------------------------------------------- 
/*
Unitizador | Tipo   | Peso        | Cubagem     | Altura  | Largura | Comprimento | Misto | Qtd End
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
XXXXXX     | 999999 | 999.999,999 | 999.999,999 | 999,999 | 999,999 | 999,999     | Sim   | 145
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
OZ|OA|OE|OP|OS|OM|TE|Estrutura|Endereço       | Peso Máx   | Peso Ocup  | Cubagem Max| Cubagem Ocup| Altura | Largura| Comprimento| QTD Max Unt| QTD Ocup Unt| Mensagem
—————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
99|99|99|99|99|99| X|   000000|XXXXXXXXXXXXXXX| 999.999,999| 999.999,999| 999.999,999|  999.999,999| 999,999| 999,999|     999,999|  9999999999|   9999999999| XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
*/
Static Function ReportDef()
Local oReport, oSection1, oSection2, oSection3, oCell

	oReport  := TReport():New('WMSR125',STR0001,'',{|oReport| ReportPrint(oReport)},'') // Busca Endereço
	oReport:HideParamPage()
	oReport:SetLandscape()

	oSection1 := TRSection():New(oReport, STR0024) // Informações Classificação
	TRCell():New(oSection1,'TP2_CODCLA',,STR0025,"@E 999,999,999",10,,{||,aLogEnd[nCL,1]},"RIGHT",,"RIGHT") // Classificação
	TRCell():New(oSection1,'D14_LOCAL' ,'D14',,,,,{||,aLogEnd[nCL,2]}) // Local
	TRCell():New(oSection1,'D14_PRODUT','D14',,,,,{||,aLogEnd[nCL,3]}) // Produto
	TRCell():New(oSection1,'D14_LOTECT','D14',,,,,{||,aLogEnd[nCL,4]}) // Lote
	oCell := TRCell():New(oSection1,'TP2_QTDEND',,STR0006,"@E 999,999,999",10,,{||,aLogEnd[nCL,5]},"RIGHT",,"RIGHT") // Qtd End
	oSection1:SetHeaderBreak(.T.)
	oCell:SetAutoSize(.T.)
	TRBreak():New(oSection1,{||oSection1:Cell('TP2_CODCLA'):uPrint},STR0024,.F.,'TP2_QUEBRA',.F.) //  Informações Classificação

	oSection2 := TRSection():New(oSection1, STR0002) // Informações Unitizador
	TRCell():New(oSection2,'D14_IDUNIT','D14',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||,aLogEnd[nCL,RELDETUNI,nUT,1]})
	TRCell():New(oSection2,'D14_CODUNI','D14',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||,aLogEnd[nCL,RELDETUNI,nUT,2]})
	TRCell():New(oSection2,'D0T_CAPMAX','D0T',STR0003,,,,{||,aLogEnd[nCL,RELDETUNI,nUT,3]},"RIGHT",,"RIGHT") // Peso
	TRCell():New(oSection2,'D14_CUBAGE',,STR0004,"@E 999,999.999",10,,{||,aLogEnd[nCL,RELDETUNI,nUT,4]},"RIGHT",,"RIGHT") // Cubagem
	TRCell():New(oSection2,'D0T_ALTURA','D0T',,,,,{||,aLogEnd[nCL,RELDETUNI,nUT,5]})
	TRCell():New(oSection2,'D0T_LARGUR','D0T',,,,,{||,aLogEnd[nCL,RELDETUNI,nUT,6]})
	TRCell():New(oSection2,'D0T_COMPRI','D0T',,,,,{||,aLogEnd[nCL,RELDETUNI,nUT,7]})
	oCell := TRCell():New(oSection2,'D14_MISTO' ,,STR0005,,3,,{||,Iif(aLogEnd[nCL,RELDETUNI,nUT,8],STR0007,STR0008)}) // Misto - Sim##Não
	oSection2:SetHeaderBreak(.T.)
	oCell:SetAutoSize(.T.)
	TRBreak():New(oSection2,{||oSection2:Cell('D14_IDUNIT'):uPrint},STR0002,.F.,'D14_QUEBRA',.F.) // Informações Unitizador

	oSection3 := TRSection():New(oSection2, STR0009) // Endereços
	TRCell():New(oSection3,'BE_ORDZON' ,,'OZ','99',2,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,1]}) // Ordem Zona Armazenagem
	TRCell():New(oSection3,'BE_ORDDC8' ,,'OA','99',2,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,2]}) // Ordem Sequencia Abastecimento
	TRCell():New(oSection3,'BE_ORDDC3' ,,'OE','99',2,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,3]}) // Ordem Estrutura Sequencia Abastecimento
	TRCell():New(oSection3,'BE_ORDPRD' ,,'OP','99',2,,{||,StrZero(aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,4],2,0)}) // Ordem Produto
	TRCell():New(oSection3,'BE_ORDSLD' ,,'OS','99',2,,{||,StrZero(aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,5],2,0)}) // Ordem Saldo
	TRCell():New(oSection3,'BE_ORDMOV' ,,'OM','99',2,,{||,StrZero(aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,6],2,0)}) // Ordem Movimento
	TRCell():New(oSection3,'BE_TIPEND' ,,'TE', '9',1,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,7]}) // Tipo Endereçamento
	TRCell():New(oSection3,'BE_ESTFIS' ,'SBE',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,8]})
	TRCell():New(oSection3,'BE_LOCALIZ','SBE',,,,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,9]})
	TRCell():New(oSection3,'BE_CAPACID','SBE',STR0010,,,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,10]}) // Peso Máx
	TRCell():New(oSection3,'BE_CAPACID','SBE',STR0011,,,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,11]}) // Peso Ocup
	TRCell():New(oSection3,'BE_CUBAGEM',,STR0012,"@E 999,999.999",10,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,12]},"RIGHT",,"RIGHT") // Cubagem Max
	TRCell():New(oSection3,'BE_CUBOCUP',,STR0013,"@E 999,999.999",10,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,13]},"RIGHT",,"RIGHT") // Cubagem Ocup
	TRCell():New(oSection3,'BE_ALTURLC','SBE',,,,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,14]})
	TRCell():New(oSection3,'BE_LARGLC' ,'SBE',,,,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,15]})
	TRCell():New(oSection3,'BE_COMPRLC','SBE',,,,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,16]})
	TRCell():New(oSection3,'BE_UNITMAX',,STR0014,"@E 999,999,999",10,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,17]},"RIGHT",,"RIGHT") // Qtd Max Unit
	TRCell():New(oSection3,'BE_UNITOCU',,STR0015,"@E 999,999,999",10,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,18]},"RIGHT",,"RIGHT") // Qtd Ocup Unit
	oCell := TRCell():New(oSection3,'BE_MSGINFO',,STR0016,'@#',50,,{||,aLogEnd[nCL,RELDETUNI,nUT,RELDETEND,nED,19]}) // Mensagem
	oCell:SetAutoSize(.T.)
Return(oReport)
//----------------------------------------------
// Impressão do relatório
//----------------------------------------------
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oSection1:Section(1)
Local oSection3 := oSection2:Section(1)
Local nCL1      := 1
Local nUT1      := 1
Local nED1      := 1
Local cMensagem := ""
Local oBrush    := TBrush():New(,CLR_HBLUE)

	oReport:SetMeter(Len(aLogEnd))
	oSection1:Init()
	For nCL1 := 1 To Len(aLogEnd)
		nCL := nCL1
		oSection1:PrintLine()
		oSection2:Init()
		For nUT1 := 1 To Len(aLogEnd[nCL,RELDETUNI])
			nUT := nUT1
			oSection2:PrintLine()
			oSection3:Init()
			For nED1 := 1 To Len(aLogEnd[nCL,RELDETUNI,nUT,RELDETEND])
				nED := nED1
				oSection3:PrintLine()
			Next
			oSection3:Finish()
			oReport:FillRect({oReport:nRow,oReport:nCol,oReport:nRow+3,oReport:oPage:nHorzRes},oBrush)
			oReport:SkipLine(1)
		Next
		oSection2:Finish()
		oReport:IncMeter()
	Next
	oSection1:Finish()
	
	oReport:PrintText("OZ - "+STR0017,,,CLR_HBLUE) // Ordem Zona Armazenagem, onde: 00-Zona do produto, 01...99-Zona alternativa"
	oReport:PrintText("OA - "+STR0018+" https://tdn.totvs.com/pages/viewpage.action?pageId=556379278",,,CLR_HBLUE) // Ordem Sequencia Abastecimento: https://tdn.totvs.com/pages/viewpage.action?pageId=556379278
	oReport:PrintText("OE - "+STR0019,,,CLR_HBLUE) // Ordem Estrutura Sequencia Abastecimento
	oReport:PrintText("OP - "+STR0020,,,CLR_HBLUE) // Ordem Produto, onde: 01-Exclusivo produto, 02-Qualquer produto"
	oReport:PrintText("OS - "+STR0021,,,CLR_HBLUE) // Ordem Saldo, onde: 01-Saldo produto, 02-Saldo misto, 03-Saldo outro produto, 99-Sem saldo"
	oReport:PrintText("OM - "+STR0022,,,CLR_HBLUE) // Ordem Movimento, onde: 01-Movimento pendente produto, 99-Sem movimento pendente"
	cMensagem := "TE - " + STR0023 + Posicione("SX3", 2, "DC3_TIPEND", "X3CBox()" )
	oReport:PrintText(cMensagem,,,CLR_HBLUE) // Tipo Endereçamento, onde: "

Return
