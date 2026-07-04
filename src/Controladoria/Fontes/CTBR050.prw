/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR050.CH"
#INCLUDE "PROTHEUS.Ch"

// 17/08/2009 -- Filial com mais de 2 caracteres

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr050	³ Autor ³ Pilar S Albaladejo	³ Data ³ 12.09.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Analitico Sintetico Modelo 2			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Ctbr050()                               			 		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso    	 ³ Generico     											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function Ctbr050()     

Local alink	   := {{"Saiba mais!","https://tdn.totvs.com/pages/viewpage.action?pageId=496381097"}}
PRIVATE titulo		:= ""
PRIVATE nomeprog	:= "CTBR050"
PRIVATE aSelFil		:= {} 
Private lRelease := GetRpoRelease() >= "12.1.027"


DESHELPC050("CTBR050DES","Balancete Analítico/Sintético Modelo 2(CTBR050), será descontinuado a partir do release 12.1.27" + CHR(10)+CHR(13)+CHR(10)+CHR(13), alink )

If lRelease
    Return .F.
Else
    CTBR040R4()
Endif

Return



/*/{Protheus.doc} DESHELPC050
Rotina para exibir HELP com direcionamento para o TDN/KCS
@type  Function
@author Totvs
@since 04/10/2019
@version 12.1.25
@return
/*/
Static Function DESHELPC050(cTitulo AS Character, cMsg AS Character, aBtLinks AS Array)

Local oDlg AS Object
Local oPanel AS Object
Local oTextDesc AS Object
Local oBtnLink1 AS Object
Local oBtnLink2 AS Object
Local oBtnLink3 AS Object
Local oFont AS Object
Local oSay AS Object

Default cTitulo := ""
Default cMsg := ""
Default aBtLinks := {}

oFont := TFont():New('Arial',,-16,.T.)

// Limite de 3 links externos para nao estourar a tela
DEFINE MSDIALOG oDlg FROM 0,0 TO 140,360 TITLE OemToAnsi(cTitulo) PIXEL // 150 altura da tela x 352 largura da tela
oDlg:lMaximized := .F.

oPanel := TPanelCss():New(0,0,"",oDlg,,.F.,.F.,,,oDlg:nWidth/2,oDlg:nHeight/2,.T.,.F.)

oPanelScroll := TScrollBox():New(oPanel,0,0,70,180,.T.,.T.,.F.) //80 altura da borda interior x  180 largura da borda interior   

oTextDesc := tSimpleEditor():New(2,2, oPanelScroll,(oPanelScroll:nWidth/2)-7,(oPanelScroll:nHeight/2)-7,,.T.,,,.T. )
oTextDesc:Setcss("background-color : transparent; border: 1px solid #DCDCDC;  border-radius: 4px; ")
oTextDesc:Load(cMsg)

If Len(aBtLinks) >= 1
	oSay := TSay():New((oPanel:nHeight/1)-72,005,{|| "Testes acesse:"},oPanel,,oFont,,,,.T.)

	oBtnLink1 := TButton():New( (oPanel:nHeight/2)-60, 5, aBtLinks[1,1]   ,oPanel,, 40 ,12,,,.F.,.T.,.F.,,.F.,,,.F. ) // 40 area largura do link x 12 area altura do link 
	oBtnLink1:SetCSS("QPushButton {text-decoration: underline; color: blue; border: 0px solid #DCDCDC; border-radius: 0px;Text-align:left}")
	oBtnLink1:bLClicked := {|| ShellExecute("open", aBtLinks[1,2] ,"","",3) }
EndIf

If Len(aBtLinks) >= 2
	oBtnLink2 := TButton():New( (oPanel:nHeight/2)-48, 5, aBtLinks[2,1]   ,oPanel,, 40 ,12,,,.F.,.T.,.F.,,.F.,,,.F. )
	oBtnLink2:SetCSS("QPushButton {text-decoration: underline; color: blue; border: 0px solid #DCDCDC; border-radius: 0px;Text-align:left}")
	oBtnLink2:bLClicked := {|| ShellExecute("open", aBtLinks[2,2] ,"","",3) }
EndIf

If Len(aBtLinks) >= 3
	oBtnLink3 := TButton():New( (oPanel:nHeight/2)-36, 5, aBtLinks[3,1]   ,oPanel,, 40 ,12,,,.F.,.T.,.F.,,.F.,,,.F. )
	oBtnLink3:SetCSS("QPushButton {text-decoration: underline; color: blue; border: 0px solid #DCDCDC; border-radius: 0px;Text-align:left}")
	oBtnLink3:bLClicked := {|| ShellExecute("open", aBtLinks[3,2] ,"","",3) }
EndIf

ACTIVATE MSDIALOG oDlg CENTERED

Return

