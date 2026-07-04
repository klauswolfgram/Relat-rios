/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 12     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#INCLUDE "ofior400.ch"
#Include "protheus.ch"
#Include "Fileio.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ OFIOR400 ³ Autor ³ Fabio                 ³ Data ³ 17/05/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relatorio de Producao                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR400
//Local oReport
Local aArea := GetArea()
Private cImp := ""
Private aNaoApont := {} // Vetor que contera Valores de Servicos nao Apontados
FS_OFR400R3()
RestArea( aArea )
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³FS_OFR400R3 ³ Autor ³ Fabio                 ³ Data ³ 17/05/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relatorio de producao                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_OFR400R3()
Local cDesc1		:=STR0001 //"Impressao de Producao"
Local cDesc2 		:=""
Local cDesc3 		:=""
Local cAlias		:="VSG"

Private nLin := 1
Private aPag := 1
Private nIte := 1
Private aReturn := { STR0002, 1,STR0003, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private cTamanho:= "M"           // P/M/G
Private Limite  := 132           // 80/132/220
Private aOrdem  := {}           // Ordem do Relatorio
Private cTitulo := STR0004 //"Comissao"
Private cNomProg:= "OFIOR400"
Private cNomeRel:= "OFIOR400"
Private cPerg  := "OFR400"
Private nLastKey:= 0
ValidPerg()

cNomeRel:=SetPrint(cAlias,cNomeRel,cPerg ,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)
If nLastKey == 27
	Return
EndIf

PERGUNTE("OFR400",.f.)
SetDefault(aReturn,cAlias)
RptStatus( { |lEnd| U_ImpOR400(@lEnd,cNomeRel,cAlias) } , cTitulo )
If aReturn[5] == 1
	OurSpool( cNomeRel )
EndIf
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ImpOR400  ºAutor  ³Fabio               º Data ³  11/13/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime producao                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ImpOR400(lEnd,__wNRel,cAlias)
Local nLin := 1
Local nFor := 1
LocaL cTitulo , cabec1 , cabec2 , nomeprog , tamanho , nCaracter
Local cArqIndex1 , cArqIndex2 , cArqIndex3 , cArqIndex4 , cArqIndex5 , aVetCampos := {}
Local aTotal := {}
Local lOFIOR400  := ( FunName() == "OFIOR400" ) // Função ImpOR400 pode ser chamado de outra rotina para gravar somente TXT - Alteração Escandinavia (SCANIA)
Private cbTxt    := Space(10)
Private cbCont   := 0
Private cString  := "VC1"
Private Li       := 80
Private m_Pag    := 1
Private wnRel    := __wnRel
Private nValTer := 0
Set Printer to &cNomeRel
Set Printer On
Set Device  to Printer
&& Cria Arquivo de Trabalho
aAdd(aVetCampos,{ "TRB_DATVEN" , "D" ,                       8  , 0 })  && data da venda
aAdd(aVetCampos,{ "TRB_FORPAG" , "C" ,                       3  , 0 })  && Forma de Pagamento
aAdd(aVetCampos,{ "TRB_DESPAG" , "C" ,                       22 , 0 })  && Descricao Forma de Pagamento
aAdd(aVetCampos,{ "TRB_TIPCOM" , "C" ,                       1  , 0 })  && tipo de comissao
aAdd(aVetCampos,{ "TRB_TIPVAL" , "C" ,                       1  , 0 })  && Tipo de valor ( valor totalizado ou nao )
aAdd(aVetCampos,{ "TRB_CODVEN" , "C" ,                       6  , 0 })  && codigo do vendedor
aAdd(aVetCampos,{ "TRB_NOMTEC" , "C" ,                       20 , 0 })  && nome do vendedor
aAdd(aVetCampos,{ "TRB_VALCMP" , "N" ,                       12 , 2 })  && Valor comissao Pecas
aAdd(aVetCampos,{ "TRB_VALTTP" , "N" ,                       12 , 2 })  && Valor Moeda Forte Pecas
aAdd(aVetCampos,{ "TRB_VALCMS" , "N" ,                       12 , 2 })  && Valor comissao Servicos
aAdd(aVetCampos,{ "TRB_VALTTS" , "N" ,                       12 , 2 })  && Valor Moeda Forte Servicos
aAdd(aVetCampos,{ "TRB_VALCMV" , "N" ,                       12 , 2 })  && Valor comissao Veiculos
aAdd(aVetCampos,{ "TRB_VALTTV" , "N" ,                       12 , 2 })  && Valor Moeda Forte Veiculos
aAdd(aVetCampos,{ "TRB_CC"     , "C" ,                       9  , 0 })  && Centro de Custo
aAdd(aVetCampos,{ "TRB_DESCC"  , "C" ,                       20 , 0 })  && Descricao do Centro de Custo
aAdd(aVetCampos,{ "TRB_FUNCAO" , "C" ,                       5  , 0 })  && Funcao
aAdd(aVetCampos,{ "TRB_DESFUN" , "C" ,                       20 , 0 })  && Descricao da funcao
aAdd(aVetCampos,{ "TRB_PERCOM" , "N" ,                       5  , 0 })  && Percentual de comissao
aAdd(aVetCampos,{ "TRB_NUMNFI" , "C" ,                       9  , 0 })  && Numero da Nota Fiscal
aAdd(aVetCampos,{ "TRB_SERNFI" , "C" , tamsx3('VV0_SERNFI')[1]  , 0 })  && Serie
aAdd(aVetCampos,{ "TRB_GRUITE" , "C" ,                       4  , 0 })  && grupo do item
aAdd(aVetCampos,{ "TRB_CODITE" , "C" ,                       27 , 0 })  && codigo do item
aAdd(aVetCampos,{ "TRB_DESCRI" , "C" ,                       15 , 0 })  && descricao
aAdd(aVetCampos,{ "TRB_CODSER" , "C" ,                       15 , 0 })  && codigo do Servico
aAdd(aVetCampos,{ "TRB_CODMOT" , "C" ,                       06 , 0 })  && codigo do Motivo
aAdd(aVetCampos,{ "TRB_CHASSI" , "C" ,                       25 , 0 })  && Chassi do Veiculo
aAdd(aVetCampos,{ "TRB_MOTIVO" , "C" ,                       33 , 0 })  && Motivo de Lançamento Manual de Comissão
aAdd(aVetCampos,{ "TRB_NUMOSV" , "C" ,                        8 , 0 })  && Numero da O.S.
aAdd(aVetCampos,{ "TRB_CLIENT" , "C" ,                       30 , 0 })  && Cliente

cArqIndex1 := CriaTrab(NIL, .F.)
cArqIndex2 := CriaTrab(NIL, .F.)
cArqIndex3 := CriaTrab(NIL, .F.)
cArqIndex4 := CriaTrab(NIL, .F.)
cArqIndex5 := CriaTrab(NIL, .F.)

oObjTempTable := OFDMSTempTable():New()
oObjTempTable:cAlias := "TRB"
oObjTempTable:aVetCampos := aVetCampos
oObjTempTable:AddIndex(cArqIndex1, {"TRB_FORPAG","TRB_CC","TRB_FUNCAO","TRB_CODVEN","TRB_TIPCOM","TRB_DATVEN","TRB_NUMNFI","TRB_TIPVAL"} )
oObjTempTable:AddIndex(cArqIndex2, {"TRB_TIPVAL","TRB_FORPAG","TRB_CC","TRB_FUNCAO","TRB_CODVEN","TRB_TIPCOM","TRB_DATVEN","TRB_NUMNFI","TRB_CODMOT"} )
oObjTempTable:AddIndex(cArqIndex3, {"TRB_TIPVAL","TRB_FORPAG","TRB_CC","TRB_FUNCAO","TRB_CODVEN","TRB_TIPCOM","TRB_DATVEN","TRB_NUMNFI","TRB_CHASSI"} )
oObjTempTable:AddIndex(cArqIndex4, {"TRB_TIPVAL","TRB_FORPAG","TRB_CC","TRB_FUNCAO","TRB_CODVEN","TRB_TIPCOM","TRB_DATVEN","TRB_NUMNFI","TRB_CODSER"} )
oObjTempTable:AddIndex(cArqIndex5, {"TRB_TIPVAL","TRB_FORPAG","TRB_CC","TRB_FUNCAO","TRB_CODVEN","TRB_TIPCOM","TRB_DATVEN","TRB_NUMNFI","TRB_GRUITE","TRB_CODITE"} )
oObjTempTable:CreateTable()
	
DbSetOrder(1)
&& Monta Arquivo de Trabalho
FS_LEVTOTAL( )

cTitulo:= STR0006 //"Relatorio de producao"
cabec1 := STR0007 + Space(32) + STR0008 //"Centro de Custo/Funcao"###"Pecas R$ ---- Pecas MF ----- Srvs R$ ----- Srvs MF ----- Veics R$ --- Veics MF"
cabec2 := ""
nomeprog:="OFIOR400"
tamanho:="M"
nCaracter:=15
DbSelectArea( "TRB" )
DbSetOrder(0)
DbGotop()
aAdd( aTotal ,  TRB->TRB_VALTTP )
aAdd( aTotal ,  TRB->TRB_VALCMP )
aAdd( aTotal ,  TRB->TRB_VALTTS+nValTer )
aAdd( aTotal ,  TRB->TRB_VALCMS )
aAdd( aTotal ,  TRB->TRB_VALTTV )
aAdd( aTotal ,  TRB->TRB_VALCMV )
ctitulo += STR0046+dtoc(MV_PAR01)+STR0047+dtoc(MV_PAR02)
DbSetOrder(5)
DbGoTop()
While !Eof()
	If nLin == 1
		nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
		If Len( aTotal ) # 0
			If lOFIOR400
				nLin++
				@ nLin++ , 00 pSay STR0009 + Repl(".",37) + Transform( aTotal[1] , "@E 99,999,999.99" ) + Space(1)+ Transform( aTotal[2] , "@E 99,999,999.99" ) + Space(1)+ Transform( aTotal[3] , "@E 99,999,999.99" ) + Space(1)+ Transform( aTotal[4] , "@E 99,999,999.99" ) + Space(1)+ Transform( aTotal[5] , "@E 99,999,999.99" ) + Space(1)+ Transform( aTotal[6] , "@E 99,999,999.99" )  //"Total Geral "
			Else
				fwrite(outputfile,""+CHR(13)+CHR(10))
				fwrite(outputfile,STR0009 + Repl(".",37) + Transform( aTotal[1] , "@E 99,999,999.99" ) + Space(1)+ Transform( aTotal[2] , "@E 99,999,999.99" ) + Space(1)+ Transform( aTotal[3] , "@E 99,999,999.99" ) + Space(1)+ Transform( aTotal[4] , "@E 99,999,999.99" ) + Space(1)+ Transform( aTotal[5] , "@E 99,999,999.99" ) + Space(1)+ Transform( aTotal[6] , "@E 99,999,999.99" )+CHR(13)+CHR(10)) //"Total Geral "
			Endif
			aTotal := {}
		EndIf
	EndIf
	If TRB->TRB_TIPVAL == "1" .and. MV_PAR12 == 1
		If lOFIOR400
			nLin++
			@ nLin++ , 01 pSay TRB->TRB_FORPAG + " - " + TRB->TRB_DESPAG + Repl(".",20) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )
		Else
			fwrite(outputfile,""+CHR(13)+CHR(10))
			fwrite(outputfile,Space(1)+TRB->TRB_FORPAG + " - " + TRB->TRB_DESPAG + Repl(".",20) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )+CHR(13)+CHR(10))
		Endif
	EndIf
	&& Total por Centro de Custo
	If TRB->TRB_TIPVAL == "2"
		If lOFIOR400
			nLin++
			@ nLin++ , 02 pSay TRB->TRB_CC + " - " + TRB->TRB_DESCC + Repl(".",15) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )
		Else
			fwrite(outputfile,""+CHR(13)+CHR(10))
			fwrite(outputfile,Space(2)+TRB->TRB_CC + " - " + TRB->TRB_DESCC + Repl(".",15) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )+CHR(13)+CHR(10))
		Endif
	EndIf
	&& Total por Funcao
	If TRB->TRB_TIPVAL == "3"
		If lOFIOR400
			nLin++
			@ nLin++ , 03 pSay TRB->TRB_FUNCAO  + " - " + TRB->TRB_DESFUN + Repl(".",18) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )
		Else
			fwrite(outputfile,""+CHR(13)+CHR(10))
			fwrite(outputfile,Space(3)+TRB->TRB_FUNCAO  + " - " + TRB->TRB_DESFUN + Repl(".",18) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )+CHR(13)+CHR(10))
		Endif
	EndIf
	&& Totaliza  produtivo
	If TRB->TRB_TIPVAL == "4"
		If lOFIOR400
			nLin++
			@ nLin++ , 04 pSay TRB->TRB_CODVEN + " - " + TRB->TRB_NOMTEC + " " + Repl(".",15) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )
		Else
			fwrite(outputfile,""+CHR(13)+CHR(10))
			fwrite(outputfile,Space(4)+TRB->TRB_CODVEN + " - " + TRB->TRB_NOMTEC + " " + Repl(".",15) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1)+ Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )+CHR(13)+CHR(10))
		Endif
	EndIf
	&& Total de Pecas
	If TRB->TRB_TIPVAL == "5"
		If lOFIOR400
			nLin++
			@ nLin++ , 05 pSay STR0010+If( TRB->TRB_TIPCOM == "P" , STR0011 , If( TRB->TRB_TIPCOM == "S" , STR0012 , STR0013 )) ; //"Total de "###"Pecas   "###"Servicos"###"Veiculos"
			+ Repl(".",27) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )
		Else
			fwrite(outputfile,""+CHR(13)+CHR(10))
			fwrite(outputfile,Space(5)+STR0010+If( TRB->TRB_TIPCOM == "P" , STR0011 , If( TRB->TRB_TIPCOM == "S" , STR0012 , STR0013 )) + Repl(".",27) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )+CHR(13)+CHR(10))
		Endif
	EndIf
	&& Total do Dia
	If TRB->TRB_TIPVAL == "6"
		If lOFIOR400
			nLin++
			@ nLin++ , 06 pSay STR0014 + Dtoc(TRB->TRB_DATVEN) + Repl(".",20) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )  //"Total do Dia "
		Else
			fwrite(outputfile,""+CHR(13)+CHR(10))
			fwrite(outputfile,Space(6)+STR0014 + Dtoc(TRB->TRB_DATVEN) + Repl(".",20) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )+CHR(13)+CHR(10)) //"Total do Dia "
		Endif
	EndIf
	&& Total Nota Fiscal
	If TRB->TRB_TIPVAL == "7"
		If lOFIOR400
			nLin++
		Else
			fwrite(outputfile,""+CHR(13)+CHR(10))
		Endif
		If TRB->TRB_TIPCOM == "A"
			cKeyAce := "000009"+TRB->TRB_CODMOT
			FG_Seek("VS0","cKeyAce",1,.f.)
			If lOFIOR400
				@ nLin++ , 07 pSay TRB->TRB_CODMOT + " " + left(VS0->VS0_DESMOT,34) + " " + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )  //"Total Nf "
			Else
				fwrite(outputfile,Space(7)+TRB->TRB_CODMOT + " " + left(VS0->VS0_DESMOT,34) + " " + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )+CHR(13)+CHR(10)) //"Total Nf "
			Endif
		Else
			If lOFIOR400
				@ nLin++ , 07 pSay STR0015 + TRB->TRB_NUMNFI + " " + FGX_UFSNF(TRB->TRB_SERNFI) + " "+TRB->TRB_NUMOSV + " "+ substr(TRB->TRB_CLIENT,1,10)+""+ Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )  //"Total Nf "
			Else
				fwrite(outputfile,Space(7)+STR0015 + TRB->TRB_NUMNFI + " " + FGX_UFSNF(TRB->TRB_SERNFI) + " "+TRB->TRB_NUMOSV + " "+ substr(TRB->TRB_CLIENT,1,10)+""+ Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )+CHR(13)+CHR(10)) //"Total Nf "
			Endif
		EndIf
	EndIf
	&& Total por item/servico/veiculos
	If TRB->TRB_TIPVAL == "8"
		If TRB->TRB_TIPCOM == "A"
			If lOFIOR400
				@ nLin++ , 08 pSay TRB->TRB_MOTIVO + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )
			Else
				fwrite(outputfile,Space(8)+TRB->TRB_MOTIVO + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )+CHR(13)+CHR(10))
			Endif
		EndIf
		If TRB->TRB_TIPCOM == "P"
			If lOFIOR400
				@ nLin++ , 08 pSay TRB->TRB_GRUITE + " " + TRB->TRB_CODITE + " " + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )
			Else
				fwrite(outputfile,Space(8)+TRB->TRB_GRUITE + " " + TRB->TRB_CODITE + " " + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )+CHR(13)+CHR(10))
			Endif
		EndIf
		If TRB->TRB_TIPCOM == "S"
			If lOFIOR400
				@ nLin++ , 08 pSay TRB->TRB_CODSER + Repl(".",26) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )
			Else
				fwrite(outputfile,Space(8)+TRB->TRB_CODSER + Repl(".",26) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )+CHR(13)+CHR(10))
			Endif
		EndIf
		If TRB->TRB_TIPCOM == "V"
			If lOFIOR400
				@ nLin++ , 08 pSay TRB->TRB_CHASSI + Repl(".",16) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )
			Else
				fwrite(outputfile,Space(8)+TRB->TRB_CHASSI + Repl(".",16) + Transform( TRB->TRB_VALTTP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMP , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMS , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALTTV , "@E 99,999,999.99" ) + Space(1) + Transform( TRB->TRB_VALCMV , "@E 99,999,999.99" )+CHR(13)+CHR(10))
			Endif
		EndIf
	EndIf
	If nLin >= 62
		nLin := 1
	EndIf
	DbSelectArea("TRB")
	DbSkip()
EndDo
/*
If MV_PAR13 == 2   && Encerra Comissao
DbSelectArea("SX6")
DbSetOrder(1)
If DbSeek(xFilial("SX6")+"MV_FECCOM")
RecLock("SX6",.f.)
SX6->X6_CONTEUD := Dtos(dDataBase)
MsUnLock()
EndIf
EndIf
*/


// Imprime Servicos nao Apontados

nLenVet := Len(aNaoApont)

nFor := 0
If nLenVet > 0
	nLin    := 1
	cabec1 := Space(43)+STR0016
	nLin    := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
	nTotVNA := 0
	for nFor := 1 to nLenVet
		If nLin == 1
			nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 1
		EndIf
		@ nLin++ , 16 pSay aNaoApont[nFor,1] + " - " + aNaoApont[nFor,2] +  STR0017+ Transform( aNaoApont[nFor,3] , "@E 99,999,999.99" ) + "  " + aNaoApont[nFor,4]
		If nLin >= 60
			nLin := nLin + 2
			@ nLin++ , 16 pSay STR0018
			nLin := 1
		EndIf
		nTotVNA += aNaoApont[nFor,3]
	Next
	nLin := nLin + 2
	@ nLin++, 16 psay STR0019 + Transform( nTotVNA , "@E 99,999,999.99" )
Endif

Eject
Set Printer to
Set Device  to Screen
MS_FLUSH()
oObjTempTable:CloseTable()
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_LEVTOTAºAutor  ³Fabio               º Data ³  11/13/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Totaliza                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_LEVTOTAL( )
Local nPosReg := 0 , nBarra   := 0 , aControTotal:={}
Local nPos := 0
Local lSchedule := FWGetRunSchedule() // Esta sendo chamado por outras rotinas via SCHEDULE ?
&& Lancamento manual
If ( MV_PAR11 == 1 .or. MV_PAR11 == 5 )
	DbSelectArea("VSQ")
	DbSetOrder(1)
	DbSeek( xFilial( "VSQ" ) + Dtos(MV_PAR01) , .t. )
	If !lSchedule
		Count to nBarra For !Eof() .and. VSQ->VSQ_FILIAL == xFilial("VSQ") .and. VSQ->VSQ_DATMAN >= MV_PAR01 .and. VSQ->VSQ_DATMAN <= MV_PAR02
	EndIf
EndIf
&& Veiculos
If ( MV_PAR11 == 1 .or. MV_PAR11 == 4 )
	DbSelectArea("VV0")
	DbSetOrder(2)
	DbSeek( xFilial( "VV0" ) + "0" + Dtos(MV_PAR01) , .t. )
	If !lSchedule
		Count to nBarra For !Eof() .and. VV0->VV0_FILIAL == xFilial("VV0") .and. VV0->VV0_OPEMOV == "0" .and. VV0->VV0_DATMOV >= MV_PAR01 .and. VV0->VV0_DATMOV <= MV_PAR02
	EndIf
EndIf
&& Servicos
If ( MV_PAR11 == 1 .or. MV_PAR11 == 3 )
	DbSelectArea("VSC")
	DbSetOrder(5)
	DbSeek( xFilial( "VSC" ) + Dtos(MV_PAR01) , .t. )
	If !lSchedule
		Count to nBarra For !Eof() .and. VSC->VSC_FILIAL == xFilial("VSC") .and. VSC->VSC_DATVEN >= MV_PAR01 .and. VSC->VSC_DATVEN <= MV_PAR02
	EndIf
EndIf
&& Pecas
If ( MV_PAR11 == 1 .or. MV_PAR11 == 2 )
	DbSelectArea("VEC")
	DbSetOrder(3)
	DbSeek( xFilial( "VEC" ) + Dtos(MV_PAR01) , .t. )
	If !lSchedule
		Count to nBarra For !Eof() .and. VEC->VEC_FILIAL == xFilial("VEC") .and. VEC->VEC_DATVEN >= MV_PAR01 .and. VEC->VEC_DATVEN <= MV_PAR02
	EndIf
EndIf
If !lSchedule
	SetRegua( nBarra )
EndIf
&& Totaliza Lancamento de Comissao manual
If ( MV_PAR11 == 1 .or. MV_PAR11 == 5 )
	DbSelectArea("VSQ")
	DbSetOrder(1)
	DbSeek( xFilial( "VSQ" ) + Dtos(MV_PAR01) , .t. )
	Do While !Eof() .and. VSQ->VSQ_FILIAL == xFilial("VSQ") .and. VSQ->VSQ_DATMAN >= MV_PAR01 .and. VSQ->VSQ_DATMAN <= MV_PAR02
		DbSelectArea("VSG")
		DbSetOrder(1)
		DbSeek( xFilial( "VSG" ) + VSQ->VSQ_NUMIDE + "A" )
		Do While !Eof() .and. VSG->VSG_FILIAL == xFilial("VSG") .and. VSG->VSG_NOSNUM == VSQ->VSQ_NUMIDE .and. VSG->VSG_TIPCOM == "A"
			DbSelectArea("VAI")
			DbSetOrder(6)
			DbSeek( xFilial("VAI") + VSG->VSG_CODVEN )
			If ( Empty( MV_PAR07 ) .or. VAI->VAI_CODTEC >= MV_PAR07 ) .and. ( Empty( MV_PAR08 ) .or. VAI->VAI_CODTEC <= MV_PAR08 )
				If !Empty(MV_PAR03) .or. !Empty(MV_PAR04)
					If VAI->VAI_CC  < Alltrim(MV_PAR03) .or. VAI->VAI_CC > Alltrim(MV_PAR04)
						DbSelectArea("VSG")
						dbSkip()
						Loop
					EndIf
				EndIf
				If !Empty(MV_PAR05) .or. !Empty(MV_PAR06)
					If VAI->VAI_FUNCAO < Alltrim(MV_PAR05) .or. VAI->VAI_FUNCAO > Alltrim(MV_PAR06)
						DbSelectArea("VSG")
						dbSkip()
						Loop
					EndIf
				EndIf
				DbSelectArea("SRJ")
				DbSetOrder(1)
				DbSeek( xFilial("SRJ") + VAI->VAI_FUNCAO )
				DbSelectArea("CTT")
				DbSetOrder(1)
				DbSeek( xFilial("CTT") + VAI->VAI_CC )
				DbSelectArea("VS0")
				DbSetOrder(1)
				DbSeek( xFilial("VS0") + VSQ->VSQ_MOTIVO )
				cFormaPag := "XXX"
				If MV_PAR12 == 1
					cFormaPag := "LANCTO MANUAL"
				EndIf
				
				For nPosReg := 0 to If( MV_PAR10 == 1 , 4 , If( MV_PAR10 == 2 , 5 , 8 ) )  && 5 niveis de valor
					//For nPosReg := 0 to If( MV_PAR10 == 1 , 4 , If( MV_PAR10 == 2 , 5 , If( MV_PAR10 == 3 , 6 , If( MV_PAR10 == 4 , 7 , 8 ) ) ) )  && 5 niveis de valor
					DbSelectArea("TRB")
					DbSetOrder(4)
					If nPosReg == 0
						DbSeek( Str( nPosReg , 1 ) )
						&& Se o Valor ja foi somado nao soma no total
						If Len(aControTotal) # 0 .and. Ascan(aControTotal, VV0->VV0_NUMNFI + VVA->VVA_CHASSI ) # 0
							Loop
						EndIf
						Aadd(aControTotal, VV0->VV0_NUMNFI + VVA->VVA_CHASSI )
					ElseIf nPosReg == 1
						DbSeek( Str( nPosReg , 1 ) + cFormaPag )
					ElseIf nPosReg == 2
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC  )
					ElseIf nPosReg == 3
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO )
					ElseIf nPosReg == 4
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN )
					ElseIf nPosReg == 5
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN + VSG->VSG_TIPCOM  )
					ElseIf nPosReg == 6
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN + VSG->VSG_TIPCOM + Dtos( VSQ->VSQ_DATMAN ) )
					ElseIf nPosReg == 7
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN + VSG->VSG_TIPCOM + Dtos( VSQ->VSQ_DATMAN ) + Space(Len(TRB->TRB_NUMNFI)) )
					Else
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN + VSG->VSG_TIPCOM + Dtos( VSQ->VSQ_DATMAN ) + Space(Len(TRB->TRB_NUMNFI)) + VSQ->VSQ_MOTIVO )
					EndIf
					RecLock( "TRB" , !Found() )
					If nPosReg >= 0
						TRB->TRB_TIPVAL := Str( nPosReg , 1 )
					EndIf
					If nPosReg >= 1
						TRB->TRB_FORPAG := cFormaPag
						TRB->TRB_DESPAG := cFormaPag
						TRB->TRB_MOTIVO := VSQ->VSQ_COMMOT
					EndIf
					If nPosReg >= 2
						TRB->TRB_CC     := VAI->VAI_CC
						TRB->TRB_DESCC  := CTT->CTT_DESC01
					EndIf
					If nPosReg >= 3
						TRB->TRB_FUNCAO := VAI->VAI_FUNCAO
						TRB->TRB_DESFUN := SRJ->RJ_DESC
						TRB->TRB_DESCC  := CTT->CTT_DESC01
					EndIf
					If nPosReg >= 4
						TRB->TRB_CODVEN := VSG->VSG_CODVEN
						TRB->TRB_NOMTEC := VAI->VAI_NOMTEC
						TRB->TRB_DESCC  := CTT->CTT_DESC01
					EndIf
					If nPosReg >= 5
						TRB->TRB_TIPCOM := VSG->VSG_TIPCOM
						TRB->TRB_DESCC  := CTT->CTT_DESC01
					EndIf
					If nPosReg >= 6
						TRB->TRB_DATVEN := VSQ->VSQ_DATMAN
						TRB->TRB_DESCC  := CTT->CTT_DESC01
					EndIf
					If nPosReg >= 7
						TRB->TRB_CODMOT := VSQ->VSQ_MOTIVO
					EndIf
					TRB->TRB_DESCRI := VS0->VS0_DESMOT
					TRB->TRB_PERCOM := VSG->VSG_PERCOM
					&& Totaliza
					If MV_PAR09 == 1
						TRB->TRB_VALCMP += VSG->VSG_VALCOM
					EndIf
					If MV_PAR09 == 2
						TRB->TRB_VALCMP += VSG->VSG_MODFOR
					EndIf
					If MV_PAR09 >= 3
						TRB->TRB_VALCMP += xMoeda(VSG->VSG_VALCOM , 1 , MV_PAR09 , VSQ->VSQ_DATMAN )
					EndIf
					MsUnLock()
				next
			EndIf
			DbSelectArea("VSG")
			DbSkip()
		EndDo
		If !lSchedule
			IncRegua()
		EndIf
		DbSelectArea("VSQ")
		DbSkip()
	EndDo
EndIf
&& Totaliza Veiculos
If ( MV_PAR11 == 1 .or. MV_PAR11 == 4 )
	DbSelectArea("VV0")
	DbSetOrder(2)
	DbSeek( xFilial( "VV0" ) + "0" + Dtos(MV_PAR01) , .t. )
	Do While !Eof() .and. VV0->VV0_FILIAL == xFilial("VV0") .and. VV0->VV0_OPEMOV == "0" .and. VV0->VV0_DATMOV >= MV_PAR01 .and. VV0->VV0_DATMOV <= MV_PAR02
		If Empty( VV0->VV0_NUMNFI ) .or. VV0->VV0_SITNFI # "1"
			DbSkip()
			Loop
		EndIf
		DbSelectArea("VVA")
		DbSetOrder(1)
		DbSeek( xFilial( "VVA" ) + VV0->VV0_NUMTRA )
		Do While !Eof() .and. VVA->VVA_FILIAL == xFilial("VVA") .and. VVA->VVA_NUMTRA == VV0->VV0_NUMTRA
			DbSelectArea("VSG")
			DbSetOrder(1)
			DbSeek( xFilial( "VSG" ) + VVA->VVA_NUMTRA + "V" )
			Do While !Eof() .and. VSG->VSG_FILIAL == xFilial("VSG") .and. VSG->VSG_NOSNUM == VVA->VVA_NUMTRA .and. VSG->VSG_TIPCOM == "V"
				DbSelectArea("VAI")
				DbSetOrder(6)
				DbSeek( xFilial("VAI") + VSG->VSG_CODVEN )
				If ( Empty( MV_PAR07 ) .or. VAI->VAI_CODTEC >= MV_PAR07 ) .and. ( Empty( MV_PAR08 ) .or. VAI->VAI_CODTEC <= MV_PAR08 )
					If !Empty(MV_PAR03) .or. !Empty(MV_PAR04)
						If VAI->VAI_CC  < Alltrim(MV_PAR03) .or. VAI->VAI_CC > Alltrim(MV_PAR04)
							DbSelectArea("VSG")
							dbSkip()
							Loop
						EndIf
					EndIf
					If !Empty(MV_PAR05) .or. !Empty(MV_PAR06)
						If VAI->VAI_FUNCAO < Alltrim(MV_PAR05) .or. VAI->VAI_FUNCAO > Alltrim(MV_PAR06)
							DbSelectArea("VSG")
							dbSkip()
							Loop
						EndIf
					EndIf
					DbSelectArea("SF2")
					DbSetOrder(1)
					DbSeek( xFilial("SF2") + VV0->VV0_NUMNFI + VV0->VV0_SERNFI )
					DbSelectArea("SE4")
					DbSetOrder(1)
					DbSeek( xFilial("SE4") + SF2->F2_COND )
					DbSelectArea("SRJ")
					DbSetOrder(1)
					DbSeek( xFilial("SRJ") + VAI->VAI_FUNCAO )
					DbSelectArea("CTT")
					DbSetOrder(1)
					DbSeek( xFilial("CTT") + VAI->VAI_CC )
					cFormaPag := "XXX"
					If MV_PAR12 == 1
						cFormaPag := SF2->F2_COND
					EndIf
					For nPosReg := 0 to If( MV_PAR10 == 1 , 4 , If( MV_PAR10 == 2 , 5 , 8 ) )  && 5 niveis de valor
						//For nPosReg := 0 to If( MV_PAR10 == 1 , 4 , If( MV_PAR10 == 2 , 5 , If( MV_PAR10 == 3 , 6 , If( MV_PAR10 == 4 , 7 , 8 ) ) ) )  && 5 niveis de valor
						DbSelectArea("TRB")
						DbSetOrder(3)
						If nPosReg == 0
							DbSeek( Str( nPosReg , 1 ) )
							&& Se o Valor ja foi somado nao soma no total
							If Len(aControTotal) # 0 .and. Ascan(aControTotal, VSC->VSC_NUMNFI + VSC->VSC_CODSER ) # 0
								Loop
							EndIf
							aAdd(aControTotal, VSC->VSC_NUMNFI + VSC->VSC_CODSER )
						ElseIf nPosReg == 1
							DbSeek( Str( nPosReg , 1 ) + cFormaPag )
						ElseIf nPosReg == 2
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC  )
						ElseIf nPosReg == 3
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO )
						ElseIf nPosReg == 4
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN )
						ElseIf nPosReg == 5
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN + VSG->VSG_TIPCOM  )
						ElseIf nPosReg == 6
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN + VSG->VSG_TIPCOM + Dtos( VV0->VV0_DATMOV ) )
						ElseIf nPosReg == 7
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN + VSG->VSG_TIPCOM + Dtos( VV0->VV0_DATMOV ) + VV0->VV0_NUMNFI )
						Else
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN + VSG->VSG_TIPCOM + Dtos( VV0->VV0_DATMOV ) + VV0->VV0_NUMNFI + VVA->VVA_CHASSI )
						EndIf
						RecLock( "TRB" , !Found() )
						If nPosReg >= 0
							TRB->TRB_TIPVAL := Str( nPosReg , 1 )
						EndIf
						If nPosReg >= 1
							TRB->TRB_FORPAG := cFormaPag
							TRB->TRB_DESPAG := SE4->E4_DESCRI
						EndIf
						If nPosReg >= 2
							TRB->TRB_DESCC  := CTT->CTT_DESC01
							TRB->TRB_CC     := VAI->VAI_CC
						EndIf
						If nPosReg >= 3
							TRB->TRB_FUNCAO := VAI->VAI_FUNCAO
							TRB->TRB_DESFUN := SRJ->RJ_DESC
							TRB->TRB_DESCC  := CTT->CTT_DESC01
						EndIf
						If nPosReg >= 4
							TRB->TRB_CODVEN := VSG->VSG_CODVEN
							TRB->TRB_NOMTEC := VAI->VAI_NOMTEC
							TRB->TRB_DESCC  := CTT->CTT_DESC01
						EndIf
						If nPosReg >= 5
							TRB->TRB_TIPCOM := VSG->VSG_TIPCOM
							TRB->TRB_DESCC  := CTT->CTT_DESC01
						EndIf
						If nPosReg >= 6
							TRB->TRB_DATVEN := VV0->VV0_DATMOV
							TRB->TRB_DESCC  := CTT->CTT_DESC01
						EndIf
						If nPosReg >= 7
							TRB->TRB_NUMNFI := VV0->VV0_NUMNFI
							TRB->TRB_SERNFI := VV0->VV0_SERNFI
							TRB->TRB_DESCC  := CTT->CTT_DESC01
						EndIf
						If nPosReg >= 8
							TRB->TRB_CHASSI := VVA->VVA_CHASSI
						EndIf
						TRB->TRB_DESCC  := CTT->CTT_DESC01
						TRB->TRB_PERCOM := VSG->VSG_PERCOM
						&& Totaliza
						If MV_PAR09 == 1
							TRB->TRB_VALTTV += VVA->VVA_VALVDA
							TRB->TRB_VALCMV += VSG->VSG_VALCOM
						EndIf
						If MV_PAR09 == 2
							TRB->TRB_VALTTV += VVA->VVA_VMFVDA
							TRB->TRB_VALCMV += VSG->VSG_MODFOR
						EndIf
						If MV_PAR09 >= 3
							TRB->TRB_VALTTV += xMoeda(VVA->VVA_VALVDA , 1 , MV_PAR09 , VV0->VV0_DATMOV )
							TRB->TRB_VALCMV += xMoeda(VSG->VSG_VALCOM , 1 , MV_PAR09 , VV0->VV0_DATMOV )
						EndIf
						MsUnLock()
					next
				EndIf
				DbSelectArea("VSG")
				DbSkip()
			EndDo
			DbSelectArea("VVA")
			DbSkip()
		EndDo
		If !lSchedule
			IncRegua()
		EndIf
		DbSelectArea("VV0")
		DbSkip()
	EndDo
EndIf
&& Totaliza Servico
nTotalit:=0
If ( MV_PAR11 == 1 .or. MV_PAR11 == 3 )
	DbSelectArea("VSC")
	DbSetOrder(5)
	DbSeek( xFilial( "VSC" ) + Dtos(MV_PAR01) , .t. )
	Do While !Eof() .and. VSC->VSC_FILIAL == xFilial("VSC") .and. VSC->VSC_DATVEN >= MV_PAR01 .and. VSC->VSC_DATVEN <= MV_PAR02
		If !Empty(VSC->VSC_CODPRO) // Servicos com Produtivos Apontados
			DbSelectArea("VSG")
			DbSetOrder(1)
			DbSeek( xFilial( "VSG" ) + VSC->VSC_NUMIDE + "S" )
			Do While !Eof() .and. VSG->VSG_FILIAL == xFilial("VSG") .and. VSG->VSG_NOSNUM == VSC->VSC_NUMIDE .and. VSG->VSG_TIPCOM == "S"
				DbSelectArea("VAI")
				DbSetOrder(6)
				DbSeek( xFilial("VAI") + VSG->VSG_CODVEN )
				If ( Empty( MV_PAR07 ) .or. VAI->VAI_CODTEC >= MV_PAR07 ) .and. ( Empty( MV_PAR08 ) .or. VAI->VAI_CODTEC <= MV_PAR08 )
					If !Empty(MV_PAR03) .or. !Empty(MV_PAR04)
						If VAI->VAI_CC  < Alltrim(MV_PAR03) .or. VAI->VAI_CC > Alltrim(MV_PAR04)
							DbSelectArea("VSG")
							dbSkip()
							Loop
						EndIf
					EndIf
					If !Empty(MV_PAR05) .or. !Empty(MV_PAR06)
						If VAI->VAI_FUNCAO < Alltrim(MV_PAR05) .or. VAI->VAI_FUNCAO > Alltrim(MV_PAR06)
							DbSelectArea("VSG")
							dbSkip()
							Loop
						EndIf
					EndIf
					DbSelectArea("SF2")
					DbSetOrder(1)
					DbSeek( xFilial("SF2") + VSC->VSC_NUMNFI + VSC->VSC_SERNFI )
					DbSelectArea("SE4")
					DbSetOrder(1)
					DbSeek( xFilial("SE4") + SF2->F2_COND )
					DbSelectArea("SRJ")
					DbSetOrder(1)
					DbSeek( xFilial("SRJ") + VAI->VAI_FUNCAO )
					DbSelectArea("CTT")
					DbSetOrder(1)
					DbSeek( xFilial("CTT") + VAI->VAI_CC )
					DbSelectArea("VO6")
					DbSetOrder(1)
					DbSeek( xFilial("VO6") + VSC->VSC_SERINT )
					DbSelectArea("VOI")
					DbSetOrder(1)
					DbSeek( xFilial("VOI") + VSC->VSC_TIPTEM )
					cFormaPag := "XXX"
					If MV_PAR12 == 1
						cFormaPag := SF2->F2_COND
					EndIf
					nPosReg := 0
					For nPosReg := 0 to If( MV_PAR10 == 1 , 4 , If( MV_PAR10 == 2 , 5 , 8 ) )  && 5 niveis de valor
						//For nPosReg := 0 to If( MV_PAR10 == 1 , 4 , If( MV_PAR10 == 2 , 5 , If( MV_PAR10 == 3 , 6 , If( MV_PAR10 == 4 , 7 , 8 ) ) ) )  && 5 niveis de valor
						
						DbSelectArea("TRB")
						DbSetOrder(2)
						If nPosReg == 0
							DbSeek( Str( nPosReg , 1 ) )
							&& Se o Valor ja foi somado nao soma no total
							//If Len(aControTotal) # 0 .and. Ascan(aControTotal, VSC->VSC_NUMNFI + VSC->VSC_CODSER ) # 0
							//	Loop
							//EndIf
							aAdd(aControTotal, VSC->VSC_NUMNFI + VSC->VSC_CODSER )
						ElseIf nPosReg == 1
							DbSeek( Str( nPosReg , 1 ) + cFormaPag )
						ElseIf nPosReg == 2
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC  )
						ElseIf nPosReg == 3
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO )
						ElseIf nPosReg == 4
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN )
						ElseIf nPosReg == 5
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN  + VSG->VSG_TIPCOM  )
						ElseIf nPosReg == 6
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN  + VSG->VSG_TIPCOM + Dtos( VSC->VSC_DATVEN ) )
						ElseIf nPosReg == 7
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN  + VSG->VSG_TIPCOM + Dtos( VSC->VSC_DATVEN ) + VSC->VSC_NUMNFI )
						Else
							DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN  + VSG->VSG_TIPCOM + Dtos( VSC->VSC_DATVEN ) + VSC->VSC_NUMNFI + VSC->VSC_CODSER )
						EndIf
						RecLock( "TRB" , !Found() )
						If nPosReg >= 0
							TRB->TRB_TIPVAL := Str( nPosReg , 1 )
						EndIf
						If nPosReg >= 1
							TRB->TRB_FORPAG := cFormaPag
							TRB->TRB_DESPAG := SE4->E4_DESCRI
						EndIf
						If nPosReg >= 2
							TRB->TRB_CC     := VAI->VAI_CC
							TRB->TRB_DESCC  := CTT->CTT_DESC01
						EndIf
						If nPosReg >= 3
							TRB->TRB_FUNCAO := VAI->VAI_FUNCAO
							TRB->TRB_DESFUN := SRJ->RJ_DESC
							TRB->TRB_DESCC  := CTT->CTT_DESC01
						EndIf
						If nPosReg >= 4
							TRB->TRB_CODVEN := VSG->VSG_CODVEN
							TRB->TRB_NOMTEC := VAI->VAI_NOMTEC
							TRB->TRB_DESCC  := CTT->CTT_DESC01
						EndIf
						If nPosReg >= 5
							TRB->TRB_TIPCOM := VSG->VSG_TIPCOM
							TRB->TRB_DESCC  := CTT->CTT_DESC01
						EndIf
						If nPosReg >= 6
							TRB->TRB_DATVEN := VSC->VSC_DATVEN
							TRB->TRB_DESCC  := CTT->CTT_DESC01
						EndIf
						If nPosReg >= 7
							TRB->TRB_NUMNFI := VSC->VSC_NUMNFI
							TRB->TRB_SERNFI := VSC->VSC_SERNFI
							TRB->TRB_NUMOSV := VSC->VSC_NUMOSV
							If VOI->VOI_SITTPO <> "3"
								DbSelectArea("SA1")
								DbSetOrder(1)
								DbSeek( xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA )
								TRB->TRB_CLIENT:= SA1->A1_NOME
							Else
								DbSelectArea("SA1")
								DbSetOrder(1)
								DbSeek( xFilial("SA1") + VO4->VO4_FATPAR + VO4->VO4_LOJA )
								TRB->TRB_CLIENT:= SA1->A1_NOME
							Endif
							TRB->TRB_DESCC  := CTT->CTT_DESC01
						EndIf
						If nPosReg >= 8
							TRB->TRB_CODSER := VSC->VSC_CODSER
							TRB->TRB_DESCRI := Substr(VO6->VO6_DESSER,1,30)
						EndIf
						TRB->TRB_PERCOM := VSG->VSG_PERCOM
						&& Totaliza
						If VOI->VOI_SITTPO == "3"
							VO4->(dbGoTo(val(VSC->VSC_RECVO4)))
							If MV_PAR09 == 1
								TRB->TRB_VALTTS += VO4->VO4_VALINT
								TRB->TRB_VALCMS += VSG->VSG_VALCOM
							EndIf
							If MV_PAR09 >= 3
								TRB->TRB_VALTTS += xMoeda(VO4->VO4_VALINT , 1 , MV_PAR09 , VSC->VSC_DATVEN )
								TRB->TRB_VALCMS += xMoeda(VSG->VSG_VALCOM , 1 , MV_PAR09 , VSC->VSC_DATVEN )
							EndIf
						Else
							If MV_PAR09 == 1
								TRB->TRB_VALTTS += VSC->VSC_VALSER
								TRB->TRB_VALCMS += VSG->VSG_VALCOM
							EndIf
							If MV_PAR09 == 2
								TRB->TRB_VALTTS += VSC->VSC_VMFSER
								TRB->TRB_VALCMS += VSG->VSG_MODFOR
							EndIf
							If MV_PAR09 >= 3
								TRB->TRB_VALTTS += xMoeda(VSC->VSC_VALSER , 1 , MV_PAR09 , VSC->VSC_DATVEN )
								TRB->TRB_VALCMS += xMoeda(VSG->VSG_VALCOM , 1 , MV_PAR09 , VSC->VSC_DATVEN )
							EndIf
						EndIf
						MsUnLock()
					next
				EndIf
				DbSelectArea("VSG")
				DbSkip()
			EndDo
		Else
			DbSelectArea("VOK")
			DbSetOrder(1)
			DbSeek( xFilial("VOK") + VSC->VSC_TIPSER )
			
			DbSelectArea("VOI")
			DbSetOrder(1)
			DbSeek( xFilial("VOI") + VSC->VSC_TIPTEM )
			
			nPos := aScan(aNaoApont,{|x| x[1] == VSC->VSC_TIPSER})
			If nPos > 0
				If VOI->VOI_SITTPO == "3" // Internos
					VO4->(dbGoTo(val(VSC->VSC_RECVO4)))
					aNaoApont[nPos,3] += VO4->VO4_VALINT
					nValTer += VO4->VO4_VALINT
				Else
					aNaoApont[nPos,3] += VSC->VSC_VALSER
					nValTer += VSC->VSC_VALSER
				Endif
			Else
				If VOI->VOI_SITTPO == "3" // Internos
					VO4->(dbGoTo(val(VSC->VSC_RECVO4)))
					aadd(aNaoApont,{VSC->VSC_TIPSER,VOK->VOK_DESSER,VO4->VO4_VALINT,VOK->VOK_INCMOB})
					nValTer += VO4->VO4_VALINT
				Else
					aadd(aNaoApont,{VSC->VSC_TIPSER,VOK->VOK_DESSER,VSC->VSC_VALSER,VOK->VOK_INCMOB})
					nValTer += VSC->VSC_VALSER
				Endif
			Endif
		EndIF
		If !lSchedule
			IncRegua()
		EndIf
		DbSelectArea("VSC")
		DbSkip()
	EndDo
EndIf
&& Totaliza Pecas
If ( MV_PAR11 == 1 .or. MV_PAR11 == 2 )
	DbSelectArea("VEC")
	DbSetOrder(3)
	DbSeek( xFilial( "VEC" ) + Dtos(MV_PAR01) , .t. )
	Do While !Eof() .and. VEC->VEC_FILIAL == xFilial("VEC") .and. VEC->VEC_DATVEN >= MV_PAR01 .and. VEC->VEC_DATVEN <= MV_PAR02
		DbSelectArea("VSG")
		DbSetOrder(1)
		DbSeek( xFilial( "VSG" ) + VEC->VEC_NUMIDE + "P" )
		Do While !Eof() .and. VSG->VSG_FILIAL == xFilial("VSG") .and. VSG->VSG_NOSNUM == VEC->VEC_NUMIDE .and. VSG->VSG_TIPCOM == "P"
			DbSelectArea("VAI")
			DbSetOrder(6)
			DbSeek( xFilial("VAI") + VSG->VSG_CODVEN )
			If ( Empty( MV_PAR07 ) .or. VAI->VAI_CODTEC >= MV_PAR07 ) .and. ( Empty( MV_PAR08 ) .or. VAI->VAI_CODTEC <= MV_PAR08 )
				If !Empty(MV_PAR03) .or. !Empty(MV_PAR04)
					If VAI->VAI_CC  < Alltrim(MV_PAR03) .or. VAI->VAI_CC > Alltrim(MV_PAR04)
						DbSelectArea("VSG")
						dbSkip()
						Loop
					EndIf
				EndIf
				If !Empty(MV_PAR05) .or. !Empty(MV_PAR06)
					If VAI->VAI_FUNCAO < Alltrim(MV_PAR05) .or. VAI->VAI_FUNCAO > Alltrim(MV_PAR06)
						DbSelectArea("VSG")
						dbSkip()
						Loop
					EndIf
				EndIf
				DbSelectArea("SF2")
				DbSetOrder(1)
				DbSeek( xFilial("SF2") + VEC->VEC_NUMNFI + VEC->VEC_SERNFI )
				DbSelectArea("SE4")
				DbSetOrder(1)
				DbSeek( xFilial("SE4") + SF2->F2_COND )
				DbSelectArea("SRJ")
				DbSetOrder(1)
				DbSeek( xFilial("SRJ") + VAI->VAI_FUNCAO )
				DbSelectArea("CTT")
				DbSetOrder(1)
				DbSeek( xFilial("CTT") + VAI->VAI_CC )
				DbSelectArea("SB1")
				DbSetOrder(7)
				DbSeek( xFilial("SB1") + VEC->VEC_GRUITE + VEC->VEC_CODITE )
				DbSelectArea("SA1")
				DbSetOrder(1)
				DbSeek( xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA )
				cFormaPag := "XXX"
				If MV_PAR12 == 1
					cFormaPag := SF2->F2_COND
				EndIf
				For nPosReg := 0 to If( MV_PAR10 == 1 , 4 , If( MV_PAR10 == 2 , 5 , 8 ) )  && 5 niveis de valor
					//For nPosReg := 0 to If( MV_PAR10 == 1 , 4 , If( MV_PAR10 == 2 , 5 , If( MV_PAR10 == 3 , 6 , If( MV_PAR10 == 4 , 7 , 8 ) ) ) )  && 5 niveis de valor
					
					DbSelectArea("TRB")
					DbSetOrder(1)
					If nPosReg == 0
						DbSeek( Str( nPosReg , 1 ) )
					ElseIf nPosReg == 1
						DbSeek( Str( nPosReg , 1 ) + cFormaPag )
					ElseIf nPosReg == 2
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC  )
					ElseIf nPosReg == 3
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO )
					ElseIf nPosReg == 4
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN )
					ElseIf nPosReg == 5
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN + VSG->VSG_TIPCOM  )
					ElseIf nPosReg == 6
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN + VSG->VSG_TIPCOM + Dtos( VEC->VEC_DATVEN ) )
					ElseIf nPosReg == 7
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN + VSG->VSG_TIPCOM + Dtos( VEC->VEC_DATVEN ) + VEC->VEC_NUMNFI )
					Else
						DbSeek( Str( nPosReg , 1 ) + cFormaPag + VAI->VAI_CC + VAI->VAI_FUNCAO + VSG->VSG_CODVEN + VSG->VSG_TIPCOM + Dtos( VEC->VEC_DATVEN ) + VEC->VEC_NUMNFI + VEC->VEC_GRUITE + VEC->VEC_CODITE )
					EndIf
					RecLock( "TRB" , !Found() )
					If nPosReg >= 0
						TRB->TRB_TIPVAL := Str( nPosReg , 1 )
					EndIf
					If nPosReg >= 1
						TRB->TRB_FORPAG := cFormaPag
						TRB->TRB_DESPAG := SE4->E4_DESCRI
					EndIf
					If nPosReg >= 2
						TRB->TRB_CC     := VAI->VAI_CC
						TRB->TRB_DESCC  := CTT->CTT_DESC01
					EndIf
					If nPosReg >= 3
						TRB->TRB_FUNCAO := VAI->VAI_FUNCAO
						TRB->TRB_DESFUN := SRJ->RJ_DESC
						TRB->TRB_DESCC  := CTT->CTT_DESC01
					EndIf
					If nPosReg >= 4
						TRB->TRB_CODVEN := VSG->VSG_CODVEN
						TRB->TRB_NOMTEC := VAI->VAI_NOMTEC
						TRB->TRB_DESCC  := CTT->CTT_DESC01
					EndIf
					If nPosReg >= 5
						TRB->TRB_TIPCOM := VSG->VSG_TIPCOM
						TRB->TRB_DESCC  := CTT->CTT_DESC01
					EndIf
					If nPosReg >= 6
						TRB->TRB_DATVEN := VEC->VEC_DATVEN
						TRB->TRB_DESCC  := CTT->CTT_DESC01
					EndIf
					If nPosReg >= 7
						TRB->TRB_NUMNFI := VEC->VEC_NUMNFI
						TRB->TRB_SERNFI := VEC->VEC_SERNFI
						TRB->TRB_NUMOSV := VEC->VEC_NUMOSV
						TRB->TRB_CLIENT := SA1->A1_NOME
						TRB->TRB_DESCC  := CTT->CTT_DESC01
					EndIf
					If nPosReg >= 8
						TRB->TRB_GRUITE := VEC->VEC_GRUITE
						TRB->TRB_CODITE := VEC->VEC_CODITE
					EndIf
					TRB->TRB_DESCRI := SB1->B1_DESC
					TRB->TRB_PERCOM := VSG->VSG_PERCOM
					&& Totaliza
					If MV_PAR09 == 1
						TRB->TRB_VALTTP += VEC->VEC_VALVDA
						TRB->TRB_VALCMP += VSG->VSG_VALCOM
					EndIf
					If MV_PAR09 == 2
						TRB->TRB_VALTTP += VEC->VEC_VMFVDA
						TRB->TRB_VALCMP += VSG->VSG_MODFOR
					EndIf
					If MV_PAR09 >= 3
						TRB->TRB_VALTTP += xMoeda(VEC->VEC_VALVDA , 1 , MV_PAR09 , VEC->VEC_DATVEN )
						TRB->TRB_VALCMP += xMoeda(VSG->VSG_VALCOM , 1 , MV_PAR09 , VEC->VEC_DATVEN )
					EndIf
					MsUnLock()
				next
			EndIf
			DbSelectArea("VSG")
			DbSkip()
		EndDo
		If !lSchedule
			IncRegua()
		EndIf
		DbSelectArea("VEC")
		DbSkip()
	EndDo
EndIf
Return
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³OA110OK     ³ Autor ³  Ednilson           ³ Data ³ 24/10/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Funcao para o TudoOk                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FS_VALR400(cPar01,cPar02)
Local lRet := .t.
If cPar01 > cPar02
	Help(" ",1,"DATA2MOATU")
	lRet := .f.
EndIf
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ValidPerg   ³ Autor ³ Fabio                 ³ Data ³ 17/05/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Valida pergunte.                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValidPerg()
Local i:=0
Local j:=0

_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))
aRegs:={}
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/f3

Aadd(aRegs,{cPerg,'01',STR0020,STR0020,STR0020,'mv_ch1','D',8,0,0,'G','','mv_par01',"","","","","","","","","","","","","","","","","","","","","","","","","",'S',"","","",""})
Aadd(aRegs,{cPerg,'02',STR0021,STR0021,STR0021,'mv_ch2','D',8,0,0,'G','U_FS_VALR400(MV_PAR01,MV_PAR02)','mv_par02',"","","","","","","","","","","","","","","","","","","","","","","","","",'S',"","","",""})
Aadd(aRegs,{cPerg,'03',STR0022,STR0022,STR0022,'mv_ch3','C',9,0,0,'G','Vazio().or.FG_SEEK("CTT","mv_par03",1,.F.)','mv_par03',"","","","","","","","","","","","","","","","","","","","","","","","",'CTT','S',"","","",""})
Aadd(aRegs,{cPerg,'04',STR0023,STR0023,STR0023,'mv_ch4','C',9,0,0,'G','Vazio().or.FG_SEEK("CTT","mv_par04",1,.F.)','mv_par04',"","","","","","","","","","","","","","","","","","","","","","","","",'CTT','S',"","","",""})
Aadd(aRegs,{cPerg,'05',STR0024,STR0024,STR0024,'mv_ch5','C',6,0,0,'G','Vazio().or.FG_SEEK("SRJ","MV_PAR05",1,.F.)','mv_par05',"","","","","","","","","","","","","","","","","","","","","","","","",'SRJ','S',"","","",""})
Aadd(aRegs,{cPerg,'06',STR0025,STR0025,STR0025,'mv_ch6','C',6,0,0,'G','Vazio().or.FG_SEEK("SRJ","MV_PAR06",1,.F.)','mv_par06',"","","","","","","","","","","","","","","","","","","","","","","","",'SRJ','S',"","","",""})
Aadd(aRegs,{cPerg,'07',STR0026,STR0026,STR0026,'mv_ch7','C',6,0,0,'G','Vazio().or.FG_SEEK("VAI","MV_PAR07",1,.F.)','mv_par07',"","","","","","","","","","","","","","","","","","","","","","","","",'VAI','S',"","","",""})
Aadd(aRegs,{cPerg,'08',STR0027,STR0027,STR0027,'mv_ch8','C',6,0,0,'G','Vazio().or.FG_SEEK("VAI","MV_PAR08",1,.F.)','mv_par08',"","","","","","","","","","","","","","","","","","","","","","","","",'VAI','S',"","","",""})
Aadd(aRegs,{cPerg,'09',STR0028,STR0028,STR0028,'mv_ch9','N',1,0,1,'C','','mv_par09',STR0029,"","","","",STR0030,"","","","",STR0031,"","",,,STR0032,"","","","",STR0033,"","","","",'S',"","","",""})
Aadd(aRegs,{cPerg,'10',STR0034,STR0034,STR0034,'mv_c10','N',1,0,3,'C','','mv_par10',STR0035,"","","","",STR0036,"","","","",STR0037,"","","","","","","","","","","","","","",'S',"","","",""})
Aadd(aRegs,{cPerg,'11',STR0038,STR0038,STR0038,'mv_c11','N',1,0,1,'C','','mv_par11',STR0048,"","","","",STR0039,"","","","",STR0040,"","","","",STR0041,"","","","",STR0042,"","","","",'S',"","","",""})
Aadd(aRegs,{cPerg,'12',STR0043,STR0043,STR0043,'mv_c12','N',1,0,1,'C','','mv_par12',STR0044,"","","","",STR0045,"","","","","","","","","","","","","","","","","","","",'S',"","","",""})
//Aadd(aRegs,{cPerg,'13','Encerra Comissao ?','¿Cierra Comision ?','Close Commission ?','mv_c13','N',1,0,2,'C','','mv_par13','Nao','No','No',"","",'Sim','Si','Yes',,,,,,,,,,,,,,,,,,'S',,,,})

dbSelectArea("SX1")
SX1->(DbSetOrder(1))
If DbSeek (cPerg+"13")
	While !eof() .and. SX1->X1_GRUPO+SX1->X1_ORDEM==cPerg+"13"
		&& Exclui
		RecLock("SX1",.F.,.T.)
		dbdelete()
		MsUnlock()
		dbSelectArea("SX1")
		DbSkip()
	Enddo
EndIF

For i:=1 to Len(aRegs)
	If !DbSeek(cPerg+aRegs[i,2])
		RecLock("SX1", !Found() )
		For j:=1 to Len(aRegs[i])
			If aRegs[i,j] # NIL
				FieldPut(j,aRegs[i,j])
			EndIf
		Next
		MsUnlock()
		dbCommit()
	EndIF
Next

dbSelectArea(_sAlias)

Return
