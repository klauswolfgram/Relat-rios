/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"  
#INCLUDE "WMSR121.CH"
#define RELDETEST 7

//-----------------------------------------------------------
/*/{Protheus.doc} WMSR121
Rotina que permite gerar um relatório da busca de endereços 
para o endereçamento

@author  Flavio Luiz Vicco
@version	P11
@since   17/10/06 - revisão 18/09/14
/*/
//-----------------------------------------------------------
User Function WMSR121(aLogAux)
Local oReport
Private nOS := 1
Private nTB := 1
Private nED := 1
Private aLogEnd := aLogAux

   If !SuperGetMv("MV_WMSNEW",.F.,.F.)
   	Return WMSR120()
   EndIf

   If Type("aLogEnd") != "A"
      Return Nil
   EndIf

   oReport := ReportDef()
   oReport:PrintDialog()
Return

//-----------------------------------------
// Definições do relatório
//-----------------------------------------
Static Function ReportDef()
Local oReport, oSection1, oSection2, oSection3
Local bTipoEnd := Nil
Local bCompEnd := Nil
Local cPictSld := Posicione('SX3',2,'D14_QTDEST','X3_PICTURE')
Local nSizeSld := TamSX3('D14_QTDEST')[1]

   oReport  := TReport():New('WMSR121',STR0001,'',{|oReport| ReportPrint(oReport)},'') // Busca Endereço
   oReport:HideParamPage()

   oSection1 := TRSection():New(oReport, STR0006) // Ordem de Serviço
   TRCell():New(oSection1,'DCF_DOCTO' ,'DCF',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||,aLogEnd[nOS,1]})
   TRCell():New(oSection1,'DCF_SERIE' ,'DCF',,,,,{||,aLogEnd[nOS,2]})
   TRCell():New(oSection1,'DCF_CODPRO','DCF',,,,,{||,aLogEnd[nOS,3]})
   TRCell():New(oSection1,'B1_DESC'   ,'SB1',,,,,{||,aLogEnd[nOS,4]})
   TRCell():New(oSection1,'DCF_LOTECT','DCF',,,,,{||,aLogEnd[nOS,5]})
   TRCell():New(oSection1,'DCF_QUANT' ,'DCF',,,,,{||,aLogEnd[nOS,6]})
   oSection1:SetHeaderBreak(.T.)
   oSection1:Cell('DCF_QUANT'):SetAutoSize(.T.)
   TRBreak():New(oSection1,{||oSection1:Cell('DCF_DOCTO'):uPrint+oSection1:Cell('DCF_SERIE'):uPrint+oSection1:Cell('DCF_CODPRO'):uPrint},STR0006,.F.,'DCF_QUEBRA',.F.) // Ordem de Serviço

   // 1=End Vazio;2=Parcial Ocup;3=Parcial/Lote;4=Compartilha
   bTipoEnd := {||,Iif(aLogEnd[nOS,RELDETEST,nTB,2]=='1',STR0002/*"End Vazio"*/,Iif(aLogEnd[nOS,RELDETEST,nTB,2]=='2',STR0003/*"Parcial Ocup"*/,Iif(aLogEnd[nOS,RELDETEST,nTB,2]=='3',STR0004/*"Parcial/Lote"*/,Iif(aLogEnd[nOS,RELDETEST,nTB,2]=='4',STR0005/*"Compartilha"*/,''))))}
   oSection2 := TRSection():New(oSection1, STR0007) // Tipo Busca
   TRCell():New(oSection2,'TIP_BUSCA',,STR0007,'@#',100,,{||,aLogEnd[nOS,RELDETEST,nTB,1]}) // Tipo Busca
   TRCell():New(oSection2,'DCF_TIPEND',,STR0015,'@#',12,,bTipoEnd) // Tipo End
   oSection2:SetHeaderBreak(.T.)
   oSection2:Cell('DCF_TIPEND'):SetAutoSize(.T.)
   TRBreak():New(oSection2,oSection2:Cell('TIP_BUSCA'),STR0007,.F.,'TIP_BUSCA',.F.) // Tipo Busca

   oSection3 := TRSection():New(oSection2, STR0008) // Endereços
   TRCell():New(oSection3,'D14_ESTFIS' ,'D14',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||,aLogEnd[nOS,RELDETEST,nTB,3,nED,1]})
   TRCell():New(oSection3,'D14_ORDZON' ,,'OZ','99',2,,{||,aLogEnd[nOS,RELDETEST,nTB,3,nED,2]}) // Ordem Zona Armazenagem
   TRCell():New(oSection3,'D14_ORDPRD' ,,'OP','99',2,,{||,aLogEnd[nOS,RELDETEST,nTB,3,nED,3]}) // Ordem Produto
   TRCell():New(oSection3,'D14_ORDSLD' ,,'OS','99',2,,{||,aLogEnd[nOS,RELDETEST,nTB,3,nED,4]}) // Ordem Saldo
   TRCell():New(oSection3,'D14_ORDMOV' ,,'OM','99',2,,{||,aLogEnd[nOS,RELDETEST,nTB,3,nED,5]}) // Ordem Movimento
   TRCell():New(oSection3,'D14_ENDER'  ,'D14',,,,,{||,aLogEnd[nOS,RELDETEST,nTB,3,nED,6]})
   TRCell():New(oSection3,'D14_CAPAC'  ,,STR0009,cPictSld,nSizeSld,,{||,aLogEnd[nOS,RELDETEST,nTB,3,nED,7]}) // Capacidade
   TRCell():New(oSection3,'D14_SALDO'  ,,STR0010,cPictSld,nSizeSld,,{||,aLogEnd[nOS,RELDETEST,nTB,3,nED,8]}) // Saldo D14
   TRCell():New(oSection3,'D14_SLDRF'  ,,STR0011,cPictSld,nSizeSld,,{||,aLogEnd[nOS,RELDETEST,nTB,3,nED,9]}) // Saldo RF
   TRCell():New(oSection3,'D14_SOLIC'  ,,STR0012,cPictSld,nSizeSld,,{||,aLogEnd[nOS,RELDETEST,nTB,3,nED,10]}) // Solicitado
   TRCell():New(oSection3,'D14_UTILZ'  ,,STR0013,cPictSld,nSizeSld,,{||,aLogEnd[nOS,RELDETEST,nTB,3,nED,11]}) // Utilizado
   TRCell():New(oSection3,'D14_MSGINFO',,STR0014,'@#',50,,{||,aLogEnd[nOS,RELDETEST,nTB,3,nED,12]}) // Mensagem
   oSection3:Cell('D14_MSGINFO'):SetAutoSize(.T.)
Return(oReport)
//----------------------------------------------
// Impressão do relatório
//----------------------------------------------
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oSection1:Section(1)
Local oSection3 := oSection2:Section(1)
Local nOS1 := 1
Local nTB1 := 1
Local nED1 := 1  
Local nSaldo := 0
Local cMensagem := ""
Local oBrush := TBrush():New(,CLR_HBLUE)

   oReport:SetMeter(Len(aLogEnd))
   oSection1:Init()
   For nOS1 := 1 To Len(aLogEnd)
      nOS := nOS1
      oSection1:PrintLine()
      oSection2:Init()
      For nTB1 := 1 To Len(aLogEnd[nOS,RELDETEST])
         nTB := nTB1
         oSection2:PrintLine()
         oSection3:Init()
         For nED1 := 1 To Len(aLogEnd[nOS,RELDETEST,nTB,3])
            nED := nED1
            nSaldo := aLogEnd[nOS,RELDETEST,nTB,3,nED,10] - aLogEnd[nOS,RELDETEST,nTB,3,nED,11]
            oSection3:PrintLine()
         Next
         oSection3:Finish()
      Next
      oSection2:Finish()
      // Se sobrou saldo deste produto, deve imprimir uma mensagem
      If nSaldo > 0
         cMensagem := WmsFmtMsg(STR0016,{{"[VAR01]",aLogEnd[nOS,3]},{"[VAR02]",Str(nSaldo)}}) // Produto [VAR01] não foi totalmente endereçado. Saldo restante: [VAR02].
         oReport:PrintText(cMensagem,,,255)
      EndIf 
      oReport:FillRect({oReport:nRow,oReport:nCol,oReport:nRow+3,oReport:oPage:nHorzRes},oBrush)
      oReport:SkipLine(1)
      oReport:IncMeter()
   Next
   oSection1:Finish()
   oBrush := Nil
   
   oReport:PrintText("OZ - "+STR0020,,,CLR_HBLUE) // Ordem Zona Armazenagem, onde: 00-Zona do produto, 01...99-Zona alternativa
   oReport:PrintText("OP - "+STR0021,,,CLR_HBLUE) // Ordem Produto, onde: 01-Exclusivo produto, 02-Qualquer produto
   oReport:PrintText("OS - "+STR0022,,,CLR_HBLUE) // Ordem Saldo, onde: 01-Saldo produto, 02-Saldo misto, 03-Saldo outro produto, 99-Sem saldo
   oReport:PrintText("OM - "+STR0023,,,CLR_HBLUE) // Ordem Movimento, onde: 01-Movimento pendente produto, 99-Sem movimento pendente
Return