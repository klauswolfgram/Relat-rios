/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QDOR070.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QDOR070  ³ Autor ³ Yale Amorim           ³ Data ³ 05/11/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Protocolo de Entrega de Documentos e Registros da Qualidade³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QDOR070( <cParam1>, <aParam2>, <cParam3> )                 ³±±
±±³          ³ cParam1: QDH_FILIAL + QDH_DOCTO + QDH_RV                   ³±±
±±³          ³ aParam2: Array contendo os destinatarios. 13 elementos/Reg.³±±
±±³          ³          Veja estrutura do array em QDOA130.PRW "LerQD1"   ³±±
±±³          ³          Elementos usados nesta rotina: 2,3,10,11 e 12.    ³±±
±±³          ³          Ex: { {1,2,3,...13},{1,2,3,...13},...}            ³±±
±±³          ³ cParam3: Campo "ESPECIE" para identificacao do texto no QD2³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOA120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function QDOR070( cChave, aRegs, cStatus, cEspecie )
Local cTitulo	:= STR0001	//"PROTOCOLO DE ENTREGA DE DOCUMENTOS E REGISTROS DA QUALIDADE"
Local cDesc1    := STR0002      //"Este programa ir  imprimir o Protocolo de Entrega de Documentos"
Local cDesc2	:= STR0003	//"e Registros da Qualidade, que assegura o recebimento de documentos"
Local cDesc3    := STR0004      //"por todos os envolvidos em sua implementa‡„o"
Local cString	:= "QDH" 
Local wnrel		:= "QDOR070"
Local Tamanho	:= "P"
Local nQDHOrder := QDH->( IndexOrd() )
Local nSRAOrder := SRA->( IndexOrd() )

Private cPerg   := ""
Private aReturn := { STR0005,1,STR0006, 2, 2, 1, "",1 }         //"Zebrado"###"Administra‡„o"
Private nLastKey:=0
Private INCLUI := .F.	// Colocada para utilizar as funcoes
Private li := 80
Private m_pag := 1

wnrel :=SetPrint(cString,wnrel,cPerg,ctitulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho)

If nLastKey = 27
	Return
End
	
SetDefault(aReturn,cString)

If nLastKey = 27
	Return
End

QDH->( DbSetOrder( 1 ) )
QDH->( DbSeek( cChave ) )

RptStatus({|lEnd| R070Impr(@lEnd,ctitulo,wnRel,tamanho,aRegs,cStatus,cEspecie)},ctitulo)

QDH->( DbSetOrder( nQDHOrder ) )
SRA->( DbSetOrder( nSRAOrder ) )
Return .T.

/*								    				    
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R070Impr ³ Autor ³ Yale Amorim           ³ Data ³ 05/11/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o relatorio.                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR070                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R070Impr(lEnd,ctitulo,wnRel,tamanho,aRegs,cStatus,cEspecie)
Local cCabec :=""
Local cbtxt  := SPACE(10)
Local cbcont :=0
Local nPos
Local aReg
Local nC
Local cDepto := ""

Do Case
Case AllTrim( cEspecie ) $ "SMD,SEX,SCL,RMD,REX,RCL,MDA"
	cCabec := STR0015	//"RESPONSAVEL                                               DATA      ASSINATURA"
Case AllTrim( cEspecie ) $ "AMD,AEX,ACL"
	cCabec := STR0016	//"RESPONSAVEL                         APROVA?               DATA      ASSINATURA"
End

li       := 80
m_pag    := 1

//                   12345678901234567890123456789012345 123456789012345678901 123456789 1234567890123
//                             1         2         3         4         5         6         7         8
//                   012345678901234567890123456789012345678901234567890123456789012345678901234567890
// Posicoes 000-036-058-068

// Total de Elementos da Regua
SetRegua( Len( aRegs ) )

// Ordena por DEPTO + NOME dos destinatarios.
ASort( aRegs,,,{ |x,y| x[ 12 ] + x[ 2 ] < y[ 12 ] + y[ 2 ] } )

SRA->( DbSetOrder( 1 ) )

For nC := 1 To Len( aRegs )
	IncRegua()
	aReg := aRegs[ nC ]
	
	If SRA->( DbSeek( aReg[ 10 ] + aReg[ 11 ] ) )
	
		If SRA->RA_TPRCBT $ "2,3" .And. SRA->RA_SITFOLH # "D"
		
			If cDepto # aReg[ 12 ]
				cDepto := aReg[ 12 ]
				li := 80
			End
			
			If li > 58
				R070Cabec(cStatus,cEspecie)
				@ li,00 PSay STR0009 + aReg[ 12 ] + " - " + aReg[ 3 ] //"DEPARTAMENTO DESTINO: "
				li++
				@ li,00 PSay Replicate( "-", 80 )
				li++
				@ li,00 PSay cCabec
				li++
				@ li,00 PSay Replicate( "-", 80 )
				li++
			End
			
			@ li,00 PSay Left( SRA->RA_NOME, 35 )
			
			@ li,58 PSay "__/__/__"
			@ li,68 PSay Replicate( "_", 12 )
			li++
		End
		
	End
	
	If lEnd
		li++
		@ PROW()+1,001 PSAY STR0008	//"CANCELADO PELO OPERADOR"
		Exit
	End
	
Next

If li != 80
	roda(cbcont,cbtxt,tamanho)
End

Set Device To Screen

If aReturn[5] = 1
	Set Printer TO 
	dbCommitAll()
	ourspool(wnrel)
End

MS_FLUSH()

Return (.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R070Cabec³ Autor ³ Yale Amorim           ³ Data ³ 05/11/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime dados pertinentes ao cabecalho do programa.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ R070Impr                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R070Cabec( cStatus, cEspecie )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas na impressao do texto de convocacao   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cTexto:="",cImpTxt:="",cImpLinha:=""
Local aLinhas := {}
Local nc:=0,nCount:=0
Local cAcentos  := "€ú‡úŽúú…ú†úƒú úúˆú‚ú¡ú“ú”ú¢ú™ú£ú"
Local cAcSubst  := "C,c,A~A'a`a~a^a'E'e^e'i'o^o~o'O~U'"
Local cChave
Local nTamLin := TamSX3("QA2_TEXTO")[1]
Local axTextos := {}
Local cNome := ""
Local cDepto := ""
Local nSRARecno := SRA->( RecNo() )
li:=0
//@ li,00 PSAY AvalImp(80)
@ li,00 PSay STR0010 + QDH->QDH_DOCTO + STR0014 + QDH->QDH_RV	        //"DOCUMENTO   : "  ###  " - REVISAO: "
li++
@ li,00 PSay STR0011 + Substr( Alltrim( QDH->QDH_TITULO ),1,70 )	//"TITULO   : "
li++

If !Empty(Substr(Alltrim(QDH->QDH_TITULO),71))
	@ li,09 PSay Substr(Alltrim(QDH->QDH_TITULO),71)
	li++
EndIf

@ li,00 PSay STR0007 + OemToAnsi( Left( QA_NSIT( cStatus ),40 ) )	    //"ASSUNTO     : "
li++
@ li,00 PSay Replicate("-",80)
li++

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime texto padrao do protocolo                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If AllTrim( cEspecie ) $ "REX,RCL" .And. QDH->QDH_STATUS $ "SEX,SCL"
	cChave := QD1->QD1_CHAVE
Else
	cChave := QDH->QDH_CHAVE
End

If !Empty( cChave )
	
	If !Empty( cTexto := QA_RecTxt( cChave, cEspecie, 1, nTamLin, "QA2", axTextos) )
		@ li,00 PSay STR0012	// "MOTIVO      : "
		li++
		
		For nC := 1 To MLCOUNT(cTexto,80)
			aLinha := MEMOLINE(cTexto,80,nC)
			cImpTxt   := ""
			cImpLinha := ""
			
			For nCount := 1 To Len(aLinha)
				cImpTxt := Substr(aLinha,nCount,1)
				
				If AT(cImpTxt,cAcentos)>0
					cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
				EndIf
				
				cImpLinha := cImpLinha+cImpTxt
			Next nCount
			
			@li,00 PSAY cImpLinha
			li++
		Next nC
	
		@ li,00 PSay Replicate("-",80)
		li++
	End
	
	QDN->( DbSeek( xFilial( "QDN" ) + QDH->QDH_DOCTO + QDH->QDH_RV + AllTrim( cStatus ) ) )
	SRA->( DbSeek( QDN->QDN_FILMAT + QDN->QDN_MAT ) )
	cNome := AllTrim( SRA->RA_NOME )
	cDepto := AllTrim( QA_NDEPT( QDN->QDN_DEPTO,.T.,QDN->QDN_FILMAT ) )
	
	@ li,00 PSAY OemToAnsi( STR0013 ) + cNome + " - " + cDepto	// "Solicitante: "
	li++
	@ li,00 PSay Replicate("-",80)
End

SRA->( DbGoTo( nSRARecno ) )
li++
Return
